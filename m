Return-Path: <linux-wireless+bounces-38066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTalDS90PGq6oAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C83486C1F5A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38066-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38066-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EB033026AC3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83361FC0FC;
	Thu, 25 Jun 2026 00:19:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3D211A14
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:19:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346795; cv=none; b=TTD1Qa38jClGFTkgtkTyAFIoZq4r/Y0zKbOgFWnsGizs7H5sCbvSW/REm+dNzkKk8Zd0ykau+g0PhNnJHjU0n2PAXBNtNnGpRDFx3TV8RChMYOZIQ53wmXxyeN2/qqgdjBkQpzmHK/ujaEHY/jKolKT7QNg+Rtzn65YeO1UcxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346795; c=relaxed/simple;
	bh=EZ1aRmR+L0dJFLJDn9T74m1+qYCGE5RUOs5NoIylOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBgUO+lHZj2aL56Un0wpjCeNpGK7Qcpvc50Q/3REG6cY5cs3SFDxwPhx6JjzNyZcmdby9oKfsdEbqhG6RpNpvcQ48Ei3AF+ISs4hAhH/O9VBLBRqAJInhTa4edx9A7MwGuentt33MHqWfhsfKVc7M9oHCLvmUjZijp8WPyzOjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c892935bcdeso731350a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346793; x=1782951593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iH50/idgNS/OFjXNiC0UlN4WVXV6UF+nXJI8fijGnkQ=;
        b=byokhNz7hFI9Z5E74uMrDP07j5yMfkntGnsGDLi2V9jbLdPu/eku16UfVLBG7FOOUl
         9EbsJC5bAZuAlSIX0OHucn8hrcvPlxQLgdfHoVN++UtjTafC9LE6yPxPCMA0jMdtYG94
         A10k590bLF9AN1clWPT1m7Y63zMlfi4704VUx529C+GdmaVI9krvgd1K3dYKibJTch5J
         XTGY6dG+37pBixJhiRFW6BBciflzSMiHwLnMU/Fxlqxn1q4jet9h8Vx5/TfmkAWc9Jv9
         ma/3VS+PQdWovRnu4M1uzBYaZC84Byf4du6RtavkDCFCK5cuUF1EDRZIU/exm/+CY6p5
         eieA==
X-Forwarded-Encrypted: i=1; AFNElJ/iVLo9GgwKzMPzuceiS/h6hs5NZI+DIkArJ9YdIhlLTY2zhE8Tmzrr4waI/ZnSmKy1jLPztUfxmp5CTWiJ+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLKB1CPXeAQHcGTMX7swHK0EH4MRP8CTuqmEozMDip8YwoHMf
	3qDkZPb6vyUx2SKP1GSVKflSca0GkRJlkNH9HkXH4RGEdXfp52Hxh9KVpyF0mwWI
X-Gm-Gg: AfdE7cn1aPOr3QmlSJRGkGpRHt5eJyflJqFCpTPqNX+dYwub3/mmWlMvEe5stTyy9ak
	+ltodAysoGvHAUybnO2PpuHlCeSzDdCXQeDDxauiF311TnkDhj2g9BCESK59oYI/3xj/sdy1u3e
	6x9kOeri9PYLsybAXVStoqy/6pYOpX9xCwRY8Jby+kvt+0MB5ron/v6Cxj8bB/JTZ1h5zA0BwYG
	BBQJd5WhVzJhvJ1ACVqKDYRzl3e2ij1V7wmzqzsOPj3P3T3ob1Z034b5RPvGXhnFM7gKyIDQDTc
	MkoC2658UDj2UVwNu2qnmWjDXGPXUI+WUjcHbRN8HLnTeSgc/QqNpzDMwuK2TRWp248UMKD9Zbe
	FuccvI2PMkIVSp+KfR1fjFwuoOLXtYcFHLAYnctUUtuUoBdyBOm9pbGu4nISZ9CUB8wI9oSL5Hk
	HGddRGkEa14sZBU+WBIZ5an+NOFcmuG/QzrnTa2EXEdtx3DV2knWj27qz69uf+vAftgyLrvHFqS
	EGnsMfWbCjng6/xNNndBogPFWdMIg==
X-Received: by 2002:a05:6a21:9982:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3bd4afd7d7amr313044637.20.1782346793012;
        Wed, 24 Jun 2026 17:19:53 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:19:52 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 7/9] wifi: mt76: mt7925: wire up NAN operations
Date: Wed, 24 Jun 2026 19:18:32 -0500
Message-ID: <20260625001834.475094-8-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38066-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C83486C1F5A

From: Sean Wang <sean.wang@mediatek.com>

Wire mac80211 NAN start, stop and change_conf callbacks to the mt7925 NAN
MCU helpers. Track the active NAN vif and notify mac80211 on cluster join
events.

Initialize NAN PHY capabilities after the supported bands are ready.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  29 +++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 201 ++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/nan.c   | 239 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/nan.h   |   2 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   3 +
 5 files changed, 430 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index e85b0d104fbe..1b44f5c8fb0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -152,6 +152,33 @@ static int mt7925_init_hardware(struct mt792x_dev *dev)
 	return 0;
 }
 
+static int mt7925_init_nan_cap(struct mt76_dev *mdev)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	struct wiphy *wiphy = mdev->hw->wiphy;
+
+	if (!(dev->fw_features & MT792x_FW_CAP_NAN))
+		return 0;
+
+	sband = wiphy->bands[NL80211_BAND_2GHZ];
+	if (sband)
+		wiphy->nan_capa.phy.ht = sband->ht_cap;
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (sband)
+		wiphy->nan_capa.phy.vht = sband->vht_cap;
+
+	sband = wiphy->bands[NL80211_BAND_2GHZ];
+	he_cap = sband ? ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_NAN)
+		       : NULL;
+	if (he_cap)
+		wiphy->nan_capa.phy.he = *he_cap;
+
+	return 0;
+}
+
 static void mt7925_init_work(struct work_struct *work)
 {
 	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
@@ -172,6 +199,8 @@ static void mt7925_init_work(struct work_struct *work)
 		return;
 	}
 
+	dev->mt76.init_wiphy = mt7925_init_nan_cap;
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a9059866b701..ddb637d6a3c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -11,6 +11,7 @@
 #include "regd.h"
 #include "mcu.h"
 #include "mac.h"
+#include "nan.h"
 
 static void
 mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
@@ -412,7 +413,8 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 	mconf->mt76.link_idx = hweight16(mvif->valid_links);
 
-	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
+	if (mvif->phy->mt76->chandef.chan &&
+	    mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
 	else
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
@@ -474,12 +476,32 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	INIT_WORK(&mvif->csa_work, mt7925_csa_work);
 	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
 
+	if (vif->type == NL80211_IFTYPE_NAN)
+		dev->nan_vif = vif;
 out:
 	mt792x_mutex_release(dev);
 
 	return ret;
 }
 
+static void
+mt7925_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
+
+	mt792x_mutex_acquire(dev);
+
+	if (dev->nan_vif == vif)
+		dev->nan_vif = NULL;
+
+	mconf = mt792x_link_conf_to_mconf(&vif->bss_conf);
+	mt792x_mac_link_bss_remove(dev, mconf, &mvif->sta.deflink);
+
+	mt792x_mutex_release(dev);
+}
+
 static void mt7925_roc_iter(void *priv, u8 *mac,
 			    struct ieee80211_vif *vif)
 {
@@ -1217,19 +1239,36 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 int mt7925_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct ieee80211_link_sta *link_sta = &sta->deflink;
 
-	if (ev != MT76_STA_EVENT_ASSOC)
-		return 0;
+	switch (ev) {
+	case MT76_STA_EVENT_ASSOC:
+		if (ieee80211_vif_is_mld(vif)) {
+			struct mt792x_sta *msta =
+				(struct mt792x_sta *)sta->drv_priv;
 
-	if (ieee80211_vif_is_mld(vif)) {
-		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+			link_sta = mt792x_sta_to_link_sta(vif, sta,
+							  msta->deflink_id);
+			mt7925_mac_set_links(mdev, vif);
+		}
 
-		link_sta = mt792x_sta_to_link_sta(vif, sta, msta->deflink_id);
-		mt7925_mac_set_links(mdev, vif);
-	}
+		mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
+		break;
+	case MT76_STA_EVENT_AUTHORIZE:
+		if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+			int ret;
 
-	mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
+			mt792x_mutex_acquire(dev);
+			ret = mt792x_nan_map_sta_rec(mdev, vif, sta);
+			mt792x_mutex_release(dev);
+
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -1357,6 +1396,36 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
+	/* Release NAN peer record before tearing down the STA. */
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA) {
+		int ret = mt792x_nan_set_peer_rec(mdev, sta);
+
+		if (ret)
+			dev_err(mdev->dev,
+				"NAN: failed to deactivate peer record: %d\n",
+				ret);
+	}
+
+	/* Release NDP context ID for NAN_DATA sta. */
+	if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+		struct ieee80211_sta *nmi_sta;
+
+		rcu_read_lock();
+		nmi_sta = rcu_dereference(sta->nmi);
+		if (nmi_sta) {
+			struct mt792x_sta *nmi_msta =
+				(struct mt792x_sta *)nmi_sta->drv_priv;
+
+			if (msta->nan_sched.ndp_ctx_assigned) {
+				clear_bit(msta->nan_sched.ndp_ctx_id,
+					  &nmi_msta->nan_sched.ndp_ctx_bitmap);
+				msta->nan_sched.ndp_ctx_assigned = false;
+			}
+		}
+		rcu_read_unlock();
+	}
+
 	if (ieee80211_vif_is_mld(vif)) {
 		mt7925_mac_sta_remove_links(dev, vif, sta, msta->valid_links);
 		mt7925_mcu_del_dev(mdev, vif);
@@ -2059,6 +2128,11 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	mt792x_mutex_release(dev);
+
+	if (vif->type == NL80211_IFTYPE_NAN &&
+	    changed & BSS_CHANGED_NAN_LOCAL_SCHED) {
+		mt7925_nan_local_sched_changed(dev, vif);
+	}
 }
 
 static void mt7925_link_info_changed(struct ieee80211_hw *hw,
@@ -2481,12 +2555,115 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	}
 }
 
+static int mt7925_start_nan(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct cfg80211_nan_conf *conf)
+{
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_channel *chan;
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	chan = conf->band_cfgs[NL80211_BAND_2GHZ].chan;
+	if (!chan) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	cfg80211_chandef_create(&link_conf->chanreq.oper, chan,
+				NL80211_CHAN_NO_HT);
+
+	err = mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
+				      NULL, true);
+	if (err < 0)
+		goto out;
+
+	dev->nan_vif = vif;
+
+	err = mt7925_nan_set_nmi_addr(dev, vif->addr);
+	if (err)
+		goto rollback_bss;
+
+	err = mt7925_nan_enable(vif, dev, conf);
+	if (err)
+		goto rollback_bss;
+
+	goto out;
+
+rollback_bss:
+	dev->nan_vif = NULL;
+	mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf, NULL, false);
+
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_stop_nan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
+{
+	struct ieee80211_bss_conf *link_conf = &vif->bss_conf;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err, ret;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_nan_disable(vif, dev);
+
+	ret = mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
+				      NULL, false);
+	if (!err)
+		err = ret;
+
+	if (dev->nan_vif == vif)
+		dev->nan_vif = NULL;
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_nan_change_conf(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_nan_conf *conf,
+				  u32 changes)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_nan_change_configure(vif, dev, conf);
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_nan_peer_sched_changed(struct ieee80211_hw *hw,
+					 struct ieee80211_sta *sta)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt792x_nan_set_peer_schedule(dev, sta);
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
 	.stop = mt792x_stop,
 	.add_interface = mt7925_add_interface,
-	.remove_interface = mt792x_remove_interface,
+	.remove_interface = mt7925_remove_interface,
 	.config = mt7925_config,
 	.conf_tx = mt7925_conf_tx,
 	.configure_filter = mt7925_configure_filter,
@@ -2550,6 +2727,10 @@ const struct ieee80211_ops mt7925_ops = {
 	.channel_switch = mt7925_channel_switch,
 	.abort_channel_switch = mt7925_abort_channel_switch,
 	.channel_switch_rx_beacon = mt7925_channel_switch_rx_beacon,
+	.start_nan = mt7925_start_nan,
+	.stop_nan = mt7925_stop_nan,
+	.nan_change_conf = mt7925_nan_change_conf,
+	.nan_peer_sched_changed = mt7925_nan_peer_sched_changed,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/nan.c b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
index dc7aa2cd9449..849952c6ac21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/nan.c
@@ -31,6 +31,8 @@ static void mt7925_nan_set_5g_channel(struct mt792x_dev *dev,
 	if (!mt7925_regd_is_valid_channel(dev, NL80211_BAND_5GHZ, chan))
 		return;
 
+	req->config_support_5g = 1;
+	req->support_5g_val = 1;
 	req->config_5g_channel = 1;
 
 	if (chan->hw_value == NAN_5G_LOW_DISC_CHANNEL)
@@ -41,6 +43,16 @@ static void mt7925_nan_set_5g_channel(struct mt792x_dev *dev,
 	req->channel_5g_val = cpu_to_le32(ch5g);
 }
 
+static void mt7925_nan_set_2g_support(struct mt7925_nan_enable_req_tlv *req,
+				      struct cfg80211_nan_conf *conf)
+{
+	if (!conf->band_cfgs[NL80211_BAND_2GHZ].chan)
+		return;
+
+	req->config_2dot4g_support = 1;
+	req->support_2dot4g_val = 1;
+}
+
 static void mt7925_nan_set_cluster_id(struct mt7925_nan_enable_req_tlv *req,
 				      const u8 *cluster_id)
 {
@@ -131,6 +143,38 @@ mt7925_nan_update_conf(struct mt792x_vif *mvif,
 	memcpy(mvif->nan.conf.cluster_id, conf->cluster_id, ETH_ALEN);
 }
 
+int mt7925_nan_set_nmi_addr(struct mt792x_dev *dev, const u8 *addr)
+{
+	struct mt76_dev *mdev;
+	struct {
+		u8 rsv[4];
+		struct mt7925_nan_nmi_addr_tlv nmi_addr_tlv;
+	} nmi_cmd = {
+		.rsv = { 0 },
+		.nmi_addr_tlv = {
+			.tag = cpu_to_le16(NAN_UNI_CMD_CHANGE_NMI_ADDRESS),
+			.len = cpu_to_le16(sizeof(struct mt7925_nan_nmi_addr_tlv)),
+		},
+	};
+	int ret;
+
+	if (!dev || !addr)
+		return -EINVAL;
+
+	if (is_zero_ether_addr(addr) || is_multicast_ether_addr(addr)) {
+		dev_err(dev->mt76.dev, "NAN: invalid NMI address %pM\n", addr);
+		return -EINVAL;
+	}
+
+	mdev = &dev->mt76;
+	memcpy(nmi_cmd.nmi_addr_tlv.nmi_addr, addr, ETH_ALEN);
+
+	ret = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(NAN), &nmi_cmd,
+				sizeof(nmi_cmd), true);
+
+	return ret;
+}
+
 int mt7925_nan_enable(struct ieee80211_vif *vif,
 		      struct mt792x_dev *dev,
 		      struct cfg80211_nan_conf *conf)
@@ -152,12 +196,14 @@ int mt7925_nan_enable(struct ieee80211_vif *vif,
 		},
 	};
 	struct mt7925_nan_enable_req_tlv *p_nan_req_tlv = &nan_cmd.nan_req_tlv;
+	int ret;
 
 	if (!vif || !dev || !conf)
 		return -EINVAL;
 
 	p_nan_req_tlv->master_pref = conf->master_pref;
 
+	mt7925_nan_set_2g_support(p_nan_req_tlv, conf);
 	mt7925_nan_set_5g_channel(dev, p_nan_req_tlv, conf);
 	mt7925_nan_set_cluster_id(p_nan_req_tlv, conf->cluster_id);
 	mt7925_nan_set_dw_interval(p_nan_req_tlv, conf);
@@ -167,7 +213,9 @@ int mt7925_nan_enable(struct ieee80211_vif *vif,
 
 	mt7925_nan_update_conf(mvif, conf);
 
-	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(NAN), &nan_cmd, sizeof(nan_cmd), true);
+	ret = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(NAN), &nan_cmd, sizeof(nan_cmd), true);
+
+	return ret;
 }
 
 int mt7925_nan_disable(struct ieee80211_vif *vif, struct mt792x_dev *dev)
@@ -427,7 +475,7 @@ mt7925_nan_mcu_handle_de_event(struct mt792x_dev *dev, struct tlv *tlv)
 	if (de_evt->event_type != NAN_EVENT_ID_JOINED_CLUSTER)
 		return;
 
-	if (!ieee80211_vif_nan_started(dev->nan_vif)) {
+	if (!dev->nan_vif || !ieee80211_vif_nan_started(dev->nan_vif)) {
 		dev_warn(dev->mt76.dev, "nan: joined-cluster event but NAN not started\n");
 		return;
 	}
@@ -592,16 +640,21 @@ void mt7925_nan_local_sched_changed(struct mt792x_dev *dev,
 {
 	struct mt7925_nan_common_hdr *hdr;
 	struct mt76_dev *mdev;
+	bool deferred;
 	struct sk_buff *skb;
+	int ret = -ENOMEM;
 
 	if (!dev || !vif)
 		return;
 
 	mdev = &dev->mt76;
+	deferred = vif->cfg.nan_sched.deferred;
+
+	mt792x_mutex_acquire(dev);
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL, MT7925_NAN_AVAIL_MAX_SIZE);
 	if (!skb)
-		return;
+		goto out;
 
 	hdr = (struct mt7925_nan_common_hdr *)skb_put(skb, sizeof(*hdr));
 	memset(hdr, 0, sizeof(*hdr));
@@ -609,11 +662,22 @@ void mt7925_nan_local_sched_changed(struct mt792x_dev *dev,
 	if (mt7925_nan_avail_ctrl_tlv(skb, vif) ||
 	    mt7925_nan_avail_tlv(skb, vif)) {
 		dev_kfree_skb(skb);
-		return;
+		goto out;
 	}
 
-	mt76_mcu_skb_send_msg(mdev, skb,
-			      MCU_UNI_CMD(NAN), true);
+	ret = mt76_mcu_skb_send_msg(mdev, skb,
+				    MCU_UNI_CMD(NAN), true);
+out:
+	mt792x_mutex_release(dev);
+
+	if (deferred) {
+		if (ret)
+			dev_err(mdev->dev,
+				"NAN: local schedule update failed: %d\n",
+				ret);
+
+		ieee80211_nan_sched_update_done(vif);
+	}
 }
 
 static int mt7925_nan_peer_rec_tlv(struct sk_buff *skb,
@@ -641,6 +705,23 @@ static int mt7925_nan_peer_rec_tlv(struct sk_buff *skb,
 	return 0;
 }
 
+static u8 mt7925_nan_get_supported_bands(struct mt792x_vif *mvif)
+{
+	struct wiphy *wiphy;
+	u8 bands = 0;
+
+	if (!mvif || !mvif->phy)
+		return BIT(NAN_SUPPORTED_BAND_ID_2P4G);
+
+	wiphy = mvif->phy->mt76->hw->wiphy;
+	if (wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ))
+		bands |= BIT(NAN_SUPPORTED_BAND_ID_2P4G);
+	if (wiphy->nan_supported_bands & BIT(NL80211_BAND_5GHZ))
+		bands |= BIT(NAN_SUPPORTED_BAND_ID_5G);
+
+	return bands ?: BIT(NAN_SUPPORTED_BAND_ID_2P4G);
+}
+
 static int mt7925_nan_peer_cap_tlv(struct sk_buff *skb,
 				   struct ieee80211_sta *sta,
 				   struct mt792x_sta *msta)
@@ -667,7 +748,8 @@ static int mt7925_nan_peer_cap_tlv(struct sk_buff *skb,
 
 	peer_cap_tlv = (struct mt7925_nan_sched_update_peer_cap_tlv *)tlv;
 	peer_cap_tlv->sch_idx = msta->nan_sched.sch_idx;
-	peer_cap_tlv->supported_bands = BIT(NAN_SUPPORTED_BAND_ID_2P4G);
+	peer_cap_tlv->supported_bands =
+		mt7925_nan_get_supported_bands(msta->vif);
 	peer_cap_tlv->max_chnl_switch_time = sched->max_chan_switch;
 
 	for (i = 0; i < sched->n_channels; i++) {
@@ -696,38 +778,52 @@ static int mt7925_nan_peer_cap_tlv(struct sk_buff *skb,
 
 static void
 mt7925_nan_fill_crb_committed(struct mt7925_nan_sched_update_crb_tlv *crb_tlv,
+			      struct ieee80211_vif *vif,
 			      struct ieee80211_nan_peer_sched *sched)
 {
+	struct ieee80211_nan_sched_cfg *local_sched;
+	u8 local_map_id;
 	u32 m, slot;
 
-	if (!sched)
+	if (!vif || !sched)
 		return;
 
+	local_sched = &vif->cfg.nan_sched;
+	local_map_id = mt7925_nan_avail_attr_ctrl(local_sched) &
+		       NAN_AVAIL_CTRL_MAPID;
+
 	for (m = 0; m < CFG80211_NAN_MAX_PEER_MAPS &&
 	     m < NAN_TIMELINE_MGMT_SIZE; m++) {
 		struct mt7925_nan_sched_timeline *tl =
 			&crb_tlv->comm_faw_timeline[m];
 		struct ieee80211_nan_peer_map *map = &sched->maps[m];
+		u32 avail_map = 0;
 
 		if (map->map_id == CFG80211_NAN_INVALID_MAP_ID)
 			continue;
 
 		tl->map_id = map->map_id;
+		tl->local_map_id = local_map_id;
 
-		/*
-		 * Convert peer schedule slots to FW avail_map bitmap.
-		 * Each bit in avail_map[0] represents one time slot where
-		 * the peer has committed availability.
-		 */
 		for (slot = 0; slot < CFG80211_NAN_SCHED_NUM_TIME_SLOTS;
 		     slot++) {
-			struct ieee80211_nan_channel *ch = map->slots[slot];
+			struct ieee80211_nan_channel *local_ch;
+			struct ieee80211_nan_channel *peer_ch;
+
+			local_ch = local_sched->schedule[slot];
+			peer_ch = map->slots[slot];
 
-			if (!ch || !ch->chanctx_conf)
+			if (!local_ch || !local_ch->chanctx_conf ||
+			    !peer_ch || !peer_ch->chanctx_conf)
 				continue;
 
-			tl->avail_map[0] |= cpu_to_le32(BIT(slot));
+			if (local_ch->chanctx_conf != peer_ch->chanctx_conf)
+				continue;
+
+			avail_map |= BIT(slot);
 		}
+
+		tl->avail_map[0] = cpu_to_le32(avail_map);
 	}
 }
 
@@ -753,7 +849,8 @@ static int mt7925_nan_update_crb_tlv(struct sk_buff *skb,
 	crb_tlv->is_use_ranging = false;
 	crb_tlv->comm_ndc_ctrl.is_valid = false;
 
-	mt7925_nan_fill_crb_committed(crb_tlv, sta->nan_sched);
+	mt7925_nan_fill_crb_committed(crb_tlv, msta->vif->phy->dev->nan_vif,
+				      sta->nan_sched);
 
 	return 0;
 }
@@ -762,10 +859,12 @@ int mt792x_nan_set_peer_schedule(struct mt792x_dev *dev,
 				 struct ieee80211_sta *sta)
 {
 	struct mt7925_nan_common_hdr *hdr;
+	bool idx_allocated = false;
 	struct mt792x_sta *msta;
 	struct mt792x_nan *nan;
 	struct mt76_dev *mdev;
 	struct sk_buff *skb;
+	int ret;
 
 	if (!dev || !sta)
 		return -EINVAL;
@@ -794,21 +893,36 @@ int mt792x_nan_set_peer_schedule(struct mt792x_dev *dev,
 		set_bit(idx, &nan->conn_bitmap);
 		msta->nan_sched.sch_idx = idx;
 		msta->nan_sched.idx_assigned = true;
+		idx_allocated = true;
 
 		if (mt7925_nan_peer_rec_tlv(skb, sta, msta, true) ||
 		    mt7925_nan_peer_cap_tlv(skb, sta, msta)) {
-			dev_kfree_skb(skb);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto free_skb;
 		}
 	}
 
 	if (mt7925_nan_update_crb_tlv(skb, sta, msta)) {
-		dev_kfree_skb(skb);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_skb;
 	}
 
-	return mt76_mcu_skb_send_msg(mdev, skb,
-				     MCU_UNI_CMD(NAN), true);
+	ret = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(NAN), true);
+	if (ret && idx_allocated)
+		goto clear_idx;
+
+	return ret;
+
+free_skb:
+	dev_kfree_skb(skb);
+	if (!idx_allocated)
+		return ret;
+
+clear_idx:
+	clear_bit(msta->nan_sched.sch_idx, &nan->conn_bitmap);
+	msta->nan_sched.idx_assigned = false;
+
+	return ret;
 }
 
 int mt792x_nan_set_peer_rec(struct mt76_dev *mdev,
@@ -818,6 +932,7 @@ int mt792x_nan_set_peer_rec(struct mt76_dev *mdev,
 	struct mt792x_sta *msta;
 	struct mt792x_nan *nan;
 	struct sk_buff *skb;
+	int ret;
 
 	if (!mdev || !sta)
 		return -EINVAL;
@@ -844,11 +959,14 @@ int mt792x_nan_set_peer_rec(struct mt76_dev *mdev,
 		return -ENOMEM;
 	}
 
+	ret = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(NAN), true);
+	if (ret)
+		return ret;
+
 	clear_bit(msta->nan_sched.sch_idx, &nan->conn_bitmap);
 	msta->nan_sched.idx_assigned = false;
 
-	return mt76_mcu_skb_send_msg(mdev, skb,
-				     MCU_UNI_CMD(NAN), true);
+	return 0;
 }
 
 int mt792x_nan_map_sta_rec(struct mt76_dev *mdev,
@@ -859,16 +977,21 @@ int mt792x_nan_map_sta_rec(struct mt76_dev *mdev,
 	struct mt7925_nan_common_hdr *hdr;
 	struct ieee80211_sta *nmi_sta;
 	struct mt792x_sta *nmi_msta;
+	struct mt792x_vif *mvif;
 	struct mt792x_sta *msta;
 	u8 nmi_addr[ETH_ALEN];
 	struct sk_buff *skb;
 	int ndp_ctx_id = 0;
+	int ret = -ENOMEM;
+	struct mt792x_dev *dev;
 	struct tlv *tlv;
 
 	if (!mdev || !vif || !sta)
 		return -EINVAL;
 
+	dev = container_of(mdev, struct mt792x_dev, mt76);
 	msta = (struct mt792x_sta *)sta->drv_priv;
+	mvif = (struct mt792x_vif *)vif->drv_priv;
 
 	rcu_read_lock();
 	nmi_sta = rcu_dereference(sta->nmi);
@@ -882,21 +1005,51 @@ int mt792x_nan_map_sta_rec(struct mt76_dev *mdev,
 	memcpy(nmi_addr, nmi_sta->addr, ETH_ALEN);
 	nmi_msta = (struct mt792x_sta *)nmi_sta->drv_priv;
 
+	if (!nmi_msta->nan_sched.idx_assigned) {
+		if (!nmi_sta->nan_sched) {
+			rcu_read_unlock();
+			dev_err(mdev->dev,
+				"NAN: peer schedule missing for NDI sta %pM\n",
+				sta->addr);
+			return -EAGAIN;
+		}
+
+		rcu_read_unlock();
+		ret = mt792x_nan_set_peer_schedule(dev, nmi_sta);
+		if (ret)
+			return ret;
+
+		rcu_read_lock();
+		nmi_sta = rcu_dereference(sta->nmi);
+		if (!nmi_sta) {
+			rcu_read_unlock();
+			dev_err(mdev->dev,
+				"NAN: NMI sta not found for NDI sta %pM\n",
+				sta->addr);
+			return -EINVAL;
+		}
+
+		nmi_msta = (struct mt792x_sta *)nmi_sta->drv_priv;
+	}
+
 	ndp_ctx_id = find_first_zero_bit(&nmi_msta->nan_sched.ndp_ctx_bitmap,
 					 NAN_MAX_NDP_CXT);
-	if (ndp_ctx_id < NAN_MAX_NDP_CXT)
-		set_bit(ndp_ctx_id, &nmi_msta->nan_sched.ndp_ctx_bitmap);
-	else
-		ndp_ctx_id = 0;
+	if (ndp_ctx_id >= NAN_MAX_NDP_CXT) {
+		rcu_read_unlock();
+		return -ENOSPC;
+	}
+
+	set_bit(ndp_ctx_id, &nmi_msta->nan_sched.ndp_ctx_bitmap);
 	rcu_read_unlock();
 
 	msta->nan_sched.ndp_ctx_id = ndp_ctx_id;
+	msta->nan_sched.ndp_ctx_assigned = true;
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL,
 				 sizeof(struct mt7925_nan_common_hdr) +
 				 sizeof(struct mt7925_nan_sched_map_sta_rec_tlv));
 	if (!skb)
-		return -ENOMEM;
+		goto clear_ndp_ctx;
 
 	hdr = (struct mt7925_nan_common_hdr *)skb_put(skb, sizeof(*hdr));
 	memset(hdr, 0, sizeof(*hdr));
@@ -905,16 +1058,34 @@ int mt792x_nan_map_sta_rec(struct mt76_dev *mdev,
 				      sizeof(struct mt7925_nan_sched_map_sta_rec_tlv));
 	if (!tlv) {
 		dev_kfree_skb(skb);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto clear_ndp_ctx;
 	}
 
 	map_tlv = (struct mt7925_nan_sched_map_sta_rec_tlv *)tlv;
 	memcpy(map_tlv->nmi_addr, nmi_addr, ETH_ALEN);
 	map_tlv->sta_rec_idx = msta->deflink.wcid.idx;
 	map_tlv->ndp_ctx_id = ndp_ctx_id;
-	map_tlv->role_idx = 0;
+	map_tlv->role_idx = cpu_to_le32(mvif->bss_conf.mt76.idx);
 	memcpy(map_tlv->ndi_addr, vif->addr, ETH_ALEN);
 
-	return mt76_mcu_skb_send_msg(mdev, skb,
-				     MCU_UNI_CMD(NAN), true);
+	ret = mt76_mcu_skb_send_msg(mdev, skb,
+				    MCU_UNI_CMD(NAN), true);
+	if (ret)
+		goto clear_ndp_ctx;
+
+	return 0;
+
+clear_ndp_ctx:
+	rcu_read_lock();
+	nmi_sta = rcu_dereference(sta->nmi);
+	if (nmi_sta) {
+		nmi_msta = (struct mt792x_sta *)nmi_sta->drv_priv;
+		clear_bit(msta->nan_sched.ndp_ctx_id,
+			  &nmi_msta->nan_sched.ndp_ctx_bitmap);
+	}
+	rcu_read_unlock();
+	msta->nan_sched.ndp_ctx_assigned = false;
+
+	return ret ?: -ENOMEM;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/nan.h b/drivers/net/wireless/mediatek/mt76/mt7925/nan.h
index 1895d0be8ee4..d308eadb3636 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/nan.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/nan.h
@@ -422,6 +422,8 @@ int mt7925_nan_change_configure(struct ieee80211_vif *vif,
 
 void mt7925_nan_mcu_event(struct mt792x_dev *dev, struct sk_buff *skb);
 
+int mt7925_nan_set_nmi_addr(struct mt792x_dev *dev, const u8 *addr);
+
 void mt7925_nan_local_sched_changed(struct mt792x_dev *dev,
 				    struct ieee80211_vif *vif);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 89c3f84a776a..9d5a2adc81f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -23,6 +23,7 @@
 #define MT792x_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
 #define MT792x_FW_TAG_FEATURE	4
+#define MT792x_FW_CAP_NAN	BIT(5)
 #define MT792x_FW_CAP_CNM	BIT(7)
 
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
@@ -116,10 +117,12 @@ struct mt792x_link_sta {
 };
 
 struct mt792x_sta_nan_sched {
+	/* protects NAN peer schedule state */
 	u16 committed_dw;
 	u32 sch_idx;
 	bool idx_assigned;
 	unsigned long ndp_ctx_bitmap;
+	bool ndp_ctx_assigned;
 	u8 ndp_ctx_id;		/* assigned NDP context ID (for NDI sta) */
 	struct {
 		u8 map_id;
-- 
2.43.0


