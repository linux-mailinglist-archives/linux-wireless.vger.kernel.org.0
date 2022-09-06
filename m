Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFB5AED07
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiIFOH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiIFOGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:06:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6585AB4
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471938; x=1694007938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57EsCeN96aU/GbsBp91aR4FkeJbmOE9aupl6NB4s5J4=;
  b=BanHxC/Z//y8QOPAJQ8rqjeg0BdJYEskkT7ByObnvMIt0ImOGw6AAhNK
   jKqIDlgs+s7vWxxsA82PWIuSeTz1z1s/TeGwQFhBdoG9X+aIy3lv1RQCD
   q1/+ofLYCFFofukaUHv1FPdbFXAQiApvJM6O58+V0QbgzLEPuFwamaMA/
   uChvYPXqm5mT5ryGUB0V1BQA2asCqM+VDSxvnqykSTbJeKI6UVfUigqiK
   p8cyZlB9KHVpCC6IeJUNOEU6S7nHecdISgc9LVq3vir02LiBZDd6t5I/Y
   FSU4dbEjmK3LcTIzunHA1sf3QLc4hWvdJow7uyFOoYl9a0wISWD8SYUow
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279608704"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279608704"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459692"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:32 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: cfg: remove IWL_DEVICE_BZ_COMMON macro
Date:   Tue,  6 Sep 2022 16:42:10 +0300
Message-Id: <20220906161827.23d6c92e9a11.I4a11928a6d698079dc742e3ba3d3ce6fd7a878d1@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We only have a single use of this inside the IWL_DEVICE_BZ
macro, so just combine the contents here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c949675ca2ed..110fda65bd21 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -249,7 +249,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
-#define IWL_DEVICE_BZ_COMMON						\
+#define IWL_DEVICE_BZ							\
 	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
@@ -285,16 +285,13 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
 			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
 		},							\
-	}
-
-#define IWL_DEVICE_BZ							\
-	IWL_DEVICE_BZ_COMMON,						\
+	},								\
 	.trans.umac_prph_offset = 0x300000,				\
 	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
 	.trans.base_params = &iwl_ax210_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,		\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
 			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-- 
2.35.3

