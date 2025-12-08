Return-Path: <linux-wireless+bounces-29592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784DACAD5DD
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2E263007D4A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF5217659;
	Mon,  8 Dec 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="gGN4BksY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD518DB0D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202943; cv=none; b=l40+ofu75Cc29prIrn1v9aX9HwLvY0o4hBKChDRqQEKy1PkRNAESWRTpMKbu2ks5o9gyrCHU1gGxK6LAW8tlmnvJvwHULYjJ+CTp++xYqLyorAXjjrQrojLcy0y00NokkIFP7pKxCcucr+BqXrRcZUdnwphWxtIK8EM1MaQYGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202943; c=relaxed/simple;
	bh=Cq/QwyGbw1Ux5TZnBkH3i5CCP89CVlUJ6+vm+ONBEds=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YlDrawd4sp6dJvhl58ZYeSwSN2nvaRH/XqKVifoTQJChDc/0nsgmRTqyf5E0CMsEVUqHvkVRCJcsUCSF1xQ9e82cp5gYLYTBEDdUZuvojh9KSFEFxpFQ0oGzYGhA5gC/vzGbbgTXCtXZPBVwkE4OLP4rsSo/BqNgtDDcAw7/V7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=gGN4BksY; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765202929; x=1765462129;
	bh=7xKKt909XKM2EH3yOIWAoQAaZo8e2mCfrm92d5bodac=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gGN4BksY/W6FGl7tKzpSVB/QbMuy02ZM6RarW6y2Os3Dz1BG/BsZ2ujGDNxjLY6H5
	 ZCjWdeKB6yw6Vzwk8jX3/kBZ0xLo5/mJVv8Bz8aXNhQPkBH+DSmkfA85WGyk+hle1N
	 CzUrX9oMYJM6Pbqaf6/O0YNK7HDEqeYkh8KTYKW+INYDvc6L5dT9Wq0nGJkuCkG/1c
	 0wSG6qDV7nwvpO5gXvxRljScI5QfsPOKSMfNuDBXqD4Q3f41oiVdtQMgyyIVoCOXBP
	 n6hCtCfsw0yQpRnFWpJdO7RnMTmLEMSwKnXnVFokfUL9kb+9YmkscGX62ScqAH939L
	 L5p8zT78FanFg==
Date: Mon, 08 Dec 2025 14:08:44 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] mt76: mt7996: reset device after MCU message timeout
Message-ID: <27bebda195599b55d097f4586a034dddce5d2cc0.1765202889.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: b71fcf917b3da5fa424f8b06dd84a0fba461e2e3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Trigger a full reset after MCU message timeout.

Signed-off-by: Chad Monroe <chad@monroe.io>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89..07b0a694c1bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2736,6 +2736,11 @@ void mt7996_reset(struct mt7996_dev *dev)
 =09=09return;
 =09}
=20
+=09if ((READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA)) {
+=09=09set_bit(MT76_MCU_RESET, &dev->mphy.state);
+=09=09wake_up(&dev->mt76.mcu.wait);
+=09}
+
 =09queue_work(dev->mt76.wq, &dev->reset_work);
 =09wake_up(&dev->reset_wait);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/=
wireless/mediatek/mt76/mt7996/mcu.c
index 14a88ef79b6c..40ebda9a3f12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -209,6 +209,7 @@ static int
 mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 =09=09=09  struct sk_buff *skb, int seq)
 {
+=09struct mt7996_dev *dev =3D container_of(mdev, struct mt7996_dev, mt76);
 =09struct mt7996_mcu_rxd *rxd;
 =09struct mt7996_mcu_uni_event *event;
 =09int mcu_cmd =3D FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
@@ -217,6 +218,14 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int c=
md,
 =09if (!skb) {
 =09=09dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 =09=09=09cmd, seq);
+
+=09=09if (!test_and_set_bit(MT76_MCU_RESET, &dev->mphy.state)) {
+=09=09=09dev->recovery.restart =3D true;
+=09=09=09wake_up(&dev->mt76.mcu.wait);
+=09=09=09queue_work(dev->mt76.wq, &dev->reset_work);
+=09=09=09wake_up(&dev->reset_wait);
+=09=09}
+
 =09=09return -ETIMEDOUT;
 =09}
=20
--=20
2.47.3



