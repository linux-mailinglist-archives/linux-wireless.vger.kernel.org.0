Return-Path: <linux-wireless+bounces-26321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5392B22AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D011884223
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3F2E9EBA;
	Tue, 12 Aug 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZSouSQE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8D2EB5AB
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009106; cv=none; b=Hfc+sojj9LCLWqHfvamGdyX9bYZGO3DOreORJVm//kFXpg77pXrzrsIgDGy9AAvQj4cylZUH5UQnFW73y2SKm4q9J1JxqAkUWkInjdg34RLiCrQw3kitbtsIWcomPaOoLfHNLGOGa05gbbpw099/NVYud009HkEdnwH5bB2LcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009106; c=relaxed/simple;
	bh=slB7AODLH4rMn+fyVUFoD9/FcJwxGLBlABN/GZdkAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXYIAhE5EcIIxHIQ9YWozDaHDRUHbOhVPFxkPFwQlOYrq1/2T3pMejite5tZO1LvyQMSUBHVwy6n2oNwvTX4YHitik2ixYxYJX8NfHsho1yp48ilGS5C7A9lB3+yoTfBUxQi+xoUz77MPRtI6gVcKFaYkCbVmMYVwbfa9vmkwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZSouSQE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b77b8750acso3484035f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755009103; x=1755613903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXL1kgKd7MqF5ozdFO6BqzMRJ11gZJEgeIwxPdrd66M=;
        b=uZSouSQEGI9A9JvImnpCPQy3aGm267vg8mlEnP1b/FOQim5+ys8HH9SxlIilRTq1Fv
         rQBBx1hEgoODDrmwX7Sp4fOaY4RMEANin9Vj+VODkfyDaMJPUhrL+lsyssIy4Al7wdhF
         xjVF+TAh75iCtKu0/Upj1236zTnIxWv4AukyUt8r7DSVRHdunDt4i8owGYekf2q30Auw
         wi1BLGEPVl8UOMug5jOmh9Z/TOtk3dKafV7iXbrHz5qG+Qaj1sqvVuy9fRLHHVFB2GTi
         IfewVVjqMfkge6dnPlOUINDzq9q2PtJHwUr/dfhTRFLRbpZNPwWO+4WweCn067Kqe0WT
         tO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009103; x=1755613903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXL1kgKd7MqF5ozdFO6BqzMRJ11gZJEgeIwxPdrd66M=;
        b=Nvqq9JAgX3R7KwQpsIY7QGT6NHjg6QBsjd9NAeJ/8UNw8jXcdE6wqlpP17QXeu6LID
         WD4SA/HfXGprwxYGrGQ012WPUgZec+PiGUa2UtUYtJbT79FZq/XI9gzs1cnesOOBZCsE
         zctrt/fYkBpXDGRRcNWHd30nhAPTSRcyJWU18atdPh0L8RskdiMaCMUmeYW+Sljq243n
         oMrwVO09fH1mDgPYhDRW7xi6e7WSMBXAFnw79rSdHmaPPORwwcs+nyoB/Im0DFF6VuWW
         nriSen65MZLs549nlz6jKHskhqWgMkD9e2H47Zps7eAqQ9RPKzXOD7fMARDYf31fKofa
         uBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0VK5iW3GZCDC5Qg9Dkb94THTuDy/vrwoAfz1G6KoFHbrN9p7t0oq9hxKG2ZAnTx+4wZEL4mbeGlu/K+fhbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8z+lDrYDjZ30NrJDKHKV1jTnPOMy48NtjwU9ZvdzOHF3GY526
	DeM4UQN3lXTZhKditbXh7ss7kOYznNMSkDEBCuQNQOD2JvIwOFtUkoz1cwSVCQzhVhQ=
X-Gm-Gg: ASbGnctElZZv6T32OfkZ/4E8NR1FR7GSPOtpng8uGiit2yAcHwCFyQqLAgaGsCHp0lP
	sbo992z/TqVcWfzuoIxyMEJ3KpoISSZTn3TKUxFvPaRfb4E9KRzfdy4LGS2zXJhAL4yEEW/6YRV
	1pcODBKZMHRWgnTGxvta2nCFOQ3SxEO9/+Dlica2fnkNwWn9F0+8cw8n5p5kYPq7ETy7JezU19N
	DNQNmOtWi3eRn6BK7vxzZNWbmu5xQGLLPIJMdSXeghe3N75hYyGCGkAwWzEBSsWW87mxlrk54MG
	nqgj3Ts0WgkM/RNbpNKwgAfytcBY+3GVXUtmORQUzujMq2UO+RhyTz2yuS3TVAuOQX67cbljPiU
	7PAx/xgQhfxSoy/0P62tN3xCialM=
X-Google-Smtp-Source: AGHT+IG7434voTLkB5M6b+fTgoWLoFErvf4ICwBcvLqh4dF8oHZLQrTA736aANmFH3FFG/GLfqf60A==
X-Received: by 2002:a05:6000:400d:b0:3b7:590d:ac7d with SMTP id ffacd0b85a97d-3b911148b2amr3399318f8f.1.1755009103161;
        Tue, 12 Aug 2025 07:31:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abedesm44899000f8f.3.2025.08.12.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:31:42 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:31:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJtQS-Tpzw90Hqtl@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>

On Tue, Aug 12, 2025 at 10:13:43PM +0800, Qianfeng Rong wrote:
> 
> 在 2025/8/12 21:48, Dan Carpenter 写道:
> > On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
> > > Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> > > simplify the code.
> > > 
> > > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> > > ---
> > >   drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > index 3498743d5ec0..fb4183ff02a9 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
> > >   	 * additional active scan request for hidden SSIDs on passive channels.
> > >   	 */
> > >   	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
> > > -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
> > > -						 adapter->num_in_chan_stats));
> > > +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
> > > +					    sizeof(*adapter->chan_stats));
> > n_channels_bg is 14
> > n_channels_a is either 0 or 31 depending on if we're using BAND_A.
> > sizeof(*adapter->chan_stats) is 10.
> > 
> > So we're either allocating 280 or 900 bytes, which is quite small.  We
> > should just use kmalloc_array() instead of vmalloc_array().
> Switching to kmalloc_array() requires changing vfree() to kfree(),
> but I couldn't locate the memory release code.

It's not hard to locate with a bit of looking.  ;)

>  This modification
> likely requires deep familiarity with the codebase.  Also, for
> variable-sized allocations, kvmalloc_array() is preferable, but
> requires kvfree() for proper memory release.

Don't use kvmalloc_array().  The rules are:
1) small amounts of memory: kmalloc()
2) possibly large ammounts of memory up to 2GB: kvmalloc()
3) definitely large ammounts of memory or larger than 2GB: vmalloc()

There are also places where the memory needs to be contiguous and for
those situations kvmalloc() and vmalloc() can't be used.

Here we're allocating less than a PAGE so the appropriate thing is
kmalloc_array().

I'm looking at this some more and these statistics are updated in
mwifiex_update_chan_statistics() and not necessarily all of them
are updated.  But they're used in mwifiex_cfg80211_dump_survey()
when potentially the memory is still uninitialized.

I really think we should zero this memory, so lets allocate it
with kcalloc().

regards,
dan carpenter


