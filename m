Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810236B9A5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhDZTGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:06:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:13419 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhDZTGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:06:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463952; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QPqcADw635hcdQyOQNqmZC+V4GOyaA0yK1j/7Ko4pzg=; b=LjJCElNnedz9MMAqsKuv8uiFhyrCh1yNXRuT66KM/46X+hCumna43l9Dyz9Bjryc7ehpX9Kr
 m/gnYQEEax1vYNiAKzNmddMWcq/jadVakmu7OoGgYWIoAawEAtqPCor+s9FomUibI292eJk5
 YQtTNLodQGzKZ+zIUzmJzpYUKv4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60870f09febcffa80f073eec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 19:05:45
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8448AC43143; Mon, 26 Apr 2021 19:05:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC396C4338A;
        Mon, 26 Apr 2021 19:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC396C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v10 2/4] mac80211: multiple bssid support in interface handling
Date:   Mon, 26 Apr 2021 12:05:32 -0700
Message-Id: <20210426190534.12667-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426190534.12667-1-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This change adds a new helper function ieee80211_set_mbssid_options()
to set multiple BSSID and enhanced multi-BSSID advertisement (EMA)
configuration in mac80211.

New flags are set per interface to indicate transmitting/non-transmitting
and EMA enabled/disabled configurations. Value 0 indicates that the AP does
not support multiple BSSID advertisements.

For non-transmitting profiles, a parent pointer points to the transmitting
interface from the global list of interfaces per wiphy.

When ieee80211_do_stop() is called for a non-transmitting interface,
it first brings down the transmitting interface.

When ieee80211_del_iface() is called for the transmitting interface,
it first brings down all the non-transmitting interfaces.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v10: Released wiphy->mtx before dev_close().
     New flag for IEEE80211_HW_SUPPORTS_EMA_AP.
     ieee80211_set_mbssid_options() returns int instead of void.
     
     
 include/net/mac80211.h | 34 ++++++++++++++++++-
 net/mac80211/cfg.c     | 74 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c |  2 ++
 net/mac80211/iface.c   | 12 +++++++
 4 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..ca83bfe14355 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @mbssid: Multiple bssid settings for AP mode
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +701,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	struct cfg80211_mbssid_config mbssid;
 };
 
 /**
@@ -1663,6 +1665,20 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
+/**
+ * enum ieee80211_vif_mbssid_flags - virtual interface multiple bssid flags
+ *
+ * @IEEE80211_VIF_MBSSID_TX: Set for the transmitting profile.
+ * @IEEE80211_VIF_MBSSID_NON_TX: Set for non-transmitting profiles.
+ * @IEEE80211_VIF_MBSSID_EMA: Set when enhanced multi-BSS advertisements
+ *	are enabled.
+ */
+enum ieee80211_vif_mbssid_flags {
+	IEEE80211_VIF_MBSSID_TX     = BIT(1),
+	IEEE80211_VIF_MBSSID_NON_TX = BIT(2),
+	IEEE80211_VIF_MBSSID_EMA    = BIT(3),
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1709,6 +1725,10 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
+ *
+ * @mbssid: Multiple BSSID configurations.
+ * @mbssid.parent: Interface index of the transmitted BSS.
+ * @mbssid.flags: multiple bssid flags, see enum ieee80211_vif_mbssid_flags.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1737,6 +1757,11 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
+	struct {
+		struct ieee80211_vif *parent;
+		u32 flags;
+	} mbssid;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -2381,7 +2406,7 @@ struct ieee80211_txq {
  * @IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN: Driver does not report accurate A-MPDU
  *	length in tx status information
  *
- * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID in STA mode
  *
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
@@ -2402,6 +2427,11 @@ struct ieee80211_txq {
  *	usage and 802.11 frames with %RX_FLAG_ONLY_MONITOR set for monitor to
  *	the stack.
  *
+ * @IEEE80211_HW_SUPPORTS_MBSSID_AP: Hardware supports multiple BSSID
+ *	advertisements in AP mode.
+ * @IEEE80211_HW_SUPPORTS_EMA_AP: Hardware supports enhanced multiple BSSID
+ *	advertisements in AP mode.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2457,6 +2487,8 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
+	IEEE80211_HW_SUPPORTS_MBSSID_AP,
+	IEEE80211_HW_SUPPORTS_EMA_AP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7a99892e5aba..d1a965897b9d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,44 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_mbssid_options(struct ieee80211_sub_if_data *sdata,
+					struct cfg80211_mbssid_config params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct net_device *parent;
+	struct ieee80211_sub_if_data *psdata;
+
+	if (!params.count || sdata->vif.type != NL80211_IFTYPE_AP ||
+	    !ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP))
+		return -EINVAL;
+
+	sdata->vif.mbssid.parent = NULL;
+	sdata->vif.mbssid.flags = IEEE80211_VIF_MBSSID_TX;
+	if (params.parent) {
+		parent = __dev_get_by_index(wiphy_net(wiphy), params.parent);
+		if (!parent || !parent->ieee80211_ptr)
+			return -EINVAL;
+
+		psdata = IEEE80211_WDEV_TO_SUB_IF(parent->ieee80211_ptr);
+		if (psdata != sdata) {
+			if (psdata->vif.mbssid.parent)
+				return -EINVAL;
+			sdata->vif.mbssid.parent = &psdata->vif;
+			sdata->vif.mbssid.flags = IEEE80211_VIF_MBSSID_NON_TX;
+		}
+	}
+
+	if (params.ema) {
+		if (!ieee80211_hw_check(&local->hw, SUPPORTS_EMA_AP))
+			return -EINVAL;
+		sdata->vif.mbssid.flags |= IEEE80211_VIF_MBSSID_EMA;
+	}
+
+	sdata->vif.bss_conf.mbssid = params;
+	return 0;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -141,6 +179,36 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 
 static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	struct ieee80211_local *local;
+	struct ieee80211_vif *vif;
+
+	if (!sdata)
+		return 0;
+
+	local = sdata->local;
+	vif = &sdata->vif;
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP)) {
+		if (vif->mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
+			struct ieee80211_sub_if_data *child, *tmpsdata;
+
+			wiphy_unlock(local->hw.wiphy);
+			mutex_lock(&local->iflist_mtx);
+			list_for_each_entry_safe(child, tmpsdata,
+						 &local->interfaces, list) {
+				if (child->vif.mbssid.parent == vif &&
+				    ieee80211_sdata_running(child))
+					dev_close(child->wdev.netdev);
+			}
+			mutex_unlock(&local->iflist_mtx);
+			wiphy_lock(local->hw.wiphy);
+		} else {
+			vif->mbssid.parent = NULL;
+			vif->mbssid.flags = 0;
+		}
+	}
+
 	ieee80211_if_remove(IEEE80211_WDEV_TO_SUB_IF(wdev));
 
 	return 0;
@@ -1078,6 +1146,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (params->mbssid.count) {
+		err = ieee80211_set_mbssid_options(sdata, params->mbssid);
+		if (err)
+			return err;
+	}
+
 	mutex_lock(&local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &params->chandef,
 					IEEE80211_CHANCTX_SHARED);
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 9245c0421bda..00e5089a4a6c 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -457,6 +457,8 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
 	FLAG(SUPPORTS_RX_DECAP_OFFLOAD),
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
+	FLAG(SUPPORTS_MBSSID_AP),
+	FLAG(SUPPORTS_EMA_AP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b1c170939e44..1ab75d464569 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -375,6 +375,18 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	struct cfg80211_chan_def chandef;
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
+	struct ieee80211_sub_if_data *parent;
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP) &&
+	    sdata->vif.mbssid.flags & IEEE80211_VIF_MBSSID_NON_TX) {
+		parent = vif_to_sdata(sdata->vif.mbssid.parent);
+		if (parent && ieee80211_sdata_running(parent)) {
+			wiphy_unlock(local->hw.wiphy);
+			dev_close(parent->wdev.netdev);
+			wiphy_lock(local->hw.wiphy);
+		}
+	}
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-- 
2.31.1

