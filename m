Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8298A650CB0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 14:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiLSNgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSNgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 08:36:08 -0500
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 05:36:03 PST
Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257810FA
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 05:36:02 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:30:27 +0100
From:   Ingo Saitz <ingo@hannover.ccc.de>
To:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw88 / 8821cu driver missing firmware
Message-ID: <Y6Bnc+UUY3R/nc6L@spatz.zoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I saw the 8821cu chipset being merged for linus' next kernel release and
decided to give it a try. I have been running 8821cu from
https://github.com/morrownr/8821cu-20210118 succeffully, so I know my
hardware works.

The driver as merged in commit 07cef03b8d44dee7488de3d1585387e603c78676
to git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
can't find any firmware for the driver, and the card does not work. At
boot it repeatedly logged failures to my kernel.log:

2022-12-16T19:20:21.563669+01:00 pinguin kernel: [    7.823614] rtw_8821cu 2-11:1.0: Firmware version 24.11.0, H2C version 12
2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.906497] usbcore: registered new interface driver rtw_8821cu
2022-12-16T19:20:21.563670+01:00 pinguin kernel: [    7.930657] rtw_8821cu 2-11:1.0 wlx1cbfcefeb2a3: renamed from wlan0
2022-12-16T19:20:59.576907+01:00 pinguin kernel: [  631.847796] rtw_8821cu 2-11:1.0: failed to download firmware
2022-12-16T19:20:59.576910+01:00 pinguin kernel: [  631.849195] rtw_8821cu 2-11:1.0: leave idle state failed
2022-12-16T19:20:59.580239+01:00 pinguin kernel: [  631.851635] rtw_8821cu 2-11:1.0: failed to leave ips state
2022-12-16T19:20:59.580241+01:00 pinguin kernel: [  631.851636] rtw_8821cu 2-11:1.0: failed to leave idle state
2022-12-16T19:21:08.563579+01:00 pinguin kernel: [  640.833372] rtw_8821cu 2-11:1.0: error beacon valid
2022-12-16T19:21:08.563590+01:00 pinguin kernel: [  640.833480] rtw_8821cu 2-11:1.0: failed to download rsvd page
2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.833640] rtw_8821cu 2-11:1.0: failed to download firmware
2022-12-16T19:21:08.563591+01:00 pinguin kernel: [  640.835040] rtw_8821cu 2-11:1.0: leave idle state failed
2022-12-16T19:21:08.566911+01:00 pinguin kernel: [  640.837510] rtw_8821cu 2-11:1.0: failed to leave ips state
2022-12-16T19:21:08.566915+01:00 pinguin kernel: [  640.837513] rtw_8821cu 2-11:1.0: failed to leave idle state
2022-12-16T19:21:17.550263+01:00 pinguin kernel: [  649.820641] rtw_8821cu 2-11:1.0: error beacon valid
2022-12-16T19:21:17.550288+01:00 pinguin kernel: [  649.820759] rtw_8821cu 2-11:1.0: failed to download rsvd page

There is no mention of what firmware would be needed in the source code
itself, yet the repository https://github.com/ulli-kroll/rtl8821cu
includes a file firmware/rtl8821cufw.bin.

I don't know whether this needs another big update before linus merge
window for 6.2 closes, so I chose to report it early.

My hardware:
* XVZ USB WiFi Dongle für PC 600Mbps Dual Band

shows up as:

Bus 002 Device 003: ID 0bda:c811 Realtek Semiconductor Corp. 802.11ac NIC

Bus 002 Device 003: ID 0bda:c811 Realtek Semiconductor Corp. 802.11ac NIC
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0xc811
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 802.11ac NIC
  iSerial                 3 123456
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0035
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              2 802.11ac NIC
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x08  EP 8 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

    Ingo
-- 
 ╭─╮  Kennedy's Lemma:
╭│───╮  If you can parse Perl, you can solve the Halting Problem.
│╰─│─╯
╰──╯  http://www.perlmonks.org/?node_id=663393
