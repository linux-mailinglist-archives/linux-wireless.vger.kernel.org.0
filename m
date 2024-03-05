Return-Path: <linux-wireless+bounces-4393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4487260D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DCA1F21DD6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D1BE4D;
	Tue,  5 Mar 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="lYTe0B4H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCEDF5B
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661371; cv=none; b=rrREvUSOFc9Cq9bEL0ZqsWXzia56J6UUkpw+HM1SzMEu2QC8USSX74zXXz33NNDiY8Heg1pIb5ZtOEF1ZD2R09sK4s25Ft8gFKB5H2btOHr9EfhePUZmlTLCsAQI/aFgS/RRo8xhWRxEriMLmIXvbSiuF/feuAI5HZ+oaPyHBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661371; c=relaxed/simple;
	bh=oDsOsTeiTrnHZ6Ml0OymUtjzxHBbtozFlOmA7lhZg3s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e4SO+5q4lS4mZY4yIQ5Y5Qwq1ZlFi00hhN1a8qE+fLn8J/JZOJIx69Mht8LSoDZ5P9neUKyJcGIO6Q4sC/HiIrnciUXh4f5ZfxDclexkWpDw7u4UyzGSiyJdlrQqf6jAZcBu13q7DJuL016hKwqnjIieKfYGHiPhjooPfetll0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=lYTe0B4H; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail2; t=1709661359; x=1709920559;
	bh=LCfHSJif2IzTulfiAhxVZDIoy9aDonUR7qQ6uLz691o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lYTe0B4HlEQUx4SQEzJDZQaKmxugpsW4T4zNt82JJM8zaQoLmxHbfVyuopBecSDzJ
	 nSvcOj7m58LPqiIvx5ByUIZRUXyiLYs0wzRevJoNdTylj9GBCTBZ6rG+C5tbwrm5WW
	 M5ZrUnAJDVNlwrwPoG00sW7w5EALbtQde9WpGOUx5tCZDVlsgMjVetyc7nbbzi2y5W
	 Qo0auFI7EVGvSuWESyom0ltI+YwK2OPWs6qoll+VJEBg73U/s1PZiGDrYfp2x8SePl
	 oWH8DTrKabi7jhspVJWDTeCuCnNA6U3A02X85jrpeIhZEN6bnN3bAz+Xq1lXasEWK0
	 fbt4gFZf9nshQ==
Date: Tue, 05 Mar 2024 17:55:35 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] wifi: mt76: mt7996: fix size of txpower MCU command
Message-ID: <301ef7cfecc47fa488fdf172596c9ed75719410e.1709657969.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fixes issues with scanning and low power output at some rates.

Fixes: f75e4779d215 ("wifi: mt76: mt7996: add txpower setting support")
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/=
wireless/mediatek/mt76/mt7996/mcu.c
index b44abe2acc81..cfb5a7d348eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4464,7 +4464,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy=
)
 =09=09u8 band_idx;
 =09} __packed req =3D {
 =09=09.tag =3D cpu_to_le16(UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL),
-=09=09.len =3D cpu_to_le16(sizeof(req) + MT7996_SKU_RATE_NUM - 4),
+=09=09.len =3D cpu_to_le16(sizeof(req) + MT7996_SKU_PATH_NUM - 4),
 =09=09.power_ctrl_id =3D UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL,
 =09=09.power_limit_type =3D TX_POWER_LIMIT_TABLE_RATE,
 =09=09.band_idx =3D phy->mt76->band_idx,
@@ -4479,7 +4479,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy=
)
 =09mphy->txpower_cur =3D tx_power;
=20
 =09skb =3D mt76_mcu_msg_alloc(&dev->mt76, NULL,
-=09=09=09=09 sizeof(req) + MT7996_SKU_RATE_NUM);
+=09=09=09=09 sizeof(req) + MT7996_SKU_PATH_NUM);
 =09if (!skb)
 =09=09return -ENOMEM;
=20
@@ -4503,6 +4503,9 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy=
)
 =09/* eht */
 =09skb_put_data(skb, &la.eht[0], sizeof(la.eht));
=20
+=09/* padding */
+=09skb_put_zero(skb, MT7996_SKU_PATH_NUM - MT7996_SKU_RATE_NUM);
+
 =09return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 =09=09=09=09     MCU_WM_UNI_CMD(TXPOWER), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/n=
et/wireless/mediatek/mt76/mt7996/mt7996.h
index 36d1f247d55a..ddeb40d522c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -50,6 +50,7 @@
 #define MT7996_CFEND_RATE_11B=09=090x03=09/* 11B LP, 11M */
=20
 #define MT7996_SKU_RATE_NUM=09=09417
+#define MT7996_SKU_PATH_NUM=09=09494
=20
 #define MT7996_MAX_TWT_AGRT=09=0916
 #define MT7996_MAX_STA_TWT_AGRT=09=098
--=20
2.39.2



