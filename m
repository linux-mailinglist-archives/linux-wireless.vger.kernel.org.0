Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176577DBCF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbjHPILi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbjHPILQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7CEE
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173476; x=1723709476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5MWBmaoXGc1nEKdDu02ENf1fei4u0BZViXJTMm3zpRw=;
  b=HbOHCfJI5KyODxEX36Iq8g3Ko9j1XgvaktSe2VLDsueBEUF1mLXJoUb2
   5TKYNZqQWqcvBl1QQOGcAJ0DZng1yZ8QDXbvUjT8fxmv/jyK6ZY/ujDnY
   nXoukUnUsUZ5788WzlsssU7snu8/Tz3o7+f8AsaJ928Ru+SthgeBq8uln
   900tK1hvSwma1B02bekQuxClVNI8NlXCQz/Um5dm6zZ3RvRiM+UVLMx3l
   P+aAeYGTA4qoGp1knx/DPV7VjlP0uPnw7VDJ91iB+ZXofBFsIxBp5Sck7
   xqCiAE/1S2GZMNz5V2kf+3JeNIccmaZgezk+n0Moza8GTWKVPRburdcoY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447798"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098754"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098754"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/12] wifi: iwlwifi: remove WARN from read_mem32()
Date:   Wed, 16 Aug 2023 11:10:45 +0300
Message-Id: <20230816104355.5f4e80eb63cc.Iffd88f63f95575f28e503da13b473724e3341aee@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no reason to warn here, it's not an internal consistency
issue, we even use this to check if the device is dead, and if it
read_mem() returns an error that's either because grab NIC access
or memory allocation failed, both of which are already noisy.

Just remove the warning entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d02943d0ea62..8a6ddb5fb0c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1490,7 +1490,7 @@ static inline u32 iwl_trans_read_mem32(struct iwl_trans *trans, u32 addr)
 {
 	u32 value;
 
-	if (WARN_ON(iwl_trans_read_mem(trans, addr, &value, 1)))
+	if (iwl_trans_read_mem(trans, addr, &value, 1))
 		return 0xa5a5a5a5;
 
 	return value;
-- 
2.38.1

