Return-Path: <linux-wireless+bounces-11815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6F95BDFB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 20:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881D9B210F0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09021CF296;
	Thu, 22 Aug 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjMtLYV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3B1CDA1C
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350059; cv=none; b=scAMl/DSVpxFoKaDhBVIyxiLoiROtxyXdvcONFxkIT/1++8TX73jcjQLs0BJunbM5xYKsAYiZDtRqoKFMj7MSqn8dOjUbfBa6o8EMd2Xq5mJP7pbQg9ComSUqfs/nvnDXS/wY9wxSjv6bDrj5/YZeJ3GvuKRvAPPzQgfdMTJgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350059; c=relaxed/simple;
	bh=1O9vC8Ub5ix8LyTH4b/+Hy7eOAcgoYhD/5DXIM/VygQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk30dA9ytiINLJs4oRQBG+mkvFCU8cmvVZ6ECIg1+QVeM+/c82JiBAEGO1qCAg0JjxwgfqzHO1l6U4qv8GA8VjlpB5/ktw9tqQIoNyk9BR1IoqSte2XC23YbgwwIcDbwE8FbvyphHOXjBCy7EtUh306qI+joRqtlE85H/sn0wpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZjMtLYV6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so846473a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724350058; x=1724954858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/pvOZ8QmQOJgVwLDkuJvTgRqV+BiNA2Wp1U0v/4kwo=;
        b=ZjMtLYV6A1EKgpVMpEKNfpFJZegYaMLhj3hjvNnXs5xXWUn7AkxraUWF4NTXmRazZw
         tmmBgr1nSUBufdw0tfFnUhD6Lmww7uElFKTxWYR6a1L64G15r7JVZhuNllOttS6CxTh8
         Pm/9Reh13XaKVykBdddeoTP7n0v+BGT1HwEIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350058; x=1724954858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/pvOZ8QmQOJgVwLDkuJvTgRqV+BiNA2Wp1U0v/4kwo=;
        b=Kds1UZNE1US/2dqFGqhIVmXnz8fvtlKiLyKR6ak1B0g21vo6liXEUmEbdVYedZ3oX9
         nfqWyD1MyLEcmP+1C/G2WmaQwaCFe5Nq4VGwfwD1LvQWLqSZjA3pBeJGMbgBKKIbm/zM
         7rC8P4H0fKKrJxAG+kK9LLGAzJGhN3uWym2VD68gjAdDRQ51hhblPvo88PlijMY5K0nS
         eqJCw8paoI9E4Cvw6i80PpFVrfcpsTOqzQLYhDQ7G3MTZtNWn8XugMmRKoJ/hGRSEhYK
         uZiDEzja0NKNfSVzZ6QoIi3SbBgM74p+Dt0+cmHw9+VMTZzCtyxGvR3t95gcjnYtHedc
         cMmA==
X-Forwarded-Encrypted: i=1; AJvYcCW4TCcGe04E6yeIGHMcB/4w+M6qqsmlnkJ3Garf8mCtIGyCB6iyZsOBWiGCsnIKkNft+035ZfY2CO9ERfcxXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1562l8GoWBivPcY9iqkgiVozzYuiJmhQEqPdxuj6owTViwc4I
	ueFPJTNXG0+Ql2OlNscgn4ZagZJAwHD2LbJFFXZvVEClnr9JZqQ0PmFmGt30Yw==
X-Google-Smtp-Source: AGHT+IEvb1NFF7jDJJq6my2bW/vOgpn7OwDAHHPeb3en8xgSUD8A2nA+Vjnbu2muHEJGXT/ggFNSPA==
X-Received: by 2002:a17:90b:3b45:b0:2cc:ff56:5be1 with SMTP id 98e67ed59e1d1-2d5e99c52d1mr7283937a91.7.1724350057634;
        Thu, 22 Aug 2024 11:07:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d613a6123fsm2181163a91.33.2024.08.22.11.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:07:37 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:07:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Message-ID: <Zsd-ZxscUBmf0xsu@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>

Hi Sascha,

On Tue, Aug 20, 2024 at 01:55:28PM +0200, Sascha Hauer wrote:
> The command response handler copies the new MAC address over to
> priv->curr_addr. The same is done in the code issuing the call
> already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
> handling.

It took a bit to figure out what you meant here -- I guess you're
referring to mwifiex_set_mac_address()? It could help to document what
you mean.

I'm also a bit torn; this command API ostensibly has a (unused so far,
for this command) HostCmd_ACT_GEN_GET mode, in which case this *is*
important.

If anything, I might consider dropping some of the handling in
mwifiex_set_mac_address(), because it seems to presume (and then has to
undo for failure) behavior of the underlying command.

Brian

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> index 9c53825f222d1..7f81e709bd6b7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> @@ -473,25 +473,6 @@ static int mwifiex_ret_rf_antenna(struct mwifiex_private *priv,
>  	return 0;
>  }
>  
> -/*
> - * This function handles the command response of set/get MAC address.
> - *
> - * Handling includes saving the MAC address in driver.
> - */
> -static int mwifiex_ret_802_11_mac_address(struct mwifiex_private *priv,
> -					  struct host_cmd_ds_command *resp)
> -{
> -	struct host_cmd_ds_802_11_mac_address *cmd_mac_addr =
> -							&resp->params.mac_addr;
> -
> -	memcpy(priv->curr_addr, cmd_mac_addr->mac_addr, ETH_ALEN);
> -
> -	mwifiex_dbg(priv->adapter, INFO,
> -		    "info: set mac address: %pM\n", priv->curr_addr);
> -
> -	return 0;
> -}
> -
>  /*
>   * This function handles the command response of set/get MAC multicast
>   * address.
> @@ -1232,7 +1213,6 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
>  	case HostCmd_CMD_MAC_CONTROL:
>  		break;
>  	case HostCmd_CMD_802_11_MAC_ADDRESS:
> -		ret = mwifiex_ret_802_11_mac_address(priv, resp);
>  		break;
>  	case HostCmd_CMD_MAC_MULTICAST_ADR:
>  		ret = mwifiex_ret_mac_multicast_adr(priv, resp);
> 
> -- 
> 2.39.2
> 

