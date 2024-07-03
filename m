Return-Path: <linux-wireless+bounces-9968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A5926AAD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2BEB2393C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA51993A9;
	Wed,  3 Jul 2024 21:43:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF8199225
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043030; cv=none; b=LyP/jmh6604Q0jQN2yvdEMEZTHnkamsWbDm9HgJ1AOeiT3P+uUTQAALP/yaeoQA3sFO/vY66RLBe9X7LoqczkFb9NF+VVBWkfG4S/TQ37EI+7/YunyoqaQncE2nVRcDOZxSUe6wNYqTmdyPdT2yT2dklF85g0RmRz65HnHLh8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043030; c=relaxed/simple;
	bh=LPmmqlk5uxY2VbbisSrv8wxqM80Bk0v2EZanD+wc9qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rR7/G2qQAqmiw2+hCuzTQubLKBw4B7mYMOokyVovLjeNXtrNBGPFWCWhezkKqkvlceGviLqli5okyfMIW4ctpELCw/0gf0c+wbYn8L0KU5/GsvDrHRHqAwvddviKy8cE/5KS1z0Mg3VXEYa61gHsUHT9YwfFLieM/+ZDwwpj5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-700d68d3195so136695a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043028; x=1720647828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J9B7zhjK3f29ovrL4Llul+VWCgxd/DHWLce6tzebVg=;
        b=WQlRBD7pBOCHK+TNKJ1+bD7+i/ockEt6k0x5MzpR3LZBO64AIthJZB+lLGNHd0jgG8
         FJf4w/KHYTF+sauLwjzaKtx713eLE++MJNox6KVmrvGDhj8D9H2Fn3ydOl3WyxyKO5MU
         SDuaDFB8LxBS2ToK4K+Zh565vrefiTw4QTSYjvZ6GV3t6/2aZ/Oqv6Pe36YtgRVwJQbX
         kyYWyUI+wNGMG43WVZYJi0RlCccMOqTEw21Nt8bOgf1etHYRbiZ7XdiMNWmx7THfK3m9
         u4WVpvwRS2pegTrDZ2zDcssTcEk+n0XK3fO2ttg57Q53H42ixc5FgbI8XhHiqROLVs1V
         gXjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9IU8DGtUeOPnouYPwoS4Cg85q/drAdNjcqAdkZBlmLsAS9txt1J1oX0tyTgxUOzsiVE1qLbt2ABgOJrYVL2+4eZLEtXQbPWhAe7vOSGI=
X-Gm-Message-State: AOJu0YzQgaHed8ghtnwjotfyvHhSGwhFr/JsyKldjB5aJS+wxX81JeEW
	y88WGkx53a1VIBD9q+R3CWwPN8KLjvFA2jM9hp/Iv0DS549Ted+q
X-Google-Smtp-Source: AGHT+IGmS4lxO+9/5KpWC0FYHXRgQxAMPZY/PNjXZVYVqL4NuwCgC1ZKfvRFuBZHJYGD3zKGbvWLeg==
X-Received: by 2002:a9d:65c5:0:b0:700:ca13:30bc with SMTP id 46e09a7af769-70207763b58mr13703664a34.2.1720043028356;
        Wed, 03 Jul 2024 14:43:48 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:46 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 28/29] wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
Date: Wed,  3 Jul 2024 14:42:33 -0700
Message-Id: <cf15c40ca54e933b3a9ada3c65bed902ed259bef.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Get band information from the per-link BSS.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 36ddc64ed7d6..829d87d4eb95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1707,7 +1707,9 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 			     struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif,
+							   link_sta->link_id);
+	struct cfg80211_chan_def *chandef = &mconf->mt76.ctx->def;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra_info *ra_info;
 	struct tlv *tlv;
-- 
2.25.1


