Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442E53C6F1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiFCIaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbiFCIaJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:30:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014427B38
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5415AB82234
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 08:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4CC385A9;
        Fri,  3 Jun 2022 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654245006;
        bh=F/yFt7FSuieqmGZcdFXJ/QAp5UbHxQNdjguj42ZfMKs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=l9Trv2/0e54zgnhcipilEBUHH91W+U2KV095lz3v+uSLRDXroqEpFvIHVLsFfpUml
         UO0ONcecM7gmGGpGfiwjlPg6woetdqSdpsXK4KU48ncssUc9etAz+BvwfJHpyM0pXz
         BLHBCckhuKizo9ORaH8mpaoYoUzb1Y3I2Ai6pE6X6D7Z4mPvIHe4utGVT6acytSq+O
         WVUZD++VvICqIFdBimodOCgeefkel9sMIeol5ZgHXUdvhvdGb4z6CnGOKzfeN6gPYd
         b5onSwg0Tgbze2sepdlrUWZ13ZA+VeeRM5fLKHYGfDdThIbcSQVkV+C1NGVGUModMc
         clqGIWCYcAqvw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Seevalamuthu M \(QUIC\)" <quic_seevalam@quicinc.com>
Cc:     "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
References: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
        <87bl0asfsp.fsf@kernel.org>
        <DM8PR02MB8199EBB0A4ACC6F64F8C92FFF62D9@DM8PR02MB8199.namprd02.prod.outlook.com>
Date:   Fri, 03 Jun 2022 11:30:03 +0300
In-Reply-To: <DM8PR02MB8199EBB0A4ACC6F64F8C92FFF62D9@DM8PR02MB8199.namprd02.prod.outlook.com>
        (Seevalamuthu M.'s message of "Tue, 8 Feb 2022 05:30:07 +0000")
Message-ID: <878rqeno8k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Seevalamuthu M (QUIC)" <quic_seevalam@quicinc.com> writes:

> Hi Kalle,
>
>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Monday, January 17, 2022 6:03 PM
>> To: Seevalamuthu M (QUIC) <quic_seevalam@quicinc.com>
>> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
>> 
>> Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:
>> 
>> > Advertise AP-VLAN interface type for vlan support in driver.
>> > Metadata information in dp_tx is added to notify firmware that
>> > multicast/broadcast packets are encrypted in software.
>> >
>> > Tested-on: IPQ8074 hw2.0 AHB
>> > WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1
>> >
>> > Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
>> 
>> [...]
>> 
>> > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>> > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> > @@ -78,6 +78,44 @@ enum hal_encrypt_type
>> ath11k_dp_tx_get_encrypt_type(u32 cipher)
>> >  	}
>> >  }
>> >
>> > +#define HTT_META_DATA_ALIGNMENT    0x8
>> > +
>> > +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8
>> > +align_len) {
>> > +	if (unlikely(skb_cow_head(skb, align_len)))
>> > +		return -ENOMEM;
>> > +
>> > +	skb_push(skb, align_len);
>> > +	memset(skb->data, 0, align_len);
>> > +	return 0;
>> > +}
>> 
>> [...]
>> 
>> > @@ -211,15 +250,42 @@ int ath11k_dp_tx(struct ath11k *ar, struct
>> ath11k_vif *arvif,
>> >  		goto fail_remove_idr;
>> >  	}
>> >
>> > +	/* Add metadata for sw encrypted vlan group traffic */
>> > +	if (!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab-
>> >dev_flags) &&
>> > +	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
>> > +	    !info->control.hw_key &&
>> > +	    ieee80211_has_protected(hdr->frame_control)) {
>> > +		/* HW requirement is that metadata should always point to a
>> > +		 * 8-byte aligned address. So we add alignment pad to start
>> of
>> > +		 * buffer. HTT Metadata should be ensured to be multiple of
>> 8-bytes
>> > +		 *  to get 8-byte aligned start address along with align_pad
>> added
>> > +		 */
>> > +		align_pad = ((unsigned long)skb->data) &
>> (HTT_META_DATA_ALIGNMENT - 1);
>> > +		ret = ath11k_dp_metadata_align_skb(skb, align_pad);
>> > +		if (unlikely(ret))
>> > +			goto fail_remove_idr;
>> 
>> If you push the skb like that shouldn't you also reserve the room for it in
>> struct ieee80211_hw::extra_tx_headroom?
>
> [seevalam] : already this is handled using skb_cow_head() in
> ath11k_dp_metadata_align_skb().

Indeed, I missed that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
