Return-Path: <linux-wireless+bounces-20686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F52A6C2D5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D66E1B631DF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FF1EE7DF;
	Fri, 21 Mar 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="UDzekyxG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7E1E766F;
	Fri, 21 Mar 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583244; cv=none; b=Rr68mLKHD/TCaT20KXzoX3gRm37uC7mNxGE8Xo4bRy3dsa76hSSq8PofT+yT3UIpa/HE6fsJE6S307WTztLFmpDK99x+xtVoFR/6pLrtSu5AvG5gtXz3EMVlRG0zzWrzBxUT/nxwmcCP+7r4g749LYLXCqvBsNidsKxnV5AImzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583244; c=relaxed/simple;
	bh=htJSDSNSw+D2B+OW5t9qaqX9kJGS+4Nr7um7swHdASA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyLAShgRGD1c6VsTIxuf6jevX7DmklV8jjTGgwbKvXrjGlbqcTZ7GFga87r2jBVQTpp8GBO23ivnv2vJsZlXbIqcwopD8DnHlD7HHa5Fz9rcFeyskkpNja3tPsa2s/88VAziSzNfTkc/UUF+coXqEsCvXPXi/qLK/asgXf1IRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=UDzekyxG; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 3305C1E000E;
	Fri, 21 Mar 2025 21:54:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 3305C1E000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742583240; bh=ynXFTazgSkznULvfVWwWFWaVZs7Dm+CTnbFjpVKtU2g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UDzekyxGeF+e5tVjfGXzHz3GepB/PdoF+tPhdW1kqrFY7ORdmYhqg1Y3g8VlR5Det
	 qQJ5oGLwNtG7zNy69dtp1OvmHJRHvvNYPNEEOUe+akyuslx9SQKOmUCDOknjVvRCMr
	 VlGVKx4kqMErGqyAaKRn+FFwytZ2fuFkSm+mdCI8gnsHAuh40zZPltqHvh6QfLg8wm
	 3/CVSjP2J4T4gUSOWUIfZSgF3G6gtl4Oe6XlKlPC0F2jusV7EMtVgXi4MVv0Y3XSyj
	 BjmhPlKBJH/W81W2R97NSCi238oUWQZ8arqLp6GcuwtJTkvDwYmd9drXFTPu6pCnHX
	 auy0kEk2mMg/g==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri, 21 Mar 2025 21:54:00 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.178) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 21 Mar
 2025 21:53:57 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Srinivasan Raju <srini.raju@purelifi.com>
CC: Murad Masimov <m.masimov@mt-integration.ru>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Emmanuel Grumbach
	<emmanuel.grumbach@intel.com>, Johannes Berg <johannes.berg@intel.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 2/2] wifi: plfxlc: Fix error handling in usb driver probe
Date: Fri, 21 Mar 2025 21:52:26 +0300
Message-ID: <20250321185226.71-3-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250321185226.71-1-m.masimov@mt-integration.ru>
References: <20250321185226.71-1-m.masimov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192024 [Mar 21 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/21 15:38:00 #27810206
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

If probe fails before ieee80211_register_hw() is successfully done,
ieee80211_unregister_hw() will be called anyway. This may lead to various
bugs as the implementation of ieee80211_unregister_hw() assumes that
ieee80211_register_hw() has been called.

Divide error handling section into relevant subsections, so that
ieee80211_unregister_hw() is called only when it is appropriate. Correct
the order of the calls: ieee80211_unregister_hw() should go before
plfxlc_mac_release(). Also move ieee80211_free_hw() to plfxlc_mac_release()
as it supposed to be the opposite to plfxlc_mac_alloc_hw() that calls
ieee80211_alloc_hw().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 11 ++++----
 drivers/net/wireless/purelifi/plfxlc/mac.h |  2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c | 29 +++++++++++-----------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 82d1bf7edba2..a7f5d287e369 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -99,11 +99,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 	return r;
 }

-void plfxlc_mac_release(struct plfxlc_mac *mac)
-{
-	plfxlc_chip_release(&mac->chip);
-}
-
 int plfxlc_op_start(struct ieee80211_hw *hw)
 {
 	plfxlc_hw_mac(hw)->chip.usb.initialized = 1;
@@ -755,3 +750,9 @@ struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf)
 	SET_IEEE80211_DEV(hw, &intf->dev);
 	return hw;
 }
+
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw)
+{
+	plfxlc_chip_release(&plfxlc_hw_mac(hw)->chip);
+	ieee80211_free_hw(hw);
+}
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.h b/drivers/net/wireless/purelifi/plfxlc/mac.h
index 9384acddcf26..56da502999c1 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.h
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.h
@@ -168,7 +168,7 @@ static inline u8 *plfxlc_mac_get_perm_addr(struct plfxlc_mac *mac)
 }

 struct ieee80211_hw *plfxlc_mac_alloc_hw(struct usb_interface *intf);
-void plfxlc_mac_release(struct plfxlc_mac *mac);
+void plfxlc_mac_release_hw(struct ieee80211_hw *hw);

 int plfxlc_mac_preinit_hw(struct ieee80211_hw *hw, const u8 *hw_address);
 int plfxlc_mac_init_hw(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 56d1139ba8bc..18e749f8f25d 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -602,7 +602,7 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_upload_mac_and_serial(intf, hw_address, serial_number);
 	if (r) {
 		dev_err(&intf->dev, "MAC and Serial upload failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}

 	chip->unit_type = STA;
@@ -611,13 +611,13 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_mac_preinit_hw(hw, hw_address);
 	if (r) {
 		dev_err(&intf->dev, "Init mac failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}

 	r = ieee80211_register_hw(hw);
 	if (r) {
 		dev_err(&intf->dev, "Register device failed (%d)\n", r);
-		goto error;
+		goto error_free_hw;
 	}

 	if ((le16_to_cpu(interface_to_usbdev(intf)->descriptor.idVendor) ==
@@ -630,7 +630,7 @@ static int probe(struct usb_interface *intf,
 	}
 	if (r != 0) {
 		dev_err(&intf->dev, "FPGA download failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}

 	tx->mac_fifo_full = 0;
@@ -640,21 +640,21 @@ static int probe(struct usb_interface *intf,
 	r = plfxlc_usb_init_hw(usb);
 	if (r < 0) {
 		dev_err(&intf->dev, "usb_init_hw failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}

 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_switch_radio(chip, PLFXLC_RADIO_ON);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_switch_radio_on failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}

 	msleep(PLF_MSLEEP_TIME);
 	r = plfxlc_chip_set_rate(chip, 8);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "chip_set_rate failed (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}

 	msleep(PLF_MSLEEP_TIME);
@@ -662,7 +662,7 @@ static int probe(struct usb_interface *intf,
 			    hw_address, ETH_ALEN, USB_REQ_MAC_WR);
 	if (r < 0) {
 		dev_dbg(&intf->dev, "MAC_WR failure (%d)\n", r);
-		goto error;
+		goto error_unreg_hw;
 	}

 	plfxlc_chip_enable_rxtx(chip);
@@ -689,12 +689,12 @@ static int probe(struct usb_interface *intf,
 	plfxlc_mac_init_hw(hw);
 	usb->initialized = true;
 	return 0;
+
+error_unreg_hw:
+	ieee80211_unregister_hw(hw);
+error_free_hw:
+	plfxlc_mac_release_hw(hw);
 error:
-	if (hw) {
-		plfxlc_mac_release(plfxlc_hw_mac(hw));
-		ieee80211_unregister_hw(hw);
-		ieee80211_free_hw(hw);
-	}
 	dev_err(&intf->dev, "pureLifi:Device error");
 	return r;
 }
@@ -728,8 +728,7 @@ static void disconnect(struct usb_interface *intf)
 	 */
 	usb_reset_device(interface_to_usbdev(intf));

-	plfxlc_mac_release(mac);
-	ieee80211_free_hw(hw);
+	plfxlc_mac_release_hw(hw);
 }

 static void plfxlc_usb_resume(struct plfxlc_usb *usb)
--
2.39.2


