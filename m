Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A826C4908BE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiAQMdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiAQMdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:33:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 04:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76CFDB80EFE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 12:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4E1C36AE3;
        Mon, 17 Jan 2022 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642422795;
        bh=bBKUMaLnO1ekU7Qi1502Up9LSB+to416XCMt4LwKiNs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hz+wK+WymJ5UN1XJ1VvmHzQ6DQuyts4vxILETzn6ZRWLhIWpQ8rrLxqhMn3PIuP/E
         QR7EeDPox/KfO34w+01b/psfi7T4PQHwij1UBO8JazShqIs8J090+Qpes9sYtTdhgG
         LNOubds/7JnLRkS/SW4Q0lLH7AnAaG8sBolHfqrMJH33XQ6Bze6lSyorbrEswf6mev
         w2IKJulX45T4W8FdpOaCX3jW7CeQ3Sli3hC6GAP5+ilZ7AyH905VQ04P51k29Jn7AL
         0IPtQFkKNLfvul4L8I0eoCtgw07uPLfbJDTindyvzD63ipedG8YWwO/pxUAEpRU3WV
         /zNsw0Ea8XFfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
References: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
Date:   Mon, 17 Jan 2022 14:33:10 +0200
In-Reply-To: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
        (Seevalamuthu Mariappan's message of "Mon, 10 Jan 2022 09:11:30
        +0530")
Message-ID: <87bl0asfsp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:

> Advertise AP-VLAN interface type for vlan support in driver.
> Metadata information in dp_tx is added to notify firmware
> that multicast/broadcast packets are encrypted in software.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -78,6 +78,44 @@ enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
>  	}
>  }
>  
> +#define HTT_META_DATA_ALIGNMENT    0x8
> +
> +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_len)
> +{
> +	if (unlikely(skb_cow_head(skb, align_len)))
> +		return -ENOMEM;
> +
> +	skb_push(skb, align_len);
> +	memset(skb->data, 0, align_len);
> +	return 0;
> +}

[...]

> @@ -211,15 +250,42 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>  		goto fail_remove_idr;
>  	}
>  
> +	/* Add metadata for sw encrypted vlan group traffic */
> +	if (!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
> +	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> +	    !info->control.hw_key &&
> +	    ieee80211_has_protected(hdr->frame_control)) {
> +		/* HW requirement is that metadata should always point to a
> +		 * 8-byte aligned address. So we add alignment pad to start of
> +		 * buffer. HTT Metadata should be ensured to be multiple of 8-bytes
> +		 *  to get 8-byte aligned start address along with align_pad added
> +		 */
> +		align_pad = ((unsigned long)skb->data) & (HTT_META_DATA_ALIGNMENT - 1);
> +		ret = ath11k_dp_metadata_align_skb(skb, align_pad);
> +		if (unlikely(ret))
> +			goto fail_remove_idr;

If you push the skb like that shouldn't you also reserve the room for it
in struct ieee80211_hw::extra_tx_headroom?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
