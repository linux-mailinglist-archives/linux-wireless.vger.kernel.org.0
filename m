Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED037E8F72
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKLKJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 05:09:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091462D61
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699783796; x=1731319796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXHqVWMtHsu0LMfNepi9whPOeRugBkLp+axt8KAHX7A=;
  b=djFpTDQDlzWjiHQhP2mLvCRb1Ivn/4pLUkLlOVccRw8J/AWr59GMy6mG
   tvtCHolHcfdXeNZ4DWB6tnfLk7BImyYJ95uXF9zGEUrCQl0qRhQC4BX5S
   LpKTK4kPenCEUTNaJedYdWcoVnCeDrF+6IljxzP2Q5qALPFFFfCDPWZVf
   J8a4pLZJn9g2TaTgHMgRV82cLtU7M30mKaGxBieafyTqDAGVOeSrxXJLr
   t7rxd0JFcH/TmkrrJjZhmp+b6kBaYRsyh34vpUB94jTpBbELmFYK7sY3n
   nKGYUvPrugFibHvifF1gxblFLoo3gN5yuEjv3aXH8ANEbD2wHjgcd1zje
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="389188498"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="389188498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 02:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="830008545"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="830008545"
Received: from egrumbac-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 02:09:52 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com, gregory.greenman@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v3] wifi: iwlwifi: fix system commands group ordering
Date:   Sun, 12 Nov 2023 12:09:44 +0200
Message-ID: <20231112100944.21177-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The commands should be sorted inside the group definition.
Fix the ordering so we won't get following warning:
WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg))

Fixes: b6e3d1ba4fcf ("wifi: iwlwifi: mvm: implement new firmware API for statistics")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v3: remove changeId for real...
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index fef86a8b4163..1627b2f819db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -550,9 +550,9 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(RFI_CONFIG_CMD),
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
 	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
-	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
 	HCMD_NAME(SYSTEM_STATISTICS_CMD),
 	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
+	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
 };
 
 /* Please keep this array *SORTED* by hex value.
-- 
2.41.0

