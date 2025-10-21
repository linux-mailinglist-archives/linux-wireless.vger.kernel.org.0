Return-Path: <linux-wireless+bounces-28138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9566BF6748
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B31719A389C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E629A2;
	Tue, 21 Oct 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="wcMKSA6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBE17BA1
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049842; cv=none; b=Y0bdSrdb0MJrTwc8BRpuWOeFY/jU9E65WjQ/xscNgEacB82pNIre3rCMi6wnH2OSYokz7Z5gbA0ejTyZJF3UhSXqiRvjrtwVEg7SQ7zlrOclg/aXCd2X7gb4taduB3h3pfZeYqN2ZxeGUe4KOgN/Xhelifst8cRdfviJgcNL8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049842; c=relaxed/simple;
	bh=sOAoarxNZNRQUqbLTxoCxieq5eJ+R8LbPJ/JZ3SdZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL9T6JXgyy/GtxymYNbNaXv8sWvlZfC3SZJPLa6blQVcx5OPyUT4bVfOnVFnIOg4Ewg8iG3RRDeITslU2lDWhxYm88+flHKWGwcSWKg8xlb5TuojkpAVHYKS1O8NmoLomkT1QIETBqtCG+iYk0eT4nHzBtberz2UQ2UsZu68fuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=wcMKSA6/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5027714b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761049839; x=1761654639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbiCoTnm2k68D4+6+y4lbE59vK0Db3fRo3aMMjv+ZvM=;
        b=wcMKSA6/Hg2drUrG9W1RcjFVPp2nmbjt1/cOIypMrCaVss2TbsWGr9OY8X/WRfSI6k
         pgxoqbyoRrzj7ddSLPiSgVkrSYKNsB7EUAYCMhtzf244nE8oO1nW6IQB7Zr3vI2NvVoz
         Q6oEaSIxYGh8Z3XlnuJ+SwltKXQ8ZJ766BRvJnxPU9LMjDUK2hOPQtPlM9V9QJzbT1JH
         vNOq7Paf2+5hNePzOaij8Ce1tADAW4O2dcAfW6AXHYZWE0pfWOsfSeURW+EZB+T2idZr
         6xwlagVeKFEnr8RrdwzmOQJSVMw2ItKdLlzXVRhNIyzl0q0bDhVi1eAl55CVOfYcTYof
         cF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049839; x=1761654639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbiCoTnm2k68D4+6+y4lbE59vK0Db3fRo3aMMjv+ZvM=;
        b=bmvQ2B28ilHTiQJ90EN3eEgqlZyv1uD0Y8hU7iNUQrryDdPMWkzI2DGlwCUnX+Ws0O
         OVEJhq3x6KyqcKWL74qs2CdJtLvTBR61H4aXxLg7zf/ILwY6jMvq4/fza1AOOAZyKcWt
         S9weD84lUcjpIzqBuAz0XDeQ5OA/ujNaKjnl8xQVEcp8eUsMLVO+brVkNH8IDXM+YW6+
         /E5ylPzW5M2c9zYTfAYFJpu8s48YdIkEoOkI5LCkXUgOuVLnBlUndJLS4cQNhc38FyKD
         PDp1A2hJtH6JgG9HxxtZAiFV2TKYmepYEyDe+z0HnijTJ6GWHpRjk/6g8TRdmI+rs7On
         Z/sg==
X-Gm-Message-State: AOJu0Yzrrl13FlYsD0O+GiBUUcgETT0zTkpNkA5FBJDlMS0TqVU8GaLU
	oMo8rh0zOoVF4omZoReKOCyBqjmEsbvbGktB4w+Tv7VP5Yl7F4PfDo6MD2RFFUl2bQk=
X-Gm-Gg: ASbGncu/lek44bj9AU3YAHPd6Z3BAUkNwtswh1JN8rMYvgL+YceFN1qFNNI0FlCzS0J
	g3DiffjtdPNbNLM5uo3McYNWqYUuGzWux4w2HoXxhiiucqd+3VSuefwQmo/M5wkeBhcwZnUCbir
	ilV8bseyDfd1N7QXth86AteXlEq1ErpAeHDGYR4pyz5fiQdy0rXkwuQwfO35ZVOFihNCg9cXTyh
	IBgWSRZ7GN5uaQkDFm9NJjAiBfOlyJO4NRj6DYHaJPe83gqJvplYcXtNMbYOdYW5JkEsvznVYWX
	Yad4Fc+H/eYkmHGf/nkGvtY6HDXmFyb4efGEHzmE2UfzvTycrcJBXhayjsLiIpAYnAjp44nC0BV
	SIUp02zic1KdDp2CFYizGDrJIJAwvaECusAoqsaJPB4xbcaPpGLyQezeB1FigPYg0SGmW9a16/y
	DdnuCtemlDaN0KC6X0HpNAU5+sDTpYXw0ytAOMdBu5bA==
X-Google-Smtp-Source: AGHT+IEa5BbogVcRaLwqWjYrHOXMeK5EnSbrLUSyee8qcGhDqkvwsEom++BJaJ/y23l27T9CutGrYw==
X-Received: by 2002:a05:6a20:7486:b0:243:fe1e:2f95 with SMTP id adf61e73a8af0-33495c0e1cdmr31967986637.6.1761049839002;
        Tue, 21 Oct 2025 05:30:39 -0700 (PDT)
Received: from localhost ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm10077619a12.10.2025.10.21.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:30:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 23:30:35 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless] wifi: cfg80211: return center freq for 1Mhz S1G
 chan start/end
Message-ID: <w3kcceceh74ss6asnatle33bs5us76rzbjihi4dm6binjd7spi@p6xm2eu4zirc>
References: <20251021110725.397982-1-lachlan.hodges@morsemicro.com>
 <ffc008eee90574ce4e1579a1222e55234818fdd3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc008eee90574ce4e1579a1222e55234818fdd3.camel@sipsolutions.net>

On Tue, Oct 21, 2025 at 02:20:45PM +0200, Johannes Berg wrote:
> ^^ should be MHz in the subject
> 
> On Tue, 2025-10-21 at 22:07 +1100, Lachlan Hodges wrote:
> > The frequencies returned by cfg80211_s1g_get_{start/end}_freq_khz()
> > for 1MHz chandefs are off by +-1000KHz. 
> 
> Hmm. I'm confused.
> 
> > +++ b/include/net/cfg80211.h
> > @@ -10194,7 +10194,8 @@ cfg80211_s1g_get_start_freq_khz(const struct cfg80211_chan_def *chandef)
> >  	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
> >  	u32 center_khz =
> >  		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
> > -	return center_khz - bw_mhz * 500 + 500;
> > +
> > +	return (bw_mhz == 1) ? center_khz : center_khz - bw_mhz * 500 + 500;
> >  }
> 
> I don't see how this changes anything - if "bw_mhz == 1" then
> 
>    center_freq - bw_mhz * 500 + 500
> == center_freq -      1 * 500 + 500
> == center_freq -          500 + 500
> == center_freq
> 
> so this makes no difference?

Is there a way to remove this patch from the internet forever? heh ^.^. Sorry -
I have clearly forgotten basic arithmetic, though I'm now questioning why I
thought I needed to write this in the first place..

lachlan

