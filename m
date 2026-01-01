Return-Path: <linux-wireless+bounces-30264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4215CECDA6
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63753010ABD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82D21D5BC;
	Thu,  1 Jan 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id1BZePZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2421FF2A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248747; cv=none; b=drwB/ywmTQahnweYqGaEFRHjuACHbVr/p6YBlq78oVR6b8lv00heWIzRWiTMo/QbcwPQuaXASe9fqfjEFiDZu3tjqfECMy/I46jD807ywMkOdoxd84gx4htjyVKjj2kR7ViZFEyPElGaPsxxr/bCXXtglfJkfCjM4ISiJGJhb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248747; c=relaxed/simple;
	bh=9dnxJtj/RMl7V1fwPhsCNOnG7O0V0CnuufX0uTayI6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgVVKmuaRGUhKX2UOgqNCjq/eXtMCKdXC94CtG7yPF0rLpKQ/fHfvDi7CVgWXQ/WTf9XWOxint/Vv2EMd9n011rVsq43VLiFGXyzU4o1CiAw0mqQ07Fum50Ds67+c4mYvVwcBJVT/YD523ImEHCdvPSLh75sGl6gZJyTC+Zj9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id1BZePZ; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso6405779a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248745; x=1767853545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXw0KS+mtzlW4R/yAZNXORVMUv1IZas0tr5wRPVkUCk=;
        b=Id1BZePZvNUuqz7DLmXhdVwN1XbURnbYstSxc+kU/Hc2RgB9TVFEtRVfF90N5koLV6
         Xa25dodgvz0mXESCyoLNXamqD5bq/PAZ8nI40/3Oce5kVveS7OzzsZ25x9EPYmuCEcS4
         e4XzR3SZrIIawxZKFOV+c/0CvKoaUoKHSlOCJ10vr0hh/epJxef49MncnlNx/b6ch/6I
         Lx+pdCGDayUo/wJIMwiQHfeG+G5Q+BILf7RB92uzI8vCdJyV1gBAT1Rf9XOKvwSacfl6
         QCp0s2cu8D2CCS5c9csMfAJ32YYcB8ugCnxNwNNeTO9iitm/pRibN1L+te2uZMnC8jV8
         +Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248745; x=1767853545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXw0KS+mtzlW4R/yAZNXORVMUv1IZas0tr5wRPVkUCk=;
        b=r6gPMMDgExubmDaIcmvlFxpppzwISt85gYuE/qUzJjgvbfCEVZ1Ix93mlwZgjGrfPF
         Zy1bGzu6uD+34TWWZYsP1/SxAONczyiCbalx1XH1ToBmNVMEI8gVWJVyfkw1Kuil8Ars
         EWxyAc4aiRnF3BuYtpaoh5s607w05WBgdmSuHdCO8GIMONNnUr9YwhI7/DH6nTNSGLVx
         UumoF1ckJh6ZBqtsRBQnvM/q6fxFWt4i4uKUX0FZ8L1tlowVb+jconfCQcR+sTE5ZXES
         2Vi40w2ZtbVHig5dyEnUJz4jikZ8ZELDofZHqa0hTAqBm4cbfbyKdUPJtq2mgDzjUys7
         sZmQ==
X-Gm-Message-State: AOJu0YwjrR8o4wBxjmvQTCCCJ4NyzqURO+TfRX+ukKNIgwwA21V3HYaF
	OZlAX7i11Fa2OPEzChkP7NwOqRvNIoKLWaqI/kImu0rXVs98mNkpBvudWDHC1tdce28=
X-Gm-Gg: AY/fxX6rCH7+jQqNKXZk211w8dazRKorR7Z+hq39xtIxO2Z1Fqt86uR04s90I/8mA65
	lupuDmdLTalA0X7dJEG+uSoD7ah9btZGEytBItGSyBbmbP4v3o3xplOy+1M5/bW4o29wUEnraUy
	L8poLu5O73sE/y0N1dMdctTTMEDpV/rbVmabTjMOzTnIwNP1pPDgNvNmW1zjHIW10oI3YY0PHlp
	FcQ/C1qOok7QBSlS2Qx/4oYFYZ+Xf6HDI0QQzCwdVUUyYXMUTv/phMZR04maNlteZgrQwqWy9tD
	v4EyLs9XISwTBEShUNF5xhKc0MMHuQh1JTtVrYfPAPnAvOiHpxhknCeOIdyCZO+vn6IoLbHbYlr
	/t5llwE1n3XJYFK+qlA9IhldYEocWvwzNom9l+J1t7QSRgEMOa+j1L0Av+HfrvDPMcVmIk7hZrs
	8z9mXKxcCXpEtCThjzaXPUyBFLWil+QemJMo2rJD1OQz7OiRSp5uJXSXzAiwwQtg==
X-Google-Smtp-Source: AGHT+IE1qOMp6eNFeyruma+P5Tn6KvSSX3KbEJeZqgXymgEx/iCWBkP2LmFHmJWNFi+DprjfluX8jw==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr27901457eec.3.1767248744793;
        Wed, 31 Dec 2025 22:25:44 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm103120199eec.2.2025.12.31.22.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:44 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Wed, 31 Dec 2025 22:25:43 -0800
Message-ID: <20260101062543.186499-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d61a7fbda745..958ff9da9f01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1527,6 +1527,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2037,6 +2039,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2843,6 +2847,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.51.0


