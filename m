Return-Path: <linux-wireless+bounces-10023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573F9291D4
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F81F1F21E59
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2D42A85;
	Sat,  6 Jul 2024 08:28:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8749658
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254510; cv=none; b=VaXgjp3Cbtv4QBziv/Cls/2C/KMTrySpSulKDs2bW37peKo9Z/E8mYd4t5wDdbffo1sVFSr4MFA+egeBGhfB7L9o4ptsC4tAavOQ91jgbK2Jn0fzS5NrxccweZlOjx3+5OeCLoS2nGG0PaqWOsC08KOgPtIeJWXX6BUO9Mf7Krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254510; c=relaxed/simple;
	bh=SMj3DlbfJOPHWdjfWn4x3a+DTf24XHA6NlcIIgD4J7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awSWANjqBhl9RrDKbWHHiuETFTyX0xotWI7UCyd3OAAd168WyHFui3SlH8IBpnF6gYVPpr/rXpF+sDDImLg229U4uoYfluhD6qYBEjmke1NykhPPf2/4789+rDu1/Y7+yBOazKJjNKLB3Et3V9zcMnRc/Ki8efBsXnWfiytFfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c5ec50da1so284872fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254508; x=1720859308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB1JYRMFZwVbYt+IuaFt8+viDBKhrduPeNh84EEGi48=;
        b=AWMuq2tiY9t6mDPQUiCsILsuEnsbI9W3Yzmd48wp6rg1FBHHSyPGNmn4YAILkJu9H5
         mtBYF/g3GuISHzsebLHzXRKBSXyh46Wvl+zRdf/tdL+jFKQB6rhrzYJ7EURg4aBvgGIh
         uda252wthN5Bpbs6bftQvarugGJtXi02JUCtrBfoU2AO37eGERzeByq0CK/2TiMQ20Ar
         I1ILWDZPGzx4EjvPUttcqxA79K5m3mV2TiBP/zhAJ1YpSY4AkiDJD0NeHkiTM212WUWL
         HsNCkzGn6o7tHA1K1MyQtg2nO0Ja+0kO+pHHRr+f0Fc4tklt45jkiHg+b76nvwIDsdHM
         h7hw==
X-Forwarded-Encrypted: i=1; AJvYcCVs8rTe5drE6F6MPuRPW4NWzx8ib7OpvtTH/E0H36mJVvVpdtqEbEskY4CH77UC8LZDe9YSIPCF/E/V1aPyTMFmMoRqZZMwGYdIsHmuvsM=
X-Gm-Message-State: AOJu0YyGlQhaFT9iecx4BfMGQVc/sAcMaqcI12/THdAIDLPEkHlxF4e4
	paVrV07M7RhoVOmcgL5/EeY/Rw+q8djivAKC3N/v8gTVPAXx7G2z8t1BkKEV
X-Google-Smtp-Source: AGHT+IEbBxEgHVC8/DnYcOIvLg50uKhSw9Uz87I6Wzgf6jIzs0QbwsclZn2PRIJzSzOKM0fnme89Qw==
X-Received: by 2002:a05:6871:24d7:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25e2b8d0139mr7037870fac.1.1720254508050;
        Sat, 06 Jul 2024 01:28:28 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:26 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 04/37] wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
Date: Sat,  6 Jul 2024 01:27:44 -0700
Message-Id: <16d65aae010113f9be3c4e6e759b4226d396a1be.1720248331.git.sean.wang@kernel.org>
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

configure mt7925_mcu_sta_key_tlv according to link id

We created a link id field in the common structure mt76_wcid so that
mt7925_mcu_sta_key_tlv can access per-link STA/BSS. Additionally,
.link_id will be required when reporting the link information of Rx status
to mac80211. We will submit the changes for reporting the Rx status in
a separate patch.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 15 +++++++++++----
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 11 +++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 15f83b5adac7..daf1e43e304e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -349,6 +349,7 @@ struct mt76_wcid {
 	u8 sta:1;
 	u8 amsdu:1;
 	u8 phy_idx:2;
+	u8 link_id:4;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS + 1][6];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index da70c203d618..59b1e920bb4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -748,6 +748,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->wcid.phy_idx = mconf->mt76.band_idx;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
+	mlink->wcid.link_id = link_sta->link_id;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a67d8dd6075f..ba91c8e37dff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -967,6 +967,7 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 	struct mt792x_sta *msta = container_of(mlink, struct mt792x_sta, deflink);
 	struct sta_rec_sec_uni *sec;
 	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct tlv *tlv;
@@ -978,17 +979,23 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->bss_idx = mvif->bss_conf.mt76.idx;
+	sec->bss_idx = mconf->mt76.idx;
 	sec->is_authenticator = 0;
-	sec->mgmt_prot = 0;
+	sec->mgmt_prot = 1; /* only used in MLO mode */
 	sec->wlan_idx = (u8)wcid->idx;
 
 	if (sta) {
+		struct ieee80211_link_sta *link_sta;
+
 		sec->tx_key = 1;
 		sec->key_type = 1;
-		memcpy(sec->peer_addr, sta->addr, ETH_ALEN);
+		link_sta = mt792x_sta_to_link_sta(vif, sta, wcid->link_id);
+		memcpy(sec->peer_addr, link_sta->addr, ETH_ALEN);
 	} else {
-		memcpy(sec->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, wcid->link_id);
+		memcpy(sec->peer_addr, link_conf->bssid, ETH_ALEN);
 	}
 
 	if (cmd == SET_KEY) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 69eb8dac0b70..fe5a6c932705 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -273,6 +273,17 @@ mt792x_vif_to_bss_conf(struct ieee80211_vif *vif, unsigned int link_id)
 	return link_conf_dereference_protected(vif, link_id);
 }
 
+static inline struct ieee80211_link_sta *
+mt792x_sta_to_link_sta(struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		       unsigned int link_id)
+{
+	if (!ieee80211_vif_is_mld(vif) ||
+	    link_id >= IEEE80211_LINK_UNSPECIFIED)
+		return &sta->deflink;
+
+	return link_sta_dereference_protected(sta, link_id);
+}
+
 static inline struct mt792x_dev *
 mt792x_hw_dev(struct ieee80211_hw *hw)
 {
-- 
2.25.1


