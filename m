Return-Path: <linux-wireless+bounces-7002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307588B60E5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AC9B20D6B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E944128399;
	Mon, 29 Apr 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsuajCu9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790998614C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414187; cv=none; b=H4j4VcScKDrCPyAWNlsnP7C6FRNk7YI64nINchnnAQMYrk1ca6JEMUVkL3S21z14LhGWGgpVhHAxa1Lzj207VLSik0EHcRcjwHsHwdYKZnPgKb0VYKi6nBjxdmEyV0KRepvfl7HrQRPGQx0yhQCCffNMELB+wWCffUv96Hiu30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414187; c=relaxed/simple;
	bh=Z2LOlsSUnMgywQTJQ+7IHJraqyXovy/jnHsooFxUr2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEtUovddXuyS8LdkvZL2s8JgkHfLZKM7wKIXQcUqLYa4pw2+hOHdBtOmBUefYLq8y1HraraAWmw9IwUkO4qIxBDihUUp4EZ9DFdMNdTzSd/bwJV62mNt6g1xcf3qkfa/It4Nfq9xGY/27EezBRzPajOqehPCVlb+tpJa/CToWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsuajCu9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso34546945ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414185; x=1715018985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+37QTrLTPLr7Kc5c3JRWh1bRwAteHaqsrzK+UmsL3Bk=;
        b=lsuajCu9lzKisZS0vlaiK3l5CfrLPvM3MsxE/vnIpIx4TJCjD5I+Hh1uo8HaxWmdTY
         N04Wn1cCkUUmtK0GaLpxqw9x3ymfL1bVgJ3U7Yh+OCwBQN/1bMZfDiLzQDjPQOEbVE51
         fy37YznGKXXXAyGK4sdIIr9ks+PrxxlCl64U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414185; x=1715018985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+37QTrLTPLr7Kc5c3JRWh1bRwAteHaqsrzK+UmsL3Bk=;
        b=T9E4tIMSdFX+pc7TLSoMcXVXm9sIdJIewS+AiJeES32tMDJv+JKZ3MT6FQAEe9psSP
         3m5o8mDvsML/1I8jGCGbVu1MJ8caVPJZAM1TiHBzEWw/H7bDwRMesopXHTXUekahdM+L
         P0vb/NjcZ3D4szZvyNCyMxT26QVI+eQYcbkKUorSVejvUAZ8ERWN8URbjSNFhICf7hui
         RDdz9PbO1rwB0Rw8hn/s0TeHtfAz8itw5mBMk2SCdq+tGfpJjMMBft+qRhuxiKMm1SNI
         LjzbJyo3Igyie5GoH0Yie5Z28PthmvYR228XLSb6ajB9WypEmpjabOWDKHKOaaU31thW
         Z7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXyr98+R/iuycE8PQcQBvFgBE+7yjb6q3ZWkZ22KN6Jw0pNabichOfGiFAy3XGVB1Jf+b9IEn4/dvm31GaC0vgsegg57OCq64PLdey8W5Y=
X-Gm-Message-State: AOJu0YxlfRgYbWFT5xJ6tgdD+Q7YsO3Pxa7tO135gQ4oC1SHCFgcE75L
	r8R4fj6pmresEzXG7tC3mG+QYAVVnD1oB8R4i27nfYsC4sQwwbOBns6mq5wCqQ==
X-Google-Smtp-Source: AGHT+IF8MAuCWI9xQ1t4CFM/UvinhLq/MLyEW/f0X3d0CRIcumGhC4JUlpaad0Aw8KATz6oAmbvB4Q==
X-Received: by 2002:a17:903:22c5:b0:1eb:e40:3e07 with SMTP id y5-20020a17090322c500b001eb0e403e07mr9620367plg.62.1714414184798;
        Mon, 29 Apr 2024 11:09:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001e868e29fabsm20585009plt.251.2024.04.29.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:09:44 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:09:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <202404291109.331E1704@keescook>
References: <ZgSTCmdP+omePvWg@neat>
 <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
 <202404291008.51DB333F@keescook>
 <877cggqdwb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cggqdwb.fsf@kernel.org>

On Mon, Apr 29, 2024 at 08:25:56PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
> >
> >> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> >> 
> >> > Prepare for the coming implementation by GCC and Clang of the
> >> > __counted_by attribute. Flexible array members annotated with
> >> > __counted_by can have their accesses bounds-checked at run-time
> >> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> >> > (for strcpy/memcpy-family functions).
> >> > 
> >> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> >> > getting ready to enable it globally.
> >> > 
> >> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> >> > a flexible structure where the size of the flexible-array member
> >> > is known at compile-time, and refactor the rest of the code,
> >> > accordingly.
> >> > 
> >> > So, with these changes, fix the following warning:
> >> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure
> >> > containing a flexible array member is not at the end of another
> >> > structure [-Wflex-array-member-not-at-end]
> >> > 
> >> > Link: https://github.com/KSPP/linux/issues/202
> >> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> >> 
> >> Patch applied to ath-next branch of ath.git, thanks.
> >> 
> >> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct
> >> wmi_set_link_monitor_cmd and avoid -Wfamnae warning
> >
> > Hi,
> >
> > I was just walking through our patch tracker and noticed that I don't
> > see this patch include in -next yet (as of next-20240429). Is there a
> > flush of the ath-next queue planned soon? Or did I miss some change?
> 
> Yeah, wireless-next was pulled last week so most likely we will create
> ath-next pull request this week.
> 
> BTW we are planning to move ath.git to a new location, rename branches
> etc. I think we'll see if we can also setup it so that it can be pulled
> to linux-next, so that you don't need to ask this every time ;)
> 
> (Just joking of course, there a lot of benefits from having the tree in
> linux-next)

Ah-ha! Thanks. Yeah, sorry if I keep asking about that. It's different
from other trees, so it doesn't stick in my head. :) I should keep
better notes!

-- 
Kees Cook

