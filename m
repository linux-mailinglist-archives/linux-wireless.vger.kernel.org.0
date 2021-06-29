Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED43B7751
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhF2RiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Jun 2021 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhF2RiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Jun 2021 13:38:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DA8C061760
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jun 2021 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TErmZqWBMVcl3qGHU0sym2lQ8P6yQw5zwZrfOKjvNeM=; b=UaQZyFYYf8Za7e1vBft+VuhYUE
        kwFxJED0Q9ugj4dYsNK2F3BwLV5Duasz28jgYW8JN7glxjZirSKB1CMPshZCo+rHol3lYl8fqyW3Z
        Sc6zFWmVPj6BZh951S36AltGqQGYg2aHhotHod25ryEClJPMnUGq9CbVndPiBUG4ch10=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lyHeB-00088b-Sx; Tue, 29 Jun 2021 19:35:43 +0200
Subject: Re: [PATCH 12/12] ath11k: avoid unnecessary lock contention in
 tx_completion path
To:     Jouni Malinen <jouni@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
 <20210615211407.92233-13-jouni@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <b1dbd11a-e978-16ea-1473-7eb81399981c@nbd.name>
Date:   Tue, 29 Jun 2021 19:35:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615211407.92233-13-jouni@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-15 23:14, Jouni Malinen wrote:
> From: P Praneesh <ppranees@codeaurora.org>
> 
> Lock is not needed for the readable idr operation, so avoid spin_lock_bh
> for the idr_find() call. No need to disable the bottom half preempt if
> it is already in bottom half context, so modify the spin_lock_bh to
> spin_lock in the data tx completion handler.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2
> 
> Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index ab9ccf0eb274..659f9d98bc0c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -288,19 +288,18 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
>  	struct sk_buff *msdu;
>  	struct ath11k_skb_cb *skb_cb;
>  
> -	spin_lock_bh(&tx_ring->tx_idr_lock);
>  	msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
> -	if (!msdu) {
> +	if (unlikely(!msdu)) {
>  		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
>  			    msdu_id);
> -		spin_unlock_bh(&tx_ring->tx_idr_lock);
>  		return;
>  	}
>  
>  	skb_cb = ATH11K_SKB_CB(msdu);
>  
> +	spin_lock(&tx_ring->tx_idr_lock);
>  	idr_remove(&tx_ring->txbuf_idr, msdu_id);
Why are you doing the lookups twice instead of just using the return
value of idr_remove?

- Felix
