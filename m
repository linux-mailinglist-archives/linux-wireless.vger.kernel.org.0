Return-Path: <linux-wireless+bounces-12601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA4A96F715
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCACFB240FA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E191D04A4;
	Fri,  6 Sep 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LlmEtahG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2068156880;
	Fri,  6 Sep 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633654; cv=none; b=e7HUiMXJjn9AGp7pmFXdnOBm+geUtn13/GdgNG/l4LESa/aq3g/JjIciuBrQptbkGhGqCvszaaVczswDrH+S8WJCZ893E7FOwXjKmHa2wQ4b7D0HBw1t/NjQP20icLAco1xafexiO5v0U8jdNXcMg0CthHgasEDWyYxxv9ujG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633654; c=relaxed/simple;
	bh=RNNKstjMPAiuuKozO5yPRYS1HARNRnneasAfawWOtMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj6yx2BOHcG5w4DtnyPFI71/VpxAjt0lmtop0MOezdHwYK3Sd0sVUOd5+BmdGUoYbMO5hFrC60TL9aXCo5m3MlpFLs632Mm25etp2xaizI2Uf+TQWGLLgt3pQ0yjeIVkGvzA1zc3fYb3vE0JhhT+p+WUFRT7zbQaju40Nt1oZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LlmEtahG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 13EFF1F9DF;
	Fri,  6 Sep 2024 16:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725633641;
	bh=l7Ni2p8AvtexQEK46PBSAU7NhUGNeYQJss2Ku2vjkws=; h=From:To:Subject;
	b=LlmEtahGerQXCR1FfgAkwadc3+sw7zeI34hDD3YJXZvN9ii4lDI7ZBvDUHCl0sVKc
	 rFS+WxBcrOm17s5oG9RMlShaKc1yjQAg3xt6i6gC3C/4U5noMF7IoOBfN610sL90o6
	 1p93NaBJLNKeQBCYXFa8d4x0OxFOuyg4vo8CmZJzjMIfUPEoP4UAjOOmnlrZVv5RPK
	 DQYxH4CbWQHFrs0ykqBROCcUFMun5Oj2ZtXeSqc1X7O2JpV/XUUW/WRUXRwHBCgBKP
	 hcLCGvsH5jrg1CvBWMkNsBAu93n58qRZDczgYpNaIY2Dlwc4sgj3wH3bx+Kn7vCwKN
	 5CEcphTHQoTug==
Date: Fri, 6 Sep 2024 16:40:36 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <20240906144036.GA45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-2-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-2-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:23PM +0200, Sascha Hauer wrote:
> The mwifiex driver tries to derive the MAC addresses of the virtual
> interfaces from the permanent address by adding the bss_num of the
> particular interface used. It does so each time the virtual interface
> is changed from AP to station or the other way round. This means that
> the devices MAC address changes during a change_virtual_intf call which
> is pretty unexpected by userspace.

Is this the only reason for this patch or there are other reasons?
I'd like to understand the whole impact, to be sure the backport to
stable is what we want.

> Furthermore the driver doesn't use the permanent address to add the
> bss_num to, but instead the current MAC address increases each time
> we do a change_virtual_intf.
> 
> Fix this by initializing the MAC address once from the permanent MAC
> address during creation of the virtual interface and never touch it
> again. This also means that userspace can set a different MAC address
> which then stays like this forever and is not unexpectedly changed
> by the driver.
> 
> It is not clear how many (if any) MAC addresses after the permanent MAC
> address are reserved for a device, so set the locally admistered
> bit for all MAC addresses modified from the permanent address.

I wonder if we should not just use the same permanent mac address whatever
the virtual interface is. Do we have something similar in other wireless
drivers?

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 +-
>  drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
>  drivers/net/wireless/marvell/mwifiex/main.c     | 54 ++++++++++++-------------
>  drivers/net/wireless/marvell/mwifiex/main.h     |  5 ++-
>  4 files changed, 30 insertions(+), 34 deletions(-)
> 
...

> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index 96d1f6039fbca..46acddd03ffd1 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -971,34 +971,16 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  }
>  
>  int mwifiex_set_mac_address(struct mwifiex_private *priv,
> -			    struct net_device *dev, bool external,
> -			    u8 *new_mac)
> +			    struct net_device *dev, u8 *new_mac)
>  {
>  	int ret;
> -	u64 mac_addr, old_mac_addr;
> +	u64 old_mac_addr;
>  
> -	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
> +	netdev_info(dev, "%s: old: %pM new: %pM\n", __func__, priv->curr_addr, new_mac);
>  
> -	if (external) {
> -		mac_addr = ether_addr_to_u64(new_mac);
> -	} else {
> -		/* Internal mac address change */
> -		if (priv->bss_type == MWIFIEX_BSS_TYPE_ANY)
> -			return -EOPNOTSUPP;
this was the only usage of MWIFIEX_BSS_TYPE_ANY, correct? Did it had any
reason before?

> -
> -		mac_addr = old_mac_addr;
> -
> -		if (priv->bss_type == MWIFIEX_BSS_TYPE_P2P) {
> -			mac_addr |= BIT_ULL(MWIFIEX_MAC_LOCAL_ADMIN_BIT);
> -			mac_addr += priv->bss_num;
> -		} else if (priv->adapter->priv[0] != priv) {
> -			/* Set mac address based on bss_type/bss_num */
> -			mac_addr ^= BIT_ULL(priv->bss_type + 8);
> -			mac_addr += priv->bss_num;
> -		}
> -	}
> +	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
>  
> -	u64_to_ether_addr(mac_addr, priv->curr_addr);
> +	ether_addr_copy(priv->curr_addr, new_mac);
>  
>  	/* Send request to firmware */
>  	ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_MAC_ADDRESS,
> @@ -1015,6 +997,26 @@ int mwifiex_set_mac_address(struct mwifiex_private *priv,
>  	return 0;
>  }
>  
> +int mwifiex_set_default_mac_address(struct mwifiex_private *priv,
> +				    struct net_device *dev)
> +{
> +	int priv_num;
> +	u8 mac[ETH_ALEN];
> +
> +	ether_addr_copy(mac, priv->adapter->perm_addr);
> +
> +	for (priv_num = 0; priv_num < priv->adapter->priv_num; priv_num++)
> +		if (priv == priv->adapter->priv[priv_num])
> +			break;
> +
> +	if (priv_num) {
> +		eth_addr_add(mac, priv_num);
> +		mac[0] |= 0x2;
> +	}

Please see my concern on this in the beginning of the email.

> @@ -1364,10 +1366,6 @@ void mwifiex_init_priv_params(struct mwifiex_private *priv,
>  	priv->assocresp_idx = MWIFIEX_AUTO_IDX_MASK;
>  	priv->gen_idx = MWIFIEX_AUTO_IDX_MASK;
>  	priv->num_tx_timeout = 0;
> -	if (is_valid_ether_addr(dev->dev_addr))
> -		ether_addr_copy(priv->curr_addr, dev->dev_addr);
> -	else
> -		ether_addr_copy(priv->curr_addr, priv->adapter->perm_addr);

With this change, when mfg_mode is true, priv->curr_addr will be not
initialized. Wanted? 

Francesco


