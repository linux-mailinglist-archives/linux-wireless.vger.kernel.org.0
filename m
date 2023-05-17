Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AFD706C3E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQPKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQPKM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 11:10:12 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0FE93DE
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:09:52 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9685628A9C1
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 15:02:16 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 673B6A8006A
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 15:02:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A93C813C2B0;
        Wed, 17 May 2023 08:02:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A93C813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684335723;
        bh=5xenKZzF8MdCMD3xz7KwUrtWcUIhn9xCSLVeMmEntIA=;
        h=From:To:Cc:Subject:Date:From;
        b=cYCXzLLrarXUOD+5ognGMhEifZCtL2O+Y7ZDxl/jMUYftAIw3dGVRLUfBUl/qn9/y
         fJrCdJo7FYrHnTsAUm164eZhLsh81XcXJ4TL5cAaMhDJbEsxZM09J1bFPRxCCh36iA
         j4BEexoTUGBc5aw3Hdb/Xr4s1hCov4UUum0Llghg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iwlwifi: Make warnings unique to aid debugging.
Date:   Wed, 17 May 2023 08:01:57 -0700
Message-Id: <20230517150157.930760-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684335725-F9iLa1Pixew4
X-MDID-O: us5;ut7;1684335725;F9iLa1Pixew4;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

So we can be certain what code is generating kernel error
messages.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index c93f3b9501de..ca55bb4e3bd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -701,7 +701,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	/* Will also start the device */
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
 	if (ret) {
-		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+		IWL_ERR(mvm, "run-mvm-ucode: Failed to start RT ucode: %d\n", ret);
 		goto error;
 	}
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
@@ -1663,7 +1663,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
-		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+		IWL_ERR(mvm, "mvm-up: Failed to start RT ucode: %d\n", ret);
 		if (ret != -ERFKILL && !mvm->pldr_sync)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_DRIVER);
-- 
2.40.0

