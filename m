Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16336190171
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCWW6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 18:58:30 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:51555 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgCWW63 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 18:58:29 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jGW1a-000NKF-OE; Mon, 23 Mar 2020 23:58:26 +0100
Received: from [2a02:168:6182:1:a8e7:613d:a871:7d4b] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jGW1a-0004KB-Ff; Mon, 23 Mar 2020 23:58:26 +0100
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Reto Schneider <code@reto-schneider.ch>
Subject: [PATCH v2 0/1] Updating RTL8192CU firmware
Date:   Mon, 23 Mar 2020 23:58:08 +0100
Message-Id: <20200323225809.11594-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323024500.4090-1-code@reto-schneider.ch>
References: <20200323024500.4090-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this update, with version 80 of the firmware, the USB interface
of the RTL8192CU WLAN controller often locked itself up:
 usb 1-2: device descriptor read/64, error -110
 usb 1-2: device not accepting address 4, error -110
 usb 1-2: device not accepting address 5, error -110
 usb usb1-port2: unable to enumerate USB device
 usb 2-2: device descriptor read/64, error -110
 usb 2-2: device descriptor read/64, error -110

On ARMv5 based GARDENA smart gateway running Linux 4.19.78, this can
be reliably reproduced by rebooting (warm) the gateway multiple times
(max. 50 attempts needed).
Unlike users having this issues on a USB Wi-Fi dongle, resetting of the
chip by replugging is not an option on this gateway due to the lack of
any power cut functionality. Therefore, a (cold) reboot of the whole
gateway is needed.

Updating the firmware of the RTL8192CU WLAN controller from version
v80.0 to v88.2 (as per output of rtl8xxxu, which was used temporarily)
seems to resolve this issue. The problem did no show up anymore for 1000
restarts.
Please note that only rtl8192cufw_TMSC.bin has been tested.

Unrelated of this USB problem, another issue still remains: Using the
rtl8192cu driver, scanning for available SSIDs yields no more results
after a few hundred scans (iw wlan0 scan).

Also, the Realtek drivers containing v88.2 of the firmware
(v4.0.1_6911.20130308 to v4.0.9_25039.20171107) have some changes
compared to the version v3.4.2_3727.20120404, for which I am unsure of
whether they need to be reflected in rtl8192cu and/or rtl8xxxu.
What I could spot for sure however, is that some tables have been
updated:
  https://github.com/rettichschnidi/linux/commit/0c865ba26aba907b601b3b73c82111dd10e59ffe

I am unsure if this changes are relevant and how the best way would be
to ensure that this commit does not break old drivers out there.

Reto Schneider (1):
  rtlwifi: v88.2 firmware files for RTL8192CU

 WHENCE                       |   6 ++++++
 rtlwifi/rtl8192cufw_A.bin    | Bin 16116 -> 16126 bytes
 rtlwifi/rtl8192cufw_B.bin    | Bin 16096 -> 16096 bytes
 rtlwifi/rtl8192cufw_TMSC.bin | Bin 16116 -> 16126 bytes
 4 files changed, 6 insertions(+)

-- 
2.20.1

