Return-Path: <linux-wireless+bounces-10039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3369291E4
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B51F21E09
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E1482FF;
	Sat,  6 Jul 2024 08:28:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6C6F30B
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254538; cv=none; b=frQyXuQEPWeovlLK1OT/WnRVy+JbjkRW9sCKAf4AJk3plf8J0kI1FoBijRfd3T85N7WgoN6etWG5lUM/ChD6h90RVI0luAYfbaQ7v4wWt4ZvrO+zJ/3KEEfvjX+lJjvWDlGZy1Vy+YrJYydzga09dZQzh9SV/uCeaHILuSJ7tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254538; c=relaxed/simple;
	bh=61MCCko0t4p0+ycrsstAs2ZwG/jDK5691YFWqER7rlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX/heeH2ewSQDg+9rAKWXQ7BxalNqDjNRCDs4EErOMgzGXnw31ESu7JUmkZzYsEKJLRmGweeqzcxdj3j9JDJTyCIfNifMEjpDRGvtQ36EJDHy7VEEDokWvweKcMkelWpgvq0JpHozBq4NoocGUCKPdGbNmkpjRQqnYpvWUZ/5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c5ec50da1so284890fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254536; x=1720859336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqUVQrvv47c1itp+tRv4q6cRbFuGM81+0GzeLk9XrrU=;
        b=OlBq82kCHs9Q3VvLZLfIdHzc4Cd1saFB2p46kop0H4ygRn8oPQD7y9gUUeefE9mm2e
         HxueOPFh7Q8MuYcsvHaGvM56ZW7qNpYMfRrwJbgWS+Robjw2SaMg+n8YPJAJdVJuOwKG
         NLD+MhS2nZtDUEjSUwURRGdzyHv4srw495Sm6U1337/aXDQXl/BYnEEjpPVr69DKZHK8
         YtqpFdTFEDNuDtFZNFYL+Ka5zXmrhAtVpChFO9NVoPmdbjEou5dMTZJsyhhVoyw/VdIV
         hQ6ARP2eIXh8+qMiWKgcYG52XTWWgSuF/zNfLQ6MXWury2npNCWq07U+GVuNWdHoJ3ms
         JFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe0idbMCUziFSmgeq/oHKTZHaPg9mVGSt01YVuwLf/9/8DkU1O+t9SHYY90yKsgptt0+SM7utt5xDtWIPOpc03ASCp8zTU/b3LxhDy6kA=
X-Gm-Message-State: AOJu0Yxq7EBorHU2e3pPCh/H6bv4GEpwJNHG7broH8LQhhgM5JylDh5u
	MXmq0QDEdOLV/wSacZVkbt1nPw0UJp4OTvT/8lQDz6rQvR5gfIQY
X-Google-Smtp-Source: AGHT+IHe1Y1PPxOR2nKL9g+jjNvFWNPedzbzTVhQiKhUAQYU+OXCr46RR8IQejk8rRcZT0GyuhU2lQ==
X-Received: by 2002:a05:6870:eca3:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-25e2bf101admr6656181fac.3.1720254535992;
        Sat, 06 Jul 2024 01:28:55 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:54 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 20/37] wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
Date: Sat,  6 Jul 2024 01:28:00 -0700
Message-Id: <6e26e2ce253630ab29702693a7822f9961de6a18.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add link handling in the BSS_CHANGED_ARP_FILTER handler.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 791e90f5760f..8acce16d88d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1749,6 +1749,10 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1759,17 +1763,13 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
-		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76);
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf);
+		}
 	}
 
 	if (changed & BSS_CHANGED_PS) {
-		unsigned long valid = ieee80211_vif_is_mld(vif) ?
-					      mvif->valid_links : BIT(0);
-		struct ieee80211_bss_conf *bss_conf;
-		int i;
-
 		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 			bss_conf = mt792x_vif_to_bss_conf(vif, i);
 			mt7925_mcu_uni_bss_ps(dev, bss_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0991af877434..3d5eaeb96047 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -121,10 +121,12 @@ int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set)
 EXPORT_SYMBOL_GPL(mt7925_mcu_regval);
 
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
-				 struct mt76_vif *vif)
+				 struct ieee80211_bss_conf *link_conf)
 {
-	struct ieee80211_vif *mvif = container_of((void *)vif, struct ieee80211_vif,
+	struct ieee80211_vif *mvif = container_of((void *)link_conf->vif,
+						  struct ieee80211_vif,
 						  drv_priv);
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct sk_buff *skb;
 	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
 			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
@@ -136,7 +138,7 @@ int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 		struct mt7925_arpns_tlv arp;
 	} req = {
 		.hdr = {
-			.bss_idx = vif->idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.arp = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index fefb6ab384bb..7fb46cad9157 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -626,5 +626,5 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 			 struct ieee80211_chanctx_conf *ctx);
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
-				 struct mt76_vif *vif);
+				 struct ieee80211_bss_conf *link_conf);
 #endif
-- 
2.25.1


