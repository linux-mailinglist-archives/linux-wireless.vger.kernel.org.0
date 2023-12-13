Return-Path: <linux-wireless+bounces-763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A84811F07
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1374628271E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A768265;
	Wed, 13 Dec 2023 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZnmOgFxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436AAD
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:37:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso2356409b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702496232; x=1703101032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKFrk1J/zY5B8/hw5jHalDc7wotPr7TIY0wnvEd3yKU=;
        b=ZnmOgFxKwJ8Re0/W1X7QINsnOx3n6keubr66ij1nLZJ7ENeDku6jXTSRQF94mAlwqY
         KOGmS9DsIVribSCUQHsKzKI4m5RlDiPvh0vRXJ0dmR/dPzwWkajXlSWrnppaEdj2fOGy
         uT7o7ErF5rlM/wIYddneiSAxReOdA9ZbvSNys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496232; x=1703101032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKFrk1J/zY5B8/hw5jHalDc7wotPr7TIY0wnvEd3yKU=;
        b=pjLy3XGvqz/nC/HhOQuVaW5oyGYiq6XxicsOB3z4nWo+vzrLtlrJj8puFmlQhq9QMZ
         QdggBGURyPq5zD+LA7eMx/ShI/ycwPeeoAPJoxuSw4/5SYhCqcC+9fRmk6sSYnnm2DAn
         T/i+6rvq9CF6OpoalKH3eblOFyB19+9TCJnTvPDEkCJWObzEgsvlMbwBx+ssZ7G7IH6d
         1hHmxePhB3T3SFvZxEcdWC3Ik3OHf+7+a7+9a/59wBOONDScfIWz+AFJPjNYwYq+Kqjn
         EeGg1QufKS5HdI859Vem4Y37j0ORl3NBwGIdyluklubOCCM/W0P2XNSrDkSlxDQuxYEL
         S03w==
X-Gm-Message-State: AOJu0YwevyZm+JR3I0C4OLEyHlImtNMtAfEmSs6LJE/bp6FRg3FB+hw6
	T7Xkfh1Mb4IP8j5oOR4/6Wmagg==
X-Google-Smtp-Source: AGHT+IEWAmv4wu9vPJK2ICJzCkDWUMORDZXKYB0gKPC3a7NsXvr4GtEaXeBkWd0hXxXYBffoLLIBHw==
X-Received: by 2002:a05:6a00:1151:b0:6ce:2e16:3771 with SMTP id b17-20020a056a00115100b006ce2e163771mr4969573pfm.22.1702496231709;
        Wed, 13 Dec 2023 11:37:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b006ceba4953f0sm10685026pfa.176.2023.12.13.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:37:11 -0800 (PST)
Date: Wed, 13 Dec 2023 11:37:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Message-ID: <202312131136.5C46279@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
 <202312131113.4C01D1DD5A@keescook>
 <bdabfb74-ea4f-4455-bb4c-1d93977393ea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdabfb74-ea4f-4455-bb4c-1d93977393ea@quicinc.com>

On Wed, Dec 13, 2023 at 11:36:08AM -0800, Jeff Johnson wrote:
> On 12/13/2023 11:16 AM, Kees Cook wrote:
> > On Wed, Dec 13, 2023 at 09:06:44AM -0800, Jeff Johnson wrote:
> >> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
> >> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
> >> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.
> > 
> > Is .gen_tdls_peer_update only ever called after a fresh allocation? It
> > wasn't obvious to me as I tried to follow the call paths. Is there harm
> > in leaving this?
> 
> The only harm is a slight increase in code size and cpu cycles.
> 
> However note the skb allocation is done within
> ath10k_wmi_10_4_gen_tdls_peer_update() itself, just before the code
> being removed:
> 	skb = ath10k_wmi_alloc_skb(ar, len);
> 	if (!skb)
> 		return ERR_PTR(-ENOMEM);
> 
> And in ath10k_wmi_alloc_skb() we have:
> 	memset(skb->data, 0, round_len);
> 
> So the memset() being removed is always redundant.

LOL. I see now. I missed that was was looking outside the function! :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

