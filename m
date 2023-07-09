Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196ED74C6F2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jul 2023 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGISNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGISNm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 14:13:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9FE1
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Q7M00LkQlBT0fmNN/54oNgCwtq1k18LxpHyE5CK8E+c=; t=1688926421; x=1690136021; 
        b=qNxJ4+aGASlF5yB10ZJJegp+6btd2eVWt2tz1xmaOmhe7xnsFJqOzLFEaHvvVfihHO3Xp9+AJzr
        7Lmpq6F9JxS8WuBXQl+Ls0SThv4UuAW6wOXGteIK6WNrJlQZIqCczQR0hAN/jbvzZL13zwrL1V8zM
        7n32UpSa8PEMP117QtjR1TM3ND/c8Y2Aj/2fjNV7ugZW1ZNYc6FNE/ZL+d7JcUAlQIUwF6yZEEX2D
        3TlMwdwALGc3Db3vS8UW7Lnv84+Uw+5HgW9A38t06Uy/GQ71VUapPXsX/lnEVATk3dsKv+mkBqozA
        iC2cZXzWpIFpop1cO/I6jk0iCLHP1nxM7VAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qIYud-00DnFG-1c;
        Sun, 09 Jul 2023 20:13:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jeff Chua <jeff.chua.linux@gmail.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: [RFC PATCH] wifi: iwlwifi: remove 'use_tfh' config to fix crash
Date:   Sun,  9 Jul 2023 20:13:24 +0200
Message-ID: <20230709181323.12085-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is equivalent to 'gen2', and it's confusing to have two
of the same configs. The split config patch actually had been
originally developed after this, and didn't add the use_tfh
in the new configs because they were copied to the new files
after ...

There's clearly still an unwind error in iwl_txq_gen2_init()
since it crashes if something fails there, but the reason it
fails in the first place is due to the gen2/use_tfh confusion.

Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
Reported-by: "Zhang, Rui" <rui.zhang@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217622
Link: https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.camel@xry111.site/
Link: https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2BmV%3DAKoECZM%2BsQ@mail.gmail.com/
Fixes: 19898ce9cf8a ("wifi: iwlwifi: split 22000.c into multiple files")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  |  5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h     |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c  |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c   | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h   |  8 ++++----
 9 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index aa4320ca4c30..d594694206b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -84,7 +84,6 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 	.mac_addr_from_csr = 0x380,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.trans.use_tfh = true,						\
 	.trans.rf_id = true,						\
 	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
@@ -122,7 +121,6 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 
 const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.mq_rx_supported = true,
-	.use_tfh = true,
 	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
@@ -134,7 +132,6 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 
 const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg = {
 	.mq_rx_supported = true,
-	.use_tfh = true,
 	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
@@ -146,7 +143,6 @@ const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg = {
 
 const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.mq_rx_supported = true,
-	.use_tfh = true,
 	.rf_id = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
@@ -200,7 +196,6 @@ const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
 	.mq_rx_supported = true,
-	.use_tfh = true,
 	.rf_id = true,
 	.gen2 = true,
 	.bisr_workaround = 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 742096c5a36a..241a9e3f2a1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -256,7 +256,6 @@ enum iwl_cfg_trans_ltr_delay {
  * @xtal_latency: power up latency to get the xtal stabilized
  * @extra_phy_cfg_flags: extra configuration flags to pass to the PHY
  * @rf_id: need to read rf_id to determine the firmware image
- * @use_tfh: use TFH
  * @gen2: 22000 and on transport operation
  * @mq_rx_supported: multi-queue rx support
  * @integrated: discrete or integrated
@@ -271,7 +270,6 @@ struct iwl_cfg_trans_params {
 	u32 xtal_latency;
 	u32 extra_phy_cfg_flags;
 	u32 rf_id:1,
-	    use_tfh:1,
 	    gen2:1,
 	    mq_rx_supported:1,
 	    integrated:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index bedd78a47f67..4e4a60ddf9b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fh_h__
@@ -71,7 +71,7 @@
 static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 					     unsigned int chnl)
 {
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		WARN_ON_ONCE(chnl >= 64);
 		return TFH_TFDQ_CBB_TABLE + 8 * chnl;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index b1af9359cea5..4bd759432d44 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2021, 2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -42,7 +42,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 	WARN_ON(!ops->wait_txq_empty && !ops->wait_tx_queues_empty);
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		trans->txqs.tfd.addr_size = 64;
 		trans->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
 		trans->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
@@ -101,7 +101,7 @@ int iwl_trans_init(struct iwl_trans *trans)
 
 	/* Some things must not change even if the config does */
 	WARN_ON(trans->txqs.tfd.addr_size !=
-		(trans->trans_cfg->use_tfh ? 64 : 36));
+		(trans->trans_cfg->gen2 ? 64 : 36));
 
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b83df0631279..b18c91c5dd5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1450,7 +1450,7 @@ static inline bool iwl_mvm_has_new_station_api(const struct iwl_fw *fw)
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
-	return mvm->trans->trans_cfg->use_tfh;
+	return mvm->trans->trans_cfg->gen2;
 }
 
 static inline bool iwl_mvm_has_unified_ucode(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index eacbbdbffb5e..3e988da44973 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -819,7 +819,7 @@ static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
 
 	iwl_enable_interrupts(trans);
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		if (cpu == 1)
 			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
 				       0xFFFF);
@@ -3394,7 +3394,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 			u8 tfdidx;
 			u32 caplen, cmdlen;
 
-			if (trans->trans_cfg->use_tfh)
+			if (trans->trans_cfg->gen2)
 				tfdidx = idx;
 			else
 				tfdidx = ptr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 1337fa95f657..790e5b124740 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -364,7 +364,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		struct iwl_txq *txq = trans->txqs.txq[txq_id];
-		if (trans->trans_cfg->use_tfh)
+		if (trans->trans_cfg->gen2)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
 					   txq->dma_addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index fbacbe9ada15..5bb3cc3367c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -985,7 +985,7 @@ void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 	bool active;
 	u8 fifo;
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
 			txq->read_ptr, txq->write_ptr);
 		/* TODO: access new SCD registers and dump them */
@@ -1040,7 +1040,7 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	if (WARN_ON(txq->entries || txq->tfds))
 		return -EINVAL;
 
-	if (trans->trans_cfg->use_tfh)
+	if (trans->trans_cfg->gen2)
 		tfd_sz = trans->txqs.tfd.size * slots_num;
 
 	timer_setup(&txq->stuck_timer, iwl_txq_stuck_timer, 0);
@@ -1347,7 +1347,7 @@ static inline dma_addr_t iwl_txq_gen1_tfd_tb_get_addr(struct iwl_trans *trans,
 	dma_addr_t addr;
 	dma_addr_t hi_len;
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		struct iwl_tfh_tfd *tfh_tfd = _tfd;
 		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
 
@@ -1408,7 +1408,7 @@ void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 
 	meta->tbs = 0;
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 
 		tfd_fh->num_tbs = 0;
@@ -1625,7 +1625,7 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 		txq->entries[read_ptr].skb = NULL;
 
-		if (!trans->trans_cfg->use_tfh)
+		if (!trans->trans_cfg->gen2)
 			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
 
 		iwl_txq_free_tfd(trans, txq);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index eca53bfd326d..1e4a24ab9bab 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020-2022 Intel Corporation
+ * Copyright (C) 2020-2023 Intel Corporation
  */
 #ifndef __iwl_trans_queue_tx_h__
 #define __iwl_trans_queue_tx_h__
@@ -38,7 +38,7 @@ static inline void iwl_wake_queue(struct iwl_trans *trans,
 static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
 				    struct iwl_txq *txq, int idx)
 {
-	if (trans->trans_cfg->use_tfh)
+	if (trans->trans_cfg->gen2)
 		idx = iwl_txq_get_cmd_index(txq, idx);
 
 	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
@@ -135,7 +135,7 @@ static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_trans *trans,
 {
 	struct iwl_tfd *tfd;
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		struct iwl_tfh_tfd *tfh_tfd = _tfd;
 
 		return le16_to_cpu(tfh_tfd->num_tbs) & 0x1f;
@@ -151,7 +151,7 @@ static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
 	struct iwl_tfd *tfd;
 	struct iwl_tfd_tb *tb;
 
-	if (trans->trans_cfg->use_tfh) {
+	if (trans->trans_cfg->gen2) {
 		struct iwl_tfh_tfd *tfh_tfd = _tfd;
 		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
 
-- 
2.41.0

