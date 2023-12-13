Return-Path: <linux-wireless+bounces-758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E660811E79
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B021FB20F10
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB75C081;
	Wed, 13 Dec 2023 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4osAj7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E899
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:16:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so43756555ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494962; x=1703099762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Br5McNKdDym1wVpBK6ZxqsWLJASJUX98L4YfXiPz+I4=;
        b=M4osAj7n5fVuu0d2QVU/hVsbixcpCa/GrQXR8qiQgTT38HTQGDW8Rxln6DRS29lC1I
         /aOM6Y2SGohkmZNOTSxmmu64Ge2UhwxX9NBeLUuu+vLoui7JDjcfgZnlIDgGDXkHaHIf
         zt1L/nQJOfrcoZFRAzxBmvvczRgDRvjBr4bhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494962; x=1703099762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br5McNKdDym1wVpBK6ZxqsWLJASJUX98L4YfXiPz+I4=;
        b=PG8fGl1BrtvbT6WrXXF1+7BYeLoPArHQrJdFHSz/txsg1hzuzVtVJaAUY3Usiozy4Y
         DHLhtnIIZzIkJikdlsNRdjTd7l+KuNqlWyKVDWyYxX/CcbjL+OD2EfBbiGvGxvwjbaSv
         8eFrUwSDVd9mC1exUcrCBWWU27jokGvmGbG84RNKjbWIUFYTR8xAQDYHNPGzxJ21MWH8
         dxNGTVlOK3W0DMJ1jC7yfUpiv9HAPcyHpRvO5KD98UOCSatjezc9Wy2fvzM0FeiCENKI
         eoiZg1Yu9CRw2IwVu+dhTSabfxk3QxUFKvL9BiHenVGG4x6AP8ql0/8fwfeT0sQCLnvd
         Md3g==
X-Gm-Message-State: AOJu0Yz9zRWOkASYSPcYglaQG7xpakKSEOEwJ5sZK7D8aSpL8KXiLs26
	of1szHQ6qPebrZYysvMDM5FJLg==
X-Google-Smtp-Source: AGHT+IFoskKiE/aMuNO9zn8FAfarVwTklXpACZeypIRM0uei3Al3NZmvnOp5zIAhin3jtPPkFxdKzA==
X-Received: by 2002:a17:902:e804:b0:1cf:7c3d:df68 with SMTP id u4-20020a170902e80400b001cf7c3ddf68mr5893869plg.39.1702494961970;
        Wed, 13 Dec 2023 11:16:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001d331bd4d4csm4097248pls.95.2023.12.13.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:16:01 -0800 (PST)
Date: Wed, 13 Dec 2023 11:16:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Message-ID: <202312131113.4C01D1DD5A@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:44AM -0800, Jeff Johnson wrote:
> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.

Is .gen_tdls_peer_update only ever called after a fresh allocation? It
wasn't obvious to me as I tried to follow the call paths. Is there harm
in leaving this?

-Kees

> 
> No functional changes, compile tested only.
> 
> [1] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath10k/wmi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 4d5aadbc7159..0cfd9484c45e 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -8918,8 +8918,6 @@ ath10k_wmi_10_4_gen_tdls_peer_update(struct ath10k *ar,
>  	if (!skb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	memset(skb->data, 0, sizeof(*cmd));
> -
>  	cmd = (struct wmi_10_4_tdls_peer_update_cmd *)skb->data;
>  	cmd->vdev_id = __cpu_to_le32(arg->vdev_id);
>  	ether_addr_copy(cmd->peer_macaddr.addr, arg->addr);
> 
> -- 
> 2.42.0
> 

-- 
Kees Cook

