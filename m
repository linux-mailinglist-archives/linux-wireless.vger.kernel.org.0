Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1457334D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiGMJqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A43F6820
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ofkHbRelfdJaq1ilWlPEeEwhG8soVA5RXKo3xYSMCDI=;
        t=1657705520; x=1658915120; b=XvXDoeUIZC1TUXpU2/RdVEHKfxTzYrdsDg+irI2MX4n6LIe
        MtDmmWaf6pgODBlF2dFIuf5oIIwDhaFKhTJEG4gAJvUpQGxKdpaxSZimn4geOSluYuECjca7yY7X2
        ygUebBLHknqiq9oLpD+FS/n4odRzWwQGU9asptjqGt8uTzxacTnOKO4ggzv5njAZCEmXHUtnO9SjA
        eBh/+Bb5FGeQcHGobNTPsFof/qNakICpBx9R2lQLJdfTA/iUAFoR5LHaC6RhdC8tDNBxsOJ/ahnXn
        Z8Swpor6RKH1iPyLbX66GjN5FpxdmrWirM4EiI9wE7AU1ukiqr//eVbRrAf0rxBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvl-00EgvB-Fu;
        Wed, 13 Jul 2022 11:45:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 42/76] wifi: cfg80211: put cfg80211_rx_assoc_resp() arguments into a struct
Date:   Wed, 13 Jul 2022 11:44:28 +0200
Message-Id: <20220713114425.c6aee74f6253.I881c3042b647c3f2709706110eadfd16cd00787c@changeid>
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

For MLO we'll need a lot more arguments, including all the
BSS pointers and link addresses, so move the data to a struct
to be able to extend it more easily later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 24 +++++++++++++++++-------
 net/mac80211/mlme.c    | 17 ++++++++++++-----
 net/wireless/mlme.c    | 32 +++++++++++++++-----------------
 net/wireless/nl80211.c | 12 ++++++------
 net/wireless/nl80211.h |  4 +---
 5 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e24233b6d4bb..1a0bdff1569c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6877,16 +6877,29 @@ void cfg80211_rx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len);
 void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
 
 /**
- * cfg80211_rx_assoc_resp - notification of processed association response
- * @dev: network device
+ * struct cfg80211_rx_assoc_resp - association response data
  * @bss: the BSS that association was requested with, ownership of the pointer
- *	moves to cfg80211 in this call
+ *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
  * @buf: (Re)Association Response frame (header + body)
  * @len: length of the frame data
  * @uapsd_queues: bitmap of queues configured for uapsd. Same format
  *	as the AC bitmap in the QoS info field
  * @req_ies: information elements from the (Re)Association Request frame
  * @req_ies_len: length of req_ies data
+ */
+struct cfg80211_rx_assoc_resp {
+	struct cfg80211_bss *bss;
+	const u8 *buf;
+	size_t len;
+	const u8 *req_ies;
+	size_t req_ies_len;
+	int uapsd_queues;
+};
+
+/**
+ * cfg80211_rx_assoc_resp - notification of processed association response
+ * @dev: network device
+ * @data: association response data, &struct cfg80211_rx_assoc_resp
  *
  * After being asked to associate via cfg80211_ops::assoc() the driver must
  * call either this function or cfg80211_auth_timeout().
@@ -6894,10 +6907,7 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  * This function may sleep. The caller must hold the corresponding wdev's mutex.
  */
 void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_bss *bss,
-			    const u8 *buf, size_t len,
-			    int uapsd_queues,
-			    const u8 *req_ies, size_t req_ies_len);
+			    struct cfg80211_rx_assoc_resp *data);
 
 /**
  * struct cfg80211_assoc_failure - association failure data
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index feb5929b37e7..a47836730493 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3877,7 +3877,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	u16 capab_info, status_code, aid;
 	struct ieee802_11_elems *elems;
-	int ac, uapsd_queues = -1;
+	int ac;
 	u8 *pos;
 	bool reassoc;
 	struct cfg80211_bss *cbss;
@@ -3886,6 +3886,9 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.u.mlme.data = ASSOC_EVENT,
 	};
 	struct ieee80211_prep_tx_info info = {};
+	struct cfg80211_rx_assoc_resp resp = {
+		.uapsd_queues = -1,
+	};
 
 	sdata_assert_lock(sdata);
 
@@ -3983,16 +3986,20 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		ieee80211_destroy_assoc_data(sdata, ASSOC_SUCCESS);
 
 		/* get uapsd queues configuration */
-		uapsd_queues = 0;
+		resp.uapsd_queues = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 			if (sdata->deflink.tx_conf[ac].uapsd)
-				uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
+				resp.uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
 
 		info.success = 1;
 	}
 
-	cfg80211_rx_assoc_resp(sdata->dev, cbss, (u8 *)mgmt, len, uapsd_queues,
-			       ifmgd->assoc_req_ies, ifmgd->assoc_req_ies_len);
+	resp.bss = cbss;
+	resp.buf = (u8 *)mgmt;
+	resp.len = len;
+	resp.req_ies = ifmgd->assoc_req_ies;
+	resp.req_ies_len = ifmgd->assoc_req_ies_len;
+	cfg80211_rx_assoc_resp(sdata->dev, &resp);
 notify_driver:
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
 	kfree(elems);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index aefe8b26f0d7..a6ad696f131b 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -21,36 +21,35 @@
 #include "rdev-ops.h"
 
 
-void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
-			    const u8 *buf, size_t len, int uapsd_queues,
-			    const u8 *req_ies, size_t req_ies_len)
+void cfg80211_rx_assoc_resp(struct net_device *dev,
+			    struct cfg80211_rx_assoc_resp *data)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)data->buf;
 	struct cfg80211_connect_resp_params cr;
 	const u8 *resp_ie = mgmt->u.assoc_resp.variable;
-	size_t resp_ie_len = len - offsetof(struct ieee80211_mgmt,
-					    u.assoc_resp.variable);
+	size_t resp_ie_len = data->len - offsetof(struct ieee80211_mgmt,
+						  u.assoc_resp.variable);
 
-	if (bss->channel->band == NL80211_BAND_S1GHZ) {
+	if (data->bss->channel->band == NL80211_BAND_S1GHZ) {
 		resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
-		resp_ie_len = len - offsetof(struct ieee80211_mgmt,
-					     u.s1g_assoc_resp.variable);
+		resp_ie_len = data->len - offsetof(struct ieee80211_mgmt,
+						   u.s1g_assoc_resp.variable);
 	}
 
 	memset(&cr, 0, sizeof(cr));
 	cr.status = (int)le16_to_cpu(mgmt->u.assoc_resp.status_code);
 	cr.links[0].bssid = mgmt->bssid;
-	cr.links[0].bss = bss;
-	cr.req_ie = req_ies;
-	cr.req_ie_len = req_ies_len;
+	cr.links[0].bss = data->bss;
+	cr.req_ie = data->req_ies;
+	cr.req_ie_len = data->req_ies_len;
 	cr.resp_ie = resp_ie;
 	cr.resp_ie_len = resp_ie_len;
 	cr.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED;
 
-	trace_cfg80211_send_rx_assoc(dev, bss);
+	trace_cfg80211_send_rx_assoc(dev, data->bss);
 
 	/*
 	 * This is a bit of a hack, we don't notify userspace of
@@ -59,13 +58,12 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 	 * frame instead of reassoc.
 	 */
 	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status)) {
-		cfg80211_unhold_bss(bss_from_pub(bss));
-		cfg80211_put_bss(wiphy, bss);
+		cfg80211_unhold_bss(bss_from_pub(data->bss));
+		cfg80211_put_bss(wiphy, data->bss);
 		return;
 	}
 
-	nl80211_send_rx_assoc(rdev, dev, buf, len, GFP_KERNEL, uapsd_queues,
-			      req_ies, req_ies_len);
+	nl80211_send_rx_assoc(rdev, dev, data);
 	/* update current_bss etc., consumes the bss reference */
 	__cfg80211_connect_result(dev, &cr, cr.status == WLAN_STATUS_SUCCESS);
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6c3b47a7960f..11cad2d46d0e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17432,13 +17432,13 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 }
 
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
-			   struct net_device *netdev, const u8 *buf,
-			   size_t len, gfp_t gfp, int uapsd_queues,
-			   const u8 *req_ies, size_t req_ies_len)
+			   struct net_device *netdev,
+			   struct cfg80211_rx_assoc_resp *data)
 {
-	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_ASSOCIATE, gfp, uapsd_queues,
-				req_ies, req_ies_len, false);
+	nl80211_send_mlme_event(rdev, netdev, data->buf, data->len,
+				NL80211_CMD_ASSOCIATE, GFP_KERNEL,
+				data->uapsd_queues,
+				data->req_ies, data->req_ies_len, false);
 }
 
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index d642e3be4ee7..a7e8e0917c1c 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -60,9 +60,7 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 			  const u8 *buf, size_t len, gfp_t gfp);
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   const u8 *buf, size_t len, gfp_t gfp,
-			   int uapsd_queues,
-			   const u8 *req_ies, size_t req_ies_len);
+			   struct cfg80211_rx_assoc_resp *data);
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 const u8 *buf, size_t len,
-- 
2.36.1

