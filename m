Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D312B3265E8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZQyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZQye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:54:34 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C4C061574
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:53:51 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 3CFD576273;
        Fri, 26 Feb 2021 16:52:20 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnG0h0dXjz4Y7q;
        Fri, 26 Feb 2021 16:52:20 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id B202E242D;
        Fri, 26 Feb 2021 16:52:19 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 2FCCC8D4A169;
        Fri, 26 Feb 2021 16:52:18 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id BBA7FE707FE;
        Fri, 26 Feb 2021 16:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id IVhNjfenOFKV; Fri, 26 Feb 2021 16:52:08 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 04039E707D9;
        Fri, 26 Feb 2021 16:52:07 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:52:07 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iwlwifi: fix 'arithmetic on a pointer to void'
 errors
Message-ID: <alpine.BSF.2.00.2102261651340.72241@ai.fobar.qr>
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

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
  drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
  drivers/net/wireless/intel/iwlwifi/fw/paging.c | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/fw.c    | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/rx.c    | 4 ++--
  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 4 ++--
  drivers/net/wireless/intel/iwlwifi/mvm/scan.c  | 5 +++--
  drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 2 +-
  drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 2 +-
  drivers/net/wireless/intel/iwlwifi/queue/tx.c  | 8 +++++---
  drivers/net/wireless/intel/iwlwifi/queue/tx.h  | 2 +-
  10 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 504729663c35..84d9d4629e79 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1913,81 +1913,81 @@ struct iwl_dump_ini_mem_ops {
  /**
   * iwl_dump_ini_mem
   *
   * Creates a dump tlv and copy a memory region into it.
   * Returns the size of the current dump tlv or 0 if failed
   *
   * @fwrt: fw runtime struct
   * @list: list to add the dump tlv to
   * @reg_data: memory region
   * @ops: memory dump operations
   */
  static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
  			    struct iwl_dump_ini_region_data *reg_data,
  			    const struct iwl_dump_ini_mem_ops *ops)
  {
  	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
  	struct iwl_fw_ini_dump_entry *entry;
  	struct iwl_fw_error_dump_data *tlv;
  	struct iwl_fw_ini_error_dump_header *header;
  	u32 type = le32_to_cpu(reg->type), id = le32_to_cpu(reg->id);
  	u32 num_of_ranges, i, size;
  	void *range;

  	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
  	    !ops->fill_range)
  		return 0;

  	size = ops->get_size(fwrt, reg_data);
  	if (!size)
  		return 0;

  	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + size);
  	if (!entry)
  		return 0;

  	entry->size = sizeof(*tlv) + size;

  	tlv = (void *)entry->data;
  	tlv->type = reg->type;
  	tlv->len = cpu_to_le32(size);

  	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
  		     type);

  	num_of_ranges = ops->get_num_of_ranges(fwrt, reg_data);

  	header = (void *)tlv->data;
  	header->region_id = reg->id;
  	header->num_of_ranges = cpu_to_le32(num_of_ranges);
  	header->name_len = cpu_to_le32(IWL_FW_INI_MAX_NAME);
  	memcpy(header->name, reg->name, IWL_FW_INI_MAX_NAME);

  	range = ops->fill_mem_hdr(fwrt, reg_data, header);
  	if (!range) {
  		IWL_ERR(fwrt,
  			"WRT: Failed to fill region header: id=%d, type=%d\n",
  			id, type);
  		goto out_err;
  	}

  	for (i = 0; i < num_of_ranges; i++) {
  		int range_size = ops->fill_range(fwrt, reg_data, range, i);

  		if (range_size < 0) {
  			IWL_ERR(fwrt,
  				"WRT: Failed to dump region: id=%d, type=%d\n",
  				id, type);
  			goto out_err;
  		}
-		range = range + range_size;
+		range = (void *)((u8 *)range + range_size);
  	}

  	list_add_tail(&entry->list, list);

  	return entry->size;

  out_err:
  	vfree(entry);

  	return 0;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 4a8fe9641a32..78dab70de473 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -108,110 +108,110 @@ static int iwl_alloc_fw_paging_mem(struct iwl_fw_runtime *fwrt,
  static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
  			       const struct fw_img *image)
  {
  	int sec_idx, idx, ret;
  	u32 offset = 0;

  	/*
  	 * find where is the paging image start point:
  	 * if CPU2 exist and it's in paging format, then the image looks like:
  	 * CPU1 sections (2 or more)
  	 * CPU1_CPU2_SEPARATOR_SECTION delimiter - separate between CPU1 to CPU2
  	 * CPU2 sections (not paged)
  	 * PAGING_SEPARATOR_SECTION delimiter - separate between CPU2
  	 * non paged to CPU2 paging sec
  	 * CPU2 paging CSS
  	 * CPU2 paging image (including instruction and data)
  	 */
  	for (sec_idx = 0; sec_idx < image->num_sec; sec_idx++) {
  		if (image->sec[sec_idx].offset == PAGING_SEPARATOR_SECTION) {
  			sec_idx++;
  			break;
  		}
  	}

  	/*
  	 * If paging is enabled there should be at least 2 more sections left
  	 * (one for CSS and one for Paging data)
  	 */
  	if (sec_idx >= image->num_sec - 1) {
  		IWL_ERR(fwrt, "Paging: Missing CSS and/or paging sections\n");
  		ret = -EINVAL;
  		goto err;
  	}

  	/* copy the CSS block to the dram */
  	IWL_DEBUG_FW(fwrt, "Paging: load paging CSS to FW, sec = %d\n",
  		     sec_idx);

  	if (image->sec[sec_idx].len > fwrt->fw_paging_db[0].fw_paging_size) {
  		IWL_ERR(fwrt, "CSS block is larger than paging size\n");
  		ret = -EINVAL;
  		goto err;
  	}

  	memcpy(page_address(fwrt->fw_paging_db[0].fw_paging_block),
  	       image->sec[sec_idx].data,
  	       image->sec[sec_idx].len);
  	dma_sync_single_for_device(fwrt->trans->dev,
  				   fwrt->fw_paging_db[0].fw_paging_phys,
  				   fwrt->fw_paging_db[0].fw_paging_size,
  				   DMA_BIDIRECTIONAL);

  	IWL_DEBUG_FW(fwrt,
  		     "Paging: copied %d CSS bytes to first block\n",
  		     fwrt->fw_paging_db[0].fw_paging_size);

  	sec_idx++;

  	/*
  	 * Copy the paging blocks to the dram.  The loop index starts
  	 * from 1 since the CSS block (index 0) was already copied to
  	 * dram.  We use num_of_paging_blk + 1 to account for that.
  	 */
  	for (idx = 1; idx < fwrt->num_of_paging_blk + 1; idx++) {
  		struct iwl_fw_paging *block = &fwrt->fw_paging_db[idx];
  		int remaining = image->sec[sec_idx].len - offset;
  		int len = block->fw_paging_size;

  		/*
  		 * For the last block, we copy all that is remaining,
  		 * for all other blocks, we copy fw_paging_size at a
  		 * time. */
  		if (idx == fwrt->num_of_paging_blk) {
  			len = remaining;
  			if (remaining !=
  			    fwrt->num_of_pages_in_last_blk * FW_PAGING_SIZE) {
  				IWL_ERR(fwrt,
  					"Paging: last block contains more data than expected %d\n",
  					remaining);
  				ret = -EINVAL;
  				goto err;
  			}
  		} else if (block->fw_paging_size > remaining) {
  			IWL_ERR(fwrt,
  				"Paging: not enough data in other in block %d (%d)\n",
  				idx, remaining);
  			ret = -EINVAL;
  			goto err;
  		}

  		memcpy(page_address(block->fw_paging_block),
-		       image->sec[sec_idx].data + offset, len);
+		       (const u8 *)image->sec[sec_idx].data + offset, len);
  		dma_sync_single_for_device(fwrt->trans->dev,
  					   block->fw_paging_phys,
  					   block->fw_paging_size,
  					   DMA_BIDIRECTIONAL);

  		IWL_DEBUG_FW(fwrt,
  			     "Paging: copied %d paging bytes to block %d\n",
  			     len, idx);

  		offset += block->fw_paging_size;
  	}

  	return 0;

  err:
  	iwl_free_fw_paging(fwrt);
  	return ret;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 15e2773ce7e7..455e7ee95aae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -618,123 +618,123 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
  int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
  {
  	struct iwl_notification_wait calib_wait;
  	static const u16 init_complete[] = {
  		INIT_COMPLETE_NOTIF,
  		CALIB_RES_NOTIF_PHY_DB
  	};
  	int ret;

  	if (iwl_mvm_has_unified_ucode(mvm))
  		return iwl_run_unified_mvm_ucode(mvm);

  	lockdep_assert_held(&mvm->mutex);

  	mvm->rfkill_safe_init_done = false;

  	iwl_init_notification_wait(&mvm->notif_wait,
  				   &calib_wait,
  				   init_complete,
  				   ARRAY_SIZE(init_complete),
  				   iwl_wait_phy_db_entry,
  				   mvm->phy_db);

  	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);

  	/* Will also start the device */
  	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_INIT);
  	if (ret) {
  		IWL_ERR(mvm, "Failed to start INIT ucode: %d\n", ret);
  		goto remove_notif;
  	}

  	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000) {
  		ret = iwl_mvm_send_bt_init_conf(mvm);
  		if (ret)
  			goto remove_notif;
  	}

  	/* Read the NVM only at driver load time, no need to do this twice */
  	if (!mvm->nvm_data) {
  		ret = iwl_nvm_init(mvm);
  		if (ret) {
  			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
  			goto remove_notif;
  		}
  	}

  	/* In case we read the NVM from external file, load it to the NIC */
  	if (mvm->nvm_file_name) {
  		ret = iwl_mvm_load_nvm_to_nic(mvm);
  		if (ret)
  			goto remove_notif;
  	}

  	WARN_ONCE(mvm->nvm_data->nvm_version < mvm->trans->cfg->nvm_ver,
  		  "Too old NVM version (0x%0x, required = 0x%0x)",
  		  mvm->nvm_data->nvm_version, mvm->trans->cfg->nvm_ver);

  	/*
  	 * abort after reading the nvm in case RF Kill is on, we will complete
  	 * the init seq later when RF kill will switch to off
  	 */
  	if (iwl_mvm_is_radio_hw_killed(mvm)) {
  		IWL_DEBUG_RF_KILL(mvm,
  				  "jump over all phy activities due to RF kill\n");
  		goto remove_notif;
  	}

  	mvm->rfkill_safe_init_done = true;

  	/* Send TX valid antennas before triggering calibrations */
  	ret = iwl_send_tx_ant_cfg(mvm, iwl_mvm_get_valid_tx_ant(mvm));
  	if (ret)
  		goto remove_notif;

  	ret = iwl_send_phy_cfg_cmd(mvm);
  	if (ret) {
  		IWL_ERR(mvm, "Failed to run INIT calibrations: %d\n",
  			ret);
  		goto remove_notif;
  	}

  	/*
  	 * Some things may run in the background now, but we
  	 * just wait for the calibration complete notification.
  	 */
  	ret = iwl_wait_notification(&mvm->notif_wait, &calib_wait,
  				    MVM_UCODE_CALIB_TIMEOUT);
  	if (!ret)
  		goto out;

  	if (iwl_mvm_is_radio_hw_killed(mvm)) {
  		IWL_DEBUG_RF_KILL(mvm, "RFKILL while calibrating.\n");
  		ret = 0;
  	} else {
  		IWL_ERR(mvm, "Failed to run INIT calibrations: %d\n",
  			ret);
  	}

  	goto out;

  remove_notif:
  	iwl_remove_notification(&mvm->notif_wait, &calib_wait);
  out:
  	mvm->rfkill_safe_init_done = false;
  	if (iwlmvm_mod_params.init_dbg && !mvm->nvm_data) {
  		/* we want to debug INIT and we have no NVM - fake */
  		mvm->nvm_data = kzalloc(sizeof(struct iwl_nvm_data) +
  					sizeof(struct ieee80211_channel) +
  					sizeof(struct ieee80211_rate),
  					GFP_KERNEL);
  		if (!mvm->nvm_data)
  			return -ENOMEM;
  		mvm->nvm_data->bands[0].channels = mvm->nvm_data->channels;
  		mvm->nvm_data->bands[0].n_channels = 1;
  		mvm->nvm_data->bands[0].n_bitrates = 1;
  		mvm->nvm_data->bands[0].bitrates =
-			(void *)mvm->nvm_data->channels + 1;
+			(void *)(mvm->nvm_data->channels + 1);
  		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
  	}

  	return ret;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8ef5399ad9be..d779e5e19568 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -40,62 +40,62 @@ void iwl_mvm_rx_rx_phy_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
  /*
   * iwl_mvm_pass_packet_to_mac80211 - builds the packet for mac80211
   *
   * Adds the rxb to a new skb and give it to mac80211
   */
  static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
  					    struct ieee80211_sta *sta,
  					    struct napi_struct *napi,
  					    struct sk_buff *skb,
  					    struct ieee80211_hdr *hdr, u16 len,
  					    u8 crypt_len,
  					    struct iwl_rx_cmd_buffer *rxb)
  {
  	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);
  	unsigned int fraglen;

  	/*
  	 * The 'hdrlen' (plus the 8 bytes for the SNAP and the crypt_len,
  	 * but those are all multiples of 4 long) all goes away, but we
  	 * want the *end* of it, which is going to be the start of the IP
  	 * header, to be aligned when it gets pulled in.
  	 * The beginning of the skb->data is aligned on at least a 4-byte
  	 * boundary after allocation. Everything here is aligned at least
  	 * on a 2-byte boundary so we can just take hdrlen & 3 and pad by
  	 * the result.
  	 */
  	skb_reserve(skb, hdrlen & 3);

  	/* If frame is small enough to fit in skb->head, pull it completely.
  	 * If not, only pull ieee80211_hdr (including crypto if present, and
  	 * an additional 8 bytes for SNAP/ethertype, see below) so that
  	 * splice() or TCP coalesce are more efficient.
  	 *
  	 * Since, in addition, ieee80211_data_to_8023() always pull in at
  	 * least 8 bytes (possibly more for mesh) we can do the same here
  	 * to save the cost of doing it later. That still doesn't pull in
  	 * the actual IP header since the typical case has a SNAP header.
  	 * If the latter changes (there are efforts in the standards group
  	 * to do so) we should revisit this and ieee80211_data_to_8023().
  	 */
  	hdrlen = (len <= skb_tailroom(skb)) ? len : hdrlen + crypt_len + 8;

  	skb_put_data(skb, hdr, hdrlen);
  	fraglen = len - hdrlen;

  	if (fraglen) {
-		int offset = (void *)hdr + hdrlen -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + hdrlen -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);

  		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
  				fraglen, rxb->truesize);
  	}

  	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
  }

  /*
   * iwl_mvm_get_signal_strength - use new rx PHY INFO API
   * values are reported by the fw as positive values - need to negate
   * to obtain their dBM.  Account for missing antennas by replacing 0
   * values by -256dBm: practically 0 power and a non-feasible 8 bit value.
   */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c21736f80c29..d6b4563e2393 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -115,90 +115,90 @@ static inline int iwl_mvm_check_pn(struct iwl_mvm *mvm, struct sk_buff *skb,
  /* iwl_mvm_create_skb Adds the rxb to a new skb */
  static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
  			      struct ieee80211_hdr *hdr, u16 len, u8 crypt_len,
  			      struct iwl_rx_cmd_buffer *rxb)
  {
  	struct iwl_rx_packet *pkt = rxb_addr(rxb);
  	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
  	unsigned int headlen, fraglen, pad_len = 0;
  	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);

  	if (desc->mac_flags2 & IWL_RX_MPDU_MFLG2_PAD) {
  		len -= 2;
  		pad_len = 2;
  	}

  	/* If frame is small enough to fit in skb->head, pull it completely.
  	 * If not, only pull ieee80211_hdr (including crypto if present, and
  	 * an additional 8 bytes for SNAP/ethertype, see below) so that
  	 * splice() or TCP coalesce are more efficient.
  	 *
  	 * Since, in addition, ieee80211_data_to_8023() always pull in at
  	 * least 8 bytes (possibly more for mesh) we can do the same here
  	 * to save the cost of doing it later. That still doesn't pull in
  	 * the actual IP header since the typical case has a SNAP header.
  	 * If the latter changes (there are efforts in the standards group
  	 * to do so) we should revisit this and ieee80211_data_to_8023().
  	 */
  	headlen = (len <= skb_tailroom(skb)) ? len :
  					       hdrlen + crypt_len + 8;

  	/* The firmware may align the packet to DWORD.
  	 * The padding is inserted after the IV.
  	 * After copying the header + IV skip the padding if
  	 * present before copying packet data.
  	 */
  	hdrlen += crypt_len;

  	if (WARN_ONCE(headlen < hdrlen,
  		      "invalid packet lengths (hdrlen=%d, len=%d, crypt_len=%d)\n",
  		      hdrlen, len, crypt_len)) {
  		/*
  		 * We warn and trace because we want to be able to see
  		 * it in trace-cmd as well.
  		 */
  		IWL_DEBUG_RX(mvm,
  			     "invalid packet lengths (hdrlen=%d, len=%d, crypt_len=%d)\n",
  			     hdrlen, len, crypt_len);
  		return -EINVAL;
  	}

  	skb_put_data(skb, hdr, hdrlen);
  	skb_put_data(skb, (u8 *)hdr + hdrlen + pad_len, headlen - hdrlen);

  	/*
  	 * If we did CHECKSUM_COMPLETE, the hardware only does it right for
  	 * certain cases and starts the checksum after the SNAP. Check if
  	 * this is the case - it's easier to just bail out to CHECKSUM_NONE
  	 * in the cases the hardware didn't handle, since it's rare to see
  	 * such packets, even though the hardware did calculate the checksum
  	 * in this case, just starting after the MAC header instead.
  	 */
  	if (skb->ip_summed == CHECKSUM_COMPLETE) {
  		struct {
  			u8 hdr[6];
  			__be16 type;
  		} __packed *shdr = (void *)((u8 *)hdr + hdrlen + pad_len);

  		if (unlikely(headlen - hdrlen < sizeof(*shdr) ||
  			     !ether_addr_equal(shdr->hdr, rfc1042_header) ||
  			     (shdr->type != htons(ETH_P_IP) &&
  			      shdr->type != htons(ETH_P_ARP) &&
  			      shdr->type != htons(ETH_P_IPV6) &&
  			      shdr->type != htons(ETH_P_8021Q) &&
  			      shdr->type != htons(ETH_P_PAE) &&
  			      shdr->type != htons(ETH_P_TDLS))))
  			skb->ip_summed = CHECKSUM_NONE;
  	}

  	fraglen = len - headlen;

  	if (fraglen) {
-		int offset = (void *)hdr + headlen + pad_len -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + headlen + pad_len -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);

  		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
  				fraglen, rxb->truesize);
  	}

  	return 0;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index caf87f320094..7a1519a8a300 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2028,85 +2028,86 @@ iwl_mvm_fill_scan_sched_params(struct iwl_mvm_scan_params *params,
  static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
  			     struct iwl_mvm_scan_params *params,
  			     int type, int uid)
  {
  	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
  	struct iwl_scan_umac_chan_param *chan_param;
  	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
-	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
-		mvm->fw->ucode_capa.n_scan_channels;
+	void *sec_part = (void *)((u8 *)cmd_data +
+		sizeof(struct iwl_scan_channel_cfg_umac) *
+		mvm->fw->ucode_capa.n_scan_channels);
  	struct iwl_scan_req_umac_tail_v2 *tail_v2 =
  		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
  	struct iwl_scan_req_umac_tail_v1 *tail_v1;
  	struct iwl_ssid_ie *direct_scan;
  	int ret = 0;
  	u32 ssid_bitmap = 0;
  	u8 channel_flags = 0;
  	u16 gen_flags;
  	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);

  	chan_param = iwl_mvm_get_scan_req_umac_channel(mvm);

  	iwl_mvm_scan_umac_dwell(mvm, cmd, params);

  	mvm->scan_uid_status[uid] = type;

  	cmd->uid = cpu_to_le32(uid);
  	gen_flags = iwl_mvm_scan_umac_flags(mvm, params, vif);
  	cmd->general_flags = cpu_to_le16(gen_flags);
  	if (iwl_mvm_is_adaptive_dwell_v2_supported(mvm)) {
  		if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_FRAGMENTED)
  			cmd->v8.num_of_fragments[SCAN_LB_LMAC_IDX] =
  							IWL_SCAN_NUM_OF_FRAGS;
  		if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_LMAC2_FRAGMENTED)
  			cmd->v8.num_of_fragments[SCAN_HB_LMAC_IDX] =
  							IWL_SCAN_NUM_OF_FRAGS;

  		cmd->v8.general_flags2 =
  			IWL_UMAC_SCAN_GEN_FLAGS2_ALLOW_CHNL_REORDER;
  	}

  	cmd->scan_start_mac_id = scan_vif->id;

  	if (type == IWL_MVM_SCAN_SCHED || type == IWL_MVM_SCAN_NETDETECT)
  		cmd->flags = cpu_to_le32(IWL_UMAC_SCAN_FLAG_PREEMPTIVE);

  	if (iwl_mvm_scan_use_ebs(mvm, vif)) {
  		channel_flags = IWL_SCAN_CHANNEL_FLAG_EBS |
  				IWL_SCAN_CHANNEL_FLAG_EBS_ACCURATE |
  				IWL_SCAN_CHANNEL_FLAG_CACHE_ADD;

  		/* set fragmented ebs for fragmented scan on HB channels */
  		if (iwl_mvm_is_frag_ebs_supported(mvm)) {
  			if (gen_flags &
  			    IWL_UMAC_SCAN_GEN_FLAGS_LMAC2_FRAGMENTED ||
  			    (!iwl_mvm_is_cdb_supported(mvm) &&
  			     gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_FRAGMENTED))
  				channel_flags |= IWL_SCAN_CHANNEL_FLAG_EBS_FRAG;
  		}
  	}

  	chan_param->flags = channel_flags;
  	chan_param->count = params->n_channels;

  	ret = iwl_mvm_fill_scan_sched_params(params, tail_v2->schedule,
  					     &tail_v2->delay);
  	if (ret) {
  		mvm->scan_uid_status[uid] = 0;
  		return ret;
  	}

  	if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
  		tail_v2->preq = params->preq;
  		direct_scan = tail_v2->direct_scan;
  	} else {
  		tail_v1 = (struct iwl_scan_req_umac_tail_v1 *)sec_part;
  		iwl_mvm_scan_set_legacy_probe_req(&tail_v1->preq,
  						  &params->preq);
  		direct_scan = tail_v1->direct_scan;
  	}
  	iwl_scan_build_ssids(params, direct_scan, &ssid_bitmap);
  	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
  				       params->n_channels, ssid_bitmap,
  				       cmd_data);
  	return 0;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 42426e25cac6..d910da26365a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -705,68 +705,68 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
  static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
  				  struct iwl_rxq *rxq)
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  	struct device *dev = trans->dev;
  	int i;
  	int free_size;
  	bool use_rx_td = (trans->trans_cfg->device_family >=
  			  IWL_DEVICE_FAMILY_AX210);
  	size_t rb_stts_size = use_rx_td ? sizeof(__le16) :
  			      sizeof(struct iwl_rb_status);

  	spin_lock_init(&rxq->lock);
  	if (trans->trans_cfg->mq_rx_supported)
  		rxq->queue_size = trans->cfg->num_rbds;
  	else
  		rxq->queue_size = RX_QUEUE_SIZE;

  	free_size = iwl_pcie_free_bd_size(trans, use_rx_td);

  	/*
  	 * Allocate the circular buffer of Read Buffer Descriptors
  	 * (RBDs)
  	 */
  	rxq->bd = dma_alloc_coherent(dev, free_size * rxq->queue_size,
  				     &rxq->bd_dma, GFP_KERNEL);
  	if (!rxq->bd)
  		goto err;

  	if (trans->trans_cfg->mq_rx_supported) {
  		rxq->used_bd = dma_alloc_coherent(dev,
  						  (use_rx_td ? sizeof(*rxq->cd) : sizeof(__le32)) * rxq->queue_size,
  						  &rxq->used_bd_dma,
  						  GFP_KERNEL);
  		if (!rxq->used_bd)
  			goto err;
  	}

-	rxq->rb_stts = trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
+	rxq->rb_stts = (void *)((u8 *)trans_pcie->base_rb_stts + rxq->id * rb_stts_size);
  	rxq->rb_stts_dma =
  		trans_pcie->base_rb_stts_dma + rxq->id * rb_stts_size;

  	if (!use_rx_td)
  		return 0;

  	/* Allocate the driver's pointer to TR tail */
  	rxq->tr_tail = dma_alloc_coherent(dev, sizeof(__le16),
  					  &rxq->tr_tail_dma, GFP_KERNEL);
  	if (!rxq->tr_tail)
  		goto err;

  	/* Allocate the driver's pointer to CR tail */
  	rxq->cr_tail = dma_alloc_coherent(dev, sizeof(__le16),
  					  &rxq->cr_tail_dma, GFP_KERNEL);
  	if (!rxq->cr_tail)
  		goto err;

  	return 0;

  err:
  	for (i = 0; i < trans->num_rx_queues; i++) {
  		struct iwl_rxq *rxq = &trans_pcie->rxq[i];

  		iwl_pcie_free_rxq_dma(trans, rxq);
  	}

  	return -ENOMEM;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 381e8f90b6f2..9073a7e551dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -151,28 +151,28 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
  static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
  				  dma_addr_t addr, u16 len, bool reset)
  {
  	void *tfd;
  	u32 num_tbs;

-	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
+	tfd = (void *)((u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr);

  	if (reset)
  		memset(tfd, 0, trans->txqs.tfd.size);

  	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);

  	/* Each TFD can point to a maximum max_tbs Tx buffers */
  	if (num_tbs >= trans->txqs.tfd.max_tbs) {
  		IWL_ERR(trans, "Error can not send more than %d chunks\n",
  			trans->txqs.tfd.max_tbs);
  		return -EINVAL;
  	}

  	if (WARN(addr & ~IWL_TX_DMA_MASK,
  		 "Unaligned address = %llx\n", (unsigned long long)addr))
  		return -EINVAL;

  	iwl_pcie_tfd_set_tb(trans, tfd, num_tbs, addr, len);

  	return num_tbs;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 833f43d1ca7a..e4b1cf55dfb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -203,25 +203,26 @@ int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
  static struct page *get_workaround_page(struct iwl_trans *trans,
  					struct sk_buff *skb)
  {
  	struct page **page_ptr;
  	struct page *ret;

  	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);

  	ret = alloc_page(GFP_ATOMIC);
  	if (!ret)
  		return NULL;

  	/* set the chaining pointer to the previous page if there */
-	*(void **)(page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) =
+	    *page_ptr;
  	*page_ptr = ret;

  	return ret;
  }

  /*
   * Add a TB and if needed apply the FH HW bug workaround;
   * meta != NULL indicates that it's a page mapping and we
   * need to dma_unmap_page() and set the meta->tbs bit in
   * this case.
   */
@@ -303,45 +304,46 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
  #ifdef CONFIG_INET
  struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
  				      struct sk_buff *skb)
  {
  	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans->txqs.tso_hdr_page);
  	struct page **page_ptr;

  	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);

  	if (WARN_ON(*page_ptr))
  		return NULL;

  	if (!p->page)
  		goto alloc;

  	/*
  	 * Check if there's enough room on this page
  	 *
  	 * Note that we put a page chaining pointer *last* in the
  	 * page - we need it somewhere, and if it's there then we
  	 * avoid DMA mapping the last bits of the page which may
  	 * trigger the 32-bit boundary hardware bug.
  	 *
  	 * (see also get_workaround_page() in tx-gen2.c)
  	 */
  	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
  			   sizeof(void *))
  		goto out;

  	/* We don't have enough room on this page, get a new one. */
  	__free_page(p->page);

  alloc:
  	p->page = alloc_page(GFP_ATOMIC);
  	if (!p->page)
  		return NULL;
  	p->pos = page_address(p->page);
  	/* set the chaining pointer to NULL */
-	*(void **)(page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) =
+	    NULL;
  out:
  	*page_ptr = p->page;
  	get_page(p->page);
  	return p;
  }
  #endif
@@ -983,17 +985,17 @@ int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
  void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
  {
  	struct page **page_ptr;
  	struct page *next;

  	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
  	next = *page_ptr;
  	*page_ptr = NULL;

  	while (next) {
  		struct page *tmp = next;

-		next = *(void **)(page_address(next) + PAGE_SIZE -
+		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
  				  sizeof(void *));
  		__free_page(tmp);
  	}
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index af1dbdf5617a..939d439a2841 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -38,10 +38,10 @@ static inline void iwl_wake_queue(struct iwl_trans *trans,
  static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
  				    struct iwl_txq *txq, int idx)
  {
  	if (trans->trans_cfg->use_tfh)
  		idx = iwl_txq_get_cmd_index(txq, idx);

-	return txq->tfds + trans->txqs.tfd.size * idx;
+	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
  }

  int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
