Return-Path: <linux-wireless+bounces-20813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B521A70CD1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E379B3B6B28
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB019AD48;
	Tue, 25 Mar 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6MF6CC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF81EF088
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941531; cv=none; b=Xh/oI4W+EwjeXL8cduNmsJI4ISTBdo68ej7jEGKqq9GZSOlkUDJ+DlpxjYgUu+0gISprYO6ACNERjbLhSlCLg35xIalcij8x2JLTiw4b/KR+AbW+KgzUZ4B2Uz4xn45CJCiWGDTbAcMlC32gw87N+XixsZGIuX8XIb9g0mPOmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941531; c=relaxed/simple;
	bh=DxbUnuBK5ISJePyX2IHCaXKQFXjrwR0Adn2978Bbh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bggsJAqJkYfGvNZ+jFtrjJOqoo8jmIKrvTBT4McKTlBTs0LvdLSTHUZy2G0y8B6nGi9RfMbmc0eNR1HlMpXvxGvxhMAF3P8xZ5etGAz8mUINechbAqhLUkmkVOC6ukpeKdcSUhn3JsaLSnLDv5AVCVv71To1t1DhT7ykHlwWjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a6MF6CC2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3031354f134so7207764a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742941529; x=1743546329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e872gGg4Gz2lxgWQ8PrbHnFp07xu+/jOZUr0j6fpLIg=;
        b=a6MF6CC2oWz49InrEUZIAMfKaoSJktAMJO2sQt+JYyjKmXBOR2l95H4ffjGaTlWJzJ
         y5TcWnEkUn1MliKJYNo15G98GN/9kLlcc4+AC3gZyqWE6p+T+WeirQ8WO5M4EOihxFUO
         p8vJdh0ABQMCboa3q8JMjEfY4IjHPJhNvRSZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941529; x=1743546329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e872gGg4Gz2lxgWQ8PrbHnFp07xu+/jOZUr0j6fpLIg=;
        b=KNOK78yGLiPXOLv1UI20YqeMVBr1wtFdfcvPcvP2WwcucuWHMAluNrzcSRB2+x7H5T
         bDhB05A9dxQNOl8/sCJ6LHjl2gqvF4weeFq3ESF0X7K3mPZUxEtHEDoQvejzYl54forr
         vq41MqJp8Jxxlu57zGOqSTI8JZu3nua3gkBAfk5g6qirrSoc5cLVJHyU4f0a6Ff5fkAN
         Imset4mesUDHeKXN2+CPFIihFE4l4xs86pwVT4rLig8w28sD6amTHVGbcEteITf03o9K
         EMKbJbrbFjTd7SWHnIy2YOqTEqXvwLE+WKX4SpMz3Uo5eLUgCINU5xxOnRcU4aJSYoWo
         d7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJPak/KdUGcqmm13I/+9H86I3rfJ4vehmPa9BtUJRHDvNNzyCQQwNiffaW9Oo4U4EcMQnsGDBKu3uYxndzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCL5v5kZHXV5fKfCUXPw8gMMSKJ7HuIy2c6wHZJJqb6zcoVUQR
	SQ7FOzyN24MMxs4nBaBr27rLGCwlU3yX93PdhS+gmnU9F4gWyXD2oAAyAhSMVQ==
X-Gm-Gg: ASbGnctEnu79hNBjYVM9JGDrXSZ4pgwxZVUuAN3p/S0UiFRCZXEIESqgPRhAShq4oVa
	ayMsyUYKyx9McHPTh4wII4Iw/kfDKHBhANT9wbF4PLdC9ySfp087Ykl2XUN4MOlUAZu1bezHIZS
	atRvbEe0qsQQSBJ+O2DhTgsuQ5l9ynJH63WQmuB0Ns33nK/8JFWXm1JvbcSlEanniYbRKpqxnKF
	Bjn3yCnP4GehrN+x+LGtfOae9SLxnNHkaw7PROBXzp8aFSmL0S7jZzMvT9WtRBms6C1CnrTdjZW
	sYYrTZht85ltHlvIwRniND1MKJo/ALpUXhVybg7zZgnlo1C6uGwFeNE7PnI01RDCJTTGoxx8yC9
	Bp7/z4B8=
X-Google-Smtp-Source: AGHT+IGfR3dYvOb5O7Gtf+Lz8lxv5DNfeDk0VRui04c4b/0fsh/5+kLMqM9QCS8L5AH9kKzdEgIq5Q==
X-Received: by 2002:a17:90b:35c4:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-3030fe7f0fcmr28488510a91.9.1742941529313;
        Tue, 25 Mar 2025 15:25:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3037c8ec9fdsm36517a91.1.2025.03.25.15.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:25:28 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:25:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de
Subject: Re: [PATCH wireless-next v5 10/10] wifi: mwifiex: drop asynchronous
 init waiting code
Message-ID: <Z-MtVj4NpcLuZxJv@google.com>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
 <20250324-mwifiex-cleanup-1-v5-10-1128a2be02af@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-10-1128a2be02af@pengutronix.de>

Hi Sascha,

On Mon, Mar 24, 2025 at 02:24:11PM +0100, Sascha Hauer wrote:
> Historically all commands sent to the mwifiex driver have been
> asynchronous. The different commands sent during driver initialization
> have been queued at once and only the final command has been waited
> for being ready before finally starting the driver.
> 
> This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> initialization commands synchronously"). With this the initialization
> is finished once the last mwifiex_send_cmd_sync() (now
> mwifiex_send_cmd()) has returned. This makes all the code used to
> wait for the last initialization command to be finished unnecessary,
> so it's removed in this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

There are a few things that confuse me in here. See below.

> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
>  drivers/net/wireless/marvell/mwifiex/init.c    | 18 +++++-------------
>  drivers/net/wireless/marvell/mwifiex/main.c    | 25 +++----------------------
>  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  6 ------
>  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
>  6 files changed, 8 insertions(+), 81 deletions(-)
> 
...
> diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
> index 8b61e45cd6678..fc58ca1a60ca8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/init.c
> +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> @@ -487,7 +487,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  	int ret;
>  	struct mwifiex_private *priv;
>  	u8 i, first_sta = true;
> -	int is_cmd_pend_q_empty;
>  
>  	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
>  
> @@ -509,7 +508,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  	}
>  	if (adapter->mfg_mode) {
>  		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
> -		ret = -EINPROGRESS;

Why are you dropping this line? To be fair, I'm not sure I understand
all the manufacturing-mode support anyway, but I equally don't
understand why you're dropping this.

>  	} else {
>  		for (i = 0; i < adapter->priv_num; i++) {
>  			ret = mwifiex_sta_init_cmd(adapter->priv[i],
> @@ -521,18 +519,12 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
>  		}
>  	}
>  
> -	spin_lock_bh(&adapter->cmd_pending_q_lock);
> -	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);

I believe your reasoning around the synchronous command logic, but would
it help to include any sort of fail-safe here for the future? Something
like:

	WARN_ON(!list_empty(&adapter->cmd_pending_q));

? Or am I being overly cautious?

> -	spin_unlock_bh(&adapter->cmd_pending_q_lock);
> -	if (!is_cmd_pend_q_empty) {
> -		/* Send the first command in queue and return */
> -		if (mwifiex_main_process(adapter) != -1)
> -			ret = -EINPROGRESS;

You need to update the function comments now that you're dropping this.

Brian

> -	} else {
> -		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
> -	}
> +	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
>  
> -	return ret;
> +	if (adapter->if_ops.init_fw_port)
> +		adapter->if_ops.init_fw_port(adapter);
> +
> +	return 0;
>  }
>  
>  /*
...
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> index f2e9f582ae818..199a8e52e5b16 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> @@ -2418,11 +2418,5 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
>  	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
>  			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
>  
> -	if (init) {

The 'init' function parameter is no longer used. Can you drop it from
the function signature?

Brian

> -		/* set last_init_cmd before sending the command */
> -		priv->adapter->last_init_cmd = HostCmd_CMD_11N_CFG;
> -		ret = -EINPROGRESS;
> -	}
> -
>  	return ret;
>  }
... 

