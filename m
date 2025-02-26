Return-Path: <linux-wireless+bounces-19457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8EBA4537E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD5E1897D7B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DA21C183;
	Wed, 26 Feb 2025 02:57:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552D2AE7F;
	Wed, 26 Feb 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538633; cv=none; b=Zjbm7gl2+UaI6iibxbCI3c3jtp+MYRbn+BTz2miByFsOgqEm5wKFOcQnOxmD+dLv+T0Cbwq25o3HcGBu8mURUPisxXCUQFnYPPVuQVAWT94xX2g79CRjQBQksX0nHMpWW5ObS9eLdB15lh1aoFCdjd3fi0I+zSK1IOEr4CtaWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538633; c=relaxed/simple;
	bh=SWbVttSZ/38nhWtiYs9QI/3LHl/kIb3YAqwXCEaS6Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Em4Ck+1RQqx74yMVfowuxEoZHt82Om9i3drcWfL7f2XhAk2AMxQ0k1WRWCcFCcCX4G8PONfHdnnv/qXxGoU/i4W62WuVDG85a9sO5qle4RJ3saGAc9cgmtHU9vLR4LKw8bmNm3ayNisWeJQX34Lmkof82w/bfElx7qGr4IbKsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bcceee7b41so1309741fac.2;
        Tue, 25 Feb 2025 18:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538628; x=1741143428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky/E/gk2IbGf3P6mKrf8CYE7N91ey2oDG6HZ3mRTMOw=;
        b=PfxXzAzULsCkDeuKfJSmWfwfwr8QkVvnp6OXBUfok0izywAwnlhBevAEMJmV0/9wGJ
         kH5zURf9M8cYJ3r5b+ot5ZBhtal8gzdgGblO901Jac7h1CtlPFziiFSJkvHrv2zkAwyx
         7ZF102CEcUIj8Pe8oC3I1AqabY7RVoMu8i4NkFl47bEOAjRRhbv5c8Aayzq3l+vFseK2
         pctMH1bfDWjqQaPfsjmXsy2eHDLhSVVoCqE6R1CeMyxCSt2wn1n1wjL125VqMgVQsEN4
         Fxc6Sk3lqIGsLSrqpWdepSfCRl0LY3d+Ytej2ZadtVHBM09TmESRhNu0gmTNZ9oasYOc
         GIYw==
X-Forwarded-Encrypted: i=1; AJvYcCWIYLlAznpxT3Z2LUuGivod5MdN16odhalT5AnOPFkEyiOA/3eA8Zg5/+s4/jCHZd8pLMVZUEqQ@vger.kernel.org, AJvYcCXFFWAIutL65A4/LVlpsEa6dYJifjI3kvCGypQLMBTHOeCbpnwVZPbGxaX53nsQqRUP1atDRlTuTX2k59LHlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7/lKxq5FWHCCt9qddPUBjsKETdIyHLw0wS3cQwFmk8vtr9qC
	wfasCbmTaA6opxA0npaSvQLkD10oG7TTOal8RDMFffDTbfXumZLbpiXaH/Jh
X-Gm-Gg: ASbGnctCT8jPtDtYFOC7zhRw/FHW2z9a0gPf2JBPCZg2bSQay4XMkyI0mrqcE/txCYG
	a0/oOyAVwad29JhB8jdEmqULpB7hujtnI1mshFOqA7Z9rDpGRO9rTIUotvgLTo910mL4X+xH+Z+
	wAL+M2zR8qTtVjUj/J29lQVp7MQOSo/4OI3GSn2hAbRl90tbSAtMzPMgFg1KNhf33JZ2yiB4U8q
	ff2FqBxrJxurdR42Fd355ZRnqLHPdbEbhj2Qx8dmg7jl+QONvK0ZZz75CELJsUpaPNs4c+88o0J
	pgUOnqDT5hRIUaipqVUlAGY6gNi4HBKo+LIa7+V7CwE=
X-Google-Smtp-Source: AGHT+IEtZju1Rl1egzmGRBcenriEnSnl7o/IjuwHVbSdPyLu15BX9lgZop131Px3youvTRzGGC10tQ==
X-Received: by 2002:a05:6871:d217:b0:29e:7a13:1341 with SMTP id 586e51a60fabf-2c10f1d2310mr3493852fac.8.1740538628675;
        Tue, 25 Feb 2025 18:57:08 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f0135sm676360fac.27.2025.02.25.18.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:57:07 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v4 5/6] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Date: Tue, 25 Feb 2025 18:56:46 -0800
Message-Id: <20250226025647.102904-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Integrate *mlo_sta_cmd and *sta_cmd for the MLO firmware.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
  2) removed the unrelated files
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 64 ++-----------------
 1 file changed, 4 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 4c133200c70b..34e7165d1a0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1820,49 +1820,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 	}
 }
 
-static int
-mt7925_mcu_sta_cmd(struct mt76_phy *phy,
-		   struct mt76_sta_cmd_info *info)
-{
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
-	struct mt76_dev *dev = phy->dev;
-	struct sk_buff *skb;
-	int conn_state;
-
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
-					      MT7925_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
-				    CONN_STATE_DISCONNECT;
-	if (info->link_sta)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
-					      info->link_sta,
-					      conn_state, info->newly);
-	if (info->link_sta && info->enable) {
-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
-		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
-					     info->link_sta);
-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
-					    info->vif, info->rcpi,
-					    info->state);
-		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
-	}
-
-	if (info->enable)
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
-
-	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-}
-
 static void
 mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 {
@@ -1875,8 +1832,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
-		       struct mt76_sta_cmd_info *info)
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		   struct mt76_sta_cmd_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -1890,12 +1847,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->enable)
+	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      info->enable, info->newly);
-
-	if (info->enable && info->link_sta) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
@@ -1946,7 +1901,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
-	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1954,17 +1908,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	}
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
 
-	if (link_sta)
-		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
-	else
-		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
-
-	if (ieee80211_vif_is_mld(vif))
-		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
-	else
-		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
-
-	return err;
+	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
 }
 
 int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
-- 
2.25.1


