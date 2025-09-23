Return-Path: <linux-wireless+bounces-27617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6691B96AE6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47A67A3F77
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6726B2C8;
	Tue, 23 Sep 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJikmrB/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9025CC74
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643079; cv=none; b=X85sUJFJEI085m+wYILIBxUMhyqOMg2IKWoqzu0d0aoVNmJCpuNf9ucT70qFUFdzqY+OYK5pEt8/ffjo3bpBUdsEtsftJ5AM4leNpkH0CQjEEaBWNrMuE/DPiklF5mdeXGC+/mNJ9/NYduXjZI42XCsUOfJ2ihhtuMP7YJD9qSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643079; c=relaxed/simple;
	bh=0xTjUzYckiW3+Uj+BbjVGPhEvL2cUJ0srgbrDwcKnKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhIeLgyG4TL6s1h5i7MSj8jXrjrZUMoECZ98QqBbOQPVKjHPBUcZTCEXLiJegy+dymOVyuo6xUyRqzC4ScmXNaWyQ/8j1Q8B8C/swKqn3t860SBq7kt1KhGWbP25rMREbpRoweITHZ67g6J+1UMl2CD4JZGeyjVHNcszwUypwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJikmrB/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1622895a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643077; x=1759247877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhP2KIIkJJSSND6m+IFOMFXEhQ7lM+LEtWJ8OfvJe8g=;
        b=hJikmrB/+3KvtCnOmNaSE0kc9cfGcePluCyqT7nB+z5lFUbSaZmmPpg2K0ORiaror5
         57jn2KmCS9CEtTuFjiHO7iDiQar7NAVk3p/pLlJlU3OheMc/Kvu9lvRUa1UCjbuA1HG7
         2/pwuvMoIe/kK/lwx0IQgJ9decXsa6gsTFpeRkCL71il3iCPvWA6r9MTQOcYCcMudEBl
         vDDEYa1XEe5KfUNPWbHhJTCaMI1tBIKJhsRJZZphKs1n3Sel3hwbgQWvKLAqHKKqGjA3
         w/N3YGEmG/4cvvHOq+ye7IkaoEn6xGT8ATugKYXMmVhUP38VmId49CSCJE7adS8NbCEh
         HZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643077; x=1759247877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhP2KIIkJJSSND6m+IFOMFXEhQ7lM+LEtWJ8OfvJe8g=;
        b=tE4QLMfI3AaaGBiVwUkplyyBBNPiagT1b8B5mCq23u2VBoBkDCFuzNExSEhzkyrmHT
         C07290r5654A7PXjxOZH0S8vZrbXSsQPQDpkc8HR+U8oo0jNNto/ZnME8DfRqucRhiWR
         L41CVlREoqaqUJaPUwCNEon+RUWwvGC+zIhMdtJToQyTpQNRq3P5s+TmPPOroKu8B8hL
         tY53N8BnUvX6TZ+7No4BqQ7fT8ukJIrQDXnfXWYCxKxYURXOGKVkr5iThsRlvtyV9VSJ
         4mZ0Lhs59iQoYzgMjEW6b5aOAE8P5rFRYORj7lwMnxedvto56VV/MTrJAqA3epfOq8Cz
         h5Rg==
X-Gm-Message-State: AOJu0Ywk3qhFHEO8dYO6UFGPIv31sy4Gg89koNMFnl8rGEUVFZAKMymG
	0PGonMQXcNhoflC8qehD988XFmEw88XNc8ynmDq1PuzGjR1NKKutBnax
X-Gm-Gg: ASbGncuRr+rSaRNctqXc8gltn++Ow1QtgOuGKRvqs0jh4RtpAJMI4ko5pqrRrJQBoNi
	dR2Hehygnth3rI691ZE/aeLUz9rvpUsvIV8FleO4VZ5/GpFeAUBOOhG40I5Cul+dbeY8t+1B8DW
	HP6YaTk5Yvvnj26PHlMAkHA3/alpH64hKMlkp0N1Hn5ED7UXeRBP/meLdqFdduln2MYX1votq6i
	oGqLG69dUlxW68ENWaiQCob6p4jPWIHNnQE+D0mysUaESlEss1oW+453ofojUBTwY1PBzJZewK6
	czS/xX0XdOesnw+c/LPDE6Vl5Rj/kgo5mL0KCIlOEfILrGzrM8tUIPURz7MDuRpGbNqpVHRhh9Z
	Jqb96SNfgR8lGujYQ16jPwUdZNFz4fxPOGnXFk4gJgcNgI9kMLA==
X-Google-Smtp-Source: AGHT+IHf8qBwNyR+6g2DVbOWQjt+iH9yo2QnbmewQABZ0aI+yvUdFycwvCtErc3P83DnFjNDYk2lUA==
X-Received: by 2002:a17:90b:3a8e:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-332a92d31e5mr3363869a91.1.1758643077369;
        Tue, 23 Sep 2025 08:57:57 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061925esm16901961a91.2.2025.09.23.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:57:56 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:57:53 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"visitorckw@gmail.com" <visitorckw@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Message-ID: <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715313b943d84cfeb3a337dc20be5f6a@realtek.com>

On Mon, Sep 22, 2025 at 05:50:50AM +0000, Ping-Ke Shih wrote:
> Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
> > and 'str_read_write()'.
> > 
> > The change improves readability and enables potential string deduplication
> > by the linker, which may slightly reduce binary size.
> 
> Have you measured the change of binary size? Maybe you can share the result
> here.
> 

I tested the patch and did not observe any measurable change in the binary size.
The commit message was refers to the description in string-choice.h:

"3) Deduping by the linker, which results in a smaller binary file."

> > 
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 10 ++++++----
> >  drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 10 ++++++----
> >  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c |  8 +++++---
> >  drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 11 ++++++-----
> >  drivers/net/wireless/realtek/rtw89/usb.c          |  3 ++-
> >  drivers/net/wireless/realtek/rtw89/wow.c          |  5 ++++-
> >  6 files changed, 29 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> > index 84c46d2f4d85..000753061e38 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
> > @@ -2,6 +2,8 @@
> >  /* Copyright(c) 2022-2023  Realtek Corporation
> >   */
> > 
> > +#include <linux/string_choices.h>
> > +
> 
> Driver has included this implicitly, so don't need to include it across
> whole patch.
> 

Got it, I will drop the include from all files in v2. Thanks.

> Otherwise looks good to me.
> 

