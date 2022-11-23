Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830F636BEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiKWVEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbiKWVEW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:04:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8636C976D3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669237458; x=1700773458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8OrHqzkF2OLUlDXE0/n3azvIfN5Tv6UiZCT0XvuM44E=;
  b=d7KeBst501JE/moh3xqLZkYpQqD88j+O6ODlAUecLz/wkYtTX8gF8Atx
   TETdisceWLiLTFifi+l34xC+V/yUtT2mpt7SRUx7NWi24ZOVul26lJGYO
   6ZmfnPFl2i6CKr1pynM7m1kwqi8+uzRCuGavDdrBUKZFDgG3K7AcDNOv4
   Ll+ozCxFyjgJcf+UGVZtCSMRj0ktWykkL6vPD6/9u87D6es0fBiK6C/0f
   hJ9clCgMJoubsImJHSCyAG39Huz5rLQMfN5D9OrhZBN5D+oMuA6clccke
   fPE8b6kxTJXN4vWfAWCFiTRY1PPN+1xkCMDun+6MrahsgrCk5tsBFjgNW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312857391"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312857391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619761718"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619761718"
Received: from stopaz-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.194.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:15 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/5] wifi: iwlwifi: mvm: return error value in case PLDR sync failed
Date:   Wed, 23 Nov 2022 23:02:08 +0200
Message-Id: <20221123225313.08b345123f83.I13bfacc2f6da7de8ada90127fe7108d1bb73af92@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221123210209.2941641-1-gregory.greenman@intel.com>
References: <20221123210209.2941641-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In case PLDR sync is required but iwlmei failed to get a response
from CSME, the device cannot be brought up, so return an error
value.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/Y3uYUEFnMiBY2ABQ@kili/
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 74354d044db9..2f4c9e653e99 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1483,7 +1483,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
 	mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
 	if (mvm->pldr_sync && iwl_mei_pldr_req())
-		return ret;
+		return -EBUSY;
 
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
-- 
2.35.3

