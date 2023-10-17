Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022F7CBEBD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjJQJRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJQJRN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08AB0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534231; x=1729070231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r2t9u//+09uySJiJIB+in/VGs+d7pckDc9QCLXAAIZU=;
  b=LTDR3wPC8r0VCCbtIJjN6Rh0/E3dRWze0tgsPyQoRCiCoKHYyppQAb3f
   KF+7gZZ8t36r+MLj4443DckvG+GAaNr6St96MvZ3qcqJGjerHak3uoxl0
   u0ZidOs8AagfK1Hi4+zPQdVTxBZD91Gz4lbbiSkwWRHs6KbK3gN0OPMk5
   QjqdPF/rghKKsWEM8vPedu1tGqpErnjez0rN4Z/GBRH1g28hsgHp+2XyN
   h5jBiKp+jF/3OWC8X35ZG8r2wpcZ0RDRUS/2x3CH3RQoq1rWO/KomIgF6
   KzwlbqDvh9YhLoaHmMSv/nRuWTEgmDIcYIwymrZtiC3wQWaNH2tBsiiS1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808524"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731848"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731848"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: api: fix center_freq label in PHY diagram
Date:   Tue, 17 Oct 2023 12:16:39 +0300
Message-Id: <20231017115047.08ac3cf524c0.I538f424e1ab30f73b0af8381224f377893e15526@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
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

Somehow I managed to put the EHT line in the wrong place and
also didn't indent the center_freq label correctly. Fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 8fe42cff1102..306ed88de463 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -25,8 +25,8 @@
  * For legacy set bit means upper channel, otherwise lower.
  * For VHT - bit-2 marks if the control is lower/upper relative to center-freq
  *   bits-1:0 mark the distance from the center freq. for 20Mhz, offset is 0.
- *                                   center_freq
  * For EHT - bit-3 is used for extended distance
+ *                                           center_freq
  *                                                |
  * 40Mhz                                     |____|____|
  * 80Mhz                                |____|____|____|____|
-- 
2.38.1

