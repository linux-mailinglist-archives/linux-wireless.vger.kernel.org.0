Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA997E990C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjKMJfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKMJfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:35:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A710D0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868148; x=1731404148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZVTSkDZCckfqyq3NRnQcS4JtXQn/kS85t/7rlZPLSHo=;
  b=BIvvC0kbWUAkH4z6ctIlkwLYXnBOwielbUm7AvtwvQC6/mtyak6Icg67
   s1QuFBu+M8H4PujVOOKHjUgf7cwIEcoZbWp1ynXh1TVr2TrLiVBFmng/p
   zreRQEpnMUt5NpPOQZPSIRY+zC1QQM1vHKuzOSlq8gTIfuGpxinwxiqe5
   pFXFLjPX8xm/Ts9bgI5RxqV1O5xk5Zm6X4qiMZzXlR85mWaoWzsK96YdD
   jvxN5Vmfxvxv8yfj7B9mecf9wfPV0dIm1LkSG7rCcvGpEAnq32hnSwvyN
   VCIjtSj+lfk5f/Ko3DnlDrSX4TCTxrqZEuUQssi2UsyPQ6jKzB2vmfnLs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735701"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695224"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695224"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:46 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/6] wifi: cfg80211: Extend support for scanning while MLO connected
Date:   Mon, 13 Nov 2023 11:35:00 +0200
Message-Id: <20231113112844.d4490bcdefb1.I8fcd158b810adddef4963727e9153096416b30ce@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

To extend the support of TSF accounting in scan results for MLO
connections, allow to indicate in the scan request the link ID
corresponding to the BSS whose TSF should be used for the TSF
accounting.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 8 +++++---
 net/wireless/nl80211.c       | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..d36ad4cedf3b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2608,6 +2608,8 @@ struct cfg80211_scan_6ghz_params {
  * @n_6ghz_params: number of 6 GHz params
  * @scan_6ghz_params: 6 GHz params
  * @bssid: BSSID to scan for (most commonly, the wildcard BSSID)
+ * @tsf_report_link_id: for MLO, indicates the link ID of the BSS that should be
+ *      used for TSF reporting. Can be set to -1 to indicate no preference.
  */
 struct cfg80211_scan_request {
 	struct cfg80211_ssid *ssids;
@@ -2636,6 +2638,7 @@ struct cfg80211_scan_request {
 	bool scan_6ghz;
 	u32 n_6ghz_params;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
+	s8 tsf_report_link_id;
 
 	/* keep last */
 	struct ieee80211_channel *channels[] __counted_by(n_channels);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dced2c49daec..03e44823355e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6241,9 +6241,11 @@ enum nl80211_feature_flags {
  *	the BSS that the interface that requested the scan is connected to
  *	(if available).
  * @NL80211_EXT_FEATURE_BSS_PARENT_TSF: Per BSS, this driver reports the
- *	time the last beacon/probe was received. The time is the TSF of the
- *	BSS that the interface that requested the scan is connected to
- *	(if available).
+ *	time the last beacon/probe was received. For a non MLO connection, the
+ *	time is the TSF of the BSS that the interface that requested the scan is
+ *	connected to (if available). For an MLO connection, the time is the TSF
+ *	of the BSS corresponding with link ID specified in the scan request (if
+ *	specified).
  * @NL80211_EXT_FEATURE_SET_SCAN_DWELL: This driver supports configuration of
  *	channel dwell time.
  * @NL80211_EXT_FEATURE_BEACON_RATE_LEGACY: Driver supports beacon rate
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..12b7bd92bb86 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9337,6 +9337,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	else
 		eth_broadcast_addr(request->bssid);
 
+	request->tsf_report_link_id = nl80211_link_id_or_invalid(info->attrs);
 	request->wdev = wdev;
 	request->wiphy = &rdev->wiphy;
 	request->scan_start = jiffies;
-- 
2.38.1

