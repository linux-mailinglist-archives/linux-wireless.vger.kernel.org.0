Return-Path: <linux-wireless+bounces-23190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796EABE7CC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 00:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63364C0EAD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAD25FA00;
	Tue, 20 May 2025 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JX15bpMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE525F78E;
	Tue, 20 May 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781835; cv=none; b=lZHZ8GghnPVPutZ8ukzZp17/atrUF7CzO+VUNzlWETpENN4fNfFSQlqC3t1deMk7GO6y+UYvTWqNsRKxDYTSi/Tvk/x28loUm8mKpOcnbn+mxal5Nr5nH4OAjfD3twjtaA2Na8/g+oJJoDfCwY2RKmfmJKB08JQ/zxdr143QXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781835; c=relaxed/simple;
	bh=w8GxA9mms68Z49RxaIeHNMPUMPu7EXQ7106AefyZaNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBlJ9WrFRzFiUmQn6lA7oRuZdJJ9u6YrXSihI6DfF9Pp//X89yuESTQyhWWcD5QSWBv7G/4ZSZ2birLGnwDHtMaDuMynPxZ4FMq7vntLH7oSsR3glFXdWzGK04mZy3cIycgm0uXOewMaH+UtFRk5QNbIWaXPOYp90IfVpoK42JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JX15bpMj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=m2ty3ZMobrv68g+KtzsQH9YOTVlPU+hBtjxQI/infzo=; b=JX15bpMjFwDpmFs+sC/0OIchaQ
	pkdhMppf4dcEgLttxfJKDZscwroPjf+GF4y0dcoAm2rI/rx6WokwRcmHVQrs/ZCcc9IbPXSuP6293
	mTxdhCIt+klFXYOusHSJIRhTzkCjJ579BUcVLcFQPQa7c6MVk1M2oYnlJlg6DYencgZVRel530yCj
	AmxJ+kJYwNpS1zx8hb7H1hy51iZ3G+cprgwY6+Gnn2Gub7navDP4Fq4HrjieHBKx7yRFxjVlnS7Ut
	0cndfaW4KGkRgc0sdfnwyuHKXxlCljFfZG00/ghLHdyyEdL0cE5ldubZ3HCixw18zBCqku9mXLOqe
	hdI1GXXQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uHVtV-00000000qJG-2lXu;
	Tue, 20 May 2025 22:57:10 +0000
Message-ID: <8cc4c232-c7cd-4dec-97c8-3573b5e471c2@infradead.org>
Date: Tue, 20 May 2025 15:57:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: add sk_requests_wifi_status()
To: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20250520223430.6875-1-spasswolf@web.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250520223430.6875-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/20/25 3:34 PM, Bert Karwatzki wrote:
> Checking the SOCK_WIFI_STATUS flag bit in sk_flags, may give a wrong result
> since sk_flags are part of a union and the union is used otherwise. Add
> a sk_requests_wifi_status() which checks if sk is non-NULL, sk is a full socket
> and checks the flag bit.
> 
> Fixes: 76a853f86c97 ("wifi: free SKBTX_WIFI_STATUS skb tx_flags flag")
> Idea-by: Johannes Berg <johannes.berg@intel.com>

That is usually spelled
Suggested-by:

> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/net/wireless/ath/wil6210/txrx.h     | 3 +--
>  drivers/net/wireless/marvell/mwifiex/main.c | 3 +--
>  include/net/sock.h                          | 7 +++++++
>  net/mac80211/mesh.c                         | 2 +-
>  net/mac80211/tx.c                           | 6 +++---
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
> index 33ccd0b248d4..fff8b7f8abc5 100644
> --- a/drivers/net/wireless/ath/wil6210/txrx.h
> +++ b/drivers/net/wireless/ath/wil6210/txrx.h
> @@ -617,8 +617,7 @@ static inline bool wil_need_txstat(struct sk_buff *skb)
>  {
>  	const u8 *da = wil_skb_get_da(skb);
>  
> -	return is_unicast_ether_addr(da) && skb->sk &&
> -	       sock_flag(skb->sk, SOCK_WIFI_STATUS);
> +	return is_unicast_ether_addr(da) && sk_requests_wifi_status(skb->sk);
>  }
>  
>  static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index 1485f949ad4e..7b50a88a18e5 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -913,8 +913,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	multicast = is_multicast_ether_addr(skb->data);
>  
> -	if (unlikely(!multicast && skb->sk &&
> -		     sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
> +	if (unlikely(!multicast && sk_requests_wifi_status(skb->sk) &&
>  		     priv->adapter->fw_api_ver == MWIFIEX_FW_V15))
>  		skb = mwifiex_clone_skb_for_tx_status(priv,
>  						      skb,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 3e15d7105ad2..2da289ec4c17 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2822,6 +2822,13 @@ sk_is_refcounted(struct sock *sk)
>  	return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
>  }
>  
> +static inline bool
> +sk_requests_wifi_status(struct sock *sk)
> +{
> +	return sk && sk_fullsock(sk) && sock_flag(sk,
> +SOCK_WIFI_STATUS);

Missing indentation on the line above.

> +}
> +
>  /* Checks if this SKB belongs to an HW offloaded socket
>   * and whether any SW fallbacks are required based on dev.
>   * Check decrypted mark in case skb_orphan() cleared socket.


-- 
~Randy


