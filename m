Return-Path: <linux-wireless+bounces-33453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPStGnuBu2k2kwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:54:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F32C610B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 05:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9F86301F686
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468D2045AD;
	Thu, 19 Mar 2026 04:54:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC672571A0
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896055; cv=none; b=bErLftE8rzahBWyGhzDx+m+byVVC3UuGY18czO2PUQBXY2RoxWBc/F2pjoyiCCWMrRe89kLr80AdQ1HyCDP8f9CKUdkXoRrjkllchuxZ5vBVwpD2DCRm/eUtcBRbFXirxynV/d+TFob9IRvIN9S+DyHN6wNrrOIh8vs468Yq/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896055; c=relaxed/simple;
	bh=3Zo+9P/AhySibJwjVCTEwrEGDZWf8d5JfSB+gdtV1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PADARxoLBV+4PLrshqElxLapl1Mv1FBR4k/5c3gZd8QWxajN5sZYTyCS0JThuFMfezrEW7Xhqtabrb5MWQlaCK/OadppRtd5BTOEwJiaVkiRyVeVgVgjrADHK9Yq8mIyuU2hvovfDgY9hhtZHCrJNOKo9spL8NfPJLhBUE4hrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-793fdbb8d3aso2260787b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 21:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896053; x=1774500853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4Eb1YOEfRdkAVtKY58j579uUe7kZ9Q7QVxwqWPHF3s=;
        b=E0tH2QUTs711aGE8nDZJo3hzLTeqUN55d/uhuCbcdwdSCl9nsR8FlkPsVEd1fHM7Fn
         fkTC3g5K9WHqom58TscRloFANCdI8qDHBQJF7nTwWQJTPkmluah7Gy/68cgU5ppkUnsJ
         zhQcrHJBFSHFqRGpIxd111Eg8YjJ3zqdLPjNCafHZbgpp5qkNJnhncik5YMXI8UVUXnj
         k6NIEgLtXpihzoeiVJjVZmvOS/UBN/DQi4rJJZ1DOFnqo6SK7MRTlqJed4pn3PjjDPhh
         I6Y6KkUB8U7myfFYqwCSHEyxNErkFEBsJs4X+ivr2vI51fx9Mq0t13Iadzd01oDpcvgR
         oTSA==
X-Gm-Message-State: AOJu0YziaVU7CPA142G/LEs3Y0WWN6WiieAskPqFxPguLuHqf0x1Gs//
	KQeLyD4spHz+eK/kvJlY9Wz4WTdW05yQtnW2WWzS1e40eejQNdvb221wtAcdtA==
X-Gm-Gg: ATEYQzxyUJVq6JsHD8KNeCaHmIyqxNArjTzJMWcCo5Tb8dmBF/npa2Lz5mGCWPcUTsQ
	NztzyH5heihM9dTAY261drBgc6680IdUcUg2L16BPJbBn/KHJ5uQaSDCHoFO/orA8OTT2vOq5x1
	VyFOx0Ri4x/Upe4zoAv19RBfpRDVUdHPMxwLtTzC9/d2UpAb6Wk52Hw2Vg+7JxtQDJcrzkPG4k1
	hPk/Hjk5xof3b8hkXBSzU73P5T1RMvlpX81bqb1cwd1UFKg8LZ+2HOJxUSJhO+7n2aNolBvqGTs
	7oMoDR4VP3TGqrKIgsdlfGNZpM69+R/DuNVTKLTRe8TEYa42jSHE7ZU8dIVqOOBCdDodqgHP2/R
	4U0xK4bOV1//zoLEAq/oRMequKeC9I9CLPz4m0r20dqCrsdnEWxbbxogwyg7wJyYhllsMb2b2WI
	WIujucyo7njfuZOfA0fMpLrIWt9JIcxcc55EdB8Glfe7dIStVrv9ZIQZMyEfbwE4dOjQQQvDlOh
	A==
X-Received: by 2002:a05:690c:85:b0:79a:40fb:933f with SMTP id 00721157ae682-79a71dbc38amr62618697b3.51.1773896052831;
        Wed, 18 Mar 2026 21:54:12 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:95a7:adb9:1a5f:f78b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a7136e513sm30231457b3.10.2026.03.18.21.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:54:11 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7921u: escalate broken USB transport to device reset
Date: Wed, 18 Mar 2026 23:53:57 -0500
Message-ID: <20260319045357.13796-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319045357.13796-1-sean.wang@kernel.org>
References: <20260319045357.13796-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33453-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.455];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 111F32C610B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

Check the USB control path before running the normal WFSYS reset flow.

If USB access is no longer reliable, stop the WFSYS-only reset path,
mark the device as bus_hung, and queue a USB device reset instead.

Reuse the existing bus_hung state to represent transport-level failure,
keeping the semantics consistent with the SDIO path.

Also initialize bus_hung explicitly during probe for consistency.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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


