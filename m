Return-Path: <linux-wireless+bounces-7076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFD8B81B2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C0D1C22142
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A291A0B0E;
	Tue, 30 Apr 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QT+YxEKZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4511A0AF8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510861; cv=none; b=BfbWi3nXihcOPwzp9Q/KLvATMRKaBssbjrcchtB4Y2hqBmRnYrHrPqkxldOrlO2FeZ4Cmb+qS3RqsFRqpfSPXhCH+IQRzDC5WXLyEWg/powhV5fTyI0T5RYaUxXY7TFKELtmGK9LKHj+uJ4gm3x8v450I5nBlHJIwMcmLCkkYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510861; c=relaxed/simple;
	bh=9sgfqtMsWzv9o+g9mJtMOps7EusW138bXsllLt5r/dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlAIvLoHHDs0xfpZBRZSLkrKlV9dqkrBFz2DwBtnNnMrryZ/+5VdRu4A1FC9Nw3xDVm9UmkKhyFGPa+0v+CvNWw27P5rnAj8nU2M9uDk/s+pG8Qr3Z3zhrurVSrdGlAK+mGsKZRRW8hkDkESd2aRcYa82WStKhG592c6S1W/Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QT+YxEKZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4748468a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714510859; x=1715115659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xIU8q6pWM6w3NaeJRA8h8N2JrHznXlpLpQKHyO9q7I=;
        b=QT+YxEKZtYluZXnVbk5NdogepPybv1HDFeWh5NSGV45V3wCpBtvYa9QrKGLCNBS23m
         YpNSgCvLvbYH1kOop5lg3GIEXIW9J9hQNXIB5s4HZONXEDOtbxXnBlPVWsWVWWs88DE0
         HYTfN2XDACzmZ0sH6mvc/LXFGSb0Aozqp4KLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714510859; x=1715115659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xIU8q6pWM6w3NaeJRA8h8N2JrHznXlpLpQKHyO9q7I=;
        b=MTKbnRSYs6L5yrXX/UhLedhfwJzuuHNbRvgix697OmFJ8mfzGWMbVth7cdHHFcbR9S
         rmARGbtXn/vgsg6hlZoqUhDH0+Ud+db43me4XPIu1+xbpC2zA6YPjYSaA0x8pbkQzcPQ
         xmdE+YcP08ZUPklboc+QvSL9BlkGBCxwdYYnHDaXh3dSltOzyYksRA6/dMOS8ywSH+Rk
         GFlJvy9hIZXAZ4sZ952CePTOndTPVS7G3jk1ca04+gehDo0eC9q4oWOY79D9fYtRQsXg
         sN0c40ornWYVia8rLEVMHUv6+rpF/Pc16HqUC022LE4Vjo+5YIxbt6R3TXt2zD0Ttdnc
         dCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa1HqKfAs41VeFBo5/Mq1aFdRke3Q85EKHyqv1/SOgQW/wg0scv0gS3kG3yoW7Ef6Jg8+1rzwiVFJCNNKVHgL1QwKxxbedERGDQMrYN1I=
X-Gm-Message-State: AOJu0YxWHqXsiQcsXFv0KGSGQK6qZiyzTkk2cnVgGvAbhIcIY1+wfN7y
	qzGUYuEnFhfVZ5hp/ojsCU+0U3XdivVBaZswSs6HEjoR+QTtLMTLdJE884Vfpg==
X-Google-Smtp-Source: AGHT+IH/WlfSNtBhlJT6297Q0jgt35RvMUkm+sIKHyYlwaLfwwaWwP3me/gfM/Q1DQBlkcUJBS1qxQ==
X-Received: by 2002:a17:903:228c:b0:1e5:9da5:a799 with SMTP id b12-20020a170903228c00b001e59da5a799mr676864plh.6.1714510859313;
        Tue, 30 Apr 2024 14:00:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001eab1a1a752sm10560810plj.120.2024.04.30.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:00:58 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:00:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <202404301358.CEA4B3D@keescook>
References: <20240424220057.work.819-kees@kernel.org>
 <e2f20484fb1f4607d099d2184c1d74c6a39febc1.camel@sipsolutions.net>
 <9983345a-d590-4a78-94ca-6d96832860b1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9983345a-d590-4a78-94ca-6d96832860b1@quicinc.com>

On Tue, Apr 30, 2024 at 12:59:57PM -0700, Jeff Johnson wrote:
> On 4/30/2024 3:01 AM, Johannes Berg wrote:
> > This really doesn't even seem right, shouldn't do pointer arithmetic on
> > void pointers.
> 
> FWIW I argued this in the past in another context and Linus gave his opinion:
> 
> https://lore.kernel.org/all/CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com/

I was going to make the same argument. :) For this case, (void *) is
superior because we need to perform byte-granular arithmetic and we need
to use the implicit cast to the assigned variable's type.

The reason not to use the channels[] array is because we're not addressing
anything in the array -- we're addressing past it. Better to use the
correct allocation base.

-Kees

-- 
Kees Cook

