Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB12FB3D0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbhASIOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 03:14:20 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:20738 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbhASILo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 03:11:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611043873; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FfvnWcLcci7esXCzbeyqH605g8su50bRMAXFehtUC9k=; b=u+WH1r7rTaiRAcLW8gvxOrUzQRzdVyjfC51hDCbvkOQNQ4EqfWKUoePYQ1NTcdOmjZtbjMei
 TT1Zyu3Yz3YJ0o66dOcu7Pjsc8AtWvB9woKKvpB1QwsatU7/w7BBH/C8YQW63sAFAoHVjv4c
 2E/fuuUKaCnUyXLyykJTxHTqASU=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 600693fe1e3bf9b6690a62f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 08:10:38
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74170C43464; Tue, 19 Jan 2021 08:10:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 557D9C43461;
        Tue, 19 Jan 2021 08:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 557D9C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6 2/4] mac80211: add multiple bssid support to interface handling
Date:   Tue, 19 Jan 2021 00:10:25 -0800
Message-Id: <20210119081027.5133-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210119081027.5133-1-alokad@codeaurora.org>
References: <20210119081027.5133-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add a new helper ieee80211_set_multiple_bssid_options() takes propagating
the cfg80211 data down the stack.

The patch also makes sure that all members of the bss set will get closed
when either of them is shutdown.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v6: No changes from v5.

 include/net/mac80211.h | 30 +++++++++++++++++++++++-
 net/mac80211/cfg.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c |  1 +
 net/mac80211/iface.c   |  6 +++++
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d315740581f1..861156d7dfc3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @multiple_bssid: the multiple bssid settings of the AP.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +701,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	struct cfg80211_multiple_bssid multiple_bssid;
 };
 
 /**
@@ -1656,6 +1658,19 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_ENCAP_4ADDR		= BIT(1),
 };
 
+/**
+ * enum ieee80211_vif_multiple_bssid_flags - virtual interface multiple bssid flags
+ *
+ * @IEEE80211_VIF_MBSS_TRANSMITTING: this BSS is transmitting beacons
+ * @IEEE80211_VIF_MBSS_NON_TRANSMITTING: this BSS is not transmitting beacons
+ * @IEEE80211_VIF_MBSS_EMA_BEACON: beacons should be send out in EMA mode
+ */
+enum ieee80211_vif_multiple_bssid_flags {
+	IEEE80211_VIF_MBSS_TRANSMITTING         = BIT(1),
+	IEEE80211_VIF_MBSS_NON_TRANSMITTING     = BIT(2),
+	IEEE80211_VIF_MBSS_EMA_BEACON           = BIT(3),
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1702,6 +1717,11 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
+ *
+ * @multiple_bssid: Multiple BSSID configurations.
+ * @multiple_bssid.parent: Interface index of the transmitted BSS.
+ * @multiple_bssid.flags: multiple bssid flags, see
+ *	enum ieee80211_vif_multiple_bssid_flags.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1730,6 +1750,11 @@ struct ieee80211_vif {
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
+	struct {
+		struct ieee80211_vif *parent;
+		u32 flags;
+	} multiple_bssid;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -2377,7 +2402,7 @@ struct ieee80211_txq {
  * @IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN: Driver does not report accurate A-MPDU
  *	length in tx status information
  *
- * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID in STA mode
  *
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
@@ -2389,6 +2414,8 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD: Hardware supports tx encapsulation
  *	offload
  *
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP: Hardware supports multi BSSID in AP mode
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2442,6 +2469,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
+	IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c4c70e30ad7f..91e659a43f67 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,39 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static void ieee80211_set_multiple_bssid_options(struct ieee80211_sub_if_data *sdata,
+						 struct cfg80211_ap_settings *params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct net_device *parent;
+	struct ieee80211_sub_if_data *psdata;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_MULTI_BSSID_AP))
+		return;
+
+	if (!params->multiple_bssid.count)
+		return;
+
+	if (params->multiple_bssid.parent) {
+		parent = __dev_get_by_index(wiphy_net(wiphy),
+					    params->multiple_bssid.parent);
+		if (!parent || !parent->ieee80211_ptr)
+			return;
+		psdata = IEEE80211_WDEV_TO_SUB_IF(parent->ieee80211_ptr);
+		if (psdata->vif.multiple_bssid.parent)
+			return;
+		sdata->vif.multiple_bssid.parent = &psdata->vif;
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_NON_TRANSMITTING;
+	} else {
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_TRANSMITTING;
+	}
+
+	if (params->multiple_bssid.ema)
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_EMA_BEACON;
+	sdata->vif.bss_conf.multiple_bssid = params->multiple_bssid;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -141,6 +174,23 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 
 static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
+	struct ieee80211_sub_if_data *sdata;
+
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
+		if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+			struct ieee80211_sub_if_data *child;
+
+			rcu_read_lock();
+			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
+				if (child->vif.multiple_bssid.parent == &sdata->vif)
+					dev_close(child->wdev.netdev);
+			rcu_read_unlock();
+		} else {
+			sdata->vif.multiple_bssid.parent = NULL;
+		}
+	}
+
 	ieee80211_if_remove(IEEE80211_WDEV_TO_SUB_IF(wdev));
 
 	return 0;
@@ -1078,6 +1128,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_set_multiple_bssid_options(sdata, params);
+
 	mutex_lock(&local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &params->chandef,
 					IEEE80211_CHANCTX_SHARED);
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 48f144f107d5..f611a8caaf91 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -409,6 +409,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
+	FLAG(SUPPORTS_MULTI_BSSID_AP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3b9ec4ef81c3..1879605f4434 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -373,6 +373,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	/* make sure the parent is already down */
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    sdata->vif.multiple_bssid.parent &&
+	    ieee80211_sdata_running(vif_to_sdata(sdata->vif.multiple_bssid.parent)))
+		dev_close(vif_to_sdata(sdata->vif.multiple_bssid.parent)->wdev.netdev);
+
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
-- 
2.25.0

