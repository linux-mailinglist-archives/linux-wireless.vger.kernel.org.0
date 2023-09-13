Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9779E75A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjIML5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbjIML5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21119BB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606264; x=1726142264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGSVkrXrQ6rJ3WriB85eMQaNK4lA2pradVj6MEQVTqs=;
  b=Tkr8HoetrVHuHX1r1uci7surYGtD57uo6902QmSOUZZ2CpAQstIGUFS8
   jvxx9FWfHkSWY0ySSFaBUnk+P+ky/S0lUMtlLQiT2bOtIzV+3GhMYHme0
   sR1i9Uo51CDDsrls0SQBJJiB5X5QnvO3SfkWeOtOrSRLirhX/jbnAMim1
   mOQBJZIU0yLDPKyloWiQEO5gkjduABnRHY5JKu2IpmTPdycR29cHqpup4
   GY5XzIqIqG1VC8uA4McjOSNGcueCb9d08UpDSj+NaZi9IXvrvdxQykT5M
   Yhl/cVOltMsYW2k53efki9fTfnjgFdSYgN6DP8GaS57CX//7Un4gy0Vkv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903084"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903084"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470971"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470971"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: update context info structure definitions
Date:   Wed, 13 Sep 2023 14:56:47 +0300
Message-Id: <20230913145231.ef1553ab5178.I326ac8719566e04f799d294d8e863383cff87eaa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some new fields were added to the context info structure,
define them for future use.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 8a377b41e26a..1379dc2d231b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -187,11 +187,15 @@ struct iwl_prph_scratch_ctrl_cfg {
  * struct iwl_prph_scratch - peripheral scratch mapping
  * @ctrl_cfg: control and configuration of prph scratch
  * @dram: firmware images addresses in DRAM
+ * @fseq_override: FSEQ override parameters
+ * @step_analog_params: STEP analog calibration values
  * @reserved: reserved
  */
 struct iwl_prph_scratch {
 	struct iwl_prph_scratch_ctrl_cfg ctrl_cfg;
-	__le32 reserved[10];
+	__le32 fseq_override;
+	__le32 step_analog_params;
+	__le32 reserved[8];
 	struct iwl_context_info_dram dram;
 } __packed; /* PERIPH_SCRATCH_S */
 
-- 
2.38.1

