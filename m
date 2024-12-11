Return-Path: <linux-wireless+bounces-16216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9179EC16C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F5E28432F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6272451D0;
	Wed, 11 Dec 2024 01:20:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197313C914
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880008; cv=none; b=sNgpwTeC/yyw/S9pBk+gMW8EMj4s962g1BP3IXix1HH0pRsBoIIOjkSyP0qKruLP49azxiwhoAat376MEkewOyJLlRJLv8irK3YadOTu17dSOnLp4stF5f+rP+5pt6jggASJjJ3MbmfayvWOZs/5sv5qIdI2oJOw2abX/4z7EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880008; c=relaxed/simple;
	bh=pK++0OLvgOIrMemRBrSy+rWTQfCSK6vdyInOX1CbyFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMQcgyzot7BiubjM+dFqpSx9PmvZfEKr6/YF+wo8CK+uPsw9RECzVWKD9RxIIXgc3ketbosEPwk4bqc4Ay4to03TE3j98wsIikOpDx/Oba8u1imb8kAyAtrabtX07jgaPmFtE6RrmV3ctLRg80DtBhYLQFEYZNOhWh3NDSlStMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29fcbf3d709so1001539fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880006; x=1734484806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEJ5kdrUNfjAy+icZnm1esu6rZ7qPtHroRsyBXfTsTs=;
        b=czkUdKMwIx7dgtjyvbVbMobs+RDw9ItGbznXLQ6RjuHl+6HpWguXzE+7x9VpAvfB9v
         XvJl8Nirpolynh7QjldDZqlJYBT/5Uje1/Pi/fok0yqnxE8sXK4q9YnGOb6Dh7AzishC
         qWL8kOpWRAPWHoCvIGZjaFlXuCwaG+bO5jN/S3jHjKG+WV7/M0geonfGQIpwcQkgRfBz
         VvH9Er9/FVlWyDGwFf6LhMGbU4tfH/TQ+yKebVAMiZ+N58wVnOMe+Z7zd3V6Xxl8e/3E
         NWfS5W6vswSO03VNGwX8S3WzR8FVs0VrXKBE1Xq0J7FOn78ZWaVgSUF8qO7fsKAaKULJ
         49Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUWSKt+2ATMMsltXCiAB8ncdxUzw3mhu+tE483TTvt0IFbQmOEcZD3yPIGvQZoROvMM8Q9UkVnJluD3KzQgGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6377kMZLs3WpTMg1B1pIJ+TWXSo79Q2Uepd+aGWAXLzCiU2bN
	ZVr2q4DrdfgHkXksziqRgkvGLwtSnC5VRcpf3RZd5s2W1r10AStd
X-Gm-Gg: ASbGnctR/bxH+6xJtFbwFfzAySm7+klDqFZ/G5hVP1dDMp1/0R6e2ecOmRWn0Qa5wvK
	emZUpUMKL1Sf/SpC9HMESd9diZazsckdAaw2kY0vJqweTQNHn9/ynjYjiO8GsZxSbilBf1oZLv8
	ZJXP9XFjUQrdAVFmRxoaGV5ZvUo60fnr1/tqHxppDfZ6aQM5f90opkallrFTvmxR7dNk1hRiIT5
	bH32Dwyi2L/DTll7Ui3F34ffl2lKmVcs3HHkAGt04ri6P1fSG0/TcPX5tzcy6/PyT+Ibxo=
X-Google-Smtp-Source: AGHT+IFcQ3gUsYitlfCkN5kLRyrQGJyfYcf884guORROPcDHh0Lvi4yEHkFTf9jFWu3U8jkQsLxilg==
X-Received: by 2002:a05:6870:4990:b0:29e:671b:6003 with SMTP id 586e51a60fabf-2a012dc69ddmr561652fac.32.1733880005778;
        Tue, 10 Dec 2024 17:20:05 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:04 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 08/17] wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
Date: Tue, 10 Dec 2024 17:19:17 -0800
Message-Id: <20241211011926.5002-8-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

In mt7925_mac_link_bss_add(), the mt76_connac_mcu_uni_add_dev() function
must be executed only after all parameters have been properly initialized.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 97b48fda5595..93e00a3840fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -365,18 +365,14 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
 			       0 : mconf->mt76.idx;
 	mconf->mt76.band_idx = 0xff;
-	mconf->mt76.wmm_idx = mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
+			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
 	else
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
-					  &mlink->wcid, true);
-	if (ret)
-		goto out;
-
 	dev->mt76.vif_mask |= BIT_ULL(mconf->mt76.idx);
 	mvif->phy->omac_mask |= BIT_ULL(mconf->mt76.omac_idx);
 
@@ -395,6 +391,12 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	ewma_rssi_init(&mconf->rssi);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->wcid);
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
+					  &mlink->wcid, true);
+	if (ret)
+		goto out;
+
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = idx;
-- 
2.25.1


