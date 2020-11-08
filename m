Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD12AAE70
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 01:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKIABz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Nov 2020 19:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKIABx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Nov 2020 19:01:53 -0500
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Nov 2020 16:01:52 PST
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch [IPv6:2a00:d70:0:e::313])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E787AC0613CF
        for <linux-wireless@vger.kernel.org>; Sun,  8 Nov 2020 16:01:52 -0800 (PST)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kbuO1-000E7Y-DS; Mon, 09 Nov 2020 00:46:17 +0100
Received: from [2a02:168:6182:1:c3b1:7fc5:a6c0:ecad] (helo=ryzen2700.home.reto-schneider.ch)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kbuO1-0002jk-7y; Mon, 09 Nov 2020 00:46:17 +0100
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org, larry.finger@lwfinger.net,
        chiu@endlessos.org, Reto Schneider <code@reto-schneider.ch>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v3] rtlwifi: v88.2 firmware files for RTL8192CU
Date:   Mon,  9 Nov 2020 00:42:54 +0100
Message-Id: <20201108234254.21645-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The vendor driver rtl8188C_8192C_usb_linux_v4.0.1_6911.20130308 includes
new firmware files. These were extracted from data statements in that
driver to form these files.

Before this update, with version 80 of the firmware, the USB interface
of the RTL8192CU WLAN controller often locked itself up:
 usb 1-2: device descriptor read/64, error -110
 usb 1-2: device not accepting address 4, error -110
 usb 1-2: device not accepting address 5, error -110
 usb usb1-port2: unable to enumerate USB device
 usb 2-2: device descriptor read/64, error -110
 usb 2-2: device descriptor read/64, error -110

On ARMv5 based GARDENA smart gateways running Linux 4.19.78, this can
be reliably reproduced by rebooting (warm) the gateway multiple times
(max. 50 attempts needed).
Unlike users having this issues on a USB Wi-Fi dongle, resetting of the
chip by replugging is not an option on this gateway due to the lack of
any power cut functionality. Therefore, a (cold) reboot of the whole
gateway is needed.

Updating the firmware of the RTL8192CU WLAN controller from version
v80.0 to v88.2 (as per output of rtl8xxxu) resolves this issue.
The problem did no show up anymore for 1000 restarts.

Please note:
 - Only rtl8192cufw_TMSC.bin tested (mainly on rtl8xxxu)
 - rtl8192cu seems to work as well as before, but I can not rule out
   that this new firmware version brings unwanted changes.
   The Realtek drivers containing v88.2 of the firmware
   (v4.0.1_6911.20130308 to v4.0.9_25039.20171107) have some changes
   compared to the version v3.4.2_3727.20120404, for which I do not know
   if those should be reflected in rtl8192cu.

Unrelated of the initially described USB problem, another issue still
remains after updating the firmware: Using the rtl8192cu driver,
scanning for available SSIDs yields no more results after a few hundred
scans (iw wlan0 scan). rtl8xxxu does not suffer from this problem.

Signed-off-by: Reto Schneider <code@reto-schneider.ch>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Tested-by: Chris Chiu <chiu@endlessos.org>
---
Changes in v3:
  - Merge patch and cover letter
  - Add new tags

 WHENCE                       |   6 ++++++
 rtlwifi/rtl8192cufw_A.bin    | Bin 16116 -> 16126 bytes
 rtlwifi/rtl8192cufw_B.bin    | Bin 16096 -> 16096 bytes
 rtlwifi/rtl8192cufw_TMSC.bin | Bin 16116 -> 16126 bytes
 4 files changed, 6 insertions(+)

diff --git a/WHENCE b/WHENCE
index 6265e03..ccacf4d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2744,6 +2744,12 @@ File: rtlwifi/rtl8192cufw.bin
 File: rtlwifi/rtl8192cufw_A.bin
 File: rtlwifi/rtl8192cufw_B.bin
 File: rtlwifi/rtl8192cufw_TMSC.bin
+Info: From Vendor's rtl8188C_8192C_usb_linux_v4.0.1_6911.20130308 driver
+      All files extracted from driver/hal/rtl8192c/usb/Hal8192CUHWImg.c
+      Relevant variables (CONFIG_BT_COEXISTENCE not set):
+        - rtlwifi/rtl8192cufw_A.bin: Rtl8192CUFwUMCACutImgArray
+        - rtlwifi/rtl8192cufw_B.bin: Rtl8192CUFwUMCBCutImgArray
+        - rtlwifi/rtl8192cufw_TMSC.bin: Rtl8192CUFwTSMCImgArray
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
diff --git a/rtlwifi/rtl8192cufw_A.bin b/rtlwifi/rtl8192cufw_A.bin
index 9569d0a236ae57304fa814e04dcbe9254fe0fa69..fceafc922cc2118d8ead2a6f7faf241df0ea0d00 100644
GIT binary patch
literal 16126
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

literal 16116
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

diff --git a/rtlwifi/rtl8192cufw_B.bin b/rtlwifi/rtl8192cufw_B.bin
index 96089c4c9e6e5a95d06ed6e5a93bf9a4478e156d..06569e7f60cd573936546b28f2530f4ccfe68161 100644
GIT binary patch
literal 16096
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

literal 16096
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
bDvsz=ab(|$qcSU!93T^fNxd+dmv;YuW;*Qo

diff --git a/rtlwifi/rtl8192cufw_TMSC.bin b/rtlwifi/rtl8192cufw_TMSC.bin
index d1b84d4886d1864e7ada9ff175a1850d32061158..ec0a0d3e544af69e452f5d1054157b493ac847e3 100644
GIT binary patch
literal 16126
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

literal 16116
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

-- 
2.27.0

