Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46B6B10A7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCHSJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 13:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHSJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 13:09:26 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931CCCEAD
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XA1x4uHVuNlFCbntS4g34jb7QqqTzglZ8EyZUBaakfo=; b=CFVssRZFJbThJcyYmLxitnEnFr
        4zlejIuKaKJDoj7zV8GUHmCLF/9DfTzs9nfXNyv3ExTXzdra5u7af+Y8Z7ymcWzodZr+VyMT2/Zsv
        XEAQkN3VLhT2b3gORw18F6BpkWyzUOFUPEh3uckoWpbIvIMPfDX9z7zlkKwoj0IVLsdY=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pZyDx-00Fxwf-O9; Wed, 08 Mar 2023 19:09:13 +0100
Message-ID: <380e302d-a444-e243-f868-aa3e1efdcb73@nbd.name>
Date:   Wed, 8 Mar 2023 19:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] wifi: ath11k: fix null ptr dereference when tx
 offload is enabled
Content-Language: en-US
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
 <20230308174703.12270-2-quic_pradeepc@quicinc.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20230308174703.12270-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08.03.23 18:47, Pradeep Kumar Chitrapu wrote:
> When tx offload is enabled, info->band from skb cb is 0. This
> causes null pointer access at mac80211 when sband is accessed.
> 
> In offload case, ndo_hard_start will bypass mac80211 tx and no
> function will set info->band in skb cb to correct value.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_tx.c | 26 ++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 8afbba236935..0f3a32434970 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -354,8 +364,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
>   			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
>   		}
>   	}
> -
> -	ieee80211_tx_status(ar->hw, msdu);
> +	if (flags & ATH11K_SKB_HW_80211_ENCAP)
> +		ieee80211_tx_status_8023(ar->hw, vif, msdu);
> +	else
> +		ieee80211_tx_status(ar->hw, msdu);
>   }
>   
>   static void
> @@ -610,7 +627,10 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>   
>   	spin_unlock_bh(&ab->base_lock);
>   
> -	ieee80211_tx_status_ext(ar->hw, &status);
> +	if (flags & ATH11K_SKB_HW_80211_ENCAP)
> +		ieee80211_tx_status_8023(ar->hw, vif, msdu);
> +	else
> +		ieee80211_tx_status_ext(ar->hw, &status);
>   }
>   
>   static inline void ath11k_dp_tx_status_parse(struct ath11k_base *ab,
I think using ieee80211_tx_status_8023 is a bad idea. It is simply a 
wrapper around ieee80211_tx_status_ext which looks up the sta based on 
the MSDU DA. This means it is incompatible with 4-address mode.
If you can have a sta pointer available, it is much better to just use 
ieee80211_tx_status_ext unconditionally.

In fact, I think we should simply remove ieee80211_tx_status_8023.

- Felix
