Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388C92876DE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgJHPM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:12:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54586 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729833AbgJHPM7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbE-002QxQ-9g; Thu, 08 Oct 2020 18:12:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:42 +0300
Message-Id: <iwlwifi.20201008181047.65872d5f1670.I0b2fb2a65904ae686c3c7c05f881a1e3634dc900@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/13] iwlwifi: mvm: fix suspicious rcu usage warnings
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

mvm mutex isn't held by iwl_mvm_set_aes_rx_seq or it caller.
iee80211_local->key_mtx is held, but that is internal to mac80211.

The same applies to iwl_mvm_wowlan_program_keys.

Just hold rcu_read_lock, even though we are protected, the penalty
isn't that bad.

Warnings fixed are:

[ 4143.788196] WARNING: suspicious RCU usage
[ 4143.788211] -----------------------------
[ 4143.788220] suspicious rcu_dereference_protected() usage!
[ 4143.788227]
[ 4143.788234] rcu_scheduler_active = 2, debug_locks = 1
[ 4143.788242] 5 locks held by kworker/u8:9/5921:
[ 4143.788331]  #4: ffff88804e69ad08 (&local->key_mtx){+.+.}, at ie80211_iter_keys+0x46/0x380 [mac80211]
[ 4143.788441]
[ 4143.788441] Call Trace:
[ 4143.788455]  dump_stack+0xc1/0x11a
[ 4143.788471]  lockdep_rcu_suspicious+0x14a/0x153
[ 4143.788515]  iwl_mvm_set_aes_rx_seq+0x4a9/0x570 [iwlmvm]
[ 4143.788657]  iwl_mvm_d3_update_keys+0x2ac/0x600 [iwlmvm]
[ 4143.788784]  ieee80211_iter_keys+0x10e/0x380 [mac80211]
[ 4143.788838]  iwl_mvm_setup_connection_keep+0x287/0x8d0 [iwlmvm]

[ 7243.206556] WARNING: suspicious RCU usage
[ 7243.206811] -----------------------------
[ 7243.206926] /suspicious rcu_dereference_protected() usage!
[ 7243.207086]
[ 7243.207204] rcu_scheduler_active = 2, debug_locks = 1
[ 7243.207321] 2 locks held by cat/15952:
[ 7243.207564]  #1: ffff888008c8ad08 (&local->key_mtx){+.+.}, at:
ieee80211_iter_keys+0x46/0x380 [mac80211]
[ 7243.207751]
[ 7243.208094] Call Trace:
[ 7243.208211]  dump_stack+0xc1/0x11a
[ 7243.208355]  lockdep_rcu_suspicious+0x14a/0x153
[ 7243.208509]  iwl_mvm_wowlan_program_keys+0x1db7/0x2340 [iwlmvm]
[ 7243.209852]  ieee80211_iter_keys+0x10e/0x380 [mac80211]

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9987172a9e01..d21143495e70 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -344,11 +344,12 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			const u8 *pn;
 
 			mvmsta = iwl_mvm_sta_from_mac80211(sta);
-			ptk_pn = rcu_dereference_protected(
-						mvmsta->ptk_pn[key->keyidx],
-						lockdep_is_held(&mvm->mutex));
-			if (WARN_ON(!ptk_pn))
+			rcu_read_lock();
+			ptk_pn = rcu_dereference(mvmsta->ptk_pn[key->keyidx]);
+			if (WARN_ON(!ptk_pn)) {
+				rcu_read_unlock();
 				break;
+			}
 
 			for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 				pn = iwl_mvm_find_max_pn(key, ptk_pn, &seq, i,
@@ -360,6 +361,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 							   ((u64)pn[1] << 32) |
 							   ((u64)pn[0] << 40));
 			}
+
+			rcu_read_unlock();
 		} else {
 			for (i = 0; i < IWL_NUM_RSC; i++) {
 				u8 *pn = seq.ccmp.pn;
@@ -1363,10 +1366,12 @@ static void iwl_mvm_set_aes_rx_seq(struct iwl_mvm *mvm, struct aes_sc *scs,
 
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		ptk_pn = rcu_dereference_protected(mvmsta->ptk_pn[key->keyidx],
-						   lockdep_is_held(&mvm->mutex));
-		if (WARN_ON(!ptk_pn))
+		rcu_read_lock();
+		ptk_pn = rcu_dereference(mvmsta->ptk_pn[key->keyidx]);
+		if (WARN_ON(!ptk_pn)) {
+			rcu_read_unlock();
 			return;
+		}
 
 		for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
 			struct ieee80211_key_seq seq = {};
@@ -1378,6 +1383,7 @@ static void iwl_mvm_set_aes_rx_seq(struct iwl_mvm *mvm, struct aes_sc *scs,
 				memcpy(ptk_pn->q[i].pn[tid],
 				       seq.ccmp.pn, IEEE80211_CCMP_PN_LEN);
 		}
+		rcu_read_unlock();
 	} else {
 		for (tid = 0; tid < IWL_NUM_RSC; tid++) {
 			struct ieee80211_key_seq seq = {};
-- 
2.28.0

