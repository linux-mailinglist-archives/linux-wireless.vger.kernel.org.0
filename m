Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5D77DDFB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjHPJ5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbjHPJ45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 05:56:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F2C1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 02:56:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQk541vBvzVkGF;
        Wed, 16 Aug 2023 17:54:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:56:53 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] wifi: iwlwifi: mvm: Use helper function IS_ERR_OR_NULL()
Date:   Wed, 16 Aug 2023 17:56:32 +0800
Message-ID: <20230816095633.2905868-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use IS_ERR_OR_NULL() instead of open-coding it
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index dae6f2a1aad9..c3310a3a01a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -24,7 +24,7 @@ void iwl_mvm_teardown_tdls_peers(struct iwl_mvm *mvm)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
-		if (!sta || IS_ERR(sta) || !sta->tdls)
+		if (IS_ERR_OR_NULL(sta) || !sta->tdls)
 			continue;
 
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -47,7 +47,7 @@ int iwl_mvm_tdls_sta_count(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
 						lockdep_is_held(&mvm->mutex));
-		if (!sta || IS_ERR(sta) || !sta->tdls)
+		if (IS_ERR_OR_NULL(sta) || !sta->tdls)
 			continue;
 
 		if (vif) {
@@ -472,7 +472,7 @@ void iwl_mvm_tdls_ch_switch_work(struct work_struct *work)
 				mvm->fw_id_to_mac_id[mvm->tdls_cs.peer.sta_id],
 				lockdep_is_held(&mvm->mutex));
 	/* the station may not be here, but if it is, it must be a TDLS peer */
-	if (!sta || IS_ERR(sta) || WARN_ON(!sta->tdls))
+	if (IS_ERR_OR_NULL(sta) || WARN_ON(!sta->tdls))
 		goto out;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-- 
2.34.1

