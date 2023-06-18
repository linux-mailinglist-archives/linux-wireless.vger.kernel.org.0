Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1C7347BC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFRSuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFRSuV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CFC1B9
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114218; x=1718650218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AkDN9h5Mr4xZknSLF6DOl+cao0bGHnkKdns2iZ9N8I=;
  b=I+z93zmNn9EYaS3H7+Pnz7HHZSyfxyphNWXAQo523VE6/3y8c7nWtAA5
   43pjrbuUlPYprhRQB7x1a4LIUJ+WdXiPF+dJ2NMCacQ/QJNwwtENNO92D
   gbiIpUDfcz+XmG8Bb/5RC1szI2Um3pS61AcLFh1zPG0KMSflJveaIcOue
   JCV+tw3qohnaAv7Is6035PTgcfHhZ5FuxPC1EBJVjcy6P1YFKHYX0kcsl
   yiFcbxRfLiDBhRs/0yW3UwDYWxhwFpkImj4Zv2IY56NEtEq7yjBLNDYpz
   cOo/H+bDFPlHPlFAWsxcAx9XlZg8t0bQ71aPgnEy5gGv6jbvFlsfOJ/ZN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116624"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116624"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:18 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233839"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233839"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/20] wifi: cfg80211: Support changes in AP MLD link state change
Date:   Sun, 18 Jun 2023 21:49:43 +0300
Message-Id: <20230618214435.d562a43a623e.I9fd75221cb621dd8f0a6922a1674d54dbdb57895@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add support for the low level driver to indicate about the
removal of connection links that were removed by the AP MLD.

Propagate this information to user space so it could act
accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h       | 14 ++++++++++++
 include/uapi/linux/nl80211.h |  3 +++
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 16 ++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9972de114d73..9eba57d35e98 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8359,6 +8359,20 @@ void cfg80211_cqm_txe_notify(struct net_device *dev, const u8 *peer,
  */
 void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t gfp);
 
+/**
+ * cfg80211_cqm_links_state_change_notify - inform CQM of change in AP MLD
+ *	links
+ *
+ * @dev: network device
+ * @removed_links: bitmap of links on which connection was removed due to links
+ *	being removed by the AP MLD.
+ *
+ * Caller must acquire wdev_lock, therefore must only be called from sleepable
+ * driver context!
+ */
+void cfg80211_cqm_links_state_change_notify(struct net_device *dev,
+					    u16 removed_links);
+
 /**
  * __cfg80211_radar_event - radar detection event
  * @wiphy: the wiphy
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 03939bdb0e48..fece687054ef 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5350,6 +5350,8 @@ enum nl80211_ps_state {
  *	loss event
  * @NL80211_ATTR_CQM_RSSI_LEVEL: the RSSI value in dBm that triggered the
  *	RSSI threshold event.
+ * @NL80211_ATTR_CQM_REMOVED_LINKS: bitmap of links on which connection was
+ *	removed due to links being removed by the AP MLD.
  * @__NL80211_ATTR_CQM_AFTER_LAST: internal
  * @NL80211_ATTR_CQM_MAX: highest key attribute
  */
@@ -5364,6 +5366,7 @@ enum nl80211_attr_cqm {
 	NL80211_ATTR_CQM_TXE_INTVL,
 	NL80211_ATTR_CQM_BEACON_LOSS_EVENT,
 	NL80211_ATTR_CQM_RSSI_LEVEL,
+	NL80211_ATTR_CQM_REMOVED_LINKS,
 
 	/* keep last */
 	__NL80211_ATTR_CQM_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7b547aeb52f1..a85256a3e063 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19108,6 +19108,49 @@ void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t gfp)
 }
 EXPORT_SYMBOL(cfg80211_cqm_beacon_loss_notify);
 
+void cfg80211_cqm_links_state_change_notify(struct net_device *dev,
+					    u16 removed_links)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct sk_buff *msg;
+	unsigned long removed = removed_links;
+	u8 link_id;
+
+	ASSERT_WDEV_LOCK(wdev);
+
+	trace_cfg80211_cqm_links_state_change_notify(dev, removed_links);
+
+	if (!removed_links)
+		return;
+
+	WARN_ON((wdev->valid_links & removed_links) != removed_links);
+	wdev->valid_links &= ~removed_links;
+
+	for_each_set_bit(link_id, &removed, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (!wdev->links[link_id].client.current_bss)
+			continue;
+
+		cfg80211_unhold_bss(wdev->links[link_id].client.current_bss);
+		cfg80211_put_bss(wdev->wiphy,
+				 &wdev->links[link_id].client.current_bss->pub);
+		wdev->links[link_id].client.current_bss = NULL;
+	}
+
+	msg = cfg80211_prepare_cqm(dev, NULL, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	if (nla_put_u16(msg, NL80211_ATTR_CQM_REMOVED_LINKS, removed_links))
+		goto nla_put_failure;
+
+	cfg80211_send_cqm(msg, GFP_KERNEL);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_cqm_links_state_change_notify);
+
 static void nl80211_gtk_rekey_notify(struct cfg80211_registered_device *rdev,
 				     struct net_device *netdev, const u8 *bssid,
 				     const u8 *replay_ctr, gfp_t gfp)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index e63990b81249..facea3aba60f 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3966,6 +3966,22 @@ TRACE_EVENT(rdev_set_hw_timestamp,
 		  __entry->enable)
 );
 
+TRACE_EVENT(cfg80211_cqm_links_state_change_notify,
+	TP_PROTO(struct net_device *netdev,
+		 u16 removed_links),
+	TP_ARGS(netdev, removed_links),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+		__field(u16, removed_links)
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+		__entry->removed_links = removed_links;
+	),
+	TP_printk(NETDEV_PR_FMT ", removed_links=0x%x",
+		  NETDEV_PR_ARG, __entry->removed_links)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.38.1

