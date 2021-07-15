Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C943C9962
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhGOHLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 03:11:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbhGOHLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 03:11:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626332893; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=iOvkqZOsCACP/AufEuJqGgSGCgxjc+AnG7ZAf50uwwo=; b=nHGZ/JwTcSENHu749SEbf9g4QQz0lW7FfhpCH7rR/47YILb8JRb25rjPhva4JCFXhT4UXi6H
 E9j1pdyrA51o8+FHMOz0qN/EPuZgnm7GCN0AzrwzgaJdTEfIMTb4hTs68Fgjp//H4O1CBdjN
 ncWLy2ISNhbZl1TJt9Jw0aoZaYc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60efdecb290ea35ee60630be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Jul 2021 07:07:55
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFEF2C4338A; Thu, 15 Jul 2021 07:07:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EE44C433F1;
        Thu, 15 Jul 2021 07:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EE44C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH v11 2/4] mac80211: MBSSID support in interface handling
Date:   Thu, 15 Jul 2021 00:07:43 -0700
Message-Id: <20210715070745.5033-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715070745.5033-1-alokad@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
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
v11: Moved dev_close() for non-transmitting interfaces
     before locking wiphy->mtx.
     Removed interface count, instead mac80211 passes pointer
     'mbssid_tx_vif' to the driver for each interface.
     Removed dev_close() calls from ieee80211_del_iface().
     Removed IEEE80211_HW_SUPPORTS_MBSSID_AP and
     IEEE80211_HW_SUPPORTS_EMA_AP.
     Instead of new parameters in struct ieee80211_bss_conf,
     reused the existing ones which were used for STA mode.
     
v10: Released wiphy->mtx before dev_close().
     New flag for IEEE80211_HW_SUPPORTS_EMA_AP.
     ieee80211_set_mbssid_options() returns int instead of void.
     
 include/net/mac80211.h |  4 ++++
 net/mac80211/cfg.c     | 38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/iface.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d8a1d09a2141..a375b0c31062 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1711,6 +1711,8 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
+ *
+ * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1739,6 +1741,8 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
+	struct ieee80211_vif *mbssid_tx_vif;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 84cc7733ea66..152cfa6bcf3a 100644
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
+	if (sdata->vif.type != NL80211_IFTYPE_AP || !params.tx_dev)
+		return -EINVAL;
+
+	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params.tx_dev);
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
@@ -1078,6 +1108,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    params->mbssid_config.tx_dev) {
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
index 1e5e9fc45523..7939827621ad 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -630,17 +630,44 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
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

