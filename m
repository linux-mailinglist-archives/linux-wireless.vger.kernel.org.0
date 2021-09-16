Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703AC40D1CA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhIPC41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 22:56:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16342 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233981AbhIPC40 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 22:56:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631760907; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=vlruAR/mFYVXxb712Zn9/EfmHlG0yf4GZsJMEX3a4BQ=; b=jgyxEVKD4Bt3ydQ1vP16RS06KpCPDM1VckPwXi7ZdMiKOhTzeptxjMzeFq7O7oG+8kKnu3G6
 QL/m2yXRa6ZRQzfOrZznHsjG+BdUCOJt2T1KjBkn9WSgGe+QyEdbapGu9iSnrARX/gGjZuUU
 A34DMcf07d/40PdmZoqWFkTi29A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6142b1f8ec62f57c9a6a4527 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 02:54:48
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1FDB4C4360C; Thu, 16 Sep 2021 02:54:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0BB3C4360D;
        Thu, 16 Sep 2021 02:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D0BB3C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH v12 2/4] mac80211: MBSSID support in interface handling
Date:   Wed, 15 Sep 2021 19:54:35 -0700
Message-Id: <20210916025437.29138-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916025437.29138-1-alokad@codeaurora.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Configure multiple BSSID and enhanced multi-BSSID advertisement (EMA)
parameters in mac80211 for AP mode.

For each interface, 'mbssid_tx_vif' points to the transmitting interface of
the MBSSID set. The pointer is set to NULL if MBSSID is disabled.

Function ieee80211_stop() is modified to always bring down all the
non-transmitting interfaces first and the transmitting interface last.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v12: Only cosmetic changes.
v11: Moved dev_close() for non-transmitting interfaces
     before locking wiphy->mtx.
     Removed interface count, instead mac80211 passes pointer
     'mbssid_tx_vif' to the driver for each interface.
     Removed dev_close() calls from ieee80211_del_iface().
     Removed IEEE80211_HW_SUPPORTS_MBSSID_AP and
     IEEE80211_HW_SUPPORTS_EMA_AP.
     Instead of new parameters in struct ieee80211_bss_conf,
     reused the existing ones which were used for STA mode.

 include/net/mac80211.h |  3 +++
 net/mac80211/cfg.c     | 38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/iface.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af0fc13cea34..0d405e36c213 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1715,6 +1715,7 @@ enum ieee80211_offload_flags {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
+ * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1746,6 +1747,8 @@ struct ieee80211_vif {
 	bool color_change_active;
 	u8 color_change_color;
 
+	struct ieee80211_vif *mbssid_tx_vif;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d69b31c20fe2..e2b791c37591 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,36 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
+					   struct cfg80211_mbssid_config params)
+{
+	struct ieee80211_sub_if_data *tx_sdata;
+
+	sdata->vif.mbssid_tx_vif = NULL;
+	sdata->vif.bss_conf.bssid_index = 0;
+	sdata->vif.bss_conf.nontransmitted = false;
+	sdata->vif.bss_conf.ema_ap = false;
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP || !params.tx_wdev)
+		return -EINVAL;
+
+	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params.tx_wdev);
+	if (!tx_sdata)
+		return -EINVAL;
+
+	if (tx_sdata == sdata) {
+		sdata->vif.mbssid_tx_vif = &sdata->vif;
+	} else {
+		sdata->vif.mbssid_tx_vif = &tx_sdata->vif;
+		sdata->vif.bss_conf.nontransmitted = true;
+		sdata->vif.bss_conf.bssid_index = params.index;
+	}
+	if (params.ema)
+		sdata->vif.bss_conf.ema_ap = true;
+
+	return 0;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -1105,6 +1135,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    params->mbssid_config.tx_wdev) {
+		err = ieee80211_set_ap_mbssid_options(sdata,
+						      params->mbssid_config);
+		if (err)
+			return err;
+	}
+
 	mutex_lock(&local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &params->chandef,
 					IEEE80211_CHANCTX_SHARED);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 62c95597704b..7c687434c5e9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -632,17 +632,44 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		ieee80211_add_virtual_monitor(local);
 }
 
+static void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *tx_sdata, *non_tx_sdata, *tmp_sdata;
+	struct ieee80211_vif *tx_vif = sdata->vif.mbssid_tx_vif;
+
+	tx_sdata = vif_to_sdata(tx_vif);
+	sdata->vif.mbssid_tx_vif = NULL;
+
+	list_for_each_entry_safe(non_tx_sdata, tmp_sdata,
+				 &tx_sdata->local->interfaces, list) {
+		if (non_tx_sdata != sdata && non_tx_sdata != tx_sdata &&
+		    non_tx_sdata->vif.mbssid_tx_vif == tx_vif &&
+		    ieee80211_sdata_running(non_tx_sdata)) {
+			non_tx_sdata->vif.mbssid_tx_vif = NULL;
+			dev_close(non_tx_sdata->wdev.netdev);
+		}
+	}
+
+	if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata)) {
+		tx_sdata->vif.mbssid_tx_vif = NULL;
+		dev_close(tx_sdata->wdev.netdev);
+	}
+}
+
 static int ieee80211_stop(struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
-	/* close all dependent VLAN interfaces before locking wiphy */
+	/* close dependent VLAN and MBSSID interfaces before locking wiphy */
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct ieee80211_sub_if_data *vlan, *tmpsdata;
 
 		list_for_each_entry_safe(vlan, tmpsdata, &sdata->u.ap.vlans,
 					 u.vlan.list)
 			dev_close(vlan->dev);
+
+		if (sdata->vif.mbssid_tx_vif)
+			ieee80211_stop_mbssid(sdata);
 	}
 
 	wiphy_lock(sdata->local->hw.wiphy);
-- 
2.31.1

