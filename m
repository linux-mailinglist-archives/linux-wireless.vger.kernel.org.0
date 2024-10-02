Return-Path: <linux-wireless+bounces-13431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4598E565
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327021C21BE5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A392178ED;
	Wed,  2 Oct 2024 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch2YQ5dK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0B2178E3
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905230; cv=none; b=aondEKPk+uMEXFJ5xfBNLH14gWbCE65RFiBnVGe4Jrywnq6sFmYJ5aIzkLVBiwpyUS3aQyrVfAd+cfkv8C9NtwjyQsoKxhBx+OxU2vp6YCCbb6HYLV+tF+qN20bFkXHXJLDubAa/TONAIbWF9BZYn4LmZXBS3s60Up+hU25lo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905230; c=relaxed/simple;
	bh=09Y9jgHJXp9VnXUD+j6P2eq7N8g4IAfu401C3YlYpMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aiK8m0u8LKOE8jeTXKSGr3DvnZj0xf6QBW4Je4adhitIwAcjMqYTUoYFbbpG8eSSX4Z3dZTXV32jEKbQmiPOJW2H0ibogHy0eVUyHoqyPJDCPCv6c2w/YAcyhVzeyfDZcdwSYr8M1FEre7MQTFuZOBQmFQNX/J5JacUzkJpSeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch2YQ5dK; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7a99fde9f1dso25131185a.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2024 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727905228; x=1728510028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbnx/1jmCJVxpVNY76oZY6UsGEKPb8zsIs5QjFgvYPw=;
        b=ch2YQ5dKhmjbZDpwyJBOpHLGYT8djSgWeyr0Riwdvy9rmyAv/E1kePPFsrl4Ncude8
         Gz7ppQBfIC9N1EKa0YQemhA+cAZHCTjmphLUTlNypKT5N/PXu0B4AJrbqg6/nBFzIBDN
         mH3sQscDxR5XffhCdEqQmSxVpVYk5SXIyX8fhpSUFTEEGRAOgPToGHny2yaeJ45nLBp/
         3Fsz4QLLv12iOmpNfHHtApoziVV2vk/rSWw60pyoZ3JXtr35TL6UZC/YrQoHRrfN+mnA
         BbMgo/37+KmbEuUUuNFegmgTx51+rT+1Qjk4wZVJQA4DWj1s1WALcAU+YtQHvPLAu1nK
         o0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905228; x=1728510028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbnx/1jmCJVxpVNY76oZY6UsGEKPb8zsIs5QjFgvYPw=;
        b=qOsjRu5e6DSP4696dC2V73VRnTPus533XgvxiWs3AVteLvk1kVzf81QXid/r6Nh/2s
         L/sLae5GYwjlQatv7Y1yZLNlxukkVkHau7WqYmIBlLRGXe/7BSVeNRGzre1D+sQ/hR9I
         R5oq7HsyucetIS5YfHEHTAA4zrU16nYTwNISh41ouxn3D21kPZouO9ilkKgOG8CQXUqR
         wuzSgVq03Ke95gBbPdHNSGqAmxfe9tsq8Sfn+oIQ5vouxQjK4JNQykIPQmDCVwpSGbJ3
         1/FION3hFJ1PUMq75xjJjL2hZOxtwmfNzAvsJZrSmer0FkYXNPKFpeRtf3iw3GGgPakP
         QeNQ==
X-Gm-Message-State: AOJu0Yx8g5E8J2qeFO7tun0vCJf6JCjGeySwMzph6MnsxmgJg6KW+QhT
	c6p3QTC/+fWUJyF+7o+nLwPPrFKV5Ach+h+gWy85u5Yd6stxot2FPTJdVngoC5gLGg==
X-Google-Smtp-Source: AGHT+IGvVKxkVzIqO1aVzK1KfhXdUeEPO/IVUAq1zzjzGQn7t7CVJeZqGV2TUekB8BorfcWRHEj7ug==
X-Received: by 2002:a05:620a:198b:b0:7a2:e53:3f5d with SMTP id af79cd13be357-7ae627698ffmr538163385a.66.1727905227654;
        Wed, 02 Oct 2024 14:40:27 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f0e71sm656507185a.71.2024.10.02.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:40:27 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: krzk@kernel.org,
	nbd@nbd.name,
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
	meichia.chiu@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Gax-c <zichenxie0106@gmail.com>
Subject: [PATCH] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
Date: Wed,  2 Oct 2024 16:39:20 -0500
Message-Id: <20241002213919.30360-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c7978538-04b4-406a-b8e3-70d3472ace7f@kernel.org>
References: <c7978538-04b4-406a-b8e3-70d3472ace7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


