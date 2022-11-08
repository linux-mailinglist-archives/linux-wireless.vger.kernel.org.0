Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BACB621211
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiKHNO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiKHNO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 08:14:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E301218A
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 05:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7A3A5CE1B7A
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 13:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5445C433C1;
        Tue,  8 Nov 2022 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667913262;
        bh=HHRinKYYN9c17xVJWvh42OWBaiHiv4AidfQy3vA2TIE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Z6z0ADsP3hEHQ2B4UhqnhGOfq5RZv1yeQY6/MiQu4uy/Dr/Jz5+hD/RrySvkQrEPe
         BmFSihbthIHOhLN1xOwDWauqlL254odz/J3xzmX6o9P15bbUrOG0wYq2shV08jyYHO
         HIzLqJELkA7Rgd0Bnjaa+VWWO7hkripim3WjycalNqOglHaG7Gs+UBOwCr2txe46xI
         Yw86HaD/mEs4e1WuiJ7wJupIBEqBvkfQ48452/aT5ytxY0jCVrbbMmWFTlZA81PaUv
         RUR/a9rSt0y/HF8PzpWj75NBJX9oQCZ9w6IW8ODAFm4LPYobWTCwbs9ie+wmz/Hyx1
         qUHiwWUdp7tFg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 17/50] wifi: ath12k: add dp_tx.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-18-kvalo@kernel.org>
        <de6d5e1a-0ff4-a303-ed25-508816a39a0d@quicinc.com>
Date:   Tue, 08 Nov 2022 15:14:18 +0200
In-Reply-To: <de6d5e1a-0ff4-a303-ed25-508816a39a0d@quicinc.com> (Jeff
        Johnson's message of "Wed, 17 Aug 2022 16:35:27 -0700")
Message-ID: <87v8npeggl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_tx.c | 1206 +++++++++++++++++++++++++++++++
>>   1 file changed, 1206 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> b/drivers/net/wireless/ath/ath12k/dp_tx.c
>
> snip
>
>> +static struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
>> +							      u8 pool_id)
>> +{
>> +	struct ath12k_tx_desc_info *desc = NULL;
>
> nit: initializer always overwritten

Now fixed.

>> +int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>> +		 struct sk_buff *skb)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct hal_tx_info ti = {0};
>> +	struct ath12k_tx_desc_info *tx_desc = NULL;
>> +	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>> +	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
>> +	struct hal_tcl_data_cmd *hal_tcl_desc;
>> +	struct hal_tx_msdu_ext_desc *msg;
>> +	struct sk_buff *skb_ext_desc;
>> +	struct hal_srng *tcl_ring;
>> +	struct ieee80211_hdr *hdr = (void *)skb->data;
>> +	struct dp_tx_ring *tx_ring;
>> +	u8 pool_id;
>> +	u8 hal_ring_id;
>> +	int ret;
>> +	u8 ring_selector = 0, ring_map = 0;
>
> nit: ring_selector initializer always overwritten

Fixed.

>> +int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	int ret = 0;
>
> nit: initializer always overwritten

Fixed.

>> +int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct htt_rx_ring_tlv_filter tlv_filter = {0};
>> +	int ret = 0, ring_id = 0;
>
> nit: both initializers always overwritten

Both fixed.

>> +int ath12k_dp_tx_htt_tx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_dp *dp = &ab->dp;
>> +	struct htt_tx_ring_tlv_filter tlv_filter = {0};
>> +	int ret = 0, ring_id = 0;
>
> nit: ring_id initializer always overwritten

ring_id initialisation fixed now, but also ret is not initialised
anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
