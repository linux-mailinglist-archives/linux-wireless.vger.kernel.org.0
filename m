Return-Path: <linux-wireless+bounces-12978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB097C050
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34331C210E7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375071C9ECE;
	Wed, 18 Sep 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8X29+MK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE21AD410;
	Wed, 18 Sep 2024 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686617; cv=none; b=WA2al3DK7AGGnx7TvlTenYWJXDaFcAZLtgyzoE3tUFwZcx1aSRjhMIrocyFmraq2S/GWEz5ZphoqsLa07S+JHGRbbh0bfVurxsEfzwtH1iX1bu2RU+6iTGjo24W6YU1rtOIrVh3o0Lnjj5JVz4GuptzkesXRwd0ZfTQFafLeJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686617; c=relaxed/simple;
	bh=6uBWZyRSEQCjjsivuWfUNmDIPalqfMOcntpTzIqGDQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRs6QOxano32mh5iNohDgj/gtQsCq8g9fNt4M2j6mlvM+Ecj4YA5NtHb1pFIpZHMQckXLp5yltv4fNeZPK9TE9upEL9LfHq3vW1/TBSIdh8aC4Qs+x67kpTdQ8jtGIjpn6aTHv60It/B9gqF5bgk5ud/p6i614qwNkDNL3nGZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8X29+MK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso77585735e9.2;
        Wed, 18 Sep 2024 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726686614; x=1727291414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAC3xJ+3d5SXUtRHdf7g5sE37Xuy0N1fP7sJsE452kU=;
        b=i8X29+MKOj/BgR5BC7z7Www3RlpSgL+zDs1UG1Ejsy6Q0Rp7/a8mnHXasGqtDaCz6V
         HoTAoUxGbhguDbP7ubtLl1iH6IRa6io8ywt5TxjW2jzjsANTEFR2ZuZmXXq1WftslJnv
         xs1z6345l4k3s61IbJkiFM3P1sKl1V0L8aElcIA35wX/8F71Or82jnQcTFI0jQYXuoCh
         rzIyUrsKch2JX36FaUID6OPo+xFloBK/mbM83ZsXSBqMPQYUCnMNbQTubDzSFcnlACPp
         AgnSjeeKsBgbJwnGaV1v1gQvxmA6NR0cJY9amt9Zhk8P9+7JAmALWI1XZ8x240AIyn8X
         bV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686614; x=1727291414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAC3xJ+3d5SXUtRHdf7g5sE37Xuy0N1fP7sJsE452kU=;
        b=NSeh3AMq6NsTA9bfp1ycqFy4UeJx2IIA9JOD0dF1SRT2b29wi6PIuy27CPScFH64K4
         yteXiXv9R/y4/urpt7eOyFpCqRX5gAUxq4ELNalaR+Cx1W9Hc7Q4RjWDwu7KGMRYPu77
         QFLlrMALezVY2o0nlP1xEWDqAEonLp6CS5x1AGHpQ+ixPaNdDSHOZRzZi0EOX9kg5If1
         xnBzxGxt+a5XeOez6j/0fAF6vbvgwn6qvJ6fMvumwEqt/pfUiXelZbksbMK5gWgap1Ul
         HrIfdtyh2Gq+aoivUnQeO+NUzGG2eP5vLNO1THhBtleM3xQI+iQtC3vCVV8cZFmKsVAF
         x+rA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGd1M9VRkCQ4Pj8NPq5pAnJEAGO+68ZfDzrSsA9CY6Ri3p2ZDnIA1qPEwC6KHlk2hG5sC74LuUsPPrWPEJgQ=@vger.kernel.org, AJvYcCUd84poTXIyx3FongsP2u99N2g+9CIB5G4G9ewIv5H+NqRtZl9f2yMhTulhVemfgI2jOVTIs8NyIaulaxpc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3veTHk12WFUWftHqzQHhGBtlMYpRYczWdw+zSXzj2qS83Ih0
	WkS0SJtkzUrTXVD3eAZ94pydEj8bGfsrj2x+zNzjqGpEryndSRXSl7E6IHrc
X-Google-Smtp-Source: AGHT+IEJTbPEYhEGC0uJs0AuNwrWiloKz22gfLRi26Yi8J8NRYg+F3Ux4Mh2t00Dfwz4bNQjZDd7OQ==
X-Received: by 2002:adf:cd8b:0:b0:378:8f2f:905f with SMTP id ffacd0b85a97d-378d61d4d27mr15249317f8f.11.1726686613331;
        Wed, 18 Sep 2024 12:10:13 -0700 (PDT)
Received: from void.void ([37.46.46.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966c1sm620835466b.36.2024.09.18.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:10:13 -0700 (PDT)
Date: Wed, 18 Sep 2024 22:10:10 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] wifi: ath6kl: fix typos
Message-ID: <ZuslkoMklT_Fz2zy@void.void>
References: <20240913094818.14456-1-algonell@gmail.com>
 <172667928257.4089263.8301674737892934391.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172667928257.4089263.8301674737892934391.kvalo@kernel.org>

On Wed, Sep 18, 2024 at 05:08:03PM +0000, Kalle Valo wrote:
> Andrew Kreimer <algonell@gmail.com> wrote:
> 
> > Fix typos in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Changed the title to:
> 
> wifi: ath6kl: fix typos in struct wmi_rssi_threshold_params_cmd and wmi_snr_threshold_params_cmd comments
> 
Thank you.

> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240913094818.14456-1-algonell@gmail.com/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> https://docs.kernel.org/process/submitting-patches.html
> 

