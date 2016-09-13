import os

import pytest
from selenium.webdriver import DesiredCapabilities
from testcontainers.core.docker_client import DockerClient
from testcontainers.webdriver import StandaloneSeleniumContainer, SeleniumImage

import __root__


@pytest.fixture(scope="module")
def service(request):
    docker = DockerClient()
    docker.build_from_path(__root__.path(), tag="video_service")
    docker.run("video_service", bind_ports={8086: 8086})
    chrome = StandaloneSeleniumContainer(SeleniumImage.STANDALONE_CHROME, DesiredCapabilities.CHROME).start()

    def fin():
        docker.stop_all_spawned()
        chrome.stop()

    request.addfinalizer(fin)
    return chrome


def test_login(service):
    driver = service.get_driver()
    driver.get("http://172.17.0.2:8086/index")
    driver.find_element_by_id("inputEmail3").send_keys("admin")
    driver.find_element_by_id("inputPassword3").send_keys("admin")
    driver.find_element_by_xpath("//*[@id='parent']/form/div[3]/div/button").click()
    assert driver.find_element_by_xpath("//*[@id='navbar']/ul[2]/li[1]/span[1]").text == "username: admin"


def test_login_(service):
    driver = service.get_driver()
    driver.get("http://172.17.0.2:8086/index")
    driver.find_element_by_id("inputEmail3").send_keys("admin")
    driver.find_element_by_id("inputPassword3").send_keys("admin")
    driver.find_element_by_xpath("//*[@id='parent']/form/div[3]/div/button").click()
    assert driver.find_element_by_xpath("//*[@id='navbar']/ul[2]/li[1]/span[1]").text == "username: admin"
