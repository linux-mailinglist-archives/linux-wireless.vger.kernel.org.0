Return-Path: <linux-wireless+bounces-26679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034BB37AC7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74734E3746
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479681E9B12;
	Wed, 27 Aug 2025 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ua5lA62Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F646241696
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277419; cv=none; b=WA7wSvRbBRAIdVHdd7lmJR4+CArkWhfxwFEAgOOkIxI3PpMqvORSiZd2+1zTMUl8pQMCivECUCNEs0Lh8+SZgLFnfaDv7pGN1SDXppUW6V8B/p6WNytZCTzg4Rawq5WG+zoAQ9/WIGlRYwm1KcqvfTihsigw75kvF+GqGSx0Em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277419; c=relaxed/simple;
	bh=NkC+GwvEas2XR0AbvIuP85lnoDLc+qj84ioC+bL/TQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh0Ghb+AifPInVMRyxps5rLqyUj0rdIJQhh0SWQnnPFj5kGKh4zcOSfFkT9h8sCgqcY+h1Lv6abjh6giip2SiDeX89cse3AAXVI+os1u1OFtTSrpyskfwv8Hvt2w+xAr8X2TMWDlEBNHjz0qnitrq/tNC07V1PO+aAXrQSWAVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ua5lA62Z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e5f058so4432284a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756277415; x=1756882215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgUwLSwQ2M3USUMCbVvlZaH7p0NKbMR1fk2OIuXsXY8=;
        b=ua5lA62ZK6XBuJzfz4Y1iDu/n1sqLhs0fbFJAsOL0JHc/7p7I5ZusOeRS+A9j5kfdm
         KpdC2BkllciX97BKXebiZdYlVRPQt5VT6wxXsC3LJQPp2jeTNKcoE9Ntj7MRSPvJVDUm
         pFsmJ0haVo6+duf2RIrwBaUNqenR1hZVgA9hMD1Ca51MEywAAN+w4a9YiL3YPdcWjyaz
         T5TO9xWmGHn29Lj1YbN8fDpHf3aLLHnNGX9F5+DTh+Jgc85mD6X1PQTUS3gjSOZ+IRZ7
         M5yoEC0KT8BQTEQTHyduVu3rksERABcjpyChps7+GntjEbStmA2uLcbBeUfZgtVmP+5H
         rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277415; x=1756882215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgUwLSwQ2M3USUMCbVvlZaH7p0NKbMR1fk2OIuXsXY8=;
        b=kop049OcssHMlr5e5hBsrG8qyXcwlz0qNYPG9AOO3Att9jApxScOSaDGeOd8FJnAfQ
         aRjLybF1TpTwFBPNfK3at3l8jnyZKWOkgXy69UC+KrD01wuIexIXJa9WzMH1/IRwjd0P
         fpWC3aMUN63QfvmfPMO6K8XJT8uoER6EQDjeTBy2A5K01dybpsfqdtYKvwWTQRi594i9
         8G3qkKwffIuG2Bad3vyfyRhberNX4G5dRB8FQR98v0A+rJSQIp3PyGQw3rE0/PHTGVNF
         upJjDgQXyT7OhwgmndKZLiF16fpRqX4pYRR/PmypGWgSqtjSPH66IJyTNToHY4LNwWRN
         lMpA==
X-Gm-Message-State: AOJu0YzI3Uh9T9/ZaU0tZyFYriKj01Tt1WNRxb7z1NoTeS4e6+eeY7Rl
	vMxmqgY+nqbg+GebKiRvoNc3cfVlETI8iM6cu2BJMmm4Gb3ORClcJM3IxaTq8cbLh4V4aP2nAwg
	VgeJA
X-Gm-Gg: ASbGncupnULqs+KeCop+PEnHpl3tmh0mCkAMyN8K6hvOCzLeEU9Dq4Gnjs1S6WFke2a
	7R0ObsfuZ1RZHQfAYjYIaFgLHeaNthwVqYTHBvPCFxzOIMKxJDotPPltOsJti+kDa9wHMZ/SL/q
	vRerlO9zHQGIm3AEeAofJaB/esnRer71Kyb7/bs1aWDM+uaNWNP2OF1Um4rOgkOijAtVPpEJyQS
	dCqYTEj1kF+ztt4kjmjuDQCdFxZgtrN7BuC7Pb/kj7PjdzG5j1dMDFzTIQmP5dme+BGoeTEXbLD
	hL6Q6F9y+BEdypLM/sP7Q+yc1hPskfBxrKOXYPgd7WM0QmydDkxSGFdEKutxhQeOoer7AML2G6O
	1O8rODJItrvGDoPNWUNO0HbUw9zdrZ8DICpRE64Fp8Q8ailpca9IDUPOxmN3QE/u7Nke9+Ry43u
	c=
X-Google-Smtp-Source: AGHT+IFICHYnH3kocB0ng9xRYLD9gjP4CaSDEKVkPnZ9/vYYSf6OzOY/d4SOkIWGDU3UZNFI6Iv44Q==
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id 98e67ed59e1d1-327734aafacmr1273480a91.10.1756277415354;
        Tue, 26 Aug 2025 23:50:15 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f9cba6dsm1148239a91.22.2025.08.26.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:50:15 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:50:11 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless v3] wifi: mac80211: increase scan_ies_len for S1G
Message-ID: <wrloz5uxqofvizjipq6jza4g3arsssplpyz6gixwm437kpreph@k7bgibao7u42>
References: <20250826085437.3493-1-lachlan.hodges@morsemicro.com>
 <b813a59f1e1e6b38517a12f3c0c4e512c07ebefb.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b813a59f1e1e6b38517a12f3c0c4e512c07ebefb.camel@sipsolutions.net>

On Tue, Aug 26, 2025 at 01:49:51PM +0200, Johannes Berg wrote:
> On Tue, 2025-08-26 at 18:54 +1000, Lachlan Hodges wrote:
> > Currently the S1G capability element is not taken into account
> > for the scan_ies_len, which leads to a buffer length validation
> > failure in ieee80211_prep_hw_scan() and subsequent WARN in
> > __ieee80211_start_scan(). This prevents hw scanning from functioning.
> > To fix ensure we accommodate for the S1G capability length.
> > 
> > Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> > ---
> > v2 -> v3: don't include kernel test robot for a new patch...
> > 
> > Again, targetted wireless.. but not really sure if this qualifies
> > as a "bug"... I gave my reasoning in the reply to the first patch:
> > 
> > https://lore.kernel.org/linux-wireless/3j7kkqznavkxt23iopacl626xkppzcitiactxz43axqorucrvu@6gaixffy7zaj/
> 
> I'm happy with it to go to wireless, and will just do that at this
> stage, but I'm also curious how it would matter at all there?
> 
> The only driver with S1G right now is hwsim, I believe, which always has
> also other bands and HT/VHT/etc., so wouldn't it allocate more than
> enough space anyway?
> 
> Feels like you should only be able to run into this with a driver that
> only has S1G, and no such driver exists upstream? Or am I confused?

Thanks Johannes, and no you are not confused. In retrospect I should've
just targeted wireless-next since the "bug" didn't affect anything
upstream anyway (since hwsim used the other lengths as mentioned).

lachlan

