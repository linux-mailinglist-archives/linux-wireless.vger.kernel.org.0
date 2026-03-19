Return-Path: <linux-wireless+bounces-33452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPGsHIWBu2k2kwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:54:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D32C6112
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9983038FC3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105A33D51F;
	Thu, 19 Mar 2026 04:54:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30517377014
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896046; cv=none; b=TzMpkBhpht6LR45htMYUhgXg1Aa+4dCWIHtUla5N9A/IaiB+LyZSRTRgKzWEDeMPFJ0qz5Tr0Je0HymPftzAXERcXdBpUKrEItrEiOO2Ae/Ri29Bc7sV7sRoT9H86u31FQZ/X64yj7myK83uwx5lIUbEYPM7cyKNQmyJV2cBKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896046; c=relaxed/simple;
	bh=ZU8P5+gEYafcvSJOGV6CTSfw9fdATV6r9GxEdzWFJJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLK238aeDu/2i3ITs7ASQeRRqoKCnWIY0UHdNKMiBBvII3dTS/nVTZfa5IOKn1cV4b30dN7/zj9lmB9Gc4GZBrUHOcGEydZdH+QZb6w3WakYJhf157F5OjKwJoM6TTm5/L+IYs1Kc0bnFtlL9Tb/pfRPw8U83ZEatbH4wdD5+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79801df3e42so6415797b3.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 21:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896044; x=1774500844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfoPytrUz8jnu1QwEs3H3bRbE3lX1OzACwh2r6y3HCk=;
        b=sBDkLc/678PXeWsRKuWeWNPwBsKcDSw+URpacbqeX104S3DPto9SiBJr05Q7ltQrqF
         Xju+id1DFub9k48b6Gy4L9/EvGsgsamQxwzYZ5Puk/8njR9SGu3nJ7KeA4JFUeyGmevf
         BI+0UKaU5Lml1mW6uY9Hohnm/HAztKMmb4UISfS/HyDJsBk2Z/ZcrInRkaQmzOm8nFad
         ueAhczNYkgvcxBsGAVR59ZxjNW5P+FoG21SKYNUV6WiDH+9MJ5zOXhqXiKbul015dkGX
         dGJvFQ6C4oNPUC6E3nN0zcdPLDNaSOmOh+Ay7HV1L1mkZG6PVPfSR6iMONZ+NyooreYw
         P7iQ==
X-Gm-Message-State: AOJu0YyEKvvsK3y5C4eSFC2gXUCwuMwFgAFtudSLLw9upUCmmjyRWSZs
	5WhluzNyQT3Ve0UfuX73EueSA9mUFNFpezHaemEi2m7SDXxPSDxaaNZ9
X-Gm-Gg: ATEYQzwhWYaszPmn237CUdX5u6Fe27m5R0MVg5RKtCY9TZkGSy6S/BQcQDs5dMJVUFj
	bba1VB12DvPOQWxuBx/EpLeCbjizCYwQzC36mGsv3EkKUh6a8CUTfIfn3YWygdOLwDWZZw2HWbP
	ZQ5qBEq314jatKQzGZszmyj4zoBW6aH7yu41iyV38++jL0o1pOK3cVWlTT43lQnNIMcySzepnxK
	cqn4I6F6q0HCOQrt/7U8mrsvDH0QCJjjDzgqopW2Rz23Y6olWELpdVsS3wlHQX7ygbwKmQMP+Y+
	7UGHxwKX4M6ddBzfr5l8sGvzg7kUOpb7uABVoitiQ+EZ+iyuAqsNHqC22ZuxckcP/wt5YCmZqVo
	9kMtMyLZSfImRWJ4jdBfhj3/hD73SNz+5ChTWt23Qp2+UZLwxUKZNtclfYsGYnC3B1yzapKyafg
	bj1LEn8AONZnUbDa4WHc9l6OpdTz7xKys604ihsC+Q+J21PEjdhNW5l3dmH0Dpq1yl055qLpd+j
	Q==
X-Received: by 2002:a05:690c:c247:b0:794:87bf:76ef with SMTP id 00721157ae682-79a81a7fa9fmr23274817b3.7.1773896044146;
        Wed, 18 Mar 2026 21:54:04 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:95a7:adb9:1a5f:f78b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a7136e513sm30231457b3.10.2026.03.18.21.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:54:03 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt792x: add common USB transport reset helpers
Date: Wed, 18 Mar 2026 23:53:56 -0500
Message-ID: <20260319045357.13796-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33452-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.617];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 1D8D32C6112
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

Add per-device USB reset work and a control-path access check helper
for mt7921u and mt7925u.

This prepares common infrastructure for transport-level recovery while
keeping the reset state per-device for correct lifetime handling.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  2 +
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  2 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  5 ++
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 50 +++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 17057e68bf21..6be28f4152ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -196,6 +196,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &hif_ops;
+	mt792xu_reset_work_init(dev);
 
 	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
@@ -244,6 +245,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 
 error:
 	mt76u_queues_deinit(&dev->mt76);
+	mt792xu_reset_work_cleanup(dev);
 
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f03856d..8b5d58125352 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -184,6 +184,7 @@ static int mt7925u_probe(struct usb_interface *usb_intf,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &hif_ops;
+	mt792xu_reset_work_init(dev);
 
 	udev = usb_get_dev(udev);
 	usb_reset_device(udev);
@@ -232,6 +233,7 @@ static int mt7925u_probe(struct usb_interface *usb_intf,
 
 error:
 	mt76u_queues_deinit(&dev->mt76);
+	mt792xu_reset_work_cleanup(dev);
 
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4ff93f2cd624..5f06074591ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -243,6 +243,8 @@ struct mt792x_dev {
 	wait_queue_head_t wait;
 
 	struct work_struct init_work;
+	struct work_struct usb_reset_work;
+	atomic_t usb_reset_pending;
 
 	u8 fw_debug;
 	u8 fw_features;
@@ -489,6 +491,9 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool resume);
 int mt792xu_mcu_power_on(struct mt792x_dev *dev);
 int mt792xu_wfsys_reset(struct mt792x_dev *dev);
 int mt792xu_init_reset(struct mt792x_dev *dev);
+void mt792xu_reset_work_init(struct mt792x_dev *dev);
+void mt792xu_reset_work_cleanup(struct mt792x_dev *dev);
+int mt792xu_check_bus(struct mt792x_dev *dev);
 u32 mt792xu_rr(struct mt76_dev *dev, u32 addr);
 void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
 u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 47827d1c5ccb..2558d87b1e0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -11,6 +11,55 @@
 #include "mt792x.h"
 #include "mt76_connac2_mac.h"
 
+static int mt792xu_read32(struct mt76_dev *dev, u32 addr, void *buf)
+{
+	return __mt76u_vendor_request(dev, MT_VEND_READ_EXT,
+				      USB_DIR_IN | MT_USB_TYPE_VENDOR,
+				      (u16)(addr >> 16), (u16)addr,
+				      buf, sizeof(__le32));
+}
+
+static void mt792xu_reset_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev =
+		container_of(work, struct mt792x_dev, usb_reset_work);
+	struct usb_interface *usb_intf = to_usb_interface(dev->mt76.dev);
+
+	if (usb_intf && usb_get_intfdata(usb_intf) == dev)
+		usb_queue_reset_device(usb_intf);
+
+	atomic_set(&dev->usb_reset_pending, 0);
+}
+
+void mt792xu_reset_work_init(struct mt792x_dev *dev)
+{
+	INIT_WORK(&dev->usb_reset_work, mt792xu_reset_work);
+	atomic_set(&dev->usb_reset_pending, 0);
+}
+EXPORT_SYMBOL_GPL(mt792xu_reset_work_init);
+
+void mt792xu_reset_work_cleanup(struct mt792x_dev *dev)
+{
+	cancel_work_sync(&dev->usb_reset_work);
+	atomic_set(&dev->usb_reset_pending, 0);
+}
+EXPORT_SYMBOL_GPL(mt792xu_reset_work_cleanup);
+
+int mt792xu_check_bus(struct mt792x_dev *dev)
+{
+	int ret;
+
+	mutex_lock(&dev->mt76.usb.usb_ctrl_mtx);
+	ret = mt792xu_read32(&dev->mt76, MT_HW_CHIPID, dev->mt76.usb.data);
+	mutex_unlock(&dev->mt76.usb.usb_ctrl_mtx);
+
+	if (ret == sizeof(__le32))
+		return 0;
+
+	return ret < 0 ? ret : -EIO;
+}
+EXPORT_SYMBOL_GPL(mt792xu_check_bus);
+
 u32 mt792xu_rr(struct mt76_dev *dev, u32 addr)
 {
 	u32 ret;
@@ -333,6 +382,7 @@ void mt792xu_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
 
+	mt792xu_reset_work_cleanup(dev);
 	cancel_work_sync(&dev->init_work);
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return;
-- 
2.43.0


