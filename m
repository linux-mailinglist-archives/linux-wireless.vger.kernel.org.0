Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFF77DBDA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjHPIMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242815AbjHPILc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749B94
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173491; x=1723709491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEKK4UMyQHz6j6qD8HPXiGCZQtB7cUoKNCqHiarYSbg=;
  b=EtU9zkXwu5T3zf2PGGms/zO/HSEBdk3PlNWOYVTiA8r86BBBILJ0ooGo
   8B4EwOzHqUQEDGk0qk7wU01NFUgX6qmh1cByzaU6LwcVFutnHdhy1d5Zk
   X6Tg1ZhCBbP5NPtXeKObwEIeKOsNn18/L2fxUyniOdNFhzBBGYnDxAaA8
   WdNH1ZTHXOBZrK8L6EXJeH65hUhMulSgSrqsglulUxqPA4QgS+KhqMGQB
   G4B4U6XQRK75Dr4+0SDwUaLoMUoVb6tbuU+EBJEF+Ih0EqRmUPnqphNk7
   qcNlgpnccao3/y0IucU3SKeQRnUoGlesD5qRnm2imJTynl8Md9kJTqUpv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447873"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098853"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098853"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/12] wifi: iwlwifi: mvm: enable HE TX/RX <242 tone RU on new RFs
Date:   Wed, 16 Aug 2023 11:10:52 +0300
Message-Id: <20230816104355.ddb090c86c8c.Ic630aa579e3dc52069758d8698069480d555eefe@changeid>
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

Two new RFs were added in the code, but we forgot to
add them to the list here that enables HE TX/RX 1024
QAM less than 242 tone RU.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 8c23f57f5c89..31176897b746 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -990,6 +990,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	case IWL_CFG_RF_TYPE_GF:
 	case IWL_CFG_RF_TYPE_MR:
 	case IWL_CFG_RF_TYPE_MS:
+	case IWL_CFG_RF_TYPE_FM:
+	case IWL_CFG_RF_TYPE_WH:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
 			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 		if (!is_ap)
-- 
2.38.1

