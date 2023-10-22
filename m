Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F327D236D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJVO4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVO4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F1A4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986576; x=1729522576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqjtjMp+TCzwNSHihL10AOpIZRWm7RJrZDLLjDz9YgA=;
  b=FMmVH25ukwFAGzBnO24gnyLOtEBoqj2V+rUwySqF9/pY499oLJoIoqh6
   U9DN9s4IuLkm1Tv6osszLysmD0mRhUO9SqQPCFETlgz2JsK5EE70O6od5
   q5Vve67p9gctQud5QFz4xihXaEnjuYQWjXrk/Pw2xZwQvumREm/vhCBeT
   50WyH4tUkqmDc9S7svHhNx/v38xmSQeO8Z1lJ2Z0OXULxxVDQBRt2ITFY
   6EeqVZN/QN400BPpqABMuN8xjbZWiy6FfKo9pdSwXd2biz+ZpzRX51k+8
   Wu7TRkJyCF6IbehUFe7YRjLBjfHFisBtnCiy06i0nZGH2JzNZC65oN8w0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925849"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925849"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556196"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/10] wifi: iwlwifi: mvm: add a print when sending RLC command
Date:   Sun, 22 Oct 2023 17:55:49 +0300
Message-Id: <20231022173519.ec227229263f.Iea36e64d4092e04ad561beb87002c7bb8c52596f@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Expand RLC logging to simplify the debug.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 8baf261888a7..4e1fccff3987 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -192,6 +192,9 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd.rlc.rx_chain_info,
 				     chains_static, chains_dynamic);
 
+	IWL_DEBUG_FW(mvm, "Send RLC command: phy=%d, rx_chain_info=0x%x\n",
+		     ctxt->id, cmd.rlc.rx_chain_info);
+
 	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(RLC_CONFIG_CMD,
 						    DATA_PATH_GROUP, 2),
 				    0, sizeof(cmd), &cmd);
-- 
2.38.1

