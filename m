Return-Path: <linux-wireless+bounces-36237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G6KNv0BAmrknAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:21:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F00512000
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62BFA3052E45
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F22F12A1;
	Mon, 11 May 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="eG6YkOXA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA784423A6B
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515705; cv=none; b=jAckYQ5biF5Ue2n4XDNqcy4KWk12Zy5neuFVCUD5NpdTms/XRn+/hEvaxbhqJnF9JmhfudS4SmKj0TfeHCu/lb/XudswJtn65lxS9697h8FzrbDpeFblzhgJdxOwyS1G9HeoK56/4EtGgT85Yc2iwfNMzTNiTuJ7YOzDFBHoqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515705; c=relaxed/simple;
	bh=A/Fj+NFOPcUtK+kbHgS4pzM5XLYsm/Hze0cqyL9ImZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlq2gXQyUGVqOu1zyi577AiUsjPrcYYLwLqwFGyF8+dVoDGlxYXGgJAjV8tPxk3r/Ab8HFnLXV5etPteZCMqvJ720iNMDQAwL+MSs/Niy+R1ymy+Qa2thEy+7dLtiOzM8etZIK+5g67DF7IfbTvdDoiJzP6OSDUN6aIpHTtu/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=eG6YkOXA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778515700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMo8rsH9EAVl21A/VusLdNr6UnE6XSL7Qp9X5I4tchE=;
	b=eG6YkOXASLechdTR7msMktS9eKlFL/YMB23Z7BwmeqihyHzC2tyYebYZGjelRlTdLQqUOg
	B15sOG6lfzPRe+nZg2FNRf6B16oEPeOqQi8LPvwrAwEeSzhO/jwSO69FPKBd/aY1TIT/m6
	Fzbj13QvrsU8AnSB/EzQ8/5ooLViLv67F0r0KG/AaQJU1OENPlwkhf6FFSf4lgfAlFJ2l2
	npIDyeHh9BTOSt83ps53WKfWG6t5P36i3+ip5xpfPRnuUWSolABj4YOh7X5gW/fexIzu7Y
	RdofAXbKryR4L3GG0mGJ3WFHN8SXmE6WphRKaz6qBH3IjxA2+wDAPl6aLvkhDw==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Mon, 11 May 2026 09:08:11 -0700
Message-ID: <20260511160811.17647-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260511160811.17647-1-lucid_duck@justthetip.ca>
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
 <20260511160811.17647-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D2F00512000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36237-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


