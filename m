Return-Path: <linux-wireless+bounces-19787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3CA4F22A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D319188DB73
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1858F54;
	Wed,  5 Mar 2025 00:09:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D1BA33;
	Wed,  5 Mar 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133362; cv=none; b=EYYiJ9pBUPvBjpwXGTpDj5UZL5nU3qGaf9ybD0vHCUYjJxtVvi1Uj7Wd2eMk+Y1mvl6z1VExbxU4eYcRyyOAst2csKDO2o4RNbtnR0qJyqpvePqaU+Jy7GPg5GQ8NULM0X9pfDGfBLAXSa/pq0smRTMp7VcO9ON3kH27iRuTBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133362; c=relaxed/simple;
	bh=03DJX5A+t/rFRpYZ7cbvfQOOkyQSZngBdnWGm3oSkjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQOp78VCr/15gv0DUEDJ0h5KUMkvP9X17b5IE/hzqjedmY8UJZhfeDtlwcXzHahHqF62wX79F3AxZg0U3vGRRGGkxTKaUb5dkJRLuUIo5WYUv2LH4jFjRjDhWRfv257fb7VuX2pm/O1bPpQ4jkpNurCIQ0Seukv3W++8A0tiofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f67e40ed03so316845b6e.3;
        Tue, 04 Mar 2025 16:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133360; x=1741738160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdMXQ8DVuTg7ZnWdsQQ0oBojxJey5AseHHD1u1BZ0G4=;
        b=SOK2gaFkXtyHiIQ6ZrM0F5WgP+/WTHpssABF55q1wnjjeIiP51Bu93baLCUdHYEWoY
         dIVfFCDAiH7OVH8+gpqj/QD7xbr3Ggfw6bnrhEfMpcLwirgpE91+zaHp68/GZeLoXkEB
         Lsdu8gdJZvA3YIESLSQiMzzHRODLudmXU3AaqWRTAG4E97F34I4bQryDva6whS2V2eoT
         UKo5WFIbv8HR3bk4jVSdmNcSlRdxe5vgFbkndaoFQ/2J12vK79PjbMPWmlzZAW8eJQTZ
         6CqOyYSdOkur2ej0R9Rr603t5g+mMDqHrNJoHa/gu67TJoB60l3hsTrhGxIpDFMztmAa
         EbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUQFVjg3TOXDiq61AO+R7YWf/KWRoKYgbgqRJAX1cb5JzzYl1CtmEADCKpFX7zBmFnQ7cjvSmR1tyhF/yA3Dg==@vger.kernel.org, AJvYcCWAkBrbehmM+NRtxByfl2F35CXNUhNTEo0Q7BnRRRmG7e/kPHWYGyeCRVVJZxEtFVsJFID9cQHJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBXbFkmF4dqaXDiL+HMxsBT/BUGj4lwjb9t3jwat22XjCcB5o
	tzbpz7uursZUcioGI9DmaEk+5yqX9fwsbA+yB4YskYBSjeUpRS04
X-Gm-Gg: ASbGncsTohvUxpFgMCw96YUdjFBhx5y6kJPYXxZ/2atUM6VB4qSfe+yUslc+Jxn3WOU
	77cgN7JfEwbyjX/lTvTWWYBjewiGRCW7VLjxB6bRdsCbKxJJR5wUQloYEJ67EyuL74cB8oRj54P
	s9j5hRAOPSgAe/gMNDTmv1WOy6F4ZsRiG+iafiRdqESxAxmzkWMygJLoy1R318ibrZG7yoZ8EH+
	MTDiKlweNNl0z9QjdhBejk2ExZfNbdXkOeN4vTwo+auUXe6MY5F82tko04BcCIWv4dPcnYwzaBs
	gqo8zOs4K9Iexywt4r8c1w7kbMAE0kHP2QEukTb66Q/zcdgpHCy0jqvmp8DdJw==
X-Google-Smtp-Source: AGHT+IFahbflM/2sxhPc2hoXIoRKE+629RaJj0eVCjQn7LPrXNp8XwvlKkE+YUuntxdL8oWJdNV5PA==
X-Received: by 2002:a05:6808:1306:b0:3f4:10eb:7fce with SMTP id 5614622812f47-3f683229a3fmr564639b6e.37.1741133359660;
        Tue, 04 Mar 2025 16:09:19 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:09:17 -0800 (PST)
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
Subject: [PATCH v5 6/6] wifi: mt76: mt7925: update the power-saving flow
Date: Tue,  4 Mar 2025 16:08:51 -0800
Message-Id: <20250305000851.493671-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305000851.493671-1-sean.wang@kernel.org>
References: <20250305000851.493671-1-sean.wang@kernel.org>
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
Cc: stable@vger.kernel.org
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
v5:
  1) fixed mt7925/main.c:1245:28: warning: unused variable "mvif" [-Wunused-variable]
  2) update co-developed-by tag
  3) rebase to wireless.git
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 67 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  9 +++
 4 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index f41ca4248497..a2bb36dab231 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -244,6 +244,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->mt76.tx_worker.fn = mt792x_tx_worker;
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt792x_pm_power_save_work);
+	INIT_DELAYED_WORK(&dev->mlo_pm_work, mt7925_mlo_pm_work);
 	INIT_WORK(&dev->pm.wake_work, mt792x_pm_wake_work);
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a7464839318e..aea0151d25d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -427,6 +427,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.vif = mvif;
 	mvif->sta.vif = mvif;
 	mvif->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	mvif->mlo_pm_state = MT792x_MLO_LINK_DISASSOC;
 
 	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
 	if (ret < 0)
@@ -1242,6 +1243,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
 	struct {
 		struct {
 			u8 omac_idx;
@@ -1283,6 +1286,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 	}
+
+	mvif->mlo_pm_state = MT792x_MLO_LINK_DISASSOC;
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
@@ -1354,6 +1359,38 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -1903,6 +1940,9 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 		mt7925_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
 		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+
+		if (ieee80211_vif_is_mld(vif))
+			mvif->mlo_pm_state = MT792x_MLO_LINK_ASSOC;
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
@@ -1913,9 +1953,19 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
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
 
@@ -1966,11 +2016,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
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
@@ -2054,8 +2105,6 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto free;
 
 		if (mconf != &mvif->bss_conf) {
-			mt7925_mcu_set_bss_pm(dev, link_conf, true);
-
 			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
 						 vif->active_links);
 			if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index fd5f9d4ea4a7..cb7b1a49fbd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -268,6 +268,7 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
+void mt7925_mlo_pm_work(struct work_struct *work);
 void mt7925_scan_work(struct work_struct *work);
 void mt7925_roc_work(struct work_struct *work);
 int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 32ed01a96bf7..6e25a4421e12 100644
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
@@ -239,6 +247,7 @@ struct mt792x_dev {
 	const struct mt792x_irq_map *irq_map;
 
 	struct work_struct ipv6_ns_work;
+	struct delayed_work mlo_pm_work;
 	/* IPv6 addresses for WoWLAN */
 	struct sk_buff_head ipv6_ns_list;
 
-- 
2.25.1


