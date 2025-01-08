Return-Path: <linux-wireless+bounces-17183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1BA05098
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE603A2910
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D715DBC1;
	Wed,  8 Jan 2025 02:25:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C71DFFD
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303136; cv=none; b=iuoSZ7MLmB5i+y5Ld+T0+lX9wLdalWnI+EzP7eP7TVPFpYTZi2/C0u2P75vLnkmoZU+suCyXjfcbI3LKAkJkULmlQa36i1YYdivgiSJ6DSj8qC5qRZnFEPt08vOB9IpHtBB18GH0toyMJ6BDoTJOEC/qqqCOIIC/bTwlIgRC/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303136; c=relaxed/simple;
	bh=IHkXeQel1Q2+5E9CuXQlGmVXXtVn0dDhdkgxQPhctyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYgR+MSuqHC5NbLX+jjiUDt4LtzWaZQMa+g5JduQT3vRXwkkjo2lVP09IL7y6YSYTT7MwtZu3oMXkVZC9UWrHSZQG7Z5lcWQ8/1YIoln2HQgywvSi7G7rUMqsS7I548BUkCGLT4bexWSM+iZ5tyQgd76whL/typnj9TrpHDvShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2dee7d218so7293410eaf.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 18:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303133; x=1736907933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMHTVC5omCIzKCyWSVas6ETdrQO9DyIoTSLU4TpmV5k=;
        b=w+8UfjQwwg+nt8ktaYOk/W96AJ3A+HoihLhiHzWAMw651lByN2vM8VTGH+5jVk0k3g
         Ie9LS299gcR04rJUG459rOkXTgT3693Uj/lLZEjL1t8R9iJA9xhlyEnhrsgUBCft2Icx
         Tww5FjMj/w3olL0V/GmvcMQdQr2nQVQr7xy155R53x8StnJrggxe4Eb3EiJLFI1MFKpa
         RU2H7veBWlf3dgzYJRb9tILgPRTyV9yDgSurF5s6RDfkBlRmZCkegaQ7SUps2+ZGN7c8
         KHm49xeEoS9yDY9lywmJ1LY4YM4V8H+KAGoqW+OjA1EGdVf/1PTRF7nEI0NMyxV3RwXT
         6Z0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV62HXzYzC79T6NWgLNYwcNVa7bKWcTO9uzfCYtfzBZhKJ9u6+h6rGgXzSwU/dzNAdspK1qnjxzPeXJKOuqpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwidX1gODNUFtRcqGn4To2ABsnXBVUpEpJAWwknJ2croN/rxYSd
	bja8yMJmj+YaDZPVSq7byJjg47aSi9BzvZUzp3PhAK8XfSBl6hpp
X-Gm-Gg: ASbGncsxiJZsfCeplZRKOfr2Fiv99654Zg8RSF5FH8sxFwE3owtQEeDVDzAl+dNmhdG
	wwibCljFUKNlg/rBem2JKhVgw2KScz1UOoR421H5IHueezYxBy2EGPc8xsXrAJnr1WSpG9mIojD
	QbE7nZzZxoPsPrf5jyDwXki/iWCx+frOQhkMMg7+a8C5p9Q0UXo51HqRIylU+QfjW7qrNey1g/O
	kETzIpb6ZY5dazf1M0gBiktjyOg02qG4QKfpMiE8fY+CZEp+05Q3S5p3ZhtqVpmlk/hPhc1gQ==
X-Google-Smtp-Source: AGHT+IGQa9k57yYFrsV2kb30+Ip/UeVPsLJ/gjUXW4EJquDZ30xFTxjbTqu4fk9CYmLSYObCuskDOA==
X-Received: by 2002:a05:6870:ce07:b0:29e:24c7:2861 with SMTP id 586e51a60fabf-2aa066abf1bmr581936fac.13.1736303133345;
        Tue, 07 Jan 2025 18:25:33 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f6340sm13072862fac.48.2025.01.07.18.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:25:31 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6/6] wifi: mt76: mt7925: update the power-saving flow
Date: Tue,  7 Jan 2025 18:25:09 -0800
Message-Id: <20250108022509.217803-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org>
References: <20250108022509.217803-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

After joining MLO, ensure that all links are setup before
enabling power-saving.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 65 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  9 +++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index ddc654b9ea5e..7d829b511846 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -222,6 +222,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->mt76.tx_worker.fn = mt792x_tx_worker;
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt792x_pm_power_save_work);
+	INIT_DELAYED_WORK(&dev->mlo_pm_work, mt7925_mlo_pm_work);
 	INIT_WORK(&dev->pm.wake_work, mt792x_pm_wake_work);
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4714c07cfbfe..ffe783b4fb71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -426,6 +426,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.vif = mvif;
 	mvif->sta.vif = mvif;
 	mvif->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	mvif->mlo_pm_state = MT792x_MLO_LINK_DISASSOC;
 
 	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
 	if (ret < 0)
@@ -1285,6 +1286,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 	}
+
+	mvif->mlo_pm_state = MT792x_MLO_LINK_DISASSOC;
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
@@ -1356,6 +1359,38 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static void
+mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				    mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
+
+	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
+		return;
+
+	mt792x_mutex_acquire(dev);
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		mt7925_mcu_uni_bss_ps(dev, bss_conf);
+	}
+	mt792x_mutex_release(dev);
+}
+
+void mt7925_mlo_pm_work(struct work_struct *work)
+{
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      mlo_pm_work.work);
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7925_mlo_pm_iter, dev);
+}
+
 static bool is_valid_alpha2(const char *alpha2)
 {
 	if (!alpha2)
@@ -1905,6 +1940,9 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 		mt7925_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
 		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+
+		if (ieee80211_vif_is_mld(vif))
+			mvif->mlo_pm_state = MT792x_MLO_LINK_ASSOC;
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
@@ -1915,9 +1953,19 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_PS) {
-		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (hweight16(mvif->valid_links) < 2) {
+			/* legacy */
+			bss_conf = &vif->bss_conf;
 			mt7925_mcu_uni_bss_ps(dev, bss_conf);
+		} else {
+			if (mvif->mlo_pm_state == MT792x_MLO_LINK_ASSOC) {
+				mvif->mlo_pm_state = MT792x_MLO_CHANGED_PS_PENDING;
+			} else if (mvif->mlo_pm_state == MT792x_MLO_CHANGED_PS) {
+				for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+					bss_conf = mt792x_vif_to_bss_conf(vif, i);
+					mt7925_mcu_uni_bss_ps(dev, bss_conf);
+				}
+			}
 		}
 	}
 
@@ -1968,11 +2016,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7925_mcu_set_tx(dev, info);
 
-	if (changed & BSS_CHANGED_BSSID) {
-		if (ieee80211_vif_is_mld(vif) &&
-		    hweight16(mvif->valid_links) == 2)
-			/* Indicate the secondary setup done */
-			mt7925_mcu_uni_bss_bcnft(dev, info, true);
+	if (mvif->mlo_pm_state == MT792x_MLO_CHANGED_PS_PENDING) {
+		/* Indicate the secondary setup done */
+		mt7925_mcu_uni_bss_bcnft(dev, info, true);
+
+		ieee80211_queue_delayed_work(hw, &dev->mlo_pm_work, 5 * HZ);
+		mvif->mlo_pm_state = MT792x_MLO_CHANGED_PS;
 	}
 
 	mt792x_mutex_release(dev);
@@ -2056,8 +2105,6 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto free;
 
 		if (mconf != &mvif->bss_conf) {
-			mt7925_mcu_set_bss_pm(dev, link_conf, true);
-
 			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
 						 vif->active_links);
 			if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index f5c02e5f5066..cd7a7c293018 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -247,6 +247,7 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
+void mt7925_mlo_pm_work(struct work_struct *work);
 void mt7925_scan_work(struct work_struct *work);
 void mt7925_roc_work(struct work_struct *work);
 int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 3f989e83f252..20d8b02d1b6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -81,6 +81,13 @@ enum mt792x_reg_power_type {
 	MT_AP_VLP,
 };
 
+enum mt792x_mlo_pm_state {
+	MT792x_MLO_LINK_DISASSOC,
+	MT792x_MLO_LINK_ASSOC,
+	MT792x_MLO_CHANGED_PS_PENDING,
+	MT792x_MLO_CHANGED_PS,
+};
+
 DECLARE_EWMA(avg_signal, 10, 8)
 
 struct mt792x_link_sta {
@@ -134,6 +141,7 @@ struct mt792x_vif {
 	struct mt792x_phy *phy;
 	u16 valid_links;
 	u8 deflink_id;
+	enum mt792x_mlo_pm_state mlo_pm_state;
 
 	struct work_struct csa_work;
 	struct timer_list csa_timer;
@@ -235,6 +243,7 @@ struct mt792x_dev {
 	const struct mt792x_irq_map *irq_map;
 
 	struct work_struct ipv6_ns_work;
+	struct delayed_work mlo_pm_work;
 	/* IPv6 addresses for WoWLAN */
 	struct sk_buff_head ipv6_ns_list;
 
-- 
2.25.1


