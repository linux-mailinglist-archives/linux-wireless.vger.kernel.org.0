Return-Path: <linux-wireless+bounces-34286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP20KI5tzWnvdQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 21:10:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201AB37FAB1
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 21:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 007D6305E430
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F612E091B;
	Wed,  1 Apr 2026 19:06:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138B32ED2E
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070411; cv=none; b=OHFBqzCBAmMKvw2B39OCGBJqp4lR3agwvYZ6Z9pkHLpVKV37jvYUX+Bq1sITqjTi0dUEq9aA2xu4yYzt6+7yfGFI2i9Nww9CuoOoegbBQXNC8a3bNjZ5eQdPleGsRnM9FUm3NENB02UD6C5Y6TzcRqkN88xYp/ttyVg806WUrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070411; c=relaxed/simple;
	bh=0U8ggOjLfcU5BjzQzTkxd6w1KMXgL3gnh2JOhJXMxhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8sV1mq2f3LZlcDIvwShHrdSpNoYNn5WEIfUfdcJSPYc6P259VduZDpyErZi2xIO3R/bnfYbwNEdo3edjWXTR/TZlqGfk1qYmWc2ti/JVW1yABxRp+iuk/HeRE2Q4l29zksO42UJBPrfiYdco90Tb13Ycj8dkzZKnx36HT769WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67e02b821cfso59947eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 12:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070409; x=1775675209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bbbtUfPpmMH6eFM76akrOLWA1LQMByWmMa0q4rif0s=;
        b=JBxTa1y38YUh+qDlzCsGsNbw4hgtjAjcHDa8QXuIqcDZ6Zf93hhO0AaF/evNQtrMww
         6u23Jkh3m1HK6boMxAF8/hWr47DknxAQzzDhwddAqKBoa2hHUCEGkFKFtaiTL3XyonVm
         I6IfqygoB6fTtYZPm1qsewrh7bS/Bw8sIBEsYY2KWLRBoFwVe/pvCl7I0RfuFwlM+0iN
         hBqt+MBT1Xh+LIdqmFWpJ0y2wAdq+lQxt2Han1Hc9FIKDiwi+Yv1PLdij7nKC33vELtw
         INBQ79MdB045FO8tqL/42ATt8qXbjfrvRR2TgRImgAC1nsEQdoh4SW44a9GlrTsAFllu
         rWyA==
X-Gm-Message-State: AOJu0YyHrWRHptFHpLfPXg5w5yfWYF1VBRJBl7LP6oqWT1uRn5neUrMA
	QJ2v1BKT643IXV8KWgQD8b7V38bS1sYULzU//c5Nc3TJHeF0RoZAGyTH
X-Gm-Gg: ATEYQzzmSvAe8ZREE1udJvqHBXmW06yXbUyov6o9R0bSGCkNFEIuV1e1zCpOFwyUxTj
	zXEPAhQtEcySMOhxJYMZfFlCZvR0fwsMihkbEvnce5IjMbWSmczQSd2oa4inBy2sMRnP47Lat1y
	9mHdPry/jfuePHmV0bpv/VFGOWfPZ7XAuHPoIOq8rY/6wHBcEpKYxdfQKR2xnuXPgAVA8Ar1Gxe
	AKKsjGz97BwbhPkRNFXDhXghYcsrtesEz3kwCvVZ1HwVktq1li7Z7JXa7RDxrwRkvZoOt9lc0dW
	RLVszuc0p8W6GWhiGfvdXcoB+n5U5seGKuc7gwYf+2dBweaCkDTXjqvfdt2txPe+3Xk1IJmC/52
	24LfVfZqGF4GxeMk1yxCTMYD5ENWt35EKaI0ZiyjxDceLnvQm2cEApvNWM4Ni+V8pWkuvsKxBqF
	HdkRCY/REeGeFHXrk5DsfJaFX15q/KBJU51q0zjQsiawh/rPM=
X-Received: by 2002:a05:6820:4dcb:b0:67e:367c:998b with SMTP id 006d021491bc7-67fabd207eemr2654797eaf.59.1775070409001;
        Wed, 01 Apr 2026 12:06:49 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm551867fac.6.2026.04.01.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:06:48 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Bryam Vargas <bryamestebanvargas@gmail.com>
Subject: [PATCH v2 2/2] wifi: mt76: mt7921u: escalate broken USB transport to device reset
Date: Wed,  1 Apr 2026 14:06:32 -0500
Message-ID: <20260401190632.147042-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401190632.147042-1-sean.wang@kernel.org>
References: <20260401190632.147042-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34286-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mediatek.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.580];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 201AB37FAB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

Check the USB control path before running the normal WFSYS reset flow.

If USB access is no longer reliable, stop the WFSYS-only reset path,
mark the device as bus_hung, and queue a USB device reset instead.

Reuse the existing bus_hung state to represent transport-level failure,
keeping the semantics consistent with the SDIO path.

Also initialize bus_hung explicitly during probe for consistency.

Reported-by: Bryam Vargas <bryamestebanvargas@gmail.com>
Closes: https://lore.kernel.org/r/CANAPQziOh3sB7B8G+U3AZsFfeFN1uAg4munhwA_feZi56D7W+Q@mail.gmail.com
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
- Rebased onto the latest mt76 tree
- Added the proper Reported-by tag
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  4 ++-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  5 ++++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 26 +++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db73f..d27dbee8df1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -675,7 +675,9 @@ void mt7921_mac_reset_work(struct work_struct *work)
 		if (!ret)
 			break;
 	}
-	if (mt76_is_sdio(&dev->mt76) && atomic_read(&dev->mt76.bus_hung))
+
+	if ((mt76_is_sdio(&dev->mt76) || mt76_is_usb(&dev->mt76)) &&
+	    atomic_read(&dev->mt76.bus_hung))
 		return;
 
 	if (i == 10)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 6be28f4152ed..8c0f0e4ef87b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -88,6 +88,10 @@ static int mt7921u_mac_reset(struct mt792x_dev *dev)
 {
 	int err;
 
+	mt792xu_reset_on_bus_error(dev);
+	if (atomic_read(&dev->mt76.bus_hung))
+		return 0;
+
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&dev->mt76.tx_worker);
 
@@ -196,6 +200,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &hif_ops;
+	atomic_set(&dev->mt76.bus_hung, false);
 	mt792xu_reset_work_init(dev);
 
 	udev = usb_get_dev(udev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 5f06074591ca..74222c507b81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -494,6 +494,7 @@ int mt792xu_init_reset(struct mt792x_dev *dev);
 void mt792xu_reset_work_init(struct mt792x_dev *dev);
 void mt792xu_reset_work_cleanup(struct mt792x_dev *dev);
 int mt792xu_check_bus(struct mt792x_dev *dev);
+int mt792xu_reset_on_bus_error(struct mt792x_dev *dev);
 u32 mt792xu_rr(struct mt76_dev *dev, u32 addr);
 void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
 u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 2558d87b1e0f..6b10d035bcbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -60,6 +60,32 @@ int mt792xu_check_bus(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xu_check_bus);
 
+int mt792xu_reset_on_bus_error(struct mt792x_dev *dev)
+{
+	int err = 0;
+
+	if (!atomic_read(&dev->mt76.bus_hung))
+		err = mt792xu_check_bus(dev);
+
+	if (err) {
+		atomic_set(&dev->mt76.bus_hung, true);
+
+		if (!atomic_xchg(&dev->usb_reset_pending, 1)) {
+			dev_warn(dev->mt76.dev,
+				 "USB transport access failed (%d), queueing device reset\n",
+				 err);
+
+			schedule_work(&dev->usb_reset_work);
+		}
+
+		return err;
+	}
+
+	atomic_set(&dev->mt76.bus_hung, false);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792xu_reset_on_bus_error);
+
 u32 mt792xu_rr(struct mt76_dev *dev, u32 addr)
 {
 	u32 ret;
-- 
2.43.0


