Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E36738144
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjFUKOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFUKN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:13:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871C310D2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342428; x=1718878428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ew082MpYDn8nvpAMFuvEImfWqTNLtCchmgzWpD2gLYU=;
  b=PPGe6cqF4jIP1ND5relm5+0uV3U5kNCLzzP7eUk9IX4JzCN7TXzclngD
   qsH7SMbZmWBQ4mzsGycphRHLMVjHrioyRihJ2Ey+pKrVTyL/0tsql8C2F
   HkYUSYYO0GAmwBvppw0qmqrM0QI6ET8Ah7OI74jmWxTEn0R+WJF4b6Qyg
   9XiWsCm8CcQgdVknQy5YZ/01OOrFqK5mPuzjfIcQOSjatvrPtsptQiiuw
   vDYdugtn0NRV+Un4mMwlLIQ99G8rnYazJJwam+Qz9sWchmV3QKrVVs6VN
   21VFACyixxbPrngVykNdugEfVueaLZgj2TYbbDT9DH+YfNVpPvOm5HFZV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506355"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599105"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599105"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/18] wifi: iwlwifi: give Sc devices their own family
Date:   Wed, 21 Jun 2023 13:12:08 +0300
Message-Id: <20230621130443.e98272ddb808.If18577b2393f631d1bfaa931287cae106fa32438@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

They're not the same as Bz or any prior ones, and there's
already one place in the driver that would erroneously
assign a workaround to A-step Sc devices if they're just
treated as a version of Bz. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index a294c88e6a65..296ac689d075 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -96,7 +96,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
 		},							\
 	},								\
 	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
+	.trans.device_family = IWL_DEVICE_FAMILY_SC,			\
 	.trans.base_params = &iwl_sc_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
@@ -135,7 +135,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
 #define IWL_NUM_RBDS_SC_HE		4096
 
 const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
-	.device_family = IWL_DEVICE_FAMILY_BZ,
+	.device_family = IWL_DEVICE_FAMILY_SC,
 	.base_params = &iwl_sc_base_params,
 	.mq_rx_supported = true,
 	.rf_id = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5c6ab5b9930b..ef5154cf114b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -35,6 +35,7 @@ enum iwl_device_family {
 	IWL_DEVICE_FAMILY_22000,
 	IWL_DEVICE_FAMILY_AX210,
 	IWL_DEVICE_FAMILY_BZ,
+	IWL_DEVICE_FAMILY_SC,
 };
 
 /*
-- 
2.38.1

