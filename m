Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E65AEC80
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiIFOKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiIFOIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:08:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5186739
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471979; x=1694007979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tznXWQ5RkAZHwQ+4mEODzDh0CdtCjKkHrQBezVMonSw=;
  b=WsRPAkxtXfRrb8oIhvmtTw1GaxXKuX4TKtYqRRQru/jaxgrRVLf+7XOZ
   juKbn/0Kymtefv5udXaH92nZIRcKHU0edhJzMgK+Lu34ubKfuG8pYzgjb
   UsTf2oI4EUOMH+H4K80eA2bU8znqJqnzu6Jrtqs0gVcOQNyy7a63w8D/c
   4a6e44S4A2JxxEX8Kj9+0clNGHPEwi/B8bIpixX80O6MpRfWZ2SJnjPAr
   fltk74v2RPIXmShz06Jgm7zKc1vOkHas5sLia15sBIQgIQJ9vA5yIgbO5
   1KzfMosbOXCIfZmcSRCDruGvBJPlyMer1lkNAE4iGGzyykYj39FE4GTiD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276988996"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276988996"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459883"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:40 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: don't check D0I3 version
Date:   Tue,  6 Sep 2022 16:42:11 +0300
Message-Id: <20220906161827.87c82482229a.I70456c38ed8f7beb7d62dd618f58e7dc0a7d33b2@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

This code is dead, even old FW versions don't use it.
The IWL_D0I3_RESET_REQUIRE flag will be sent by the FW via a notification,
instead of command, the notification handler will be introduced later
in the series.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  | 22 --------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c |  7 -------
 3 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index aeb0015b73d2..518755b756b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2551,7 +2551,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			.id = D0I3_END_CMD,
 			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
 		};
-		int len;
 
 		ret = iwl_mvm_send_cmd(mvm, &cmd);
 		if (ret < 0) {
@@ -2559,27 +2558,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 				ret);
 			goto err;
 		}
-		switch (mvm->cmd_ver.d0i3_resp) {
-		case 0:
-			break;
-		case 1:
-			len = iwl_rx_packet_payload_len(cmd.resp_pkt);
-			if (len != sizeof(u32)) {
-				IWL_ERR(mvm,
-					"Error with D0I3_END_CMD response size (%d)\n",
-					len);
-				goto err;
-			}
-			if (IWL_D0I3_RESET_REQUIRE &
-			    le32_to_cpu(*(__le32 *)cmd.resp_pkt->data)) {
-				iwl_write32(mvm->trans, CSR_RESET,
-					    CSR_RESET_REG_FLAG_FORCE_NMI);
-				iwl_free_resp(&cmd);
-			}
-			break;
-		default:
-			WARN_ON(1);
-		}
 	}
 
 	/* after the successful handshake, we're out of D3 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bf35e130c876..ea128066eea6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1079,7 +1079,6 @@ struct iwl_mvm {
 	struct list_head resp_pasn_list;
 
 	struct {
-		u8 d0i3_resp;
 		u8 range_resp;
 	} cmd_ver;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index db43c8a83a31..7ed4f5a0abc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1188,13 +1188,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	INIT_DELAYED_WORK(&mvm->cs_tx_unblock_dwork, iwl_mvm_tx_unblock_dwork);
 
-	mvm->cmd_ver.d0i3_resp =
-		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP, D0I3_END_CMD,
-					0);
-	/* we only support version 1 */
-	if (WARN_ON_ONCE(mvm->cmd_ver.d0i3_resp > 1))
-		goto out_free;
-
 	mvm->cmd_ver.range_resp =
 		iwl_fw_lookup_notif_ver(mvm->fw, LOCATION_GROUP,
 					TOF_RANGE_RESPONSE_NOTIF, 5);
-- 
2.35.3

