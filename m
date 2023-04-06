Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031296D944D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjDFKm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDFKm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 06:42:27 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 03:42:25 PDT
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B9555A6
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 03:42:25 -0700 (PDT)
X-Halon-ID: 91302ebd-d467-11ed-b215-c71a8e099054
Authorized-sender: petter@technux.se
Received: from petterwork (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id 91302ebd-d467-11ed-b215-c71a8e099054;
        Thu, 06 Apr 2023 12:41:20 +0200 (CEST)
Message-ID: <188007.70407276-sendEmail@petterwork>
From:   "petter@technux.se" <petter@technux.se>
Reply-To: "20230220101740.i7wxzzvte3xnwht4@fatal.se" 
          <20230220101740.i7wxzzvte3xnwht4@fatal.se>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "pkshih@realtek.com" <pkshih@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Date:   Thu, 6 Apr 2023 10:41:20 +0000
X-Mailer: sendEmail-1.56
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-143715.009865449"
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-143715.009865449
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I have seen a very similar issue as Andreas. It was found when streaming a mender file (using mender install <url> from my arm device. But I have also managed to reproduce a similar issue by flooding the interface using iperf. 

on target:
$ sudo iperf -s -u

On host:
$ iperf -c <ip> -u -b 200M -t 300

Then it will almost instantly get problems causing the lm842 dongle to stop working.

I'm using below fw:
  $ sudo dmesg | grep 8822c
  [   19.282167] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
  [   19.299025] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
  [   19.628570] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
  [   19.641604] rtw_8822cu 1-1:1.2: Firmware version 9.9.15, H2C version 15


$ iperf -s -u
------------------------------------------------------------
Server listening on UDP port 5001
UDP buffer size:  176 KByte (default)
------------------------------------------------------------
[  415.791320] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
[  415.797443] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
[  415.803511] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
[  415.809635] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
[  438.102270] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[  441.446726] rtw_8822cu 1-1:1.2: failed to send h2c command
[  471.480932] rtw_8822cu 1-1:1.2: firmware failed to report density after scan


Any ideas what might be the cause of this? I have also tried to use the latest patch from Sascha that seems to be aimed to fix some issue I thought might have been related to this(https://lore.kernel.org/linux-wireless/20230404072508.578056-1-s.hauer@pengutronix.de/T/#m54b7c8c604b91cfce470fcec8fc7d4c20f3056c9), but still get same behavior.

BR,
Petter Mabäcker


------MIME delimiter for sendEmail-143715.009865449--

