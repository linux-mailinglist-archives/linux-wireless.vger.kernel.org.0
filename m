Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55C7E8F70
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjKLKGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 05:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 05:06:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE462D61
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699783568; x=1731319568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guZIojW3h1FI938ribiE72i0mMCrjI52bWuqz4iLNzg=;
  b=Qw2FLRGPaSWQ/TZRORq0sTHZCRLGMIRq1zAGaRHzWhu7/85yYyBEmJfN
   lgDU/1H7xhSIj3bEdtOe4nNqfqeg8AkIiYgD7UNXKfHKC989F9CdBdhxL
   fbv/39ht7HLdydShn6gbG0rOsN7BfG95eVRDH4QuYc48kwELB3YEhdMDC
   AgjFUy7y46L0IepwX7vw9mxTgsR/YSqmet6hbyllg767xkArIk7A8/Bfa
   FgARb+CCALUAnssOZ9uHPr+0usxtcfD8QEQ9fdwLCGSkdyNsRGSJDnicb
   r9z/JrdhMZa3ppt85+RN1w3FfsRkKC0bn3SKMwoq3KztdbonAjXetbI4I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="3345652"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="3345652"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 02:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="834482050"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="834482050"
Received: from egrumbac-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 02:06:05 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Anjaneyulu@vger.kernel.org,
        Pagadala Yesu <pagadala.yesu.anjaneyulu@intel.com>,
        Greenman@vger.kernel.org, Gregory <gregory.greenman@intel.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: fix system commands group ordering
Date:   Sun, 12 Nov 2023 12:05:58 +0200
Message-ID: <20231112100558.20826-1-emmanuel.grumbach@intel.com>
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
Change-Id: I18f7b57c7c565537e3d97f8c7ff83f0cc8e4709c
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v2: remove ChangeId
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

