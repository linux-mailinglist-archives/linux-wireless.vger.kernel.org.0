Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50D573351
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiGMJqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiGMJpW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B0EF9E9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sex6R5v5An+FvkfBrudHiIDpEU4syYwtN6xPstQjY4g=;
        t=1657705520; x=1658915120; b=bLrk4oUnUL11sYsQSKuEdeHYlX0U9iGbTnpOzjEDQuWGwty
        aGNDlZ09cH9kiS/QFfD2kqDGR+EkKPu2SREETuQLjEEgA/EPVOnWsqQwesXFPqGVGallJ/aMwhiD9
        j+QKQxAnlYHMUXqxB2wZZxa0NhAQv2yj4jNu5Hfvwidpoxr0QTISq8St3NKqCRjjR8OlU6/QdZ5Lz
        tdCfEkofB9b1/zWtse3cL/IbLiO4ozDN8Wwn77baGcVX8E04MIEZzuF8oeg8zozzeUdsoWjJwFhEv
        FJeM6Ohu5rOWKeDK3C3ZGiXordIqVhKwY9AMziVTvmMXZuowU6VGLs4Oo8dTDb0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvk-00EgvB-LF;
        Wed, 13 Jul 2022 11:45:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 39/76] wifi: cfg80211: prepare association failure APIs for MLO
Date:   Wed, 13 Jul 2022 11:44:25 +0200
Message-Id: <20220713114425.dbbc36d117b1.I000eded67ec6213868aae26dfa1a37ca8d93c4b6@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For MLO, we need the ability to report back multiple BSS
structures to release, as well as the AP MLD address (if
attempting to make an MLO connection).

Unify cfg80211_assoc_timeout() and cfg80211_abandon_assoc()
into a new cfg80211_assoc_failure() that gets a structure
parameter with the necessary data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 29 +++++++++++++++++------------
 net/mac80211/mlme.c    | 28 +++++++++++++++++++++++-----
 net/wireless/mlme.c    | 36 +++++++++++++++++++-----------------
 net/wireless/trace.h   | 19 ++++++++++++++++---
 4 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cc20f0036e75..2a70f8900a4f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6900,24 +6900,29 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 			    const u8 *req_ies, size_t req_ies_len);
 
 /**
- * cfg80211_assoc_timeout - notification of timed out association
- * @dev: network device
- * @bss: The BSS entry with which association timed out.
- *
- * This function may sleep. The caller must hold the corresponding wdev's mutex.
- */
-void cfg80211_assoc_timeout(struct net_device *dev, struct cfg80211_bss *bss);
+ * struct cfg80211_assoc_failure - association failure data
+ * @ap_mld_addr: AP MLD address, or %NULL
+ * @bss: list of BSSes, must use entry 0 for non-MLO connections
+ *	(@ap_mld_addr is %NULL)
+ * @timeout: indicates the association failed due to timeout, otherwise
+ *	the association was abandoned for a reason reported through some
+ *	other API (e.g. deauth RX)
+ */
+struct cfg80211_assoc_failure {
+	const u8 *ap_mld_addr;
+	struct cfg80211_bss *bss[IEEE80211_MLD_MAX_NUM_LINKS];
+	bool timeout;
+};
 
 /**
- * cfg80211_abandon_assoc - notify cfg80211 of abandoned association attempt
+ * cfg80211_assoc_failure - notification of association failure
  * @dev: network device
- * @bss: The BSS entry with which association was abandoned.
+ * @data: data describing the association failure
  *
- * Call this whenever - for reasons reported through other API, like deauth RX,
- * an association attempt was abandoned.
  * This function may sleep. The caller must hold the corresponding wdev's mutex.
  */
-void cfg80211_abandon_assoc(struct net_device *dev, struct cfg80211_bss *bss);
+void cfg80211_assoc_failure(struct net_device *dev,
+			    struct cfg80211_assoc_failure *data);
 
 /**
  * cfg80211_tx_mlme_mgmt - notification of transmitted deauth/disassoc frame
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0c432e3abd90..8d339d3f89ab 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3026,8 +3026,13 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
 
-		if (abandon)
-			cfg80211_abandon_assoc(sdata->dev, assoc_data->bss);
+		if (abandon) {
+			struct cfg80211_assoc_failure data = {
+				.bss[0] = assoc_data->bss,
+			};
+
+			cfg80211_assoc_failure(sdata->dev, &data);
+		}
 	}
 
 	kfree(assoc_data);
@@ -3955,8 +3960,12 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	} else {
 		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, elems)) {
 			/* oops -- internal error -- send timeout for now */
+			struct cfg80211_assoc_failure data = {
+				.timeout = true,
+				.bss[0] = cbss,
+			};
 			ieee80211_destroy_assoc_data(sdata, false, false);
-			cfg80211_assoc_timeout(sdata->dev, cbss);
+			cfg80211_assoc_failure(sdata->dev, &data);
 			goto notify_driver;
 		}
 		event.u.mlme.status = MLME_SUCCESS;
@@ -4832,9 +4841,13 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 				.u.mlme.data = ASSOC_EVENT,
 				.u.mlme.status = MLME_TIMEOUT,
 			};
+			struct cfg80211_assoc_failure data = {
+				.bss[0] = bss,
+				.timeout = true,
+			};
 
 			ieee80211_destroy_assoc_data(sdata, false, false);
-			cfg80211_assoc_timeout(sdata->dev, bss);
+			cfg80211_assoc_failure(sdata->dev, &data);
 			drv_event_callback(sdata->local, sdata, &event);
 		}
 	} else if (ifmgd->assoc_data && ifmgd->assoc_data->timeout_started)
@@ -6467,8 +6480,13 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	sdata_lock(sdata);
 	if (ifmgd->assoc_data) {
 		struct cfg80211_bss *bss = ifmgd->assoc_data->bss;
+		struct cfg80211_assoc_failure data = {
+			.bss[0] = bss,
+			.timeout = true,
+		};
+
 		ieee80211_destroy_assoc_data(sdata, false, false);
-		cfg80211_assoc_timeout(sdata->dev, bss);
+		cfg80211_assoc_failure(sdata->dev, &data);
 	}
 	if (ifmgd->auth_data)
 		ieee80211_destroy_auth_data(sdata, false);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4a35b3559daa..aefe8b26f0d7 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -154,33 +154,35 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr)
 }
 EXPORT_SYMBOL(cfg80211_auth_timeout);
 
-void cfg80211_assoc_timeout(struct net_device *dev, struct cfg80211_bss *bss)
+void cfg80211_assoc_failure(struct net_device *dev,
+			    struct cfg80211_assoc_failure *data)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	const u8 *addr = data->ap_mld_addr ?: data->bss[0]->bssid;
+	int i;
 
-	trace_cfg80211_send_assoc_timeout(dev, bss->bssid);
-
-	nl80211_send_assoc_timeout(rdev, dev, bss->bssid, GFP_KERNEL);
-	cfg80211_sme_assoc_timeout(wdev);
+	trace_cfg80211_send_assoc_failure(dev, data);
 
-	cfg80211_unhold_bss(bss_from_pub(bss));
-	cfg80211_put_bss(wiphy, bss);
-}
-EXPORT_SYMBOL(cfg80211_assoc_timeout);
+	if (data->timeout) {
+		nl80211_send_assoc_timeout(rdev, dev, addr, GFP_KERNEL);
+		cfg80211_sme_assoc_timeout(wdev);
+	} else {
+		cfg80211_sme_abandon_assoc(wdev);
+	}
 
-void cfg80211_abandon_assoc(struct net_device *dev, struct cfg80211_bss *bss)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct wiphy *wiphy = wdev->wiphy;
+	for (i = 0; i < ARRAY_SIZE(data->bss); i++) {
+		struct cfg80211_bss *bss = data->bss[i];
 
-	cfg80211_sme_abandon_assoc(wdev);
+		if (!bss)
+			continue;
 
-	cfg80211_unhold_bss(bss_from_pub(bss));
-	cfg80211_put_bss(wiphy, bss);
+		cfg80211_unhold_bss(bss_from_pub(bss));
+		cfg80211_put_bss(wiphy, bss);
+	}
 }
-EXPORT_SYMBOL(cfg80211_abandon_assoc);
+EXPORT_SYMBOL(cfg80211_assoc_failure);
 
 void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len,
 			   bool reconnect)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4316d3dc31ea..19efb9539533 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2969,9 +2969,22 @@ DEFINE_EVENT(netdev_mac_evt, cfg80211_send_auth_timeout,
 	TP_ARGS(netdev, mac)
 );
 
-DEFINE_EVENT(netdev_mac_evt, cfg80211_send_assoc_timeout,
-	TP_PROTO(struct net_device *netdev, const u8 *mac),
-	TP_ARGS(netdev, mac)
+TRACE_EVENT(cfg80211_send_assoc_failure,
+	TP_PROTO(struct net_device *netdev,
+		 struct cfg80211_assoc_failure *data),
+	TP_ARGS(netdev, data),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+		MAC_ENTRY(ap_addr)
+		__field(bool, timeout)
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(ap_addr, data->ap_mld_addr ?: data->bss[0]->bssid);
+		__entry->timeout = data->timeout;
+	),
+	TP_printk(NETDEV_PR_FMT ", mac: " MAC_PR_FMT ", timeout: %d",
+		  NETDEV_PR_ARG, MAC_PR_ARG(ap_addr), __entry->timeout)
 );
 
 TRACE_EVENT(cfg80211_michael_mic_failure,
-- 
2.36.1

