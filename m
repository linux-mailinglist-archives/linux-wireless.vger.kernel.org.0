Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A3265E7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBZQy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZQyZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:54:25 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDCC061786
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:53:36 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 314367627D;
        Fri, 26 Feb 2021 16:53:36 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnG280VNpz4YF1;
        Fri, 26 Feb 2021 16:53:36 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id CD0D125D1;
        Fri, 26 Feb 2021 16:53:35 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 7F9DC8D4A170;
        Fri, 26 Feb 2021 16:53:34 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id EE8CFE707D9;
        Fri, 26 Feb 2021 16:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id wXoGBs5bo99W; Fri, 26 Feb 2021 16:53:26 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 6A691E707FE;
        Fri, 26 Feb 2021 16:53:26 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:53:25 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iwlwifi: de-const properly where needed
Message-ID: <alpine.BSF.2.00.2102261652510.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to de-const variables simply casting through (void *) is
not enough: "cast from 'const .. *' to 'void *' drops const qualifier".
Cast through (uintptr_t) as well [1] to make this compile on systems
with more strict requirements.
In addition passing const void *data to dma_map_single() also
drops the (const) qualifier.  De-constify on variable on assignment
which may be overwritten later.  In either case the (void *) cast
to dma_map_single() is not needed (anymore) either.

[1] See __DECONST() in sys/sys/cdefs.h in FreeBSD

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 4 ++--
  drivers/net/wireless/intel/iwlwifi/pcie/tx.c      | 4 ++--
  4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index baf7404c137d..3cad9c1d6814 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3024,32 +3024,32 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
  static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
  					       struct ieee80211_vif *vif)
  {
  	struct ieee80211_supported_band *sband;
  	const struct ieee80211_sta_he_cap *he_cap;

  	if (vif->type != NL80211_IFTYPE_STATION)
  		return;

  	if (!mvm->cca_40mhz_workaround)
  		return;

  	/* decrement and check that we reached zero */
  	mvm->cca_40mhz_workaround--;
  	if (mvm->cca_40mhz_workaround)
  		return;

  	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];

  	sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;

  	he_cap = ieee80211_get_he_iftype_cap(sband,
  					     ieee80211_vif_type_p2p(vif));

  	if (he_cap) {
  		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;

  		he->he_cap_elem.phy_cap_info[0] |=
  			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
  	}
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ebed82c590e5..e79ca96e5844 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -149,74 +149,74 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
  static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
  				     struct iwl_rx_cmd_buffer *rxb)
  {
  	struct iwl_rx_packet *pkt = rxb_addr(rxb);
  	struct iwl_datapath_monitor_notif *notif = (void *)pkt->data;
  	struct ieee80211_supported_band *sband;
  	const struct ieee80211_sta_he_cap *he_cap;
  	struct ieee80211_vif *vif;

  	if (notif->type != cpu_to_le32(IWL_DP_MON_NOTIF_TYPE_EXT_CCA))
  		return;

  	vif = iwl_mvm_get_vif_by_macid(mvm, notif->mac_id);
  	if (!vif || vif->type != NL80211_IFTYPE_STATION)
  		return;

  	if (!vif->bss_conf.chandef.chan ||
  	    vif->bss_conf.chandef.chan->band != NL80211_BAND_2GHZ ||
  	    vif->bss_conf.chandef.width < NL80211_CHAN_WIDTH_40)
  		return;

  	if (!vif->bss_conf.assoc)
  		return;

  	/* this shouldn't happen *again*, ignore it */
  	if (mvm->cca_40mhz_workaround)
  		return;

  	/*
  	 * We'll decrement this on disconnect - so set to 2 since we'll
  	 * still have to disconnect from the current AP first.
  	 */
  	mvm->cca_40mhz_workaround = 2;

  	/*
  	 * This capability manipulation isn't really ideal, but it's the
  	 * easiest choice - otherwise we'd have to do some major changes
  	 * in mac80211 to support this, which isn't worth it. This does
  	 * mean that userspace may have outdated information, but that's
  	 * actually not an issue at all.
  	 */
  	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];

  	WARN_ON(!sband->ht_cap.ht_supported);
  	WARN_ON(!(sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40));
  	sband->ht_cap.cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;

  	he_cap = ieee80211_get_he_iftype_cap(sband,
  					     ieee80211_vif_type_p2p(vif));

  	if (he_cap) {
  		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;

  		WARN_ON(!he->has_he);
  		WARN_ON(!(he->he_cap_elem.phy_cap_info[0] &
  				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G));
  		he->he_cap_elem.phy_cap_info[0] &=
  			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
  	}

  	ieee80211_disconnect(vif, true);
  }

  /**
   * enum iwl_rx_handler_context context for Rx handler
   * @RX_HANDLER_SYNC : this means that it will be called in the Rx path
   *	which can't acquire mvm->mutex.
   * @RX_HANDLER_ASYNC_LOCKED : If the handler needs to hold mvm->mutex
   *	(and only in this case!), it should be set as ASYNC. In that case,
   *	it will be called from a worker with mvm->mutex held.
   * @RX_HANDLER_ASYNC_UNLOCKED : in case the handler needs to lock the
   *	mutex itself, it will be called from a worker without mvm->mutex held.
   */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4456abb9a074..afd3e69d629b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -18,241 +18,241 @@
  /*
   * iwl_pcie_gen2_enqueue_hcmd - enqueue a uCode command
   * @priv: device private data point
   * @cmd: a pointer to the ucode command structure
   *
   * The function returns < 0 values to indicate the operation
   * failed. On success, it returns the index (>= 0) of command in the
   * command queue.
   */
  int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
  			       struct iwl_host_cmd *cmd)
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
  	struct iwl_device_cmd *out_cmd;
  	struct iwl_cmd_meta *out_meta;
  	void *dup_buf = NULL;
  	dma_addr_t phys_addr;
  	int i, cmd_pos, idx;
  	u16 copy_size, cmd_size, tb0_size;
  	bool had_nocopy = false;
  	u8 group_id = iwl_cmd_groupid(cmd->id);
  	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
  	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
  	struct iwl_tfh_tfd *tfd;

  	copy_size = sizeof(struct iwl_cmd_header_wide);
  	cmd_size = sizeof(struct iwl_cmd_header_wide);

  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
  		cmddata[i] = cmd->data[i];
  		cmdlen[i] = cmd->len[i];

  		if (!cmd->len[i])
  			continue;

  		/* need at least IWL_FIRST_TB_SIZE copied */
  		if (copy_size < IWL_FIRST_TB_SIZE) {
  			int copy = IWL_FIRST_TB_SIZE - copy_size;

  			if (copy > cmdlen[i])
  				copy = cmdlen[i];
  			cmdlen[i] -= copy;
  			cmddata[i] += copy;
  			copy_size += copy;
  		}

  		if (cmd->dataflags[i] & IWL_HCMD_DFL_NOCOPY) {
  			had_nocopy = true;
  			if (WARN_ON(cmd->dataflags[i] & IWL_HCMD_DFL_DUP)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}
  		} else if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP) {
  			/*
  			 * This is also a chunk that isn't copied
  			 * to the static buffer so set had_nocopy.
  			 */
  			had_nocopy = true;

  			/* only allowed once */
  			if (WARN_ON(dup_buf)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}

  			dup_buf = kmemdup(cmddata[i], cmdlen[i],
  					  GFP_ATOMIC);
  			if (!dup_buf)
  				return -ENOMEM;
  		} else {
  			/* NOCOPY must not be followed by normal! */
  			if (WARN_ON(had_nocopy)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}
  			copy_size += cmdlen[i];
  		}
  		cmd_size += cmd->len[i];
  	}

  	/*
  	 * If any of the command structures end up being larger than the
  	 * TFD_MAX_PAYLOAD_SIZE and they aren't dynamically allocated into
  	 * separate TFDs, then we will need to increase the size of the buffers
  	 */
  	if (WARN(copy_size > TFD_MAX_PAYLOAD_SIZE,
  		 "Command %s (%#x) is too large (%d bytes)\n",
  		 iwl_get_cmd_string(trans, cmd->id), cmd->id, copy_size)) {
  		idx = -EINVAL;
  		goto free_dup_buf;
  	}

  	spin_lock_bh(&txq->lock);

  	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
  	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
  	memset(tfd, 0, sizeof(*tfd));

  	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
  		spin_unlock_bh(&txq->lock);

  		IWL_ERR(trans, "No space in command queue\n");
  		iwl_op_mode_cmd_queue_full(trans->op_mode);
  		idx = -ENOSPC;
  		goto free_dup_buf;
  	}

  	out_cmd = txq->entries[idx].cmd;
  	out_meta = &txq->entries[idx].meta;

  	/* re-initialize to NULL */
  	memset(out_meta, 0, sizeof(*out_meta));
  	if (cmd->flags & CMD_WANT_SKB)
  		out_meta->source = cmd;

  	/* set up the header */
  	out_cmd->hdr_wide.cmd = iwl_cmd_opcode(cmd->id);
  	out_cmd->hdr_wide.group_id = group_id;
  	out_cmd->hdr_wide.version = iwl_cmd_version(cmd->id);
  	out_cmd->hdr_wide.length =
  		cpu_to_le16(cmd_size - sizeof(struct iwl_cmd_header_wide));
  	out_cmd->hdr_wide.reserved = 0;
  	out_cmd->hdr_wide.sequence =
  		cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
  					 INDEX_TO_SEQ(txq->write_ptr));

  	cmd_pos = sizeof(struct iwl_cmd_header_wide);
  	copy_size = sizeof(struct iwl_cmd_header_wide);

  	/* and copy the data that needs to be copied */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
  		int copy;

  		if (!cmd->len[i])
  			continue;

  		/* copy everything if not nocopy/dup */
  		if (!(cmd->dataflags[i] & (IWL_HCMD_DFL_NOCOPY |
  					   IWL_HCMD_DFL_DUP))) {
  			copy = cmd->len[i];

  			memcpy((u8 *)out_cmd + cmd_pos, cmd->data[i], copy);
  			cmd_pos += copy;
  			copy_size += copy;
  			continue;
  		}

  		/*
  		 * Otherwise we need at least IWL_FIRST_TB_SIZE copied
  		 * in total (for bi-directional DMA), but copy up to what
  		 * we can fit into the payload for debug dump purposes.
  		 */
  		copy = min_t(int, TFD_MAX_PAYLOAD_SIZE - cmd_pos, cmd->len[i]);

  		memcpy((u8 *)out_cmd + cmd_pos, cmd->data[i], copy);
  		cmd_pos += copy;

  		/* However, treat copy_size the proper way, we need it below */
  		if (copy_size < IWL_FIRST_TB_SIZE) {
  			copy = IWL_FIRST_TB_SIZE - copy_size;

  			if (copy > cmd->len[i])
  				copy = cmd->len[i];
  			copy_size += copy;
  		}
  	}

  	IWL_DEBUG_HC(trans,
  		     "Sending command %s (%.2x.%.2x), seq: 0x%04X, %d bytes at %d[%d]:%d\n",
  		     iwl_get_cmd_string(trans, cmd->id), group_id,
  		     out_cmd->hdr.cmd, le16_to_cpu(out_cmd->hdr.sequence),
  		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);

  	/* start the TFD with the minimum copy bytes */
  	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
  	memcpy(&txq->first_tb_bufs[idx], out_cmd, tb0_size);
  	iwl_txq_gen2_set_tb(trans, tfd, iwl_txq_get_first_tb_dma(txq, idx),
  			    tb0_size);

  	/* map first command fragment, if any remains */
  	if (copy_size > tb0_size) {
  		phys_addr = dma_map_single(trans->dev,
  					   (u8 *)out_cmd + tb0_size,
  					   copy_size - tb0_size,
  					   DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			idx = -ENOMEM;
  			iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
  			goto out;
  		}
  		iwl_txq_gen2_set_tb(trans, tfd, phys_addr,
  				    copy_size - tb0_size);
  	}

  	/* map the remaining (adjusted) nocopy/dup fragments */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];

  		if (!cmdlen[i])
  			continue;
  		if (!(cmd->dataflags[i] & (IWL_HCMD_DFL_NOCOPY |
  					   IWL_HCMD_DFL_DUP)))
  			continue;
  		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
  			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
  					   cmdlen[i], DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			idx = -ENOMEM;
  			iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
  			goto out;
  		}
  		iwl_txq_gen2_set_tb(trans, tfd, phys_addr, cmdlen[i]);
  	}

  	BUILD_BUG_ON(IWL_TFH_NUM_TBS > sizeof(out_meta->tbs) * BITS_PER_BYTE);
  	out_meta->flags = cmd->flags;
  	if (WARN_ON_ONCE(txq->entries[idx].free_buf))
  		kfree_sensitive(txq->entries[idx].free_buf);
  	txq->entries[idx].free_buf = dup_buf;

  	trace_iwlwifi_dev_hcmd(trans->dev, cmd, cmd_size, &out_cmd->hdr_wide);

  	/* start timer if queue currently empty */
  	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
  		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);

  	spin_lock(&trans_pcie->reg_lock);
  	/* Increment and update queue's write index */
  	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
  	iwl_txq_inc_wr_ptr(trans, txq);
  	spin_unlock(&trans_pcie->reg_lock);

  out:
  	spin_unlock_bh(&txq->lock);
  free_dup_buf:
  	if (idx < 0)
  		kfree(dup_buf);
  	return idx;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 6e02c8b294ac..e9997055f934 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -905,283 +905,283 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
  /*
   * iwl_pcie_enqueue_hcmd - enqueue a uCode command
   * @priv: device private data point
   * @cmd: a pointer to the ucode command structure
   *
   * The function returns < 0 values to indicate the operation
   * failed. On success, it returns the index (>= 0) of command in the
   * command queue.
   */
  int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
  			  struct iwl_host_cmd *cmd)
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
  	struct iwl_device_cmd *out_cmd;
  	struct iwl_cmd_meta *out_meta;
  	void *dup_buf = NULL;
  	dma_addr_t phys_addr;
  	int idx;
  	u16 copy_size, cmd_size, tb0_size;
  	bool had_nocopy = false;
  	u8 group_id = iwl_cmd_groupid(cmd->id);
  	int i, ret;
  	u32 cmd_pos;
  	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
  	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];

  	if (WARN(!trans->wide_cmd_header &&
  		 group_id > IWL_ALWAYS_LONG_GROUP,
  		 "unsupported wide command %#x\n", cmd->id))
  		return -EINVAL;

  	if (group_id != 0) {
  		copy_size = sizeof(struct iwl_cmd_header_wide);
  		cmd_size = sizeof(struct iwl_cmd_header_wide);
  	} else {
  		copy_size = sizeof(struct iwl_cmd_header);
  		cmd_size = sizeof(struct iwl_cmd_header);
  	}

  	/* need one for the header if the first is NOCOPY */
  	BUILD_BUG_ON(IWL_MAX_CMD_TBS_PER_TFD > IWL_NUM_OF_TBS - 1);

  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
  		cmddata[i] = cmd->data[i];
  		cmdlen[i] = cmd->len[i];

  		if (!cmd->len[i])
  			continue;

  		/* need at least IWL_FIRST_TB_SIZE copied */
  		if (copy_size < IWL_FIRST_TB_SIZE) {
  			int copy = IWL_FIRST_TB_SIZE - copy_size;

  			if (copy > cmdlen[i])
  				copy = cmdlen[i];
  			cmdlen[i] -= copy;
  			cmddata[i] += copy;
  			copy_size += copy;
  		}

  		if (cmd->dataflags[i] & IWL_HCMD_DFL_NOCOPY) {
  			had_nocopy = true;
  			if (WARN_ON(cmd->dataflags[i] & IWL_HCMD_DFL_DUP)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}
  		} else if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP) {
  			/*
  			 * This is also a chunk that isn't copied
  			 * to the static buffer so set had_nocopy.
  			 */
  			had_nocopy = true;

  			/* only allowed once */
  			if (WARN_ON(dup_buf)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}

  			dup_buf = kmemdup(cmddata[i], cmdlen[i],
  					  GFP_ATOMIC);
  			if (!dup_buf)
  				return -ENOMEM;
  		} else {
  			/* NOCOPY must not be followed by normal! */
  			if (WARN_ON(had_nocopy)) {
  				idx = -EINVAL;
  				goto free_dup_buf;
  			}
  			copy_size += cmdlen[i];
  		}
  		cmd_size += cmd->len[i];
  	}

  	/*
  	 * If any of the command structures end up being larger than
  	 * the TFD_MAX_PAYLOAD_SIZE and they aren't dynamically
  	 * allocated into separate TFDs, then we will need to
  	 * increase the size of the buffers.
  	 */
  	if (WARN(copy_size > TFD_MAX_PAYLOAD_SIZE,
  		 "Command %s (%#x) is too large (%d bytes)\n",
  		 iwl_get_cmd_string(trans, cmd->id),
  		 cmd->id, copy_size)) {
  		idx = -EINVAL;
  		goto free_dup_buf;
  	}

  	spin_lock_bh(&txq->lock);

  	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
  		spin_unlock_bh(&txq->lock);

  		IWL_ERR(trans, "No space in command queue\n");
  		iwl_op_mode_cmd_queue_full(trans->op_mode);
  		idx = -ENOSPC;
  		goto free_dup_buf;
  	}

  	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
  	out_cmd = txq->entries[idx].cmd;
  	out_meta = &txq->entries[idx].meta;

  	memset(out_meta, 0, sizeof(*out_meta));	/* re-initialize to NULL */
  	if (cmd->flags & CMD_WANT_SKB)
  		out_meta->source = cmd;

  	/* set up the header */
  	if (group_id != 0) {
  		out_cmd->hdr_wide.cmd = iwl_cmd_opcode(cmd->id);
  		out_cmd->hdr_wide.group_id = group_id;
  		out_cmd->hdr_wide.version = iwl_cmd_version(cmd->id);
  		out_cmd->hdr_wide.length =
  			cpu_to_le16(cmd_size -
  				    sizeof(struct iwl_cmd_header_wide));
  		out_cmd->hdr_wide.reserved = 0;
  		out_cmd->hdr_wide.sequence =
  			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
  						 INDEX_TO_SEQ(txq->write_ptr));

  		cmd_pos = sizeof(struct iwl_cmd_header_wide);
  		copy_size = sizeof(struct iwl_cmd_header_wide);
  	} else {
  		out_cmd->hdr.cmd = iwl_cmd_opcode(cmd->id);
  		out_cmd->hdr.sequence =
  			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
  						 INDEX_TO_SEQ(txq->write_ptr));
  		out_cmd->hdr.group_id = 0;

  		cmd_pos = sizeof(struct iwl_cmd_header);
  		copy_size = sizeof(struct iwl_cmd_header);
  	}

  	/* and copy the data that needs to be copied */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
  		int copy;

  		if (!cmd->len[i])
  			continue;

  		/* copy everything if not nocopy/dup */
  		if (!(cmd->dataflags[i] & (IWL_HCMD_DFL_NOCOPY |
  					   IWL_HCMD_DFL_DUP))) {
  			copy = cmd->len[i];

  			memcpy((u8 *)out_cmd + cmd_pos, cmd->data[i], copy);
  			cmd_pos += copy;
  			copy_size += copy;
  			continue;
  		}

  		/*
  		 * Otherwise we need at least IWL_FIRST_TB_SIZE copied
  		 * in total (for bi-directional DMA), but copy up to what
  		 * we can fit into the payload for debug dump purposes.
  		 */
  		copy = min_t(int, TFD_MAX_PAYLOAD_SIZE - cmd_pos, cmd->len[i]);

  		memcpy((u8 *)out_cmd + cmd_pos, cmd->data[i], copy);
  		cmd_pos += copy;

  		/* However, treat copy_size the proper way, we need it below */
  		if (copy_size < IWL_FIRST_TB_SIZE) {
  			copy = IWL_FIRST_TB_SIZE - copy_size;

  			if (copy > cmd->len[i])
  				copy = cmd->len[i];
  			copy_size += copy;
  		}
  	}

  	IWL_DEBUG_HC(trans,
  		     "Sending command %s (%.2x.%.2x), seq: 0x%04X, %d bytes at %d[%d]:%d\n",
  		     iwl_get_cmd_string(trans, cmd->id),
  		     group_id, out_cmd->hdr.cmd,
  		     le16_to_cpu(out_cmd->hdr.sequence),
  		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);

  	/* start the TFD with the minimum copy bytes */
  	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
  	memcpy(&txq->first_tb_bufs[idx], &out_cmd->hdr, tb0_size);
  	iwl_pcie_txq_build_tfd(trans, txq,
  			       iwl_txq_get_first_tb_dma(txq, idx),
  			       tb0_size, true);

  	/* map first command fragment, if any remains */
  	if (copy_size > tb0_size) {
  		phys_addr = dma_map_single(trans->dev,
  					   ((u8 *)&out_cmd->hdr) + tb0_size,
  					   copy_size - tb0_size,
  					   DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,
  					       txq->write_ptr);
  			idx = -ENOMEM;
  			goto out;
  		}

  		iwl_pcie_txq_build_tfd(trans, txq, phys_addr,
  				       copy_size - tb0_size, false);
  	}

  	/* map the remaining (adjusted) nocopy/dup fragments */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];

  		if (!cmdlen[i])
  			continue;
  		if (!(cmd->dataflags[i] & (IWL_HCMD_DFL_NOCOPY |
  					   IWL_HCMD_DFL_DUP)))
  			continue;
  		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
  			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
  					   cmdlen[i], DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,
  					       txq->write_ptr);
  			idx = -ENOMEM;
  			goto out;
  		}

  		iwl_pcie_txq_build_tfd(trans, txq, phys_addr, cmdlen[i], false);
  	}

  	BUILD_BUG_ON(IWL_TFH_NUM_TBS > sizeof(out_meta->tbs) * BITS_PER_BYTE);
  	out_meta->flags = cmd->flags;
  	if (WARN_ON_ONCE(txq->entries[idx].free_buf))
  		kfree_sensitive(txq->entries[idx].free_buf);
  	txq->entries[idx].free_buf = dup_buf;

  	trace_iwlwifi_dev_hcmd(trans->dev, cmd, cmd_size, &out_cmd->hdr_wide);

  	/* start timer if queue currently empty */
  	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
  		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);

  	spin_lock(&trans_pcie->reg_lock);
  	ret = iwl_pcie_set_cmd_in_flight(trans, cmd);
  	if (ret < 0) {
  		idx = ret;
  		goto unlock_reg;
  	}

  	/* Increment and update queue's write index */
  	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
  	iwl_pcie_txq_inc_wr_ptr(trans, txq);

   unlock_reg:
  	spin_unlock(&trans_pcie->reg_lock);
   out:
  	spin_unlock_bh(&txq->lock);
   free_dup_buf:
  	if (idx < 0)
  		kfree(dup_buf);
  	return idx;
  }

  /*
   * iwl_pcie_hcmd_complete - Pull unused buffers off the queue and reclaim them
   * @rxb: Rx buffer to reclaim
   */
