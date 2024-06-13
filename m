Return-Path: <linux-wireless+bounces-8918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E64906242
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428DDB2263B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71C12CDBC;
	Thu, 13 Jun 2024 03:03:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0312D761
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247786; cv=none; b=ZH0yC5MiYBOguuQiP2i6TSo6WKoreWHIqp/G7YbmS1qYa00WfnfDj7e6oUqyp6sh71E2Z88ePgdson/uHgwrMSGX3FOPrxVWxDYiXcFJpkBN7AsOWIvoEqbm2GXxtE6H9wWnFCKCLiIo4vqnHiG5EeFDV4eSqfx4gws9jBRiQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247786; c=relaxed/simple;
	bh=+7ToAbl3gbxstCLlL43SN8x97eaQW3/ezVyS/mKkyo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUqjKZ7UpZo/6hiDDUfx85eFAt96N32PhsfgTDnwurRsvT+OvFX8T7i7/Hqf3NKRAR2zL4Ao42cTT17iqXu3d+PGFknh+UUnFZk1I6w3pxtfxVG+39/5zi2C8+BrFKk788UQwH0UZxN0Pl06Z4G/g2IACLPPwA0h/qalFuBbcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1b8bacf67so76791b6e.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247784; x=1718852584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk2KfDSTIKehiWysrLk9gdpwiwyKzUSH27r7ZuD+Tno=;
        b=Mp8SGRG5D9m/ZapzSR9U4C/jInLxQ5ITwZDxBwSCWO/dM5gpRQ9pzWPghv8dSBKYlY
         DB2ImgmF8PNJWhYmLegrYO4s0qg0u91SOPWeHyHiBAkxacPBaUrBLtjAODU2NAJgty5a
         pe1q9PE/o24BlP3FxNk4+mRmzmViRKXCw/rKslF+AxUNZkYOwJk04cKrDMHip1D4wFsl
         9x/D52+4I24dTlXW47dADijrm0yNugmpYuSYALneS2zoqFySOlJzVClaxMA90sfLAD7V
         ZwMZeuqBLPBcjzuoK8oQHwzUxuzIuwRUSNs5KRQsDrm/5lPbTTHrOlCe9JCnWwDtnka9
         K0Og==
X-Forwarded-Encrypted: i=1; AJvYcCUVYFyooulPZDNMP7cUqDWeQ3hw0L1qGJ0gaYjNGinmQZ5pnQkcy2J8jh/6bkZE/kpfRPlzd6Tx9iP4izBE+w1XPnkF0+Wf4q/AZ85w4+E=
X-Gm-Message-State: AOJu0YyrsOZPNujB4JodTfZtrzOD9E3vZ5W0RFiXNhJUHNxQ4fu1DQZX
	rpG8qLPpTIApCn0SV4kM+2KOLsrLgaSKNXmLVNq/mWHNKbUKrx7HceWyndeSvnc=
X-Google-Smtp-Source: AGHT+IFcPqgYrGZI9GZ47JpULxLN3L/F/sHM2E8m7VjxRNFeYrHwyBz83/Oy9JZvqVrwfoiee4fkzw==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3670796eaf.0.1718247784338;
        Wed, 12 Jun 2024 20:03:04 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:03 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 08/47] wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
Date: Wed, 12 Jun 2024 20:02:02 -0700
Message-Id: <20240613030241.5771-9-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Extend mt7925_mcu_set_timing with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7b9deb586b34..6a1afff92399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1400,7 +1400,7 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt7925_mcu_set_timing(phy, vif);
+			mt7925_mcu_set_timing(phy, info);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index fb261ee525be..b82cc1bd09b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2296,9 +2296,9 @@ mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 }
 
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
-			  struct ieee80211_vif *vif)
+			  struct ieee80211_bss_conf *link_conf)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
@@ -2307,7 +2307,7 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7925_mcu_bss_ifs_tlv(skb, vif);
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf->vif);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index c692996e057c..d3584743c266 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -582,7 +582,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_sta *sta,
 			    int enable);
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
-			  struct ieee80211_vif *vif);
+			  struct ieee80211_bss_conf *link_conf);
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
-- 
2.34.1


