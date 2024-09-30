Return-Path: <linux-wireless+bounces-13341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09B98AEF1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A590B20DC9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA517C7B6;
	Mon, 30 Sep 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+7BhCpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B118E031
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731237; cv=none; b=tOVbmS4K6fiQTYhB4qPRlTluIt8AoauCbkSJLWZLPzcED1/rvx88uW//hsDc7S6Jlu+49FNI0kbVaI5nXBNfCIYVTy2WXBg0xjnfU8JlXYVx2YKvelFuKjB9r+eqyyzgzF/K9EgNlP35u+ocdb4toC7B5bOQ7iKlhvZPAQai6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731237; c=relaxed/simple;
	bh=eUqKwp7DKuZLZCL8HYkcOqfVPNW3kVNWj8Hk+MzINbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7JgyXD/G9lEOqZUUiPlOLjpPwHbBJZEItd5+w4YB668xT6YBt9tHKUgz5A3vWeK3I6eOzvP406PRD8eoTtpylAclqHrWzVCRPcrADrKzFytLZodzpcP6c0RtvjzWftvaGkNy5Yt7TXEEpefZZcsbxxVVbvgl5ZZ0MqMFAFX2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+7BhCpZ; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6cb4c013b78so22013336d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727731235; x=1728336035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsQ/e2xiI+dJT8z4JJ8m8p+LUueRGlcK8RjgeON3V5o=;
        b=D+7BhCpZhvLU4etZKvxjO8HYXGVgbISKEMWMbzJP2QK5+X8mHP6rpuXC70T9HPzJwM
         fbBkEU3fovFqDBz98XkEC4mcqCEEzQHJd+gbVWH0kwBAs865gMcrehoGzbeD4SCblcYx
         XHZjJRliMFGS+AdnRORRcqQ8xiLK0l1PiXREquo1K2LGVLA9xOHeIpWwMKCqmVZbWQ0m
         0Ta3ouxbX6afi+CeazJthzOKJzGKSemBVTG1L40cNns4bfHowiNcVZIDMgfEn9RNGT9W
         JQ6Wur5sNklinviJP5ixNaQsP2ccCtINmJL/WpaTs1V5yX7we5EIMLPWXFNp9CFTjdwd
         tr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727731235; x=1728336035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsQ/e2xiI+dJT8z4JJ8m8p+LUueRGlcK8RjgeON3V5o=;
        b=bPfrWomCdpJoygzipKL2D+HpFS5k8qPXQepREbngv6XWRGSE9PcNeZThRWrYxiRchP
         SQxWJUCJ4y5hNkQDQgmeGIJDBztxXB2ylW2VZ4fwrYoK/e5gHUpix7pVcL0BIlz2hX9V
         SL1r1s5CfPvM/8v0ilBcv5OZwbUJmWSNSLpn2e/Me9ew4TBPVOEICcULC37m9+1SwmL9
         MDt6qMrhNOUR1RnJYRtB9z8SPcp9YDr316tHjENavIvv1MH321jqY2QNnwKSoYl2iTQ7
         uVGuOr/pc0jaOUczwhWTzJtgpqaF6e+F+e4dnFdGExCNZ9vozlih6u0cMF1hay2ZTcAM
         VYew==
X-Gm-Message-State: AOJu0YzirFNt/chFnUMarEAy/CNyfelc6zmAkK7+YMW2RUUrmAIYUN58
	sWNyUH0LRAJrI7gAD12fs/QhXhgfVMiwvrkiQXatTJXJl/XWL7gF
X-Google-Smtp-Source: AGHT+IGd7PGLabE8elrrXK6SjnFi/BH8/IOka198aIEgOeWLSyPWOgxqBQ5q9mzYuHp41bzSL9jlIg==
X-Received: by 2002:a05:6214:3d8a:b0:6cb:32ef:d55f with SMTP id 6a1803df08f44-6cb3b5b7ef0mr236171746d6.6.1727731234766;
        Mon, 30 Sep 2024 14:20:34 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b630438sm43196826d6.70.2024.09.30.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:20:33 -0700 (PDT)
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
	meichia.chiu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	allen.ye@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	Bo.Jiao@mediatek.com,
	Money.Wang@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Gax-c <zichenxie0106@gmail.com>,
	Zijie Zhao <zzjas98@gmail.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] wifi: mt76: Fix NULL Pointer Dereference caused by mt76_connac_get_he_phy_cap()
Date: Mon, 30 Sep 2024 16:20:14 -0500
Message-Id: <20240930212014.30607-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

like commit f503ae90c735 ("wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he"), mt76_connac_get_he_phy_cap() may return a NULL pointer, leading to NULL Pointer Dereference.
Add a null check for the returned pointer.

Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zijie Zhao <zzjas98@gmail.com>
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 87d0dd040001..941a6e40e94c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -552,6 +552,9 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
 
+	if (!cap)
+		return;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_he *)tlv;
@@ -1145,6 +1148,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7915_mcu_sta_sounding_rate(bf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..1caf3e3e0e87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2509,6 +2509,9 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
 
+	if (!cap)
+		return;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_uni_he *)tlv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6c445a9dbc03..e547729701b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -799,6 +799,9 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
 
+	if (!cap)
+		return;
+
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_uni_he *)tlv;
-- 
2.25.1


