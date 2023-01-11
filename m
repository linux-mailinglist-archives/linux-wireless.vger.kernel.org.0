Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD76654F8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 08:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjAKHDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 02:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAKHDF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 02:03:05 -0500
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 23:03:02 PST
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A787651
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 23:03:02 -0800 (PST)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:43346 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_DHE_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.96)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1pFV6J-0001jT-1S;
        Wed, 11 Jan 2023 08:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=AVLCQVUbfoUNXVRhzUIRuDBYTKefpF2Oq65eiuhxedU=;
        b=bJbknLFVxVi9e+/mC41D3nNDSSLFs/MebbqzDCeAlPC9Kvc+uhmRzpoARCW4L/6AcvVaUPtTc4Ha5gGko0RuB952sxANXXplmkZMmEO/rwxZqYIDwVC+Gxd3+9lmQ7RCYo3CEeJ7+n6hwjNpAWp1gyWCM3RPd/BQP84J87GsoTE=;
Message-ID: <bb866144-1127-2310-503b-7895b7339ecb@newmedia-net.de>
Date:   Wed, 11 Jan 2023 08:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [RFC v2] wifi: ath10k: Implement duplicate detection for
 non-offloaded PCIe
To:     Zhi-Jun You <hujy652@gmail.com>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
References: <20221206073004.22608-1-hujy652@gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
In-Reply-To: <20221206073004.22608-1-hujy652@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [81.201.155.134] (helo=[172.21.254.3])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1pFV6J-0009uj-5L; Wed, 11 Jan 2023 08:00:43 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

this patch causes severe performance issues on 988x

Am 06.12.2022 um 08:30 schrieb Zhi-Jun You:
> Chips like QCA9984, IPQ4019 doesn't do duplicate detection in firmware.
> Implement it in driver so it can skip a check in mac80211.
>
> Check only the first skb since all the skbs in amsdu share the same
> header.
>
> Tested-on: QCA9984 10.4-3.9.0.2-00159
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---
> V1 -> V2: fix typo in txrx.c
> I am not sure what's the formal name for chips like QCA9984 so I will
> call it non-offloaded PCIe for now.
> ---
>   drivers/net/wireless/ath/ath10k/core.h   |  1 +
>   drivers/net/wireless/ath/ath10k/htt_rx.c | 51 ++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
>   3 files changed, 55 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index f5de8ce8fb45..6b4f5208f32f 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -436,6 +436,7 @@ struct ath10k_peer {
>   		enum htt_security_types sec_type;
>   		int pn_len;
>   	} rx_pn[ATH10K_HTT_TXRX_PEER_SECURITY_MAX];
> +	u16 last_rx_seq_ctrl[IEEE80211_NUM_TIDS + 1];
>   };
>   
>   struct ath10k_txq {
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> index 438b0caaceb7..e241eab4cce1 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -1344,6 +1344,56 @@ static char *ath10k_get_tid(struct ieee80211_hdr *hdr, char *out, size_t size)
>   	return out;
>   }
>   
> +static void ath10k_htt_rx_h_check_dup(struct ath10k *ar,
> +				      struct sk_buff_head *amsdu,
> +				      struct ieee80211_rx_status *status)
> +{
> +	struct ath10k_hw_params *hw = &ar->hw_params;
> +	struct sk_buff *first;
> +	struct ath10k_peer *peer;
> +	struct ieee80211_hdr *hdr;
> +	struct htt_rx_desc *rxd;
> +	struct rx_mpdu_start *rxd_mpdu_start;
> +	u16 peer_id;
> +	u8 tid;
> +
> +	if (skb_queue_empty(amsdu))
> +		return;
> +
> +	first = skb_peek(amsdu);
> +	rxd = HTT_RX_BUF_TO_RX_DESC(hw,
> +				    (void *)first->data - hw->rx_desc_ops->rx_desc_size);
> +
> +	rxd_mpdu_start = ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
> +	peer_id = MS(__le32_to_cpu(rxd_mpdu_start->info0),
> +		     RX_MPDU_START_INFO0_PEER_IDX);
> +
> +	spin_lock_bh(&ar->data_lock);
> +
> +	peer = ath10k_peer_find_by_id(ar, peer_id);
> +	if (!peer)
> +		goto out;
> +
> +	hdr = (void *)ath10k_htt_rx_desc_get_rx_hdr_status(hw, rxd);
> +	if (ieee80211_is_data_qos(hdr->frame_control))
> +		tid = ieee80211_get_tid(hdr);
> +	else
> +		tid = ATH10K_TXRX_NON_QOS_TID;
> +
> +	if (ieee80211_has_retry(hdr->frame_control) &&
> +	    peer->last_rx_seq_ctrl[tid] == __le16_to_cpu(hdr->seq_ctrl)) {
> +		__skb_queue_purge(amsdu);
> +		goto out;
> +	}
> +
> +	peer->last_rx_seq_ctrl[tid] = __le16_to_cpu(hdr->seq_ctrl);
> +
> +	status->flag |= RX_FLAG_DUP_VALIDATED;
> +
> +out:
> +	spin_unlock_bh(&ar->data_lock);
> +}
> +
>   static void ath10k_htt_rx_h_queue_msdu(struct ath10k *ar,
>   				       struct ieee80211_rx_status *rx_status,
>   				       struct sk_buff *skb)
> @@ -2356,6 +2406,7 @@ static int ath10k_htt_rx_handle_amsdu(struct ath10k_htt *htt)
>   		ath10k_htt_rx_h_unchain(ar, &amsdu, &drop_cnt, &unchain_cnt);
>   
>   	ath10k_htt_rx_h_filter(ar, &amsdu, rx_status, &drop_cnt_filter);
> +	ath10k_htt_rx_h_check_dup(ar, &amsdu, rx_status);
>   	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true, first_hdr, &err, 0,
>   			     false);
>   	msdus_to_queue = skb_queue_len(&amsdu);
> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
> index da3bc35e41aa..69422d2bd9bc 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -219,6 +219,7 @@ void ath10k_peer_map_event(struct ath10k_htt *htt,
>   {
>   	struct ath10k *ar = htt->ar;
>   	struct ath10k_peer *peer;
> +	int i;
>   
>   	if (ev->peer_id >= ATH10K_MAX_NUM_PEER_IDS) {
>   		ath10k_warn(ar,
> @@ -237,6 +238,8 @@ void ath10k_peer_map_event(struct ath10k_htt *htt,
>   		peer->vdev_id = ev->vdev_id;
>   		ether_addr_copy(peer->addr, ev->addr);
>   		list_add(&peer->list, &ar->peers);
> +		for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
> +			peer->last_rx_seq_ctrl[i] = USHRT_MAX;
>   		wake_up(&ar->peer_mapping_wq);
>   	}
>   
