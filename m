Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2110F95B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 08:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLCH7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 02:59:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:63309 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfLCH7I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 02:59:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 23:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="242287254"
Received: from egrumbac-mobl1.jer.intel.com ([10.12.116.174])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2019 23:59:05 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] iwlwifi: mvm: don't send the IWL_MVM_RXQ_NSSN_SYNC notif to Rx queues
Date:   Tue,  3 Dec 2019 09:58:55 +0200
Message-Id: <20191203075855.5680-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120132628.30731-1-emmanuel.grumbach@intel.com>
References: <20191120132628.30731-1-emmanuel.grumbach@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The purpose of this was to keep all the queues updated with
the Rx sequence numbers because unlikely yet possible
situations where queues can't understand if a specific
packet needs to be dropped or not.

Unfortunately, it was reported that this caused issues in
our DMA engine. We don't fully understand how this is related,
but this is being currently debugged. For now, just don't send
this notification to the Rx queues. This de-facto reverts my
commit 3c514bf831ac12356b695ff054bef641b9e99593:

iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues

Use the regular constant infra we have to make it easy to
re-enable this mechanism when the firmware will be able to cope
with the DMA stall.

This issue was reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=204873
https://bugzilla.kernel.org/show_bug.cgi?id=205001
and others maybe.

Fixes: 3c514bf831ac ("iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues")
CC: <stable@vger.kernel.org> # 5.3+
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v2: fix an unused variable warning
v3: don't comment out the code
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 60aff2ecec12..58df25e2fb32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -154,5 +154,6 @@
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				false
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
+#define IWL_MVM_USE_NSSN_SYNC			0
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 75a7af5ad7b2..27d15fa6fe04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -514,14 +514,17 @@ static bool iwl_mvm_is_sn_less(u16 sn1, u16 sn2, u16 buffer_size)
 
 static void iwl_mvm_sync_nssn(struct iwl_mvm *mvm, u8 baid, u16 nssn)
 {
-	struct iwl_mvm_rss_sync_notif notif = {
-		.metadata.type = IWL_MVM_RXQ_NSSN_SYNC,
-		.metadata.sync = 0,
-		.nssn_sync.baid = baid,
-		.nssn_sync.nssn = nssn,
-	};
-
-	iwl_mvm_sync_rx_queues_internal(mvm, (void *)&notif, sizeof(notif));
+	if (IWL_MVM_USE_NSSN_SYNC)
+	{
+		struct iwl_mvm_rss_sync_notif notif = {
+			.metadata.type = IWL_MVM_RXQ_NSSN_SYNC,
+			.metadata.sync = 0,
+			.nssn_sync.baid = baid,
+			.nssn_sync.nssn = nssn,
+		};
+
+		iwl_mvm_sync_rx_queues_internal(mvm, (void *)&notif, sizeof(notif));
+	}
 }
 
 #define RX_REORDER_BUF_TIMEOUT_MQ (HZ / 10)
-- 
2.17.1

