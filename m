Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D96078E6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJUNwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJUNww (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5A2793E4
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A897760A77
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 13:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F412C433D6;
        Fri, 21 Oct 2022 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666360366;
        bh=iCCSEg84RmEDTd2fPjesvlI+ywyuzjjhNGwvZEI/x4o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XthAxXTvBUU/aMXr2pKNResS+y8poAhnkZGjBY4x1ItqIkt222Iv5sWJtYmsAIiZS
         frSSlLdPuFzkSHxyZdWX9NYW8LS1tsxVujt5EdYCFe57JoYRYqflfbKueJu/4p/JHD
         Y6prP08BtmNidXHTPRx36o0u0p7vF1FLFtHN2E+m5nWMnlhRbvK5vTLmA0idyMl151
         OjJQENuqii9PyUSpKP8Ws2oCvVb2lvzEZLJYLE+GD9gB8oO4Lv83wsaeSS75RrBOhU
         hStC6MAKR9o1mgCqJH7tr+iqAu2WkSNanrLuLEUduLrHlaoN972HXLO7fKkS3sqhM8
         PIOxKL5+qw7iQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-16-kvalo@kernel.org>
        <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
Date:   Fri, 21 Oct 2022 16:52:40 +0300
In-Reply-To: <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com> (Jeff
        Johnson's message of "Wed, 17 Aug 2022 16:19:30 -0700")
Message-ID: <87h6zxi8rb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> +static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
>> +{
>> +	struct ath12k_pdev_dp *dp = &ar->dp;
>> +	struct ath12k_base *ab = ar->ab;
>> +	int i;
>> +	int ret;
>> +	u32 mac_id = dp->mac_id;
>> +
>> +	if (!ar->ab->hw_params->rxdma1_enable) {
>> +		/* init mon status buffer reap timer */
>> +		timer_setup(&ar->ab->mon_reap_timer,
>> +			    ath12k_dp_service_mon_ring, 0);
>> +		return 0;
>> +	}
>
> the timer_setup() seems like strange logic to have in a function named
> ath12k_dp_rx_pdev_srng_alloc() -- that doesn't have anything to do
> with srng allocation
>
> perhaps that should be in a separate properly-named function?

Sriram moved that to dp.c in commit:

3ca5427e7315 wifi: ath12k: move monitor reap timer init out of srng setup

>> +static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
>> +				   enum hal_reo_cmd_status status)
>> +{
>> +	struct ath12k_dp_rx_tid *rx_tid = ctx;
>> +
>> +	if (status != HAL_REO_CMD_SUCCESS)
>> + ath12k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status
>> %d\n",
>> +			    rx_tid->tid, status);
>> +
>> +	dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
>> +			 DMA_BIDIRECTIONAL);
>> +	kfree(rx_tid->vaddr);
>
> you don't want to set rx_tid->vaddr = NULL so that there isn't a
> dangling pointer?

Sriram fixed that in:

795c1a99be86 wifi: ath12k: set tid vaddr to NULL after free

>> +static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct
>> ath12k_dp_rx_tid *rx_tid,
>> +				  enum hal_reo_cmd_type type,
>> +				  struct ath12k_hal_reo_cmd *cmd,
>> +				  void (*cb)(struct ath12k_dp *dp, void *ctx,
>> +					     enum hal_reo_cmd_status status))
>> +{
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct ath12k_dp_rx_reo_cmd *dp_cmd;
>> +	struct hal_srng *cmd_ring;
>> +	int cmd_num;
>> +
>> +	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
>> +	cmd_num = ath12k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
>> +
>> +	/* cmd_num should start from 1, during failure return the error code */
>> +	if (cmd_num < 0)
>> +		return cmd_num;
>> +
>> +	/* reo cmd ring descriptors has cmd_num starting from 1 */
>> +	if (cmd_num == 0)
>> +		return -EINVAL;
>> +
>> +	if (!cb)
>> +		return 0;
>> +
>> +	/* Can this be optimized so that we keep the pending command list only
>> +	 * for tid delete command to free up the resoruce on the command status
>
> s/resoruce/resource/

Sriram fixed also this.

>> +	 * indication?
>> +	 */
>> +	dp_cmd = kzalloc(sizeof(*dp_cmd), GFP_ATOMIC);
>> +
>> +	if (!dp_cmd)
>> +		return -ENOMEM;
>> +
>> +	memcpy(&dp_cmd->data, rx_tid, sizeof(struct ath12k_dp_rx_tid));
>
> sizeof(*rx_tid) is preferred

And this.

>> +static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
>> +				      struct ath12k_dp_rx_tid *rx_tid)
>> +{
>> +	struct ath12k_hal_reo_cmd cmd = {0};
>> +	unsigned long tot_desc_sz, desc_sz;
>> +	int ret;
>> +
>> +	tot_desc_sz = rx_tid->size;
>> +	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
>> +
>> +	while (tot_desc_sz > desc_sz) {
>> +		tot_desc_sz -= desc_sz;
>> +		cmd.addr_lo = lower_32_bits(rx_tid->paddr + tot_desc_sz);
>> +		cmd.addr_hi = upper_32_bits(rx_tid->paddr);
>> +		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
>> +					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
>> +					     NULL);
>> +		if (ret)
>> +			ath12k_warn(ab,
>> + "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
>> +				    rx_tid->tid, ret);
>> +	}
>> +
>> +	memset(&cmd, 0, sizeof(cmd));
>> +	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
>> +	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
>> +	cmd.flag |= HAL_REO_CMD_FLG_NEED_STATUS;
>
> why |= instead of just =? flag will always be 0 at this point

Sriram fixed also this.

>> +	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
>> +				     HAL_REO_CMD_FLUSH_CACHE,
>> +				     &cmd, ath12k_dp_reo_cmd_free);
>> +	if (ret) {
>> + ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d
>> (%d)\n",
>> +			   rx_tid->tid, ret);
>> +		dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
>> +				 DMA_BIDIRECTIONAL);
>> +		kfree(rx_tid->vaddr);
>
> you don't want to set rx_tid->vaddr = NULL so that there isn't a
> dangling pointer?

Sriram fixed this.

>> +		}
>> +	}
>> +	spin_unlock_bh(&dp->reo_cmd_lock);
>> +
>> +	return;
>> +free_desc:
>> +	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
>> +			 DMA_BIDIRECTIONAL);
>> +	kfree(rx_tid->vaddr);
>
> you don't want to set rx_tid->vaddr = NULL so that there isn't a
> dangling pointer?

And this as well.

>> +void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
>> +				  struct ath12k_peer *peer, u8 tid)
>> +{
>> +	struct ath12k_hal_reo_cmd cmd = {0};
>> +	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
>> +	int ret;
>> +
>> +	if (!rx_tid->active)
>> +		return;
>> +
>> +	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
>> +	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
>> +	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
>> +	cmd.upd0 |= HAL_REO_CMD_UPD0_VLD;
>
> why |= instead of just =?

Fixed.

>> +	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
>> +				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
>> +				     ath12k_dp_rx_tid_del_func);
>> +	if (ret) {
>> + ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE
>> cmd, tid %d (%d)\n",
>> +			   tid, ret);
>> +		dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size,
>> +				 DMA_BIDIRECTIONAL);
>> +		kfree(rx_tid->vaddr);
>
> you don't want to set rx_tid->vaddr = NULL so that there isn't a
> dangling pointer?

Fixed. But now that I think it more, does setting it to NULL help? The
kernel will crash anyway if we try to access it, and if our code is so
buggy that it tries to do a double free it should warn about that anyway :)

>> +int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
>> +				u8 tid, u32 ba_win_sz, u16 ssn,
>> +				enum hal_pn_type pn_type)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct hal_rx_reo_queue *addr_aligned;
>> +	struct ath12k_peer *peer;
>> +	struct ath12k_dp_rx_tid *rx_tid;
>> +	u32 hw_desc_sz;
>> +	void *vaddr;
>> +	dma_addr_t paddr;
>> +	int ret;
>> +
>> +	spin_lock_bh(&ab->base_lock);
>> +
>> +	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
>> +	if (!peer) {
>> +		spin_unlock_bh(&ab->base_lock);
>> +		ath12k_warn(ab, "failed to find the peer to set up rx tid\n");
>
> should you log the peer_mac?

Yeah, that would be good. Added to my todo list.

>> +int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_vif *arvif,
>> +				       const u8 *peer_addr,
>> +				       enum set_key_cmd key_cmd,
>> +				       struct ieee80211_key_conf *key)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_hal_reo_cmd cmd = {0};
>> +	struct ath12k_peer *peer;
>> +	struct ath12k_dp_rx_tid *rx_tid;
>> +	u8 tid;
>> +	int ret = 0;
>> +
>> +	/* NOTE: Enable PN/TSC replay check offload only for unicast frames.
>> +	 * We use mac80211 PN/TSC replay check functionality for bcast/mcast
>> +	 * for now.
>> +	 */
>> +	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>> +		return 0;
>> +
>> +	cmd.flag |= HAL_REO_CMD_FLG_NEED_STATUS;
>> +	cmd.upd0 |= HAL_REO_CMD_UPD0_PN |
>
> why |= instead of just = for both of the above?

Fixed.

>> +		    HAL_REO_CMD_UPD0_PN_SIZE |
>> +		    HAL_REO_CMD_UPD0_PN_VALID |
>> +		    HAL_REO_CMD_UPD0_PN_CHECK |
>> +		    HAL_REO_CMD_UPD0_SVLD;
>> +
>> +	switch (key->cipher) {
>> +	case WLAN_CIPHER_SUITE_TKIP:
>> +	case WLAN_CIPHER_SUITE_CCMP:
>> +	case WLAN_CIPHER_SUITE_CCMP_256:
>> +	case WLAN_CIPHER_SUITE_GCMP:
>> +	case WLAN_CIPHER_SUITE_GCMP_256:
>> +		if (key_cmd == SET_KEY) {
>> +			cmd.upd1 |= HAL_REO_CMD_UPD1_PN_CHECK;
>> +			cmd.pn_size = 48;
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	spin_lock_bh(&ab->base_lock);
>> +
>> +	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
>> +	if (!peer) {
>> + ath12k_warn(ab, "failed to find the peer to configure pn replay
>> detection\n");
>
>
> should you log the peer_addr?
>
> also it is preferable to unlock first, and then log

Fixed.

>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
>> +					   u16 tag, u16 len, const void *ptr,
>> +					   void *data)
>> +{
>> +	struct htt_ppdu_stats_info *ppdu_info;
>> +	struct htt_ppdu_user_stats *user_stats;
>> +	int cur_user;
>> +	u16 peer_id;
>> +
>> +	ppdu_info = (struct htt_ppdu_stats_info *)data;
>
> unnecessary typecast from void*

Fixed.


>> +
>> +	switch (tag) {
>> +	case HTT_PPDU_STATS_TAG_COMMON:
>> +		if (len < sizeof(struct htt_ppdu_stats_common)) {
>> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
>> +				    len, tag);
>> +			return -EINVAL;
>> +		}
>> +		memcpy(&ppdu_info->ppdu_stats.common, ptr,
>> +		       sizeof(struct htt_ppdu_stats_common));
>> +		break;
>> +	case HTT_PPDU_STATS_TAG_USR_RATE:
>> +		if (len < sizeof(struct htt_ppdu_stats_user_rate)) {
>> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
>> +				    len, tag);
>> +			return -EINVAL;
>> +		}
>> +
>> +		peer_id = ((struct htt_ppdu_stats_user_rate *)ptr)->sw_peer_id;
>> +		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
>> +						      peer_id);
>> +		if (cur_user < 0)
>> +			return -EINVAL;
>> +		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
>> +		user_stats->peer_id = peer_id;
>> +		user_stats->is_valid_peer_id = true;
>> +		memcpy(&user_stats->rate, ptr,
>> +		       sizeof(struct htt_ppdu_stats_user_rate));
>> +		user_stats->tlv_flags |= BIT(tag);
>> +		break;
>> +	case HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON:
>> +		if (len < sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn)) {
>> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
>> +				    len, tag);
>> +			return -EINVAL;
>> +		}
>> +
>> +		peer_id = ((struct htt_ppdu_stats_usr_cmpltn_cmn *)ptr)->sw_peer_id;
>> +		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
>> +						      peer_id);
>> +		if (cur_user < 0)
>> +			return -EINVAL;
>> +		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
>> +		user_stats->peer_id = peer_id;
>> +		user_stats->is_valid_peer_id = true;
>> +		memcpy(&user_stats->cmpltn_cmn, ptr,
>> +		       sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn));
>> +		user_stats->tlv_flags |= BIT(tag);
>> +		break;
>> +	case HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS:
>> +		if (len <
>> +		    sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status)) {
>> +			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
>> +				    len, tag);
>> +			return -EINVAL;
>> +		}
>> +
>> +		peer_id =
>> +		((struct htt_ppdu_stats_usr_cmpltn_ack_ba_status *)ptr)->sw_peer_id;
>
> descendant should be indented to aid readability

Fixed.

> is it necessary to split this line?

Yeah, it becomes 105 chars long otherwise.

>> +static void ath12k_htt_pktlog(struct ath12k_base *ab, struct sk_buff *skb)
>> +{
>> +	struct htt_pktlog_msg *data = (struct htt_pktlog_msg *)skb->data;
>> +	struct ath_pktlog_hdr *hdr = (struct ath_pktlog_hdr *)data;
>> +	struct ath12k *ar;
>> +	u8 pdev_id;
>> +
>> +	pdev_id = u32_get_bits(data->hdr, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
>> +	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
>> +	if (!ar) {
>> +		ath12k_warn(ab, "invalid pdev id %d on htt pktlog\n", pdev_id);
>> +		return;
>> +	}
>> +	hdr->m_timestamp = ar->pdev->timestamp;
>> +
>> +	trace_ath12k_htt_pktlog(ar, data->payload, hdr->size,
>> +				ar->ab->pktlog_defs_checksum);
>> +}
>
> I am really confused about the above function.
> The first two declarations have both data and hdr point to the skb->data.
> So one would assume these are related structures.  But instead we have:
> struct ath_pktlog_hdr {
> 	u16 flags;
> 	u16 missed_cnt;
> 	u16 log_type;
> 	u16 size;
> 	u32 timestamp;
> 	u32 type_specific_data;
> 	struct mlo_timestamp m_timestamp;
> 	u8 payload[];
> };
>
> struct htt_pktlog_msg {
> 	u32 hdr;
> 	u8 payload[0];
> };
>
> this means the pdev_id = u32_get_bits() logic is somehow extracting
> the pdev_id from the fields that hold the flags+missed_cnt
> and the logic to write hdr->m_timestamp is somewhere in the middle of
> the htt_pktlog_msg payload[].
>
> now the only thing that I can guess is that the htt_pktlog_msg
> payload[] begins with:
> 	u16 log_type;
> 	u16 size;
> 	u32 timestamp;
> 	u32 type_specific_data;
> 	struct mlo_timestamp m_timestamp;
>
> but if so, that is less than clear from the code and declarations

Yeah, this is not making sense at all. Maybe I should just remove the
entire function?

>> +static void ath12k_htt_backpressure_event_handler(struct ath12k_base *ab,
>> +						  struct sk_buff *skb)
>> +{
>> +	u32 *data = (u32 *)skb->data;
>> +	u8 pdev_id, ring_type, ring_id, pdev_idx;
>> +	u16 hp, tp;
>> +	u32 backpressure_time;
>> +	struct ath12k_bp_stats *bp_stats;
>> +
>> +	pdev_id = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_PDEV_ID_M);
>> +	ring_type = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_RING_TYPE_M);
>> +	ring_id = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_RING_ID_M);
>> +	++data;
>> +
>> +	hp = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_HP_M);
>> +	tp = u32_get_bits(*data, HTT_BACKPRESSURE_EVENT_TP_M);
>> +	++data;
>> +
>> +	backpressure_time = *data;
>
> I believe the above code would be much clearer if skb->data was
> typecast to a struct pointer and assignments referenced members of the
> struct, just like most/all of the functions that follow.
> and as I've written before, I further believe that having accessor
> functions/macros would make it even clearer.

Sriram removed the entire the function in:

9ae39e387a65 wifi: ath12k: remove backpressure event handler

>> +static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
>> +					 struct sk_buff *msdu,
>> +					 enum hal_encrypt_type enctype,
>> +					 struct ieee80211_rx_status *status)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>> +	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
>> +	struct ieee80211_hdr *hdr;
>> +	size_t hdr_len;
>> +	u8 *crypto_hdr;
>> +	u16 qos_ctl = 0;
>
> nit: initializer always overwritten

Fixed

>> +static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
>> +					      struct sk_buff *msdu,
>> +					      struct ath12k_skb_rxcb *rxcb,
>> +					      struct ieee80211_rx_status *status,
>> +					      enum hal_encrypt_type enctype)
>> +{
>> +	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
>> +	struct ath12k_base *ab = ar->ab;
>> +	size_t hdr_len, crypto_len;
>> +	struct ieee80211_hdr *hdr;
>> +	u16 qos_ctl = 0;
>
> nit: initializer always overwritten

Fixed.

>> +static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
>> +				      struct sk_buff *msdu,
>> +				      struct ieee80211_rx_status *status)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	static const struct ieee80211_radiotap_he known = {
>> +		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
>> +				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
>> +		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
>> +	};
>> +	struct ieee80211_radiotap_he *he = NULL;
>
> nit: initializer always overwritten

Fixed.

>> +	struct ieee80211_rx_status *rx_status;
>> +	struct ieee80211_sta *pubsta = NULL;
>> +	struct ath12k_peer *peer;
>> +	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>> +	u8 decap = DP_RX_DECAP_TYPE_RAW;
>> +	bool is_mcbc = rxcb->is_mcbc;
>> +	bool is_eapol = rxcb->is_eapol;
>> +
>> +	if (status->encoding == RX_ENC_HE && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
>> +	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
>> +		he = skb_push(msdu, sizeof(known));
>> +		memcpy(he, &known, sizeof(known));
>
> this is only use of 'he' hence initializer is unnecessary

Yup.

>> +		status->flag |= RX_FLAG_RADIOTAP_HE;
>> +	}
>> +
>> +	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
>> +		decap = ath12k_dp_rx_h_decap_type(ab, rxcb->rx_desc);
>> +
>> +	spin_lock_bh(&ab->base_lock);
>> +	peer = ath12k_dp_rx_h_find_peer(ab, msdu);
>> +	if (peer && peer->sta)
>> +		pubsta = peer->sta;
>
> could just unconditionally have pubsta = peer ? peer->sta : NULL
> then initializer would be unnecessary

Fixed.

>> +int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>> +			     int budget)
>> +{
>> +	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
>> +	struct dp_link_desc_bank *link_desc_banks;
>> +	enum hal_rx_buf_return_buf_manager rbm;
>> +	struct hal_rx_msdu_link *link_desc_va;
>> +	int tot_n_bufs_reaped, quota, ret, i;
>> +	struct hal_reo_dest_ring *reo_desc;
>> +	struct dp_rxdma_ring *rx_ring;
>> +	struct dp_srng *reo_except;
>> +	u32 desc_bank, num_msdus;
>> +	struct hal_srng *srng;
>> +	struct ath12k_dp *dp;
>> +	int mac_id;
>> +	struct ath12k *ar;
>> +	dma_addr_t paddr;
>> +	bool is_frag;
>> +	u8 drop = 0;
>
> bool?

Fixed.

>> +int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>> +				 struct napi_struct *napi, int budget)
>> +{
>> +	struct ath12k *ar;
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct dp_rxdma_ring *rx_ring;
>> +	struct hal_rx_wbm_rel_info err_info;
>> +	struct hal_srng *srng;
>> +	struct sk_buff *msdu;
>> +	struct sk_buff_head msdu_list[MAX_RADIOS];
>> +	struct ath12k_skb_rxcb *rxcb;
>> +	void *rx_desc;
>> +	int mac_id;
>> +	int num_buffs_reaped = 0;
>> +	int total_num_buffs_reaped = 0;
>> +	struct ath12k_rx_desc_info *desc_info;
>> +	int ret, i;
>> +
>> +	for (i = 0; i < ab->num_radios; i++)
>> +		__skb_queue_head_init(&msdu_list[i]);
>> +
>> +	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
>> +	rx_ring = &dp->rx_refill_buf_ring;
>> +
>> +	spin_lock_bh(&srng->lock);
>> +
>> +	ath12k_hal_srng_access_begin(ab, srng);
>> +
>> +	while (budget) {
>> +		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
>> +		if (!rx_desc)
>> +			break;
>> +
>> +		ret = ath12k_hal_wbm_desc_parse_err(ab, rx_desc, &err_info);
>> +		if (ret) {
>> +			ath12k_warn(ab,
>> + "failed to parse rx error in wbm_rel ring desc %d\n",
>> +				    ret);
>> +			continue;
>> +		}
>> +
>> +		desc_info = (struct ath12k_rx_desc_info *)err_info.rx_desc;
>> +
>> +		/* retry manual desc retrieval if hw cc is not done */
>> +		if (!desc_info) {
>> +			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
>> +			if (!desc_info) {
>> + ath12k_warn(ab, "Invalid cookie in manual desc retrival");
>> +				continue;
>> +			}
>> +		}
>> +
>> +		/* FIXME: Extract mac id correctly. Since descs are not tied
>> +		 * to mac, we can extract from vdev id in ring desc.
>> +		 */
>> +		mac_id = 0;
>> +
>> +		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
>> +			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
>> +
>> +		msdu = desc_info->skb;
>> +		desc_info->skb = NULL;
>> +
>> +		spin_lock_bh(&dp->rx_desc_lock);
>> +		list_move_tail(&desc_info->list, &dp->rx_desc_free_list);
>> +		spin_unlock_bh(&dp->rx_desc_lock);
>> +
>> +		rxcb = ATH12K_SKB_RXCB(msdu);
>> +		dma_unmap_single(ab->dev, rxcb->paddr,
>> +				 msdu->len + skb_tailroom(msdu),
>> +				 DMA_FROM_DEVICE);
>> +
>> +		num_buffs_reaped++;
>> +		total_num_buffs_reaped++;
>
> why are two separate counters needed? seem they will have the same
> value always

Fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
