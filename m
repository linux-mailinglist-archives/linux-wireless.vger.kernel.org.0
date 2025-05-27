Return-Path: <linux-wireless+bounces-23434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C727FAC4979
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973F21897B4B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87E1F09B2;
	Tue, 27 May 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6iX+igI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E01FCF41
	for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331971; cv=none; b=LPlhUu1tZRQJM1fp9/BMoKzI6SG4rekUQ1sOIvZLoDEKijktjF5i3SA++Bk3yEmNJKMJC/WrMquPzV6SIAxmUDUlCBVqoRZjM5CYwY7UvhYAMplp3F0y69eRs+IcNOjadbCWwkgWzZ5M+VYGlJZGMXaXKWfl2auLcGp3N3f7iLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331971; c=relaxed/simple;
	bh=QsdO+ZSurjfW+txHD96EQ4S874P9J1sRBPDp56cKBAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbzFqz2nTBV8ICguYhh6e0wIFkWPd36Jc/y+CIV1KSo8+ApmPvf+TFKe2XQZgmdskN/Hh61zdKNwwwtnY+L7twASCG1J0Tx9xCxwx2XVwc7iBoWZ2DTs+S5lTRLDohkt3pAOhous+DjuxDMBJDMGvbyEcwaRMpiUjCcjUfp+6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u6iX+igI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad216a5a59cso377221266b.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748331968; x=1748936768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2apj+2/E8vgrIKr+nA0N8eLInGCqIVYSVlwSMLdIif8=;
        b=u6iX+igIMpZ5iCp2Ldk4WBlyLzRwbeIrg0Qi7WurmfELxe6RAwrpudgwgBoIo8Mo8m
         EYxE6Mi1miA28wNdgNCDFxPqC8wAt9LkK5UqMkqBv2yZVFI/QRmScTh5b4JCvtDJpTTz
         pguPuuMplmwYLz4U9JqrgtYz/IyD4b2lX83Z//QKcz9Q0TVPeTPbYgnj9kY9Il3HvIcG
         CDPfxqaSuOyie2nLL3IenRk/pszEiSPbWmPpNA/hjXELbT+TN/cqWirKys+/3wRA3dTX
         L0n6SnutayxsKXpy3bgRUedNXHBJg/rIUwKGCE4qRMcUQEE7g+zbFL5lddtgof4tn+Hp
         g9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748331968; x=1748936768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2apj+2/E8vgrIKr+nA0N8eLInGCqIVYSVlwSMLdIif8=;
        b=Jv7yHZRT55Lh6dcLKo1Pfki7F56CgGaOHV1geW0K58c5tOYjD0rT9pP8d+1PiZd3t7
         sjVcWl1v3Ix4IQG0fFueL4HPGmtetLkwGOhgFIyB1B6k3Q2zVaxIbhogjdA1e7qHN43U
         US/U719HtK4i1FEbKf50MVfnmbeFHKgQCvbb5sWlwc2ENP/fnfV0pgW+vkxLkQRZdnO0
         xUiIeiwrINYyjX7wonIXl36siUHc+1/ZBNjDeNRsEVKeOhdzmq+Cu1wCbMCBPam5/KA+
         F6N77jw49oFhQFV4ZIhPtYCvM3wl25RAV3yIpjyx/N9S3HlIfPiem0Eoyz41LDAIzUGn
         s4ug==
X-Forwarded-Encrypted: i=1; AJvYcCWhShqerfwdZbN/KXV+PKQG1zMXGfCunxYcGPAwV6zKYhDVR6turQOdLg5tK63dlwsty0T0I8lwHXvicsoXhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEev6zkr8drzYugWJXzDElByQpMj7ZcAUkQQkNQF77L0kPCi8P
	LNB+bFXjRTrLz2JVHNYlpHXydokGBkMrpSbBE1QumBW0kQHB3opuHtkrz+DTmvf73pQhPLpEvla
	Ufb2Q
X-Gm-Gg: ASbGnctRPTF2Cy/WKOKALHLm+dPk/Pqt+vqTDEVj2RsSO1cO2KTb+bJEiSt+tczojum
	yefVOCOEKdtnees/GPAFmqW5QiFlq1qdccp+ac4xOopgSCnnhbCn072D56k8paCqFiQgs7luNrf
	RXZbVThZ3lXqruZSpNZstcj9bg5WIcbkzmPRk1DEah/cqjEwyyUPTcsDIxKjAG8Q2g2aQVGM348
	K3oBn0X/UgqSfU5XtgPQQMxEgkNcCqvHcOXs4HJYDBvuFZ2uQVxWLlQI9uYUEnGo5HcJUVvkKSe
	xuy2ypz1FvOffacJyFSnoHNkOEJx0u7n2W6BpMkFvG+EaipBWa91/GCQv0c0eEzsC1pwm27zuGK
	SJ4/G5MJfqA==
X-Google-Smtp-Source: AGHT+IHdr5lkHBNyQR2lwCI1Zx1yTjWeGBiSlBewwlacaL6tp/Bi3RSdo5x6f9SKZp3swZZHW87cBA==
X-Received: by 2002:a17:907:72d0:b0:acb:b900:2bca with SMTP id a640c23a62f3a-ad85ade9eb1mr1043489066b.0.1748331968019;
        Tue, 27 May 2025 00:46:08 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d4ca3bdsm1794033766b.160.2025.05.27.00.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 00:46:07 -0700 (PDT)
Date: Tue, 27 May 2025 10:46:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Message-ID: <aDVtu6dpKfWOyBn6@stanley.mountain>
References: <aDVUEHfa9q2zBD6i@stanley.mountain>
 <582b5bc4c4434934838ae28d77b7f73a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582b5bc4c4434934838ae28d77b7f73a@realtek.com>

On Tue, May 27, 2025 at 07:38:17AM +0000, Zong-Zhe Yang wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > The "link_id" value comes from the user via debugfs.  If it's larger than BITS_PER_LONG then
> > that would result in shift wrapping and potentially an out of bounds access later.  Fortunately,
> > only root can write to debugfs files so the security impact is minimal.
> > 
> 
> Thank you for catching this problem.
> 
> > 
> > [...]
> > 
> > @@ -5239,6 +5239,9 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct
> > rtw89_vif *rtwvif,
> >         if (unlikely(!ieee80211_vif_is_mld(vif)))
> >                 return -EOPNOTSUPP;
> > 
> > +       if (unlikely(link_id >= BITS_PER_LONG))
> > +               return -EINVAL;
> > +
> 
> Since I think this problem only comes from dbgfs path, would you like to just add a check in debug.c ?
> 
> For example,
> (based on 0 <= valid link id < IEEE80211_MLD_MAX_NUM_LINKS < BITS_PER_LONG)
> 
> rtw89_debug_priv_mlo_mode_set(...)
> {
>         ...
>         switch (mlo_mode) {
>         case RTW89_MLO_MODE_MLSR:
>                if (argv >= IEEE80211_MLD_MAX_NUM_LINKS)
>                        return -EINVAL;
>                 ...
> 

I'd prefer to add the check in one place instead of all the callers.
We could check IEEE80211_MLD_MAX_NUM_LINKS instead of bits per long
if that's more readable?

regards,
dan carpenter


