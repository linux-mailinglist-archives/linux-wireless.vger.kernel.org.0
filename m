Return-Path: <linux-wireless+bounces-20892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27EEA73450
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 15:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C249174896
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90008217716;
	Thu, 27 Mar 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFxsw9dy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18190216E30;
	Thu, 27 Mar 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085499; cv=none; b=kQ9ca814J9P+dmkh3JjJVcc0r6mFYVq2S9Wn6s1sFlzpjUoPdMc/RB6TTi1Hh2SaQWzGbdr6Fn+76tcioR7vf4d41icMdaJSHacWApvSslgipyTzi7Ig6V3+BPDGfF5RSieRHlal54jV06zB6MVtYzOHOM+iJ5zd/NuLqWQKXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085499; c=relaxed/simple;
	bh=yEABp3GiFg/+0kZlvIxOmAhS8Jdg7pfZN6WQVp7VoUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbpXkefjAA9/v0f7GBCL811pbheO/G+5MsvblyD8mv8eAlZwvdIcVCcwXuqvNJZCWJfnw3ZEfL8dYWZcbOa0Ndr9ZUHCrvGXK3YARlYaABN1BoNZfJaXJjW+cx+Xjv8kYqnQryK3XoFRiAAggbbrUCfocFbWalAqZZhmm5gAQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFxsw9dy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so1304275a91.1;
        Thu, 27 Mar 2025 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743085497; x=1743690297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui62GSc9Eq6wueICfZ+2gQlUUj34FyRWiYMHHZxzwpY=;
        b=GFxsw9dyRH78yUblxh0cDrQk9chef0waLDO+7fU+isICdbE28bbL/mUZqciaaGO2QT
         gHHWViBmlnfRZ6JL2bhpbGwndhTDEJNQo2ekn2JEoQHbTiEEH3AI1SSKwZ5s47efHQLh
         OMhkxCRjJ6eex4Wd4GizuHKfMr1N32BoOTjyU+D0R9sdjO5JuJQi5IbXTsfP6a87bvwC
         +KZ1e/hVbVc7iDaddNbA+uEUtnJWxZnrimzbZsJMw84rhOOsiE176XP/gTgj9nFOb5iN
         trrVBkox714MvvJFRwihaiPLpcfUUEeND3o4aPhDqYGPo2yzktm0dqUUcYzrqUrf3Fnd
         PVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743085497; x=1743690297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui62GSc9Eq6wueICfZ+2gQlUUj34FyRWiYMHHZxzwpY=;
        b=m7WWJ8GXmMh30P1juqRed5ZG7gyEL96mAnqOjIkNS0dO+Rm+8sK4bKBr5HgzMwd1NU
         EDWfaB7B02wNfe7QKhp+ctQF33CIJVLPSUXM3vy+xa2kfpqUnIU/VYjtZqFUUSh26KAl
         UvPBYSlLguXdNV8k9q+o7enDd9i+VZzEPBbMdN6/f2ZKIrvOhHY78pAEfXlDWXT58xTD
         AszGtHHWsQFwaH4dM0Wp5m8U9sc3bD5F3mEjVeveT/7lYAEecRs7nLDnUhOhoDkThWRK
         S5gzvIdVSXNTKO1Z1Ex7v4yNxaCiRYDhKthbarftzMrV4hyqeDegHDy0NMXpKIrMfNLS
         fYQw==
X-Forwarded-Encrypted: i=1; AJvYcCWLRr4e6iXbLRUWyyVKT9TphxZJrKue+xk7+IjJovHlZdxf8KBNkXAJJIu+a0s5Y/w7R1owJSzytJHuQZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jgA9cnnTqrTIIk0vCfzK96mG1JStZ5mPARcVOiJE6A+pvWpI
	szcuhAfUpKvv02u2K0u5Crl6PABDsudTbjAW/LgP3a/7e2nbl3oB
X-Gm-Gg: ASbGncsFHSh47Kuxm3yw+wyjt9CoIjH46PNJ2Lt2fEOlU4RF/AGOLHpvqVUbXkpEXA7
	yMYsWmGJo5TZLqXRV+eq8h22jel64fHHUfR5Sc1q4tElhnA0XR3ZG8+rMF5RHvCPmEBEDs7wCmA
	qIpQglTZ0JFTHQEmWOJx8VFRcv/bmgXlx+KRonHi64RYGOjKFzVT4e7POzXzJmylKc7Ww9cIB3n
	CdT0i9bv+6WADn7WrOMHoQF4CkimQn79As4npd+xFwwDFnW5ZEwG90QjYsnC1ukuTrkB2oHzxE+
	1c7d+rOsR64cwY4YaCPwx3tLPz1Y9Hx6Fl4UG1n3HihWaG1Vs3Etc4a3aYIXdQ==
X-Google-Smtp-Source: AGHT+IELMj2xTDIqmJ3olXE5sPSsOQeADisXw6ErmX9HsLW4/v/8UhpHXEub4NyNRuVwWrSKIIhZQA==
X-Received: by 2002:a17:90b:4a4f:b0:2fe:a77b:d97e with SMTP id 98e67ed59e1d1-303a7d66285mr5967141a91.11.1743085497131;
        Thu, 27 Mar 2025 07:24:57 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:ccef:3c67:33df:4a11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f65casm128759295ad.230.2025.03.27.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:24:56 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:24:52 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] wifi: mac80211: Replace strncpy() with strscpy()
Message-ID: <Z-VftFBpDBT6l1f6@vaxr-BM6660-BM6360>
References: <20250327141108.182585-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327141108.182585-1-richard120310@gmail.com>

On Thu, Mar 27, 2025 at 10:11:08PM +0800, I Hsin Cheng wrote:
> The name of vif which is "vif_name" should be NULL-terminated to be a
> valid string, however "strncpy()" doesn't guarantee that. Replace it
> with "strscpy()" to make sure the content within "vif_name" is
> NULL-terminated.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  net/mac80211/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
> index 72fad8ea8bb9..37f5b1c87709 100644
> --- a/net/mac80211/trace.h
> +++ b/net/mac80211/trace.h
> @@ -1725,7 +1725,7 @@ TRACE_EVENT(drv_switch_vif_chanctx,
>  				SWITCH_ENTRY_ASSIGN(vif.vif_type, vif->type);
>  				SWITCH_ENTRY_ASSIGN(vif.p2p, vif->p2p);
>  				SWITCH_ENTRY_ASSIGN(link_id, link_conf->link_id);
> -				strncpy(local_vifs[i].vif.vif_name,
> +				strscpy(local_vifs[i].vif.vif_name,
>  					sdata->name,
>  					sizeof(local_vifs[i].vif.vif_name));
>  				SWITCH_ENTRY_ASSIGN(old_chandef.control_freq,
> -- 
> 2.43.0
>

> The name of vif which is "vif_name" should be NULL-terminated to be a
Or maybe it should be trailing NULL-padding when sources is shorter, if
it's the case we should consider strscpy_pad() or other alternatives.

Let me know if there's any mistakes or tests I can help to validate,
thanks!

Best regards,
I Hsin Cheng

