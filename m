Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C87334075
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhCJOjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:39:46 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:30118 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhCJOj2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:39:28 -0500
X-Greylist: delayed 7695 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 09:39:28 EST
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 7F5DD7B5FF;
        Wed, 10 Mar 2021 14:39:27 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZTq2qNDz3NsH;
        Wed, 10 Mar 2021 14:39:27 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 397971C3C;
        Wed, 10 Mar 2021 14:39:27 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 177808D4A156;
        Wed, 10 Mar 2021 14:39:24 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id D053CE707DE;
        Wed, 10 Mar 2021 14:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id dKaLEoe2mMi0; Wed, 10 Mar 2021 14:39:20 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id E718AE707B5;
        Wed, 10 Mar 2021 14:39:19 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:39:18 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iwlwifi: fix 'arithmetic on a pointer to
 void' errors
Message-ID: <alpine.BSF.2.00.2103101439010.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Compiling the code with clang on FreeBSD complains about:
   arithmetic on a pointer to void is a GNU extension
       [-Werror,-Wpointer-arith].
Cast to (u8 *) for the arithmetic operation and then back to
the requested type or apply () before casting to avoid errors
and have a defined behaviour.

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
changes since v1 - reduce diff context,
 		 - remove 3 unneeded casts reported by Kalle Valo
---
  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
  drivers/net/wireless/intel/iwlwifi/fw/paging.c | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/fw.c    | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/rx.c    | 4 ++--
  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 4 ++--
  drivers/net/wireless/intel/iwlwifi/mvm/scan.c  | 3 ++-
  drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 2 +-
  drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 2 +-
  drivers/net/wireless/intel/iwlwifi/queue/tx.c  | 8 +++++---
  drivers/net/wireless/intel/iwlwifi/queue/tx.h  | 2 +-
  10 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 504729663c35..f35295a17cb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1979,7 +1979,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
  				id, type);
  			goto out_err;
  		}
-		range = range + range_size;
+		range = (u8 *)range + range_size;
  	}

  	list_add_tail(&entry->list, list);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 4a8fe9641a32..78dab70de473 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -196,7 +196,7 @@ static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
  		}

  		memcpy(page_address(block->fw_paging_block),
-		       image->sec[sec_idx].data + offset, len);
+		       (const u8 *)image->sec[sec_idx].data + offset, len);
  		dma_sync_single_for_device(fwrt->trans->dev,
  					   block->fw_paging_phys,
  					   block->fw_paging_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 15e2773ce7e7..455e7ee95aae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -732,7 +732,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
  		mvm->nvm_data->bands[0].n_channels = 1;
  		mvm->nvm_data->bands[0].n_bitrates = 1;
  		mvm->nvm_data->bands[0].bitrates =
-			(void *)mvm->nvm_data->channels + 1;
+			(void *)(mvm->nvm_data->channels + 1);
  		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
  	}

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8ef5399ad9be..d779e5e19568 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -83,8 +83,8 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
  	fraglen = len - hdrlen;

  	if (fraglen) {
-		int offset = (void *)hdr + hdrlen -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + hdrlen -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);

  		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
  				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c21736f80c29..d6b4563e2393 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -193,8 +193,8 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
  	fraglen = len - headlen;

  	if (fraglen) {
-		int offset = (void *)hdr + headlen + pad_len -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + headlen + pad_len -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);

  		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
  				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index caf87f320094..729eafd5f9ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2032,7 +2032,8 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
  	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
  	struct iwl_scan_umac_chan_param *chan_param;
  	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
-	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
+	void *sec_part = (u8 *)cmd_data +
+		sizeof(struct iwl_scan_channel_cfg_umac) *
  		mvm->fw->ucode_capa.n_scan_channels;
  	struct iwl_scan_req_umac_tail_v2 *tail_v2 =
  		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 42426e25cac6..d910da26365a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -740,7 +740,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
  			goto err;
  	}

-	rxq->rb_stts = trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
+	rxq->rb_stts = (void *)((u8 *)trans_pcie->base_rb_stts + rxq->id * rb_stts_size);
  	rxq->rb_stts_dma =
  		trans_pcie->base_rb_stts_dma + rxq->id * rb_stts_size;

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 381e8f90b6f2..6fd4c68a4a49 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -154,7 +154,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
  	void *tfd;
  	u32 num_tbs;

-	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
+	tfd = (u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr;

  	if (reset)
  		memset(tfd, 0, trans->txqs.tfd.size);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 833f43d1ca7a..e4b1cf55dfb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -213,7 +213,8 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
  		return NULL;

  	/* set the chaining pointer to the previous page if there */
-	*(void **)(page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) =
+	    *page_ptr;
  	*page_ptr = ret;

  	return ret;
@@ -338,7 +339,8 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
  		return NULL;
  	p->pos = page_address(p->page);
  	/* set the chaining pointer to NULL */
-	*(void **)(page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) =
+	    NULL;
  out:
  	*page_ptr = p->page;
  	get_page(p->page);
@@ -992,7 +994,7 @@ void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
  	while (next) {
  		struct page *tmp = next;

-		next = *(void **)(page_address(next) + PAGE_SIZE -
+		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
  				  sizeof(void *));
  		__free_page(tmp);
  	}
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index af1dbdf5617a..939d439a2841 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -41,7 +41,7 @@ static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
  	if (trans->trans_cfg->use_tfh)
  		idx = iwl_txq_get_cmd_index(txq, idx);

-	return txq->tfds + trans->txqs.tfd.size * idx;
+	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
  }

  int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
