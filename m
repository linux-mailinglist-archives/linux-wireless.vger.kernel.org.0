Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1586F739D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjEDTo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjEDTn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 15:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E293D7;
        Thu,  4 May 2023 12:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D2E6372B;
        Thu,  4 May 2023 19:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B27C433EF;
        Thu,  4 May 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229408;
        bh=GFyM6cTMGTmTV2CXeC6NO2Ow8WKGYJWXlluZDvsoRaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYTOHyBHyLrOkBY1U0TsG+mDUBQ1n7ccLP6xXspYJIRYEV0ckEgY0+BW0mffVRFGf
         WV9X3Xo6/2HgtwUV12fcM13Z9iQcS4wu4ZQ84D3EYCmnwjD+qbIeuOHI4ri7uKPbV6
         9J0cfjNiMOgGVztD59oo3YTayJGqKVBI+R44ZN0qwjHMFOz7tkExFi9o7Lo1/l9Ve9
         3mJG3ISdkBFbnzmey01jwttl8d3de0AFHij864MRzYLtl+Rdq+cLY3zIbMZZkeIu5C
         ygru42vgPr2Q1yiRcg1qURVGz++pfZcaXY2aMdXHG5PxS0oPudS38HLd7GM9p4svOM
         aJr1Ws9wAuxNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, miriam.rachel.korenblit@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 38/59] wifi: iwlwifi: mvm: fix ptk_pn memory leak
Date:   Thu,  4 May 2023 15:41:21 -0400
Message-Id: <20230504194142.3805425-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d066a530af8e1833c7ea2cef7784004700c85f79 ]

If adding a key to firmware fails we leak the allocated ptk_pn.
This shouldn't happen in practice, but we should still fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.99446ffd02bc.I82a2ad6ec1395f188e0a1677cc619e3fcb1feac9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b55b1b17f4d19..c0b5dc7bd76b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3587,7 +3587,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvmsta = NULL;
-	struct iwl_mvm_key_pn *ptk_pn;
+	struct iwl_mvm_key_pn *ptk_pn = NULL;
 	int keyidx = key->keyidx;
 	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
@@ -3739,6 +3739,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		if (ret) {
 			IWL_WARN(mvm, "set key failed\n");
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
+			if (ptk_pn) {
+				RCU_INIT_POINTER(mvmsta->ptk_pn[keyidx], NULL);
+				kfree(ptk_pn);
+			}
 			/*
 			 * can't add key for RX, but we don't need it
 			 * in the device for TX so still return 0,
-- 
2.39.2

