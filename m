Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82649789D21
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjH0LGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjH0LGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F51139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134363; x=1724670363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZMVvqZCXaug+NqfDkSMDZJRu/BuAavBf96OiWR5kXx4=;
  b=kF7Lwqi+YcuB9A9BkRip++hRcRmf79CqYh+Dj6soONOk+Y/k0fvPR8wv
   ziGmgp2kLAksfkG6IuypGF3bq1YCm8SpRgqzClhsHYIF/QFZDHncKgWCq
   /V/+YAhTBBmsTYvhH5bR3ljJOZk12vMzlsBMf5kcTmMfoQNFggMPogmPZ
   FJS7H2gJHTfbLzqLvObMfmZjN+oCh5T+nXO+7EjDJqjpq39/tma4gb+Q4
   pwPLHK/TiEy5rW2wEu+R1eUwDR70lvCH/04WUc73LVgLKvGIskY6VAGz3
   ukBtHmgl5pC5qJN2FMoK+lVAYr+maUSUcdCQkTibPX912ejWSOGW8p+qH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301557"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632988"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: mac80211: fix various kernel-doc issues
Date:   Sun, 27 Aug 2023 14:05:25 +0300
Message-Id: <20230827135854.7ce9761f9ebb.I0f44e76c518f72135cc855c809bfa7a5e977b894@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are various kernel-doc issues here, fix them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h | 18 +++++++++++-------
 net/mac80211/sta_info.h    |  4 +---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a260df25f592..5381b9b959e7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -618,6 +618,8 @@ struct ieee80211_if_ocb {
  * these declarations define the interface, which enables
  * vendor-specific mesh synchronization
  *
+ * @rx_bcn_presp: beacon/probe response was received
+ * @adjust_tsf: TSF adjustment method
  */
 struct ieee80211_mesh_sync_ops {
 	void (*rx_bcn_presp)(struct ieee80211_sub_if_data *sdata, u16 stype,
@@ -858,12 +860,13 @@ enum txq_info_flags {
  * struct txq_info - per tid queue
  *
  * @tin: contains packets split into multiple flows
- * @def_flow: used as a fallback flow when a packet destined to @tin hashes to
- *	a fq_flow which is already owned by a different tin
- * @def_cvars: codel vars for @def_flow
+ * @def_cvars: codel vars for the @tin's default_flow
+ * @cstats: code statistics for this queue
  * @frags: used to keep fragments created after dequeue
  * @schedule_order: used with ieee80211_local->active_txqs
  * @schedule_round: counter to prevent infinite loops on TXQ scheduling
+ * @flags: TXQ flags from &enum txq_info_flags
+ * @txq: the driver visible part
  */
 struct txq_info {
 	struct fq_tin tin;
@@ -892,7 +895,8 @@ struct ieee80211_if_mntr {
  * struct ieee80211_if_nan - NAN state
  *
  * @conf: current NAN configuration
- * @func_ids: a bitmap of available instance_id's
+ * @func_lock: lock for @func_inst_ids
+ * @function_inst_ids: a bitmap of available instance_id's
  */
 struct ieee80211_if_nan {
 	struct cfg80211_nan_conf conf;
@@ -1253,7 +1257,7 @@ struct tpt_led_trigger {
 #endif
 
 /**
- * mac80211 scan flags - currently active scan mode
+ * enum mac80211_scan_flags - currently active scan mode
  *
  * @SCAN_SW_SCANNING: We're currently in the process of scanning but may as
  *	well be on the operating channel
@@ -1271,7 +1275,7 @@ struct tpt_led_trigger {
  *	and could send a probe request after receiving a beacon.
  * @SCAN_BEACON_DONE: Beacon received, we can now send a probe request
  */
-enum {
+enum mac80211_scan_flags {
 	SCAN_SW_SCANNING,
 	SCAN_HW_SCANNING,
 	SCAN_ONCHANNEL_SCANNING,
@@ -2204,7 +2208,7 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
  *	flags from &enum ieee80211_conn_flags.
  * @bssid: the currently connected bssid (for reporting)
  * @csa_ie: parsed 802.11 csa elements on count, mode, chandef and mesh ttl.
-	All of them will be filled with if success only.
+ *	All of them will be filled with if success only.
  * Return: 0 on success, <0 on error and >0 if there is nothing to parse.
  */
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 195b563132d6..bcf8472e0964 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2022 Intel Corporation
+ * Copyright(c) 2020-2023 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -618,8 +618,6 @@ struct link_sta_info {
  * @sta: station information we share with the driver
  * @sta_state: duplicates information about station state (for debug)
  * @rcu_head: RCU head used for freeing this station struct
- * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
- *	taken from HT/VHT capabilities or VHT operating mode notification
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer:
-- 
2.38.1

