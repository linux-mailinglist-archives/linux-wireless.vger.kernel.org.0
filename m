Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F204723A7B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFFHvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjFFHt4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:49:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CC91BE9
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037524; x=1717573524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kuH8rLnOHBn7IHbQNFuQSC7SM8D0GVZDJVNZTiQY8M0=;
  b=b8KK13rcpyDuG6QtwxrPX1kOTep3ZGQU0OmmKStGHT3dhY5LA920lp8x
   irxkG9oGCk2yEGrDCEKESyEkgR9Jpd7xEqPQiWBe2f9gL9cjf0n0mXLVn
   93cPaYHPAjOKVAv1wMvWjIaFHAb5fAodrvOQIq4T+mMNhMmaQFARkYST9
   tvbNlDTAeUJY7isizI5mvei8Cb1GrG3QVRPCnysd9XT5vMCA3ou+ULrn1
   WVwbWXJz98lyIqszFYA6zXZrkiTjcqOtOKFI8+koxX8HyLiRxvCtO9+Yw
   eJKCMA5iafrZZt85wJnNA69kDMZPTKH3VE+J1G67Yg8WmlvQ3VNaalOTW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419117"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516413"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516413"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/13] wifi: iwlwifi: fw: clean up PNVM loading code
Date:   Tue,  6 Jun 2023 10:43:08 +0300
Message-Id: <20230606103519.51fb5ee63f21.I20f270b2d47612e84643dc235c2940b8d9ed9930@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
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

This code is a bit of a maze of gotos etc. Clean up the
code a bit to make the intent clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 155 +++++++++++--------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 3b5a3c89fedf..82eb32e67a2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -270,88 +270,111 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 	return image;
 }
 
-int iwl_pnvm_load(struct iwl_trans *trans,
-		  struct iwl_notif_wait_data *notif_wait,
-		  const struct iwl_ucode_capabilities *capa)
+static void iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
+					const struct iwl_ucode_capabilities *capa)
 {
-	u8 *data;
+	struct iwl_pnvm_image *pnvm_data = NULL;
+	u8 *data = NULL;
 	size_t length;
-	struct iwl_notification_wait pnvm_wait;
-	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						PNVM_INIT_COMPLETE_NTFY) };
-	struct iwl_pnvm_image pnvm_data;
 	int ret;
 
-	/* if the SKU_ID is empty, there's nothing to do */
-	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
-		return 0;
-
-	/* failed to get/parse the image in the past, no use to try again */
+	/* failed to get/parse the image in the past, no use trying again */
 	if (trans->fail_to_parse_pnvm_image)
-		goto reduce_tables;
-
-	/* get the image, parse and load it, if not loaded yet */
-	if (!trans->pnvm_loaded) {
-		data = iwl_get_pnvm_image(trans, &length);
-		if (!data) {
-			trans->fail_to_parse_pnvm_image = true;
-			goto reduce_tables;
-		}
-		ret = iwl_pnvm_parse(trans, data, length, &pnvm_data);
-		if (ret) {
-			trans->fail_to_parse_pnvm_image = true;
-			kfree(data);
-			goto reduce_tables;
-		}
+		return;
+
+	if (trans->pnvm_loaded)
+		goto set;
 
-		ret = iwl_trans_load_pnvm(trans, &pnvm_data, capa);
-		/* can only free data after pvnm_data use, but
-		 * pnvm_data.version used below is not a pointer
-		 */
-		kfree(data);
-		if (ret)
-			goto reduce_tables;
-		IWL_INFO(trans, "loaded PNVM version %08x\n",
-			 pnvm_data.version);
+	data = iwl_get_pnvm_image(trans, &length);
+	if (!data) {
+		trans->fail_to_parse_pnvm_image = true;
+		return;
 	}
 
+	pnvm_data = kzalloc(sizeof(*pnvm_data), GFP_KERNEL);
+	if (!pnvm_data)
+		goto free;
+
+	ret = iwl_pnvm_parse(trans, data, length, pnvm_data);
+	if (ret) {
+		trans->fail_to_parse_pnvm_image = true;
+		goto free;
+	}
+
+	ret = iwl_trans_load_pnvm(trans, pnvm_data, capa);
+	if (ret)
+		goto free;
+	IWL_INFO(trans, "loaded PNVM version %08x\n", pnvm_data->version);
+
+set:
 	iwl_trans_set_pnvm(trans, capa);
+free:
+	kfree(data);
+	kfree(pnvm_data);
+}
+
+static void
+iwl_pnvm_load_reduce_power_to_trans(struct iwl_trans *trans,
+				    const struct iwl_ucode_capabilities *capa)
+{
+	struct iwl_pnvm_image *pnvm_data = NULL;
+	u8 *data = NULL;
+	size_t length;
+	int ret;
 
-reduce_tables:
-	/* now try to get the reduce power table, if not loaded yet */
 	if (trans->failed_to_load_reduce_power_image)
-		goto notification;
-
-	if (!trans->reduce_power_loaded) {
-		memset(&pnvm_data, 0, sizeof(pnvm_data));
-		data = iwl_uefi_get_reduced_power(trans, &length);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			trans->failed_to_load_reduce_power_image = true;
-			goto notification;
-		}
+		return;
 
-		ret = iwl_uefi_reduce_power_parse(trans, data, length,
-						  &pnvm_data);
-		if (ret) {
-			trans->failed_to_load_reduce_power_image = true;
-			kfree(data);
-			goto notification;
-		}
+	if (trans->reduce_power_loaded)
+		goto set;
 
-		ret = iwl_trans_load_reduce_power(trans, &pnvm_data, capa);
-		kfree(data);
-		if (ret) {
-			IWL_DEBUG_FW(trans,
-				     "Failed to load reduce power table %d\n",
-				     ret);
-			trans->failed_to_load_reduce_power_image = true;
-			goto notification;
-		}
+	data = iwl_uefi_get_reduced_power(trans, &length);
+	if (IS_ERR(data)) {
+		trans->failed_to_load_reduce_power_image = true;
+		return;
 	}
+
+	pnvm_data = kzalloc(sizeof(*pnvm_data), GFP_KERNEL);
+	if (!pnvm_data)
+		goto free;
+
+	ret = iwl_uefi_reduce_power_parse(trans, data, length, pnvm_data);
+	if (ret) {
+		trans->failed_to_load_reduce_power_image = true;
+		goto free;
+	}
+
+	ret = iwl_trans_load_reduce_power(trans, pnvm_data, capa);
+	if (ret) {
+		IWL_DEBUG_FW(trans,
+			     "Failed to load reduce power table %d\n",
+			     ret);
+		trans->failed_to_load_reduce_power_image = true;
+		goto free;
+	}
+
+set:
 	iwl_trans_set_reduce_power(trans, capa);
+free:
+	kfree(data);
+	kfree(pnvm_data);
+}
+
+int iwl_pnvm_load(struct iwl_trans *trans,
+		  struct iwl_notif_wait_data *notif_wait,
+		  const struct iwl_ucode_capabilities *capa)
+{
+	struct iwl_notification_wait pnvm_wait;
+	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						PNVM_INIT_COMPLETE_NTFY) };
+
+	/* if the SKU_ID is empty, there's nothing to do */
+	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
+		return 0;
+
+	iwl_pnvm_load_pnvm_to_trans(trans, capa);
+	iwl_pnvm_load_reduce_power_to_trans(trans, capa);
 
-notification:
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
 				   iwl_pnvm_complete_fn, trans);
-- 
2.38.1

