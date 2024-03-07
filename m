Return-Path: <linux-wireless+bounces-4463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07F8755AE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 18:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AB41C2334B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780F131750;
	Thu,  7 Mar 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvsqJQXD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CA130E30
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834359; cv=none; b=nA0ykHKmpqTSvpQ9CyWFFbT9TH3r3L86yVjuR3G1uvmuzdkt3B3aS3JDdbQvKgt+OLJTEuAj6Mp5UuWbg4rafMhXnxRRNQt4CohTFzSk4T9R9SyzftiqWlAlRvydrePIXKONQArMKwfLZ3bbnLEpeaJkuuStfC20HoiKhP1rGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834359; c=relaxed/simple;
	bh=O2hdfjlzZlZ0CPCqJt23wbPJbF7Ae0mInAc+itOKRtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOKvx7RSTXOr56kPH2b9T8n/bd+JzOTONhb9wWv5ndUIvoq3BXTIVpEmBXi7D9e5M4tQn5yfqlk98frDDCiBsCi6BFuxeQX9nEexYQ090ydowgr+91Txl+te/XBqI6BdP2KvafV8vu6uYO1SdCwZfzO2pXRGkvO9TA0wfmQBrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lvsqJQXD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da9c834646so1082886b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Mar 2024 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709834356; x=1710439156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEqlp2HgRH1JvED8C1eQ8Jd7JtBfD5vT+Rfxt4u7aG4=;
        b=lvsqJQXDodKjSvzCkHGyvGIv590mgf5/x5L8bNeJIkKlUuhyrGYEXKSyBKohU4K58c
         8FK2Z//BCr7b8m1Egf1qWTEoL146hwp8ibyRWEvnAgg13VrTXobJJa13emiBnrAi1sgP
         Hj8OxNmc8Be94QSabBeN6nbcM8WDbqE2K10Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834356; x=1710439156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEqlp2HgRH1JvED8C1eQ8Jd7JtBfD5vT+Rfxt4u7aG4=;
        b=P6urBFLyD6pSeAcV1Zs9S6eNjJRbyCO8SgfatzvIpwMmJ/Z4w6XzJunjojeT0BbUVg
         L3XNe3Rkfu/7nHPA8WfTXLmMgQ23NCbVcpXx3PS2Q1cysoqF2ssRKcvQA3xEe+5xWmwD
         y+vgy8ahJYIAIm5VHjwMrmY08Ug/3ONtKQv1rmO7gM56l5zSc9ed/rXDnD+0sOoLNPVt
         Fd9X46NkOHKK1pxWLrew0IvpQMoL2rAMX6o9EY+/7SGQOxfB8dC1yyFECW9c0BFAaK4Z
         hPIHgH9kUJaV1cgl70HoTJk+RgLPKpjdLiEt6IhJE48Z/kSuD+f/oqdrgnJCLPilhll6
         6Rxw==
X-Gm-Message-State: AOJu0YxTqAK3VRAIAuJGHq6N9AsjQigT7ETg2yt7e101iEwpZ+fIlWnK
	Px7FDDqBO+i0UQTlx9CGJj20ofto+qkf6LwlUS8Lf4imN4htSMl/9g5Eluy2wg==
X-Google-Smtp-Source: AGHT+IEOvEuUqre/6sdNhgEG9LkJsdT6YuHjsXW6DtfCKNmHlmt7CPFD+bSq/JO0jH9mi0j5BLd1wQ==
X-Received: by 2002:a05:6a20:da87:b0:1a1:4cd2:441f with SMTP id iy7-20020a056a20da8700b001a14cd2441fmr9864304pzb.6.1709834355997;
        Thu, 07 Mar 2024 09:59:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a63e944000000b005dc1edf7371sm13198387pgj.9.2024.03.07.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:59:15 -0800 (PST)
Date: Thu, 7 Mar 2024 09:59:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-wireless@vger.kernel.org, johannes.berg@intel.com,
	gregory.greenman@intel.com,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, kuba@kernel.org,
	Alon Giladi <alon.giladi@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: allocate dummy net_device
 dynamically
Message-ID: <202403070958.BE50CCDC@keescook>
References: <20240307174843.1719130-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307174843.1719130-1-leitao@debian.org>

On Thu, Mar 07, 2024 at 09:48:31AM -0800, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.
> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct iwl_trans_pcie by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at iwl_trans_pcie_alloc.
> 
> The private data of net_device becomes a pointer for the struct
> iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> given the net_device object.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Ah, nice! Thanks for doing this.

I had to double-check the pointer-to-pointer stuff, but it makes sense
to me now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

