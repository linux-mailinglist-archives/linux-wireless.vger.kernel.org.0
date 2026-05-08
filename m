Return-Path: <linux-wireless+bounces-36106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHKGJe18/WnnegAAu9opvQ
	(envelope-from <linux-wireless+bounces-36106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:04:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0A4F2385
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5513126A66
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D037B00E;
	Fri,  8 May 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="Y5uXiDNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F1371CF5
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219087; cv=none; b=rGuhvgEcs5tf84zTBD2QqUxPpqZq3CzQjYu+p1v21DM9pu4JwFGqevJvTESWII6qApFSVK96w20VLuFadhfwzM6kCyUgw9lISL7mcIteNWV0cf2qOTqQADZfD4diX1yronwtWV/SezMEpEdV8aiukw2Z8eaCL4zHcC9th3RBeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219087; c=relaxed/simple;
	bh=A/Fj+NFOPcUtK+kbHgS4pzM5XLYsm/Hze0cqyL9ImZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbRkpasFAHQeLn92r96NJVzfdMyte0D1GV/IzC954EmHcXF9qB9EsKwAcLTuwAWY6JJ3DZKQDlUBtF7IOlNM5GwX4vF96rFPVNlg4nXGBbjPrfcyeSMj4lfNLObK3o09fRxr98JKCmx6Or7imG3CIs/fklyKjyP6B4NPiAf0RsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=Y5uXiDNR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778219070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMo8rsH9EAVl21A/VusLdNr6UnE6XSL7Qp9X5I4tchE=;
	b=Y5uXiDNR8QlOXkfEMfjSXgqJQK1gtgjopXutdrqZ9fURbK+ZnfmOeiQLCirIAyusAE4Jl6
	2TLu7gcpnCq+krUA35koJJkNYFLfUqWPBFYj5cG19nR5sOrEeUJX205YIjXx0LeBQBhipt
	LvDJJiK4gV9MuZ6VzknS6+NUyNLU4vADMVyF2I7u6PJDN5gnHpOcFpd2RSJBE+gapmVPsm
	fgZp4uX6QDmyB4G1Odi/87uvkcoNeBjE8sDBGOiOJq4GQhsQvZFFtLiB0qlY1Hqdxc10cJ
	Kz1b9OODZ/Kd5FD+z8rKRPTAgIGCV5OxROX+1GV+ZmItuDCeSEDmIbsFD9dTIg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Thu,  7 May 2026 22:44:21 -0700
Message-ID: <20260508054421.128938-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260508054421.128938-1-lucid_duck@justthetip.ca>
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: EDE0A4F2385
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36106-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

The Realtek wifi 6/7 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

Implement the required commands in rtw89.

When a USB 3 device is plugged into a USB 2 port, rtw89 will try to
switch it to USB 3 mode only once. The device will disappear and come
back still in USB 2 mode, of course.

Some people experience heavy interference in the 2.4 GHz band in
USB 3 mode, so add a module parameter switch_usb_mode with the
default value 1 to let people disable the switching.

Tested with RTL8832BU and RTL8832CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/realtek/rtw89/reg.h |  4 +++
 drivers/net/wireless/realtek/rtw89/usb.c | 41 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 42ffe83931a3..7d4c085d9fb2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -164,6 +164,10 @@
 #define R_AX_DBG_PORT_SEL 0x00C0
 #define B_AX_DEBUG_ST_MASK GENMASK(31, 0)
 
+#define R_AX_PAD_CTRL2 0x00C4
+#define U2SWITCHU3 0xB
+#define USB_SWITCH_DELAY 0xF
+
 #define R_AX_PMC_DBG_CTRL2 0x00CC
 #define B_AX_SYSON_DIS_PMCR_AX_WRMSK BIT(2)
 
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 767a95f759b1..4fb25791d118 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -9,6 +9,11 @@
 #include "txrx.h"
 #include "usb.h"
 
+static bool rtw89_switch_usb_mode = true;
+module_param_named(switch_usb_mode, rtw89_switch_usb_mode, bool, 0644);
+MODULE_PARM_DESC(switch_usb_mode,
+		 "Set to N to disable switching to USB 3 mode to avoid potential interference in the 2.4 GHz band (default: Y)");
+
 static void rtw89_usb_read_port_complete(struct urb *urb);
 
 static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
@@ -1027,6 +1032,35 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static int rtw89_usb_switch_mode(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	if (!rtw89_switch_usb_mode)
+		return 0;
+
+	/* No known USB 3 devices with this chip. */
+	if (rtwdev->chip->chip_id == RTL8851B)
+		return 0;
+
+	if (rtwusb->udev->speed == USB_SPEED_SUPER)
+		return 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI, "%s: pad_ctrl2: %#x %#x\n",
+		    __func__,
+		    rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1),
+		    rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 2));
+
+	/* Already tried to switch but it's a USB 2 port. */
+	if (rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1) == USB_SWITCH_DELAY)
+		return 0;
+
+	rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 1, USB_SWITCH_DELAY);
+	rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 2, U2SWITCHU3);
+
+	return 1;
+}
+
 int rtw89_usb_probe(struct usb_interface *intf,
 		    const struct usb_device_id *id)
 {
@@ -1059,6 +1093,13 @@ int rtw89_usb_probe(struct usb_interface *intf,
 		goto err_free_hw;
 	}
 
+	ret = rtw89_usb_switch_mode(rtwdev);
+	if (ret) {
+		/* Not a fail, but we do need to skip rtw89_core_register. */
+		ret = 0;
+		goto err_intf_deinit;
+	}
+
 	if (rtwusb->udev->speed == USB_SPEED_SUPER)
 		rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_USB3;
 	else
-- 
2.53.0


