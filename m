Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE287D2372
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjJVO4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJVO4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64CA4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986587; x=1729522587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8IYcx04IqjuWbiFS4dpdSngvYA4jVhEnwwR1sjy/Ykc=;
  b=jACice5jayuMq0PQvQ2hlSquVMitS8R817z/+1SkRtqh4fNpHsipwlM3
   1fTAgPDntYmsI2cwC/dUfawpfRleylMchiZ9RBT/F7oWs30WIgiGdUWtA
   Sp/eLPAg8hH2hvUKqJFWz/XrTzTwRXRtPt0iEHS/lZv5qLgE18Gvp74q2
   qOM3Bdgy2l707ErT9pBGOWmCiDmjsVRahtDLkYPxiHvyRAJo4rGsPci8r
   IM+WwpQnS4AUmpRde6xriTBN2UFyDwOAenw5GFdK3kVxXUVwsrC6oKeyY
   g35x1IMRypcKX9MNH6A6NmBAK7lg2OGnaQ5t7qVH4irvAaJcCniawtNx/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925862"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556216"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/10] wifi: iwlwifi: mvm: show dump even for pldr_sync
Date:   Sun, 22 Oct 2023 17:55:54 +0300
Message-Id: <20231022173519.30e614ecd540.I47324f555ebcf22d0dd0afa94e7ca0af53a9fdba@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

Worst case it's extra (garbage) data, best case we see why
things failed ... Seems the trade-off is better if we print
it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8bba59d83b30..fef86a8b4163 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1979,9 +1979,6 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
-	if (mvm->pldr_sync)
-		return;
-
 	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
 	    !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 				&mvm->status))
-- 
2.38.1

