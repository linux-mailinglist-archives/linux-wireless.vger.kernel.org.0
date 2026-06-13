Return-Path: <linux-wireless+bounces-37767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hJusBNfcLWrClgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A607E67FF16
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37767-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37767-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D390930028A0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9923451CD;
	Sat, 13 Jun 2026 22:42:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F26223DCE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:42:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390548; cv=none; b=QRlJ3vllnSE8QQbGv2cr28V5vawh3F/th4fCQlqJwztTG/W74d+OId0lx1UbA2wirNyeVNyrolUtweSuj3kdMR+QHodxWxEDyXf9lw+2zd2B0gm9GI+ioPfqe43j5K4dr6TYDEVpHtmPX75UMesIpj9wjYlZ+gK8T8AXFqB6GIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390548; c=relaxed/simple;
	bh=bXvIVucXYZ/3olMf5fxKSVhBx6HRGemRiwrtSSsh6T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHNIpgjpJ6Zjnepm4M60NYP+tdOiMNsMd3qYnGn9EVsw8RyseIJTUK9vwgK19gK1QXanOjmyx7EoKFlWwhNEeNFlJlD5yNYJXlM5eNUJ49cqzNR5Fw0P069JruALEfSnKcmoju/oQUFfHT0rgcp4t82QnMQFgBXMVgIhA89SM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.176
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30807ba471bso6138811eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390547; x=1781995347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SsbLPE8jKHuu6btQ6EX0WxVpmk5Y39/q30/o1tZ/LY=;
        b=i+OZaV6wHz+UMckbzZ7i80oxGC5Bczt1lPrz0M3E2brxJMnP++elVu35Xj7VmptjEL
         RjGpjq76aViI+Kt8XThOLNZMJap+rD0sR2t4St4xPfDt1djDiq1zTtjDvZTnwYv9XruR
         QObVOC9SjFqDXdIUkMJZuZxTyel7j/acATmRnuCirlrjCJMkcxubVc01pFx+nSKyPSux
         UAjVgE8phHgXaWKwUHrv81GT5R+oG+rRhde2xjo80uMYK3HyRsU3RR2sbbNH3XmrNxZy
         QAg4XakMjOrOthOw8AOc55m48qQWsDdC405aKjIwJIKizuLIZAnisXy3mP7mMM8sNEQu
         fv+Q==
X-Gm-Message-State: AOJu0YyxRKoR6HW9uYnKmm7EkHo4GwQ2R0buBJgCm19DkCLTqkexKlWI
	7P1jrHCCJG1/4DwfwjTNiU84ZG9ozVZ8xkUDA1SUx1z4rPTxJ/kf4oil
X-Gm-Gg: Acq92OEdwWqzWmPP35H1fyvJzzx1Wc9/ttiqh5HRioi6b4U+uuHOinKQk25zrTy2djS
	LaeR1IBHC03aykJqXfw1WhopFmrbQ5f5lvddG2LWvYhoIN0xZo0HwU1OMvQ6PRmWn2IEU2ir+pG
	PkgtJhfLCTwFgadsaF89QtTN7wfX6VSrfvbjFlCG3S3RLR3uJFqGX0Jv2fwbJvnYt+uVEk4rWJI
	77mBWaTr70hVv49eEEg/WuJ1Y/1EU7TXNwQe2y4sY0Jt0FEZARxjslMgQLkSLs4u9E7zLcd6EK1
	NTLj8kg2InnXlGAfTXQfLemcVlZNRGZzc0CGQZqmgwK17aHf0vZPQA8tA4ZPn0+cifK5CApFyLK
	+fE3Hvkzcn975l7vyDeFBseBpqwyEVyQlJQoEeLuUr3zlqhjyGdcuniNcvbqVYNh2Deby0bNAAI
	6VJ39mRndMKtGeCdiByBpz+h7yfHEtU+zQh0QlvugY00HWxzCJy6oSrlusQQY0avHJLurby5eJe
	0HSC30pplDsuMZwF36ZtIg92agomJNkhufJokgZ
X-Received: by 2002:a05:7300:5415:b0:2f2:5c68:5052 with SMTP id 5a478bee46e88-3081ff744b8mr4489412eec.13.1781390546535;
        Sat, 13 Jun 2026 15:42:26 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:42:26 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/6] wifi: mt76: mt792x: stop USB register access after bus hang
Date: Sat, 13 Jun 2026 17:41:28 -0500
Message-ID: <20260613224131.2396026-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224131.2396026-1-sean.wang@kernel.org>
References: <20260613224131.2396026-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37767-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A607E67FF16

From: Sean Wang <sean.wang@mediatek.com>

Mark the mt792x USB bus hung on the first control timeout and switch
register access to no-op bus ops. Each failed vendor request may spend
up to MT_VEND_REQ_MAX_RETRY * MT_VEND_REQ_TOUT_MS, about 3 seconds, and
teardown/reset paths can keep issuing such requests after the device has
stopped responding.

Also skip the USB WFSYS reset path after bus_hung is set, since it uses
UHW vendor requests as well.

mt7925u 1-2:1.3: vendor request req:63 off:0018 failed:-110
mt7925u 1-2:1.3: vendor request req:63 off:0018 failed:-110
mt7925u 1-2:1.3: vendor request req:63 off:0018 failed:-110
mt7925u 1-2:1.3: vendor request req:63 off:0018 failed:-110
mt7925u 1-2:1.3: vendor request req:63 off:0018 failed:-110

Avoid repeating those register reads after the bus is known to be hung by
switching register access to no-op handlers.

Fixes: 0d2afe09fad5 ("mt76: mt7921: add mt7921u driver")
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 79 ++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/usb.c      | 11 +++
 3 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 07955555f84d..122e77a5f2f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -672,6 +672,7 @@ struct mt76_usb {
 
 	u8 out_ep[__MT_EP_OUT_MAX];
 	u8 in_ep[__MT_EP_IN_MAX];
+	void (*ctrl_timeout)(struct mt76_dev *dev, int err);
 	bool sg_en;
 
 	struct mt76u_mcu {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 910132e94956..d86b0918c2f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -31,10 +31,75 @@ static void mt792xu_reset_work(struct work_struct *work)
 	atomic_set(&dev->usb_reset_pending, 0);
 }
 
+static void mt792xu_queue_usb_reset(struct mt792x_dev *dev, int err)
+{
+	if (!atomic_xchg(&dev->usb_reset_pending, 1)) {
+		dev_warn(dev->mt76.dev,
+			 "USB transport access failed (%d), queueing device reset\n",
+			 err);
+
+		schedule_work(&dev->usb_reset_work);
+	}
+}
+
+static u32 mt792xu_bus_hung_rr(struct mt76_dev *mdev, u32 offset)
+{
+	return 0;
+}
+
+static void mt792xu_bus_hung_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+}
+
+static u32 mt792xu_bus_hung_rmw(struct mt76_dev *mdev, u32 offset,
+				u32 mask, u32 val)
+{
+	return 0;
+}
+
+static void mt792xu_bus_hung_write_copy(struct mt76_dev *mdev, u32 offset,
+					const void *data, int len)
+{
+}
+
+static void mt792xu_bus_hung_read_copy(struct mt76_dev *mdev, u32 offset,
+				       void *data, int len)
+{
+	memset(data, 0, len);
+}
+
+static const struct mt76_bus_ops mt792xu_bus_hung_ops = {
+	.rr = mt792xu_bus_hung_rr,
+	.wr = mt792xu_bus_hung_wr,
+	.rmw = mt792xu_bus_hung_rmw,
+	.write_copy = mt792xu_bus_hung_write_copy,
+	.read_copy = mt792xu_bus_hung_read_copy,
+	.type = MT76_BUS_USB,
+};
+
+static void mt792xu_set_bus_hung(struct mt792x_dev *dev)
+{
+	atomic_set(&dev->mt76.bus_hung, true);
+
+	if (READ_ONCE(dev->mt76.bus) == &mt792xu_bus_hung_ops)
+		return;
+
+	WRITE_ONCE(dev->mt76.bus, &mt792xu_bus_hung_ops);
+}
+
+static void mt792xu_ctrl_timeout(struct mt76_dev *mdev, int err)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+
+	mt792xu_set_bus_hung(dev);
+	mt792xu_queue_usb_reset(dev, err);
+}
+
 void mt792xu_reset_work_init(struct mt792x_dev *dev)
 {
 	INIT_WORK(&dev->usb_reset_work, mt792xu_reset_work);
 	atomic_set(&dev->usb_reset_pending, 0);
+	dev->mt76.usb.ctrl_timeout = mt792xu_ctrl_timeout;
 }
 EXPORT_SYMBOL_GPL(mt792xu_reset_work_init);
 
@@ -68,15 +133,8 @@ int mt792xu_reset_on_bus_error(struct mt792x_dev *dev)
 		err = mt792xu_check_bus(dev);
 
 	if (err) {
-		atomic_set(&dev->mt76.bus_hung, true);
-
-		if (!atomic_xchg(&dev->usb_reset_pending, 1)) {
-			dev_warn(dev->mt76.dev,
-				 "USB transport access failed (%d), queueing device reset\n",
-				 err);
-
-			schedule_work(&dev->usb_reset_work);
-		}
+		mt792xu_set_bus_hung(dev);
+		mt792xu_queue_usb_reset(dev, err);
 
 		return err;
 	}
@@ -344,6 +402,9 @@ int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 	u32 val;
 	int i;
 
+	if (atomic_read(&dev->mt76.bus_hung))
+		return -EIO;
+
 	mt792xu_epctl_rst_opt(dev, false);
 
 	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 77a8e35b1f86..ce68e1d0c786 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -30,6 +30,8 @@ int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 	for (i = 0; i < MT_VEND_REQ_MAX_RETRY; i++) {
 		if (test_bit(MT76_REMOVED, &dev->phy.state))
 			return -EIO;
+		if (dev->usb.ctrl_timeout && atomic_read(&dev->bus_hung))
+			return -EIO;
 
 		ret = usb_control_msg(udev, pipe, req, req_type, val,
 				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
@@ -42,6 +44,15 @@ int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 
 	dev_err(dev->dev, "vendor request req:%02x off:%04x failed:%d\n",
 		req, offset, ret);
+
+	if (dev->usb.ctrl_timeout) {
+		atomic_set(&dev->bus_hung, true);
+		dev_err(dev->dev, "vendor request req:%02x off:%04x timed out, marking bus hung\n",
+			req, offset);
+		dev->usb.ctrl_timeout(dev, ret);
+		return ret;
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__mt76u_vendor_request);
-- 
2.43.0


