Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCED735887
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFSN1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFSN12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932CE54
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181244; x=1718717244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cl8/ZpMdD4tIANGj37psl52UQ72RPe/+wHd/8yHEcg=;
  b=lAHzx8FGfwVL4Tbfq0umQUYUhenXmvbmXKlMHPqnFDZQq9GmdFrjDk/j
   HmoprYf3vLN4XVaP1eiUTMvWYVRRZDZg5YmC8v5UeUL+6nPQ52ilxbbHI
   rIL+VyWfJ7s2SSPc9a81gsB4lXQzasy8C6+EusJQtj2UWX0NS10qLzLsb
   sda1DNJRM2vYidDveGvmgNntsLJ6se9cTbM7N0p+R3+vWBnV1qxPqsexJ
   czgv/wXSphD4Qr3uwiPELZ0J9rgCshREhNkSQNbyZjtPyu2AbAyGHj5X3
   XWrJlBi9e0CZ4JGG1TEeoFm3Z3e7N52Ta4CB7OEps4x1HvYVA7FdwImX8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240711"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871778"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871778"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 9/9] wifi: nl80211/reg: add no-EHT regulatory flag
Date:   Mon, 19 Jun 2023 16:26:53 +0300
Message-Id: <20230619161906.74ce2983aed8.Ifa343ba89c11760491daad5aee5a81209d5735a7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

This just propagates to the channel flags, like no-HE and
similar other flags before it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/reg.c           | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index fece687054ef..b96ab2c9a5a5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4443,6 +4443,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
  * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
+ * @NL80211_RRF_NO_EHT: EHT operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4462,6 +4463,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
 	NL80211_RRF_NO_320MHZ		= 1<<18,
+	NL80211_RRF_NO_EHT		= 1<<19,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 949e1fb3bec6..ead3c74439b8 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -1587,6 +1587,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
 	if (rd_flags & NL80211_RRF_NO_320MHZ)
 		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
+	if (rd_flags & NL80211_RRF_NO_EHT)
+		channel_flags |= IEEE80211_CHAN_NO_EHT;
 	return channel_flags;
 }
 
-- 
2.38.1

