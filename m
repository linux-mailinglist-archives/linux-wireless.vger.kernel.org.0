Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E479E752
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjIML51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbjIML50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79A19A8
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606242; x=1726142242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dv76SD2Z30ojSSs7tH3+x561Om2LjEFDVs/AbYyn7os=;
  b=P6xXmXLDkaVVOs1jOzNGQ/0TGjyFhguTenHHCFXy27bqaptErOvs5edT
   0eVYHT8DwyfUL6rNnXIuFBfCgL8aMM0EVJS4K7MKb/M6M38qvENJpfcp7
   EhYCsLUbqXgeoia+yq2G5sG1If0Lq0gZhndGV1tTr4qpnlcf/B41+xH6h
   YzQ5V8HbaISlycZrmKEToRNuGbu1aXgOJ0s+4EVE/e9J0jBUqmNCNZup5
   5mN4ygFTHAL1JpJtR9QR1xI0ADKt08TCtiGWLvwxGUDW5viZJYZT/rtL4
   Kzv7BZ9gpdqqUt4AQ6gZaayrd1lgplXLePsvEjju1h+yZYqgdGfA9XIdU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903027"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903027"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470926"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470926"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: pcie: give up mem read if HW is dead
Date:   Wed, 13 Sep 2023 14:56:38 +0300
Message-Id: <20230913145231.345af79f431c.I5ecde6b76b1e3a1572bd59d3cf8f827e767cedeb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the hardware is not responding, as indicated by (currently)
five consecutive HW errors during reading, then just give up
and fail, rather than attempting forever and forever for this
to not return any useful data anyway.

Even though we no longer completely deadlock the machine if it
takes a long time, we still make it pretty much unusable since
we'll eventually hold the RTNL while waiting for this process
to finish.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 51012435e39b..93e10d7d12fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2288,6 +2288,8 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 				   void *buf, int dwords)
 {
+#define IWL_MAX_HW_ERRS 5
+	unsigned int num_consec_hw_errors = 0;
 	int offs = 0;
 	u32 *vals = buf;
 
@@ -2303,6 +2305,17 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 			while (offs < dwords) {
 				vals[offs] = iwl_read32(trans,
 							HBUS_TARG_MEM_RDAT);
+
+				if (iwl_trans_is_hw_error_value(vals[offs]))
+					num_consec_hw_errors++;
+				else
+					num_consec_hw_errors = 0;
+
+				if (num_consec_hw_errors >= IWL_MAX_HW_ERRS) {
+					iwl_trans_release_nic_access(trans);
+					return -EIO;
+				}
+
 				offs++;
 
 				if (time_after(jiffies, end)) {
-- 
2.38.1

