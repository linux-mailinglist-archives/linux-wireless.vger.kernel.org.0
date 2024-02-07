Return-Path: <linux-wireless+bounces-3279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A284C816
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDB91C21DC0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD682375A;
	Wed,  7 Feb 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j+TEedoG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924632555F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299820; cv=none; b=E7uHo/J/3AS+p9T7/5sh03R9snCGZgUKzPjemunSehPhfdhCrUKTv6EWiDxDuqpecflhtZbNsa0smO7lxy7ytUIjt6fjud9SN3EbxmgDejXGyHUxlMKU6j9o65n6fy9AM+WvF3irx128QcPCegXq95c4gnuDDTlqLKBVjal5Ukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299820; c=relaxed/simple;
	bh=9QoZb1lmroVO35bJvVBCgZvQwLS411mRGfg9/dag1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBly9aQFzhlaevsP8B8kA6EugaWe775NroTbcMsShS5KRPOYLe5FirF9z1X8QS2VSBBjs4Gcvd9DGoK++jpcbHDIa75AC2cw8b3s4yClR6xFRHlxuiHAi9niVmlhpvkJoZ+U0c4OyuDNOW4ELKviiFBIR4VTlTbNmu76BnEpOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j+TEedoG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e065098635so313202b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Feb 2024 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707299817; x=1707904617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unzmP4VueDkLJ81egUXVXd93GsMx5x/4DFW2s8hdVdE=;
        b=j+TEedoG+k0nZJRSJ3o/IdUChcvfSgvObsr5pwyeRcBIONUjDybn8tl4eg1JEmFCiw
         b1Yb5WFPloarMsCOvL57ptUQ7zW4QWlA2G1HgEhu6Z+pTAFoaQvDBUMnB5VI6+T1B97j
         /vU354/tnHB6d60bx9kLRMQS+hsrmbwDHrFOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299817; x=1707904617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unzmP4VueDkLJ81egUXVXd93GsMx5x/4DFW2s8hdVdE=;
        b=O5WXVKCZWutpdzWw1UOrraGgPnM5GACzrIMOtpBY3hqPpFEOH/aKyurqmiRYiH5GqL
         RGI2MtUd+iiWibvuYbLDHYMkoRlEGX0vMFo9DY0OmVyWF8uSlPOlvU4cypijt5oVrqxz
         RdvcAnlq8jx3EjyjwYJBPAr10LhQGHNHcU+mjyxqAjsqKBtdV3k6kNeDKy3SjGcMRiVi
         7KpFHbDsXaWa6lnoE5HNrJfopFQDcdajDEnky9mrE+KFVFQqLI9/7U4zPOcFWmTVsJhl
         TGgK+v761s2faWJ//ktcCpCQA4Nn9KHD256agHVQEcJJ8KWPiTic1s/fsYkyykbupKfe
         XD/w==
X-Gm-Message-State: AOJu0YzBVxBeS/17bLVd8X94L0ly6rynIuyvAKfmrywXE4597x13OAK9
	uLGM67iW0tAkuuZHgZDDuspBfW0s5/B5MikhEKkpP2FMj0XRZuTVL0mt24jGtg==
X-Google-Smtp-Source: AGHT+IHrF+uWvHkuZ+EpPlH5CYFsMjMmFKSibstfxHs5EGfzP/nuLGDSF3vviyIYTLakkCSSrYPIZQ==
X-Received: by 2002:a05:6a00:2d81:b0:6e0:3874:24da with SMTP id fb1-20020a056a002d8100b006e0387424damr2872821pfb.33.1707299816924;
        Wed, 07 Feb 2024 01:56:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbjXVsCQWWUNu1ltFUiLkJAac8m30g68PashXmCwiIAt1M6Ksk4TG1SZa+wnhLHaoisGB7VGdh6NNJBGhte+P0zoj1j2JEUnmdQOfT+SnN/xRHkyG2svrtJ8B/zq7pN9/z49iO3l2VYAV42KMKfe3UNCE3jrs4PK3O8CqIz8UQgVIRqlwMW5h38qIC7+Mb7QRSgKKOyYf6l26WnKL7sNLGJ9vmk7ieCQbCeaXzUqIihJZ0CGt6GnXqDH+0WijxYfISMULdjiBo7lMpzxqvpXs4mIBNbliGNqdzR5aS4xIrb+e8toU5zJYx+VphpCINF5z3mlLyJm1cBgcP3Lkvck4V1hkKOAw0Wp2eVgpVAHmetaWkdnHAFmzFE6LTwyAZJXCpIeSP9/bM/tgCeD8McE0tQETXYPzM8XU0ckXAxI4WJRklz4FxeAljDgivRcsI/1AmnuhR1P5zSxvxearhynvrJZzkp12alOVVGpIXcb3hV8tdcLyQs/HUgbWbKQ08JVJydgDVk7oVTAieFry2vQ3rWtHZxrf1bwUvv5pDFRJkFN00I3VI8Yc=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020a62d403000000b006e02e816f13sm1105495pfh.111.2024.02.07.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:56:56 -0800 (PST)
Date: Wed, 7 Feb 2024 01:56:55 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	zuoqilin <zuoqilin@yulong.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
	Rafael Beims <rafael.beims@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>, Lukas Wunner <lukas@wunner.de>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: Refactor 1-element array into flexible
 array in struct mwifiex_ie_types_chan_list_param_set
Message-ID: <202402070156.189B1D8@keescook>
References: <20240206183857.it.362-kees@kernel.org>
 <fb9ec7de-7c8a-4e94-94c2-eeea6369550e@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9ec7de-7c8a-4e94-94c2-eeea6369550e@embeddedor.com>

On Tue, Feb 06, 2024 at 02:32:32PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 2/6/24 12:39, Kees Cook wrote:
> > struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
> > as a flexible array, so convert it into one so that it doesn't trip the
> > array bounds sanitizer[1]. Only once place was using sizeof() on the
> > whole struct (in 11n.c), so adjust it to follow the calculation pattern
> > used by scan.c to avoid including the trailing single element.
> > 
> > Link: https://github.com/KSPP/linux/issues/51 [1]
> > Cc: Brian Norris <briannorris@chromium.org>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: Dmitry Antipov <dmantipov@yandex.ru>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: zuoqilin <zuoqilin@yulong.com>
> > Cc: Ruan Jinjie <ruanjinjie@huawei.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/net/wireless/marvell/mwifiex/11n.c  |  8 +++-----
> >   drivers/net/wireless/marvell/mwifiex/fw.h   |  2 +-
> >   drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
> >   3 files changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
> > index 90e401100898..9ed90da4dfcf 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/11n.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/11n.c
> > @@ -392,12 +392,10 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
> >   		chan_list =
> >   			(struct mwifiex_ie_types_chan_list_param_set *) *buffer;
> > -		memset(chan_list, 0,
> > -		       sizeof(struct mwifiex_ie_types_chan_list_param_set));
> > +		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
> >   		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
> > -		chan_list->header.len = cpu_to_le16(
> > -			sizeof(struct mwifiex_ie_types_chan_list_param_set) -
> > -			sizeof(struct mwifiex_ie_types_header));
> > +		chan_list->header.len =
> > +			cpu_to_le16(sizeof(struct mwifiex_chan_scan_param_set));
> >   		chan_list->chan_scan_param[0].chan_number =
> >   			bss_desc->bcn_ht_oper->primary_chan;
> >   		chan_list->chan_scan_param[0].radio_type =
> This probably still needs a bit more work.
> 
> There are a couple more instances of `sizeof()` that should probably be
> audited and adjusted:
> 
> drivers/net/wireless/marvell/mwifiex/11n.c:414:         *buffer += sizeof(struct mwifiex_ie_types_chan_list_param_set);
> drivers/net/wireless/marvell/mwifiex/11n.c:415:         ret_len += sizeof(struct mwifiex_ie_types_chan_list_param_set);

Good call. I think this is the right delta:

-               *buffer += sizeof(struct mwifiex_ie_types_chan_list_param_set);
-               ret_len += sizeof(struct mwifiex_ie_types_chan_list_param_set);
+               *buffer += struct_size(chan_list, chan_scan_param, 1);
+               ret_len += struct_size(chan_list, chan_scan_param, 1);

I will send a v3.

-- 
Kees Cook

