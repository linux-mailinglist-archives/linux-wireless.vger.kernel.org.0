Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E26B9D96
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNRy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCNRy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13AC64F
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816453; x=1710352453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKfQApHpC+QQFfFosW/uQl7TZHA0eUZQQkzJJX5WWTU=;
  b=KKG7Mrgm4W8ae3wHF26c3SM8Ruy71Jp4TBNwF1msZBY9ZB6LuXybGoU0
   mEusiS+uY/jfmxsXpxXJiQeeBbwRiAUpIjG8LClbo9AeVNRGpck+ehFft
   x4Dl/LOme0dToodPQNNtlWnOl/1zqPYNQcCcge1NznYfve5SlOi10YKSe
   QfEKVR2LK4FCi5hMvjNMF3NKnZsUGSeOlRR/Dmp3NZAEGfNddojD94Ssa
   iHZDj8KglcUxWgnp5OLTU+Moz4yaZ/cdhEwHUaC0nFW6L85qxs/TXhqn+
   6ZFbEAQAcefJzgyYBz0dRMQNY15nujSI2FDmeyIa528+C8loLhy9iMBnt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149715"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200588"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200588"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Solomon Tan <solomonbstoner@protonmail.ch>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/22] wifi: iwlwifi: Replace space with tabs as code indent
Date:   Tue, 14 Mar 2023 19:49:31 +0200
Message-Id: <20230314194113.eaca2a9b08f2.Ic81d60185c13cfc750bf93fbabac57314cb5de13@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Solomon Tan <solomonbstoner@protonmail.ch>

This patch addresses the checkpatch.pl warning that code indent should
use tabs.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3a828fddd72c..0582e05025ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1312,7 +1312,7 @@ static inline bool iwl_mvm_is_csum_supported(struct iwl_mvm *mvm)
 {
 	return fw_has_capa(&mvm->fw->ucode_capa,
 			   IWL_UCODE_TLV_CAPA_CSUM_SUPPORT) &&
-               !IWL_MVM_HW_CSUM_DISABLE;
+		!IWL_MVM_HW_CSUM_DISABLE;
 }
 
 static inline bool iwl_mvm_is_mplut_supported(struct iwl_mvm *mvm)
-- 
2.38.1

