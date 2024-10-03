Return-Path: <linux-wireless+bounces-13477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D6698F25B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A59281689
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F191A4E8A;
	Thu,  3 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lURfv9C+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAC19CD0B
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968730; cv=none; b=lnNT5avAl00JlY7tfpgehZSZH6FoP4kRYULXPl6ZXOclrIEVKfAxhQsoACRNwpFj6tpiyaQTzoknLK/O1LZyd91Amb4F2rxP6bEWByNmJXtN9OQcx0Hl5TUfyxSo2z30fSHKTdo+SxWNvwTGjVluRC7nWD7aXHgH1Xpa+ACISOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968730; c=relaxed/simple;
	bh=oxaRoclMddkWq7mSKvY4Ig5pTgMrYThihGewsOQjR/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgdjFA8q01In6xsj86p1qelH04/TtNt3zTTAaWDCL+YPDg7WqXIQD8X66zrWk0RCQqPfYnmMaFq+mzds6XTTxI/rtun10gtnESXlfZZTqpaUL0fCvGPjqCJe5uk0q6X1zywCVeDqWTxs6JkgMRsMDdxnpCyRn08Ic/5yE5GXXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lURfv9C+; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7ae3e3db294so65843585a.2
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727968728; x=1728573528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stIg9esjqTBVOCrbixO0axas16PaKZ9mDSWypU0VeBY=;
        b=lURfv9C+v5tYmUnb+5tPIHVQM6+oBtkll8YRrx3vAf2wo4juzE6e6kJsCy6PwDB3dN
         UIiyg32BoRxLPQw3877Mg2Yl96S4K06dnA1tgTyiiGwoud07+VAvji3eT6SHpuZMCnNt
         vc6CJCCZB+MCmjGRjQ0CrbtbHw7P6gex5NzyMnMaPbo8lg/r50sk2P+dQuFp06K8zple
         EWmWNsDB5HCAxZMTg4DD8hOc3Aoz8T25D/NZtICDdfyHa8pYW9HxFOdvaVnpIHldLc0N
         weIgsph5NjoJecS2lUYDcA6qzep0Msp8nfTpRzWOs9VlF249FGFAdm0s4HBNqBz7/fI9
         G2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968728; x=1728573528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stIg9esjqTBVOCrbixO0axas16PaKZ9mDSWypU0VeBY=;
        b=FLPIAXPtR4OG/CqpuW05AYE1NPGebWPs5XESXRAYM7ZHFMPQaGDcWXxtBsl4tNslLP
         OKdQb21FCPefeejXrXdt9PSwZvqJJvG+j3giw3VEnfdKnfHwxiFuU04/plMfc9FbriUn
         5+arit6DUu5oddCnjd3F7AKDtl6ZBW2jXsIAmNcKan9YvVpgySgcpoj7vh2bfSyV5Jv0
         JF5WyaghaGI4zCEtmCLug3nk8Zty1Jh/PQU+NK69sNTbH8qxuVlV50G1nFBHoDmOmogq
         GOB/hNeLc590vOU0J/uGvxBG4RipoPwN75GkLxtiUvM2wyN5X0auVn7Kb+7E89m4b2z2
         6qmQ==
X-Gm-Message-State: AOJu0YwBFaqzKTZXzFrvgCRXkgdZTUM876GQs4uEG77dtUOR9CIcAv3+
	faWost2d4koyZL1mpk8IX9a/xAKCxbUrIL2yRin72ofzM8xhmrUW
X-Google-Smtp-Source: AGHT+IEEFCsn4Q8lDCX9rG6BVsdQIU3ZEKq1t0MeNAyWegDJjg27MiEV03EeXDXAe5GTZPR/e/AgeQ==
X-Received: by 2002:a05:620a:440b:b0:7a9:c406:eebd with SMTP id af79cd13be357-7ae62727a81mr1091650785a.42.1727968727726;
        Thu, 03 Oct 2024 08:18:47 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39a497sm58710985a.37.2024.10.03.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:18:47 -0700 (PDT)
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
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
Date: Thu,  3 Oct 2024 10:18:20 -0500
Message-Id: <20241003151819.7977-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d69448b-10ff-49b6-bfd0-6146ef04a0cc@kernel.org>
References: <5d69448b-10ff-49b6-bfd0-6146ef04a0cc@kernel.org>
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


