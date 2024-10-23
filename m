Return-Path: <linux-wireless+bounces-14371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46879AC1BE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27851C23E96
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E9155A4E;
	Wed, 23 Oct 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxABMWm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475717F7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672517; cv=none; b=WxyfpvAU3gh9zGNqCHzfwThEBL1wUD6aNF3Ns0eZzQVsqyBsDmdzsQATIm07fIxLf+tTj4eW2BgBnq2mXOGVB9GVnj34v9sCxbrxjllAG8ufx/7ERdJASpSYJ9cT6kz7Z5Dw2STn2E2MYcaEa0I1QdCL/zp7Z+Uk0kv6EK87tRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672517; c=relaxed/simple;
	bh=asnLS+EmH7yhaFNpb7qccfRX1olrMIisDu1X+wRh2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3PPgJKgyzp/O6TFA8ijsqMBR5Bfmj4VfO+sOzX0gEiRPzI/53p463Dlv6qZq+rM31TuCYeD5EfQX1DRrT11HNxgyEMW1o5GeKbK+2+Rd047l2qgKEY/swGBVQU5QYDzyDkPfJ4swvAWL0VZTnaW5ZDDHqSfIueHxpUsiIKar0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxABMWm2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso66089375e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672514; x=1730277314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pwg9xrcCt0istZyNHx+xNVxgZiXZ5ztml68Y6uwKbU=;
        b=IxABMWm26/wnTHe+MFcSt7teFBMEjUwo/xF/G47+XFILVUq8X34V4Dn5imwUD0SITt
         6MW2/nlhH8Y/x8l1oTPR56ZSjelh32Q0CYah+rxqPi00GCNAxgnc5RZD7PWoDXu/QTNG
         ic+T2Xm01sLvouO3HOtQszRGRSnzxQ+TFZxDTq6Jq95ctIWTin+HsgLW4N0FGyRRblyZ
         7OI5qfagie0pnqLG9gdI1md3trSxpj/GahD8eqa01U2fduy4Y1BAniaZNvZZ8Woae82J
         yWG8i9AYLGo5X7YpYVeWu5dw0UkyMzf0t8TaNmZnIaBYMw7M35DRQPmfndqNl9f3YcaM
         Qspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672514; x=1730277314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pwg9xrcCt0istZyNHx+xNVxgZiXZ5ztml68Y6uwKbU=;
        b=QvOtOSfVwRkb6c10Su5Vk5XM/1Au5SIW6D+NrfykLhdQeJdyBhgS8o2z0/HMdzfKMK
         1XvEkj56LPsRnwjycrqO/HAqs4CeMGfMBuzOrJl4yU+Wx1yRB+W9vwxEeZ+k4MDhPtqB
         XXLJ07xDdjTa2bMC5N6i73yjgcGwbcra/c/1r/H4EmwDjQEfPByEEqeaGrPBz5dvTriC
         aC+OcZAGKQPWzI5kBXqgDFEBok+dNYePYGxd+Yczc001fQ+RDEm6LsNyoZf6GL4lWCmc
         ch01pMzTtEaxubVBxrsjcGH4qTKQOhE2p9LjUIzlHckO3rV24XoRQ9wnXisJgcmEEaZL
         bxNw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYTx5vzvCT+KH3zAX9EZ0NKR8re6vIXwTzXSCGLnFcQQQgVyOpG5cYX0BpnbIulttKfqJ2m3wmym2R+OMFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeaCRNiohPQSkWrx1wjt4/Y1Kpt9F5dVFtUgVODq6xuGklXPF
	NFHaB5zOKqCUdqzakahASRFEJztbmlzhU7hHFFofbXPetOcK0pM5hJ6He44gaZE=
X-Google-Smtp-Source: AGHT+IG6BfYRaxuQt+TZH1fYAiwXxf8JZ6zQWto1UJUldW2JmsaSAInHWPIkYLQ8xIlIQ44Z5SXl/Q==
X-Received: by 2002:a05:600c:3b16:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-43184198a99mr13532065e9.23.1729672513733;
        Wed, 23 Oct 2024 01:35:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c50947sm9710115e9.45.2024.10.23.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:13 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:35:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Message-ID: <2e85c84b-31bf-484b-b3e2-9285999bb2e4@stanley.mountain>
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
 <6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
 <931c79c15bc04be99bb87a9826cf2b04@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931c79c15bc04be99bb87a9826cf2b04@realtek.com>

On Tue, Oct 22, 2024 at 03:32:23AM +0000, Ping-Ke Shih wrote:
> Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > @@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw
> > > *hw,
> > >
> > >         rtwvif_link = rtwvif->links[link_conf->link_id];
> > >         if (unlikely(!rtwvif_link)) {
> > > +               mutex_unlock(&rtwdev->mutex);
> > >                 rtw89_err(rtwdev,
> > >                           "%s: rtwvif link (link_id %u) is not active\n",
> > >                           __func__, link_conf->link_id);
> > >
> > 
> > Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > 
> 
> Thanks for the ack. 
> 
> Acked-by is often used by the maintainer, so I will change it to Reviewed-by
> during committing. 

To me Acked by just means you're okay with the patch.  When I use it, it means I
don't feel qualified or interested enough to do a full review.  For example, if
I complain about a v1 patch and they fix my issue in v2 then I like to say that
I'm okay with it.  In that case I'll use Reviewed-by for a full review or Acked
by if the bits that I care about are okay.  I don't like to complain and then
just go silent.

In the end, it doesn't make any difference.  You'll get CC'd on bug reports to
do with the patch and you'll potentially feel bad for not spotting the bug, I
guess.

regards,
dan carpenter


