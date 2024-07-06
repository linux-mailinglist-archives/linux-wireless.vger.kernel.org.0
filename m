Return-Path: <linux-wireless+bounces-10026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41B9291D7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ED91F21EC3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF9482D3;
	Sat,  6 Jul 2024 08:28:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820B4D8CF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254516; cv=none; b=cDVbbj7hVDZgkVugwsC+ioCypIICsOXHaZ35TACul0OvWIIgCoCU4yVMDyMoyAbM9jVRXytVv04Js2/cS0Sl88+Yqa9nFQeVDZS7WKyyc3oMY2I/OnYkPpaz8rGxiZjQ2GUjvZYOaM34MMhYKGzD7uQ/Mocik66BhIoCEFRh8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254516; c=relaxed/simple;
	bh=AJqct517u19aRooDVisE8Mas6yCuqLVuDXO6RbJZpUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhHk9ZMV3x7W2teTVni+7GdVtIB09L8mRnwrV3Dvm9MJgGPLnLZAInm5qVpOgAZvDMJ6x2BMNBPS1o9WydELSOpLtd2ekTp3Wehl7kf3Ff4fFNO9Z9CRe2FPCX1Y34ndYKd0k/RQfLItW6dulkJbPq27FsGKAkFo2uUu555ab3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d926517363so7758b6e.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254514; x=1720859314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETsdxoWBl1jlyH0mjXdSFYsrC9eRAMS+LPSgSNFgJW4=;
        b=g6UMjW8Vn+F1CqoFeW4Sp1/giLles1USzn3KI9jvjZLXnGForSu46Xe0VHsEEHe2YW
         OA7w2JhxZMkTLze4KNm56eGpLIVLtes7x/lG9g+nVFIXCIYtmQUzy8MraiEukzvlrATi
         LRDJ7lBKnpdSe2d6FHgsf2jadnAzm9Nt5l5I8eYMKGB2SkEthjV8gZytUvl5dSj448DY
         JGwvsUsl/6oTd2J/dAM5WI6cyG/YqDPes3QGWRcGtWWK6tnk37OxRqFZVYFQJiyncT1+
         xLskN2RaLuA4oZdUC7ftyN06k6OTj8InYM4pXAPs0BRMzWac697m8d7gR/RHXbXJYkQJ
         XIUw==
X-Forwarded-Encrypted: i=1; AJvYcCWnZfUXgb/tZAbOTA4KolabOLM7AqsP5XvuCiSgsrGJORKg8vwsjJhTt7quDCCxUvwGc6NEQHEzaf4CPWfCQ31Cq5aDQsAb2lkqCOGqtpI=
X-Gm-Message-State: AOJu0YxSsorL9ErkUbpm3ZwjOpB1LmhItsSKJ/C+Kg9fzuiAoQfaWERu
	yYp+H72o4qsT29q+s5APPYofvnABvrtG09oR2gpVK8LFqTr85npr
X-Google-Smtp-Source: AGHT+IEbAWvgIdd5Bl6W9MVse4dOntxuXQSSxiWbpOYDgcFt/ainUz2UCNVJ7up+xvGXjoPuW/55rw==
X-Received: by 2002:a05:6871:24d9:b0:258:4ae8:4aec with SMTP id 586e51a60fabf-25e2bf90e00mr6557949fac.3.1720254513854;
        Sat, 06 Jul 2024 01:28:33 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:32 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/37] wifi: mt76: mt7925: add mt7925_change_vif_links
Date: Sat,  6 Jul 2024 01:27:47 -0700
Message-Id: <31c9de30c3a18592c8e100f909845383b66f8677.1720248331.git.sean.wang@kernel.org>
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

Add mt7925_change_vif_links to change the valid links on an interface,
supporting the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 130 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 117 +++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  20 +++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   6 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   5 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  23 +++-
 6 files changed, 275 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7c7452729710..fcf7bd1a06bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -472,6 +472,33 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
 	return err;
 }
 
+static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
+			      struct mt792x_bss_conf *mconf,
+			      u16 sel_links)
+{
+	int err;
+
+	if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state)))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7925_mcu_set_mlo_roc(mconf, sel_links, 5, ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
+		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
 static int mt7925_remain_on_channel(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_channel *chan,
@@ -1521,6 +1548,108 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	mt792x_mutex_release(dev);
 }
 
+static int
+mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			u16 old_links, u16 new_links,
+			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	struct mt792x_bss_conf *mconfs[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mconf;
+	struct mt792x_link_sta *mlinks[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mlink;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+	int err;
+
+	if (old_links == new_links)
+		return 0;
+
+	mt792x_mutex_acquire(dev);
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(&mvif->sta, link_id);
+
+		if (!mconf || !mlink)
+			continue;
+
+		if (mconf != &mvif->bss_conf) {
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+			devm_kfree(dev->mt76.dev, mconf);
+			devm_kfree(dev->mt76.dev, mlink);
+		}
+
+		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
+		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
+	}
+
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (!old_links) {
+			mconf = &mvif->bss_conf;
+			mlink = &mvif->sta.deflink;
+		} else {
+			mconf = devm_kzalloc(dev->mt76.dev, sizeof(*mconf),
+					     GFP_KERNEL);
+			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
+					     GFP_KERNEL);
+		}
+
+		mconfs[link_id] = mconf;
+		mlinks[link_id] = mlink;
+		mconf->link_id = link_id;
+		mconf->vif = mvif;
+		mlink->wcid.link_id = link_id;
+	}
+
+	if (hweight16(mvif->valid_links) == 0)
+		mt792x_mac_link_bss_remove(dev, &mvif->bss_conf,
+					   &mvif->sta.deflink);
+
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mconfs[link_id];
+		mlink = mlinks[link_id];
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+
+		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
+		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
+
+		err = mt7925_mac_link_bss_add(dev, link_conf, mlink);
+		if (err < 0)
+			goto free;
+
+		if (mconf != &mvif->bss_conf) {
+			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
+						 vif->active_links);
+			if (err < 0)
+				goto free;
+		}
+	}
+
+	mvif->valid_links = new_links;
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+
+free:
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
+		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
+
+		if (mconf != &mvif->bss_conf)
+			devm_kfree(dev->mt76.dev, mconfs[link_id]);
+		if (mlink != &mvif->sta.deflink)
+			devm_kfree(dev->mt76.dev, mlinks[link_id]);
+	}
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -1579,6 +1708,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.mgd_complete_tx = mt7925_mgd_complete_tx,
 	.vif_cfg_changed = mt7925_vif_cfg_changed,
 	.link_info_changed = mt7925_link_info_changed,
+	.change_vif_links = mt7925_change_vif_links,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8069b27ce61c..43c20fdb747c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -307,6 +307,9 @@ mt7925_mcu_roc_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt7925_roc_grant_tlv *grant = priv;
 
+	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION)
+		return;
+
 	if (mvif->idx != grant->bss_idx)
 		return;
 
@@ -1084,6 +1087,100 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 
+int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
+			   int duration, u8 token_id)
+{
+	struct mt792x_vif *mvif = mconf->vif;
+	struct ieee80211_vif *vif = container_of((void *)mvif,
+						 struct ieee80211_vif, drv_priv);
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_channel *chan;
+	const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	enum mt7925_roc_req type;
+	int center_ch, i = 0;
+	bool is_AG_band = false;
+	struct {
+		u8 id;
+		u8 bss_idx;
+		u16 tag;
+		struct mt792x_bss_conf *mconf;
+		struct ieee80211_channel *chan;
+	} links[2];
+
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv roc[2];
+	} __packed req;
+
+	if (!mconf || hweight16(vif->valid_links) < 2 ||
+	    hweight16(sel_links) != 2)
+		return -EPERM;
+
+	for (i = 0; i < ARRAY_SIZE(links); i++) {
+		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
+				 mconf->link_id;
+		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
+		if (WARN_ON_ONCE(!link_conf))
+			return -EPERM;
+
+		links[i].chan = link_conf->chanreq.oper.chan;
+		if (WARN_ON_ONCE(!links[i].chan))
+			return -EPERM;
+
+		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		links[i].tag = links[i].id == mconf->link_id ?
+			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
+
+		is_AG_band |= links[i].chan->band == NL80211_BAND_2GHZ;
+	}
+
+	if (vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP)
+		type = is_AG_band ? MT7925_ROC_REQ_MLSR_AG :
+				    MT7925_ROC_REQ_MLSR_AA;
+	else
+		type = MT7925_ROC_REQ_JOIN;
+
+	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
+		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
+			continue;
+
+		chan = links[i].chan;
+		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+		req.roc[i].len = cpu_to_le16(sizeof(struct roc_acquire_tlv));
+		req.roc[i].tag = cpu_to_le16(links[i].tag);
+		req.roc[i].tokenid = token_id;
+		req.roc[i].reqtype = type;
+		req.roc[i].maxinterval = cpu_to_le32(duration);
+		req.roc[i].bss_idx = links[i].mconf->mt76.idx;
+		req.roc[i].control_channel = chan->hw_value;
+		req.roc[i].bw = CMD_CBW_20MHZ;
+		req.roc[i].bw_from_ap = CMD_CBW_20MHZ;
+		req.roc[i].center_chan = center_ch;
+		req.roc[i].center_chan_from_ap = center_ch;
+
+		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
+		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
+		 */
+		req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ? 0xfe : 0xff;
+
+		if (chan->hw_value < center_ch)
+			req.roc[i].sco = 1; /* SCA */
+		else if (chan->hw_value > center_ch)
+			req.roc[i].sco = 3; /* SCB */
+
+		req.roc[i].band = ch_band[chan->band];
+	}
+
+	return mt76_mcu_send_msg(&mvif->phy->dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
 int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7925_roc_req type, u8 token_id)
@@ -1094,25 +1191,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		struct {
 			u8 rsv[4];
 		} __packed hdr;
-		struct roc_acquire_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 bss_idx;
-			u8 tokenid;
-			u8 control_channel;
-			u8 sco;
-			u8 band;
-			u8 bw;
-			u8 center_chan;
-			u8 center_chan2;
-			u8 bw_from_ap;
-			u8 center_chan_from_ap;
-			u8 center_chan2_from_ap;
-			u8 reqtype;
-			__le32 maxinterval;
-			u8 dbdcband;
-			u8 rsv[3];
-		} __packed roc;
+		struct roc_acquire_tlv roc;
 	} __packed req = {
 		.roc = {
 			.tag = cpu_to_le16(UNI_ROC_ACQUIRE),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index da4e84f468d2..fefb6ab384bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -554,6 +554,26 @@ struct mt7925_wow_pattern_tlv {
 	u8 rsv[7];
 } __packed;
 
+struct roc_acquire_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 control_channel;
+	u8 sco;
+	u8 band;
+	u8 bw;
+	u8 center_chan;
+	u8 center_chan2;
+	u8 bw_from_ap;
+	u8 center_chan_from_ap;
+	u8 center_chan2_from_ap;
+	u8 reqtype;
+	__le32 maxinterval;
+	u8 dbdcband;
+	u8 rsv[3];
+} __packed;
+
 static inline enum connac3_mcu_cipher_type
 mt7925_mcu_get_cipher(int cipher)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index b7f8802b9cd6..dbc9e3d426e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -30,12 +30,16 @@
 enum {
 	UNI_ROC_ACQUIRE,
 	UNI_ROC_ABORT,
+	UNI_ROC_SUB_LINK = 3,
 	UNI_ROC_NUM
 };
 
 enum mt7925_roc_req {
 	MT7925_ROC_REQ_JOIN,
 	MT7925_ROC_REQ_ROC,
+	MT7925_ROC_REQ_SUB_LINK,
+	MT7925_ROC_REQ_MLSR_AG = 10,
+	MT7925_ROC_REQ_MLSR_AA,
 	MT7925_ROC_REQ_NUM
 };
 
@@ -295,6 +299,8 @@ int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
 int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set);
 int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
+int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
+			   int duration, u8 token_id);
 int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7925_roc_req type, u8 token_id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index fe5a6c932705..9a7443a8a951 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -112,6 +112,7 @@ struct mt792x_bss_conf {
 	struct mt792x_vif *vif;
 	struct ewma_rssi rssi;
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	unsigned int link_id;
 };
 
 struct mt792x_vif {
@@ -122,6 +123,7 @@ struct mt792x_vif {
 	struct mt792x_sta *wep_sta;
 
 	struct mt792x_phy *phy;
+	u16 valid_links;
 };
 
 struct mt792x_phy {
@@ -398,6 +400,9 @@ mt792x_get_mac80211_ops(struct device *dev,
 int mt792x_init_wcid(struct mt792x_dev *dev);
 int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
+void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
+				struct mt792x_bss_conf *mconf,
+				struct mt792x_link_sta *mlink);
 
 static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 813296fad0ed..62f471b5498f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -113,14 +113,17 @@ void mt792x_stop(struct ieee80211_hw *hw, bool suspend)
 }
 EXPORT_SYMBOL_GPL(mt792x_stop);
 
-static void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
-				       struct ieee80211_bss_conf *link_conf,
-				       struct mt792x_link_sta *mlink)
+void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
+				struct mt792x_bss_conf *mconf,
+				struct mt792x_link_sta *mlink)
 {
-	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct ieee80211_vif *vif = container_of((void *)mconf->vif,
+						 struct ieee80211_vif, drv_priv);
+	struct ieee80211_bss_conf *link_conf;
 	int idx = mlink->wcid.idx;
 
-	mt792x_mutex_acquire(dev);
+	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, false);
 
@@ -128,7 +131,6 @@ static void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mconf->mt76.idx);
 	mconf->vif->phy->omac_mask &= ~BIT_ULL(mconf->mt76.omac_idx);
-	mt792x_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
@@ -137,14 +139,21 @@ static void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
 
 	mt76_wcid_cleanup(&dev->mt76, &mlink->wcid);
 }
+EXPORT_SYMBOL_GPL(mt792x_mac_link_bss_remove);
 
 void mt792x_remove_interface(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
 
-	mt792x_mac_link_bss_remove(dev, &vif->bss_conf, &mvif->sta.deflink);
+	mt792x_mutex_acquire(dev);
+
+	mconf = mt792x_link_conf_to_mconf(&vif->bss_conf);
+	mt792x_mac_link_bss_remove(dev, mconf, &mvif->sta.deflink);
+
+	mt792x_mutex_release(dev);
 }
 EXPORT_SYMBOL_GPL(mt792x_remove_interface);
 
-- 
2.25.1


