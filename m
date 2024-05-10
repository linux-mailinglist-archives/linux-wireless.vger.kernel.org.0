Return-Path: <linux-wireless+bounces-7475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2A8C266B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF591C22021
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136F12C7F8;
	Fri, 10 May 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee5+blIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FAF481C0;
	Fri, 10 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350185; cv=none; b=sfJDYvVMdNvCtssHyD5mdnyChzihyAx2QL9lrxvVJcmM+Lj8qPtJsxc9vtBc7JWB++iPqgGKBdV7tr4Db4k1lLDY/5Aky/EDpar3aAqnfNiXEkoiVGTJDBPJVkGuopTolzK7DI0X4JlbdgrAhCDpc0TS3OfV9Jf6qXb3xrbG68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350185; c=relaxed/simple;
	bh=ryAv9ViKVMcOS6EqwqI46QOfJSeiIcFkcxoPyrq5zlc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6w4Q7OiOum8n+5k10rIvg+UdjI1oiRxEeEspZC7zrcD67fq8iW4KrJQMNJ5yn7Zm6+s9LuR8EcSoStmT0AiHc7pAbBTEXByxALd+ShmVk6Ldar07nl6zTCEiBcCLjtLbAwPAq7/VMIvdsnKm1+SaeQOR9kIBLidoA1xb2u6xEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee5+blIk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-520f9d559f6so2313425e87.3;
        Fri, 10 May 2024 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715350182; x=1715954982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IUshYNDgznxLpJcEyG0DD70zqbgXQycZfQ4megorFuE=;
        b=Ee5+blIkGiB5RgOo8h1ikBX8t7OgRrPz9dAwvkvjrG0XvvYEQCZQ2Hjkv2x8OdjJpJ
         kChTxnQNAEB71DHnryr6O76zlmzg8T8ITyxU1jAbTckxgxpGAExtrDQi1BehUnie14XZ
         Ee8V9B2a+4r41PGfJyLQ8uixmtIjHIfzPVnHwy5gefdbYUQ5f93bp8MFu57jTuYjt8Z1
         IUyg/YkjWYKhVgcbBmfV2X1m6fJi+CPxYEvDoPw9v7947mOluDPMykGlbo6UlXZv6zBa
         9cMp80c+VuFcX6wmcNx9++HoVD+xHE5iWKFompM7DJEBYoghYKj6GMk1sUvtLDVCFNoI
         VY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350182; x=1715954982;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUshYNDgznxLpJcEyG0DD70zqbgXQycZfQ4megorFuE=;
        b=bBQLdCv3zBUAT3D97f2uhdlaUO6aJ5oMWF8gsRagHyGglmoBmhfrJqwk10CxEbUOh+
         nZ2K4LvSMrmxkXCeTE/1mnQexH80ZgU9Pqsd65WOZa6GOopjReiVYZjcvGqfLaxpmwh/
         kNbBFs7rQjHRNhhpIHQeyvT81msIxX1+3xw7sX1ihoWp1Az6NlR+6OK22I4sB2gnRnsZ
         R9c0LsN79e9UGoo5ju3VWu9YD7YpKBUtkYctD0bW5AwbsfmthrQgjzBgvpV+q6qfrOyR
         2AZIXgqsZisjLD+lR4ksB1wrJQS5yktiydQwVQjaf5UpAQdbEOQHCqqs50+PTcaOshxQ
         z1aA==
X-Forwarded-Encrypted: i=1; AJvYcCWjjmyEOmtCyBOlMk6tbdnQSOLR+KEWoNV6ifVOajZPvNE7mOHv7GC/cVmTPUghEp57NEnHwdhWQRhtOgpD+I3ZSdClIPgdmRTEMx0t/Uqnf/+95yKPF9Z0IfnekIKf5UMp3Sr16j9kNV5eKsZnXzhaW1N5em6uNBdq48ogR3qn/5EdtkA=
X-Gm-Message-State: AOJu0YyGl8H7W0cWFyjO2YngUnWrQcbkI2oQOVSwRy9euDjmP818nwYT
	gSLUZp7ovoFOfh30ydr0QIjBda2VF+RF8b8/D1sTcTkDR+STRQA6
X-Google-Smtp-Source: AGHT+IHPnFwxBKyNEbIQhl0xygTuNDfAL4ZLXFsiihw6QPJeyV0T7tJdRJWji7wQMeLS9PIpNkPVWg==
X-Received: by 2002:a05:6512:104b:b0:521:f000:5d1a with SMTP id 2adb3069b0e04-5221006cd2dmr2006606e87.59.1715350181498;
        Fri, 10 May 2024 07:09:41 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2449sm66291035e9.16.2024.05.10.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:09:40 -0700 (PDT)
Message-ID: <663e2aa4.050a0220.a4c56.1c5a@mx.google.com>
X-Google-Original-Message-ID: <Zj4qoTIXSWlkVStH@Ansuel-XPS.>
Date: Fri, 10 May 2024 16:09:37 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Sebastian Gottschall <s.gottschall@dd-wrt.com>,
	Steve deRosier <derosier@cal-sierra.com>,
	Stefan Lippers-Hollmann <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org>
 <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
 <663c9fc7.050a0220.5fb3a.4e87@mx.google.com>
 <87a5kxlqrn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5kxlqrn.fsf@kernel.org>

On Fri, May 10, 2024 at 04:50:52PM +0300, Kalle Valo wrote:
> Christian Marangi <ansuelsmth@gmail.com> writes:
> 
> >> 
> >> Sorry for the delay but finally I looked at this again. I decided to
> >> just remove the fixme and otherwise it looks good for me. Please check
> >> my changes:
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
> >>
> >
> > All ok for me, Just I notice the ATH10K_LEDS is not exposed anymore? Is
> > that intended?
> 
> Yes. It follows the same idea as other wireless drivers do, for example iwlwifi:
> 
> config IWLWIFI_LEDS
> 	bool
> 	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
> 	depends on IWLMVM || IWLDVM
> 	select LEDS_TRIGGERS
> 	select MAC80211_LEDS
> 	default y
> 
> So what this patch now does:
> 
> config ATH10K_LEDS
> 	bool
> 	depends on ATH10K
> 	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
> 	default y
> 
> The idea being that if LEDS_CLASS is enabled then ATH10K_LEDS is
> automatically enabled. But please let us know if something is wrong
> here.
>

Sure, was just asking some clarification about it. Not a problem for me
since we are using other pattern to handle this.

-- 
	Ansuel

