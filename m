Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C785728240
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjFHOHS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjFHOHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8512733
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233231; x=1717769231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQQ18E6IXICZn3mP0eHEuIrGpwBIYvL6Orc3GiJaKcA=;
  b=T2eB9KK0zMipj9ZgLQ407hC9GA+EjN3YVdTKRg02uJyoNgm5JRt/HQ7i
   zIcEx/UIx9m3HIZj2aX+PxSm8nl9XgOXT7ZjwIVaDyjCdUTf9kTGnHJ62
   6RIoTHKO19IUBnKF0QEuSKQ/2ocfbTSH3pC2ZBgQ7ulbW8bthkEtJrh5A
   dwUcrcnFMK+RapmmhYOov8eUHh7IuJT8MopIvXn1rZ/g6Zey4HKQ0B6zy
   W81bR5r07Q+0Gdxcax13Ri+RxvVRpV3Fv40Y1GP1teQnGogIe0+fyubvc
   7+TSH/vR4CVs/ySfcZS2zTxStIs5WoVEyX0lvAjAfqATWBiDHCIYRpSlu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176189"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176189"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706109"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706109"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: mac80211: include key action/command in tracing
Date:   Thu,  8 Jun 2023 16:35:57 +0300
Message-Id: <20230608163202.546e86e216df.Ie3bf9009926f8fa154dde52b0c02537ff7edae36@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We trace the key information and all, but not whether the key
is added or removed - add that information.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/trace.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index db0d0132c58c..e5edf6fe576f 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -634,6 +634,7 @@ TRACE_EVENT(drv_set_key,
 		LOCAL_ENTRY
 		VIF_ENTRY
 		STA_ENTRY
+		__field(u32, cmd)
 		KEY_ENTRY
 	),
 
@@ -641,12 +642,13 @@ TRACE_EVENT(drv_set_key,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		STA_ASSIGN;
+		__entry->cmd = cmd;
 		KEY_ASSIGN(key);
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT KEY_PR_FMT,
-		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, KEY_PR_ARG
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " cmd: %d" KEY_PR_FMT,
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->cmd, KEY_PR_ARG
 	)
 );
 
-- 
2.38.1

