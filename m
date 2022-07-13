Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7487573354
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiGMJqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9BF6826
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=juJwWG8lFFbPo4Sh68ofoGEUelchpRYCkzcP3V/Eko4=;
        t=1657705520; x=1658915120; b=OLJUTkkDp5k85IjhsxzUtGP0YSO83UEqNbaOOFxnov58RoQ
        o71l9L29YqwrrbkLCsas+p6L3qokFpNJ4JkRegJxAas208fZkqoDWgcIBepZdOoOvbHrVHwCKtqGF
        B6Sv/ho1GomV+ydEhboIetm68o9ZNoDi4i40yKLKDOepeC/iMM/fbiJzujz7Jc6vTei8oy58OhXGR
        ZkNPvNfiq95Q77H4NsAArnt8nCXBFskHTNdw69P5O/W8JmRnHNdRxihlzaa1WUSEfOvOXqDMJ+q8y
        NCWVlbaKUVOVoSAmt9aYwFkSszXoQCUVuBcQf7YQb873ij23p5a1rFcuwbOF0y7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvl-00EgvB-8b;
        Wed, 13 Jul 2022 11:45:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 41/76] wifi: cfg80211: adjust assoc comeback for MLO
Date:   Wed, 13 Jul 2022 11:44:27 +0200
Message-Id: <20220713114425.137431011758.Ie74dbd117976d94f5030dba0e2e704ad952c7e40@changeid>
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

We only report the BSSID to userspace, so change the
argument from BSS struct pointer to AP address, which
we'll use to carry either the BSSID or AP MLD address.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  4 ++--
 net/mac80211/mlme.c    |  2 +-
 net/wireless/nl80211.c |  6 +++---
 net/wireless/trace.h   | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2a70f8900a4f..e24233b6d4bb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8592,13 +8592,13 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
  * cfg80211_assoc_comeback - notification of association that was
  * temporarly rejected with a comeback
  * @netdev: network device
- * @bss: the bss entry with which association is in progress.
+ * @ap_addr: AP (MLD) address that rejected the assocation
  * @timeout: timeout interval value TUs.
  *
  * this function may sleep. the caller must hold the corresponding wdev's mutex.
  */
 void cfg80211_assoc_comeback(struct net_device *netdev,
-			     struct cfg80211_bss *bss, u32 timeout);
+			     const u8 *ap_addr, u32 timeout);
 
 /* Logging, debugging and troubleshooting/diagnostic helpers. */
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 772584732b6e..feb5929b37e7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3943,7 +3943,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	    elems->timeout_int->type == WLAN_TIMEOUT_ASSOC_COMEBACK) {
 		u32 tu, ms;
 
-		cfg80211_assoc_comeback(sdata->dev, assoc_data->bss,
+		cfg80211_assoc_comeback(sdata->dev, assoc_data->bss->bssid,
 					le32_to_cpu(elems->timeout_int->value));
 
 		tu = le32_to_cpu(elems->timeout_int->value);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 886d964242ae..6c3b47a7960f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18036,7 +18036,7 @@ static void nl80211_send_remain_on_chan_event(
 }
 
 void cfg80211_assoc_comeback(struct net_device *netdev,
-			     struct cfg80211_bss *bss, u32 timeout)
+			     const u8 *ap_addr, u32 timeout)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -18044,7 +18044,7 @@ void cfg80211_assoc_comeback(struct net_device *netdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_assoc_comeback(wdev, bss->bssid, timeout);
+	trace_cfg80211_assoc_comeback(wdev, ap_addr, timeout);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -18058,7 +18058,7 @@ void cfg80211_assoc_comeback(struct net_device *netdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bss->bssid) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, ap_addr) ||
 	    nla_put_u32(msg, NL80211_ATTR_TIMEOUT, timeout))
 		goto nla_put_failure;
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 19efb9539533..94d107cab72c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3764,20 +3764,20 @@ TRACE_EVENT(cfg80211_bss_color_notify,
 );
 
 TRACE_EVENT(cfg80211_assoc_comeback,
-	TP_PROTO(struct wireless_dev *wdev, const u8 *bssid, u32 timeout),
-	TP_ARGS(wdev, bssid, timeout),
+	TP_PROTO(struct wireless_dev *wdev, const u8 *ap_addr, u32 timeout),
+	TP_ARGS(wdev, ap_addr, timeout),
 	TP_STRUCT__entry(
 		WDEV_ENTRY
-		MAC_ENTRY(bssid)
+		MAC_ENTRY(ap_addr)
 		__field(u32, timeout)
 	),
 	TP_fast_assign(
 		WDEV_ASSIGN;
-		MAC_ASSIGN(bssid, bssid);
+		MAC_ASSIGN(ap_addr, ap_addr);
 		__entry->timeout = timeout;
 	),
 	TP_printk(WDEV_PR_FMT ", " MAC_PR_FMT ", timeout: %u TUs",
-		  WDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->timeout)
+		  WDEV_PR_ARG, MAC_PR_ARG(ap_addr), __entry->timeout)
 );
 
 DECLARE_EVENT_CLASS(link_station_add_mod,
-- 
2.36.1

