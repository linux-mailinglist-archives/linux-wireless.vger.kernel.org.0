Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518627347C2
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFRSui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFRSug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A8E49
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114233; x=1718650233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rm+h6+vmHSO5arfNDwEewLImin95ru/uQBQQcogdT+o=;
  b=FI6k5HqLuKrzuCvxGGZyq2M1oSvt33ILw6WnguPBfNDj9ZA4NIdUd/qC
   yORkFLsymtIZ2GMcbA8LvxFJUWHSUFB+1Gzf3W2RjnPhHiBG6rlDX46W8
   uFRbaRLyfXTuyamRuaf2JsPxjatHHf9tQBNtk6JN9DNHg3kH02M9nRAWD
   0S9sJL3uGa6IyL67s0fgPCfn6LOtNsI6YF4hLSTx77UCxdWJ7uPekn9xx
   vVSxCLVF1PukO3LsjBtGHJ7dX2CPJCGNa7moCzC5CYVhhFcgtLmnHa9OI
   zlee/4yW2aaHxEfctWP8RxUpJRbzwNbx9m876KS9oEqZxWFaocl1Jxpqx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116640"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116640"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:32 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233898"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233898"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/20] wifi: ieee80211: add definitions for RNR MLD params
Date:   Sun, 18 Jun 2023 21:49:49 +0300
Message-Id: <20230618214436.9999842237c0.I80f00a90cb4e43071432b4158f206c73ba799618@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Add the definitions necessary to parse the MLD parameters
included in an RNR element.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 251998be24d0..7afd08d2de2f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4485,6 +4485,7 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_TBTT_INFO_TYPE_MLD				1
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
+#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM_MLD_PARAM	16
 
 #define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
 #define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
@@ -4508,6 +4509,20 @@ enum ieee80211_range_params_max_total_ltf {
 	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_UNSPECIFIED,
 };
 
+/*
+ * reduced neighbor report, based on Draft P802.11be_D3.0,
+ * section 9.4.2.170.2.
+ */
+struct ieee80211_rnr_mld_params {
+	u8 mld_id;
+	__le16 params;
+} __packed;
+
+#define IEEE80211_RNR_MLD_PARAMS_LINK_ID			0x000F
+#define IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT		0x0FF0
+#define IEEE80211_RNR_MLD_PARAMS_UPDATES_INCLUDED		0x1000
+#define IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK			0x2000
+
 /* multi-link device */
 #define IEEE80211_MLD_MAX_NUM_LINKS	15
 
-- 
2.38.1

