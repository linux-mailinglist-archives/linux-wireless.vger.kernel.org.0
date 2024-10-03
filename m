Return-Path: <linux-wireless+bounces-13480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3098F5D8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1044D281FD4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453271AAE28;
	Thu,  3 Oct 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyyfDDC4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1A1A705F
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979035; cv=none; b=Umh8/wbd0yeZh7gbH5pRHRxkp2k34nxAGS1H2RBzIMwbWgH+JFeu+5pn7Y/P1tlwJ4DjdJ9AvpY5LfU0E9Xh9NfD/0ArT8+OHTpQ2gzM/WcPrshTQjAVEciy607o0S9mgHy3rxL37qPQSOYil6ENqRM9ol9M90kOoWVCFCVuQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979035; c=relaxed/simple;
	bh=oxaRoclMddkWq7mSKvY4Ig5pTgMrYThihGewsOQjR/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G173mPDmQKcV7+xfVvK7haeZbfne3ETrA+gFZfKmHAqNHj1/+8PTharRSwFN15O05MZr1NzGUj3+MQyIGA/94DsP0Q86IVRGgiGCKOaxFPioEKU2C1i0d+4L+cwQHSti8PgHel9u9ALaNb9az0h1xxV1yegF7KhlHAKWG4kzQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyyfDDC4; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-7a99e4417c3so100090085a.1
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727979031; x=1728583831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stIg9esjqTBVOCrbixO0axas16PaKZ9mDSWypU0VeBY=;
        b=JyyfDDC48naqdscNcJBZYZGScoLyIqy4z+6YRhbzt6GH/zd0aqAWtY0Y9Msr9+4NBA
         WgFm7m93EsUIe2x7AACSWxiXPQNmbb/zY0kbO76fjIu4xAgYjTMw3LzwS80CkIiPHZi+
         Pnq8/Dy1dvMlHwKi64wP6vVQXtdbSHED3msekzfnIHxQWY8sAVr2Tv/ZjZOQqDfFbl37
         UEheJRRKi0f9gbz9d83cWOseIwNqCAB8P19adgY8/8k6ixHeBsB1F4R4aNSLfr4QMFtL
         Sm7gQqUOmDC+mN/M9m9j2gPOqjmeTE9FU9hvke2mKBBaORShyLm4UuBwio2ZPeGS70H9
         6Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727979031; x=1728583831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stIg9esjqTBVOCrbixO0axas16PaKZ9mDSWypU0VeBY=;
        b=Fia+RByAbno6YKBJtvMdpb/mJaaOtmX0g4hRuAZbdnTtlrVTJ4Q4eSvt7XeMuVvyH9
         TVltysj0kdrrVCbqUojE4YAf2CnkP5hSNKjEcEo5M7FbknnUfQOTCfTrCs7d3jTtpbd4
         1nj9Y7eNBudnlBwKEGi92xTaU/i5x1RgMRbmG5X3qFkIpO+GgkUWQk+2HqrjbvaaS7BH
         pgD9Z3klCVfsBbuBWq3hmk/L3XlS3bMIxu+JKoBc68xX6M4fIX4m0rrN9d+eITZGtTdk
         cY/42bZcY9Gmucj5OpG9AQWradxHZfDJWkBDW9PPAZgK5UQMwP2n9eCjLQ+7TAQu3bkA
         0WxQ==
X-Gm-Message-State: AOJu0YytqhO9bSNy6CfiZYM+zop3NYi+Zx4+qDUwQ4cxKPf4L0/1XXHB
	yBeJpCsm3QcTLdt5lqVc2RKDezanIkPwO5GPoLjWfyVzHDwmNKZj
X-Google-Smtp-Source: AGHT+IFTmn46ifwLoMc4eILjoM44c4aHtVzURhmUi0RKIZEq8CxXspB4gOtL7Nd6CsXfGNQ/pWRJew==
X-Received: by 2002:a05:620a:2443:b0:7a9:b744:fc41 with SMTP id af79cd13be357-7ae6f43705amr21400685a.14.1727979031521;
        Thu, 03 Oct 2024 11:10:31 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dc0bfsm69082285a.121.2024.10.03.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 11:10:31 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	allen.ye@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	Bo.Jiao@mediatek.com,
	evelyn.tsai@mediatek.com,
	meichia.chiu@mediatek.com,
	krzk@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
Date: Thu,  3 Oct 2024 13:09:59 -0500
Message-Id: <20241003180959.12158-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

mt76_connac_get_he_phy_cap() may return a NULL pointer,
leading to NULL Pointer Dereference.
Add a NULL check for the returned pointer.

Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 87d0dd040001..762be3a37228 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
@@ -1145,6 +1147,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7915_mcu_sta_sounding_rate(bf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..55e4cda2f20f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6c445a9dbc03..55bb2d0e67e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
-- 
2.25.1


