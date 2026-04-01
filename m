Return-Path: <linux-wireless+bounces-34285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDcuOIhtzWnvdQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 21:10:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAA37FAAA
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 21:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD3C305A4E8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA332E091B;
	Wed,  1 Apr 2026 19:06:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D833F585
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070405; cv=none; b=DvCl93S033oPunehTHKO0eIXwR4pjuruyWy+gFeBnV+J950zcDmJXifpymjYvIvX3048qj7MhJanqSMwnilNcvscbNdXVBiJUqnYJTP+gxxWqxcuAOnLk1IeRMeNkXZb9epamUCg9QQJ2g5MV8MMy629IDKgRAnkJfMLtKaNgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070405; c=relaxed/simple;
	bh=UVvNZm1IYUxJ1PjPduDzojP4XDyq7KxKfPxyn0iG+UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhufI2FIGXLadCRYGWO+RqsYtJfGEEyCoDOdqAcHL98ZkM4+0oTBPFWlm59tvNJc75p52wwKTcvmFi28H3t4aAj84GeaNLpI1MbWJppVVAg/cKNHcGZYQpPbE5VVGyzW0CyO431NJHQ2oVj7dx80lKHMjJeCcqV1/6DNmWwGIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-415e568a7ecso57052fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 12:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070403; x=1775675203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhMDaJgdHrBwkyZkpBFRF9FScxuvntJewf4BaEmC6l8=;
        b=snBtw3F5lzpQ/XMCZdVGtE9DTZ7OtMq+HDUYfUqXyzUQaqUlswQa41gpEPwp152RWD
         1rIVF9odTLGcQ9Oy6RUMEcHPH3ZtB/PnFtGiFZ6R9k7p7F80CSiegFQWkcBSKtTPRneN
         0mX/8cXAPyFIdXF8u7Z8vipukT+vc18fNefoyyopVkpmMn7akknwVXITef+JjyA3Mq4p
         mXtXt3JN21yDti3sxoTgkmtRxRGsWvHKsJKmqBm79ey/M3YBkAc/17RkBD0gyggHBsqU
         VS1NEnAcvJFA5mdieRCmHrwEzFzfuR3o3Yc5XZmIwIkng2wViVbhZVxifZRtWpfzw15q
         lvYg==
X-Gm-Message-State: AOJu0YwBkefIAVg8tTWtLGG+OzJhMWpSxaJ7/mmV1h5anBVlSfhpDbkq
	SebmlBCjQtapTFhVpVxONg1X1padAOTDQvfCHJ/tivrCoc79zIRou4la5jXKaw==
X-Gm-Gg: ATEYQzzZ6jVqDZLKLOoqowwC2ic7vbrysYsSKjWdMVWPS8nTqrbkEzGZ+5xvw9AaQ9K
	8GGTK7fpHMk4IxcckwdWcknu7hFGKxInuXPxdNyEH/XkPqf2FkiAnXv1zE3cn5e6SXYjx+oMyRK
	Held/JWHw7YqVoS/ZDTLbJVJGzdW4t9JODdAC0UEoLe0uaLqn8CtWLC8HpzTjeuQuTCVz64V0n8
	q6eM7ZyavwMf91rHsdV2nKNVhpS/ZuJTrAQ5tnH+sEzxv+n9CyPfmeS+XijNGbCqapMkgwTROro
	lJic5f+tT0EjRw7RgVK04UtzWdCiIX4yOO4dH1AIucF75puNoSLnFVquYF5x38pOW8aX9s9gwqi
	TtQQ8d4b/ByZu4mg50HKxTFoW+0RdmgFVv03Dnri3R3Cp8pt3DlCzkUlS987RfQc3vlUnUL5hFP
	IvA9Q4Qdn0gtLGLk2GanevmpPo+zljH64ZZPv7AYy/pc2r6pb2gl1qeENGsA==
X-Received: by 2002:a05:6871:3588:b0:417:533b:79ac with SMTP id 586e51a60fabf-422cfc075bamr3055228fac.9.1775070402752;
        Wed, 01 Apr 2026 12:06:42 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm551867fac.6.2026.04.01.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:06:42 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/2] wifi: mt76: mt792x: add common USB transport reset helpers
Date: Wed,  1 Apr 2026 14:06:31 -0500
Message-ID: <20260401190632.147042-1-sean.wang@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-34285-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 7DBAA37FAAA
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
v2:
- Rebased onto the latest mt76 tree
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


