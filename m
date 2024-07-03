Return-Path: <linux-wireless+bounces-9959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8C926AA0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29577B25C71
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D9194C77;
	Wed,  3 Jul 2024 21:43:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BB194C65
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043011; cv=none; b=B8JIWuGJ78AZnq8O/YX6qxr81H1I15+b+Twky9wtz2ocllTRPef6/bpcf8Y/7nJppyb+mY6BC29q6LJW/wJL+jndfrbC82OFLkTJ8tkom1q0op/CnWnAjlyZ5N1EIx3gks6pfNrOOQFTtK9SGcb6JQIx2WL0Qguraq3z7yFc8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043011; c=relaxed/simple;
	bh=zeQmtMRSYLQMgmy5nGr2uOuAgoTUM/ddMoPu7sAOu0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGeK5vBBjKqTyh0c6AUec2r0ZwaWhbQ+zY0n4vNcGKtDkluepsbDDhiPXvz6DE1Dhhlg/ig4N5ZCLLHaWrjE23yMGwgs8qXMvxEgkA0731X3PnxEUHz7FQ36r2CRoHK1pVyYl4nBTJ8hradzdKBowojGQ+nVu8YvTuRLU4s1+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25dff23459cso3577fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043009; x=1720647809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCSz8cUWGD3Jpbgh3b2PR3W+Co/hw9DDq4m/R/ZmJnU=;
        b=jxMVGDDyJXIGgNgCblC0UfnGkoefiUzlAB48/TR7G+rlT6u8ORfy8D8PrbaJh3X+xA
         6AJtcD2KlcnvZ3LfMFnGCQg6qFGWaoFLGUwCpNDPaHfLEBtaeuBoBrEOCecBLMcGgWuc
         lraOs3fJDGy2eSaUkJvgtKnYaE0HGcb8c7twIP7jbDP2OW5X0mxqaS8E4+0GSRuftYNl
         PinlpAadi6admH4iUSjfqjqwrWJyZIwSJm8Jhy2fyB07C3YQ2oJYNBtriUKfI/yQtwFn
         UtwFXgYTjCB1LTz43hrNzURp7TEkVqqITXK2Lk3tG64DWKksR0CggzOibklX1E+bq7C8
         ptKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTGm8T1vvvGLvpQaj5a9xw9Hj/w8A6ctZLy6shfinZGczsott9vY1JucSMZKyBvQMgwjhVWR9Vmk9cJF/dxbOYyPCEQx4dV91x6gvTXVY=
X-Gm-Message-State: AOJu0YzLIglLU2rGaWS8U5SMvXNK8LSwgjjr0kylea9iSHk1WIHnoYFN
	guUGzlPzuytjKhDRI8SLY+LXtM7baaV/d0t+Ad6fYaI0+mOgFKw8
X-Google-Smtp-Source: AGHT+IHHdwjRum0Ixy2aektx2Alqi2y35iYb/E46T4+QqCxUIGi/GS+D5lOna7bDGqNjEWMqIfYCRA==
X-Received: by 2002:a05:6830:68cd:b0:700:d697:6ca7 with SMTP id 46e09a7af769-70207554355mr12585381a34.0.1720043008866;
        Wed, 03 Jul 2024 14:43:28 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:27 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 19/29] wifi: mt76: mt7925: update rate index according to link id
Date: Wed,  3 Jul 2024 14:42:24 -0700
Message-Id: <c3a8a5d70fe792aad6b90e0a9d0c7dfb07b2c1d7.1720042294.git.sean.wang@kernel.org>
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

Update rate index according to link id.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 265ef7ade6e4..173934ec1e71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1768,9 +1768,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_bss_conf *info,
 				     u64 changed)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
+
+	mconf = mt792x_vif_to_link(mvif, info->link_id);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1784,16 +1787,16 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE)
-		mvif->mcast_rates_idx =
+		mconf->mt76.mcast_rates_idx =
 				mt7925_get_rates_table(hw, vif, false, true);
 
 	if (changed & BSS_CHANGED_BASIC_RATES)
-		mvif->basic_rates_idx =
+		mconf->mt76.basic_rates_idx =
 				mt7925_get_rates_table(hw, vif, false, false);
 
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED)) {
-		mvif->beacon_rates_idx =
+		mconf->mt76.beacon_rates_idx =
 				mt7925_get_rates_table(hw, vif, true, false);
 
 		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif,
-- 
2.25.1


