Return-Path: <linux-wireless+bounces-29596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18465CAD765
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5E730A58E1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1372E8B94;
	Mon,  8 Dec 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="XB344MeR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A62BD036
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203858; cv=none; b=d1r8Uswx5yl2d6eSb0PuVL4oVfdZbkc8Uxs3d0JFJuTMlN8ERPZG8yMhaXgDcaJDxv8ZRMGiFi8h5sACqdJTdHdK6S/46EMljoi+H2ZXV80v8cF2RxMxbKSrhQhUtw9F3qF4i4uS6GzvlssqyDdtin15xdt+UyHBLjsV1MQXfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203858; c=relaxed/simple;
	bh=3QB3vhaNjgLrry53+0ziOLwCPzWrLl5twSEHp1eaPCY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JGRhp8To4+GwUDP+f8oloAoHrXcEo9EninQte+lCOIfRDzWBWa8vlNvvwu1b7ZYRVikNBQ7PXnWwDYqzRYPiWcocbVK5Tq5YhMi/cf7lx5/1QW9zVLhBzo7f/h4OIgBmdZMwfR8QeKVtfJklwQL5JDA8A77SaiPt8HclhuYgv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=XB344MeR; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765203845; x=1765463045;
	bh=7JXAaO2yrn7qeKYGN4H79yr+8ih1bG+MhPK7ncJdHWI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XB344MeRZM5gOQISWT53f1c4JBQ9osAoOW80l11xahnDe/ZwoCd33Iz3qE0WadkIG
	 MqbBbSCnQ4zGGkVWYYe5p6TJ8ojOeVCmOSZHbn00xXzeqxuy7YOnUmP7wEhtpjE9Wy
	 J88NaZKWjYa7wpF8UOCwyN6mPqcFzrlC5SZvgfAKkvBq1EuY6pna9ejxbFYCyOYOsy
	 cNbIJxPf6tM7sZOYAHqjGKAY6v98kfcui3zrkeH5NGqYwt1mLq/9W1IArhxpz4n9IG
	 atbnyITlEmQor4RA5SYsO0b5fNyIPoSK9SAQlTGUcSz8BtrXAnWhsxxO1M++yxbacz
	 9x95l/R51T96w==
Date: Mon, 08 Dec 2025 14:24:00 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH v2] mt76: mt7996: reset device after MCU message timeout
Message-ID: <6e05ed063f3763ad3457633c56b60a728a49a6f0.1765203753.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 80c6cf0b9126d58699fd27e33aea10b608107b02
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
index 2560e2f46e89..2e5f6a2cafe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2736,6 +2736,11 @@ void mt7996_reset(struct mt7996_dev *dev)
 =09=09return;
 =09}
=20
+=09if (READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA) {
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



