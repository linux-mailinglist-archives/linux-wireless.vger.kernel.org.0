Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46530F062
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 11:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhBDKT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 05:19:58 -0500
Received: from mx3.wp.pl ([212.77.101.9]:53022 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhBDKT5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 05:19:57 -0500
Received: (wp-smtpd smtp.wp.pl 14603 invoked from network); 4 Feb 2021 11:19:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1612433943; bh=1AXDuFLIt28K1KcSPRA3VeGyYNKSA/hAKMTsttfiZOw=;
          h=From:To:Subject;
          b=fjGO6S69SjLEf3AxIOiWJ388n8Mm0jxft45FNQFKxznt0jaG/DB6nwu8F+/7oekvs
           jvwT0XqVNftve00w8T1WP75T0pWmhA5haHxMoZH2Zzm033+Ei4kaENkvdBLqjKHr78
           sylirof6xugEC9NjVr7KIt3Kmwk49L/pwPScn28E=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 4 Feb 2021 11:19:03 +0100
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] rt2800usb: add Sweex LW163V2 id's
Date:   Thu,  4 Feb 2021 11:19:02 +0100
Message-Id: <20210204101902.199590-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 84aae4159f007565d81a6938e3b5c4d3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0VOF]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

Add support for Sweex LW163V2 device.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index d08b251ec5a2..36ac18ca8082 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -988,6 +988,7 @@ static const struct usb_device_id rt2800usb_device_table[] = {
 	{ USB_DEVICE(0x177f, 0x0313) },
 	{ USB_DEVICE(0x177f, 0x0323) },
 	{ USB_DEVICE(0x177f, 0x0324) },
+	{ USB_DEVICE(0x177f, 0x1163) },
 	/* U-Media */
 	{ USB_DEVICE(0x157e, 0x300e) },
 	{ USB_DEVICE(0x157e, 0x3013) },
-- 
2.25.4

