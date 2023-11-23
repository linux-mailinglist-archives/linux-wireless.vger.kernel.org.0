Return-Path: <linux-wireless+bounces-5-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CCE7F57D6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 06:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7032817BF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17EBE5D;
	Thu, 23 Nov 2023 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jss7zVHo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F011F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 21:48:43 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c871d566cfso5523981fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 21:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700718521; x=1701323321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90wieb6M2VCCvedLkH0yxZnXyP84LqC+5ZlCgC+WSG0=;
        b=Jss7zVHo230Tx5BkpXEooENuwF9QVNJ3o+zFJolJB7afsa2xvK7GEQHcJSkVpxeHw/
         aqg+e8kz2Ll4vlIkupEMvp8Hh4utYJh07oHVSRN5uBDsJfvEb15C6rQ2/3Rsa+sncZ/h
         SDmQxEPKBpEoY97eSYno1NurQ+xiT0JU2GgfSLG5614ExqivkeIay/GoAo7xpirmp3wi
         vuFOl6zDlKOoy8q7XUAWeyvPh9WuqeU9sWKe9vfl9i1hXGnkyKeLNnagUghWv/ovjD6A
         XTh4+T1my9NHgzNqj0gkACEHyFiPqaR5vRKKdNoiCUYS/ucM5RxzTni7cxYz9Goy16wU
         5pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700718521; x=1701323321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90wieb6M2VCCvedLkH0yxZnXyP84LqC+5ZlCgC+WSG0=;
        b=r0OXZQYV/kChUfoxPzqhQz4GjGvz7Aq1E49pr464COkBR2H4Z37FhQ5Sr+2KwDrkpF
         ikq1NhWtSYDCurZ7FxpJlzXb8vAjvtBRQgsDXosu2P82l6yxwMT+t7rgKvph0Z/lNsDu
         Th0S2Hr7wMV1PHIG4Fm8PI0mfehdFn+YtqV0RRbPdZs/f8iDsAVXAuZXpHqeE/rY3KL8
         cUfIAitog1YTTvxzymHHXmZLG2A973Q9cgGhvKj34IQl9reDqnm+Rym2oYws8Ec2lEPL
         FI3RuHTLiuPgGpGnasNRPZpqesmbtddqnCY9u8QK+vG3MUe/PxeRV6yBKG7jrV6hxPUz
         Q0sA==
X-Gm-Message-State: AOJu0Ywl+4FLwgcTfYcPRU6UDInnvjWY2P5IOnYZp6vvIkIj/QIaKdj+
	FMQxAM38lzICuKMV4RZlWTN2mw==
X-Google-Smtp-Source: AGHT+IHybDEjVgqWWR627nXsgR1xndJTpRSJuSd2v2BEMphvSQGkt9g0NQ3OT7NrcfzcnPXWmVl/DA==
X-Received: by 2002:a2e:9797:0:b0:2b6:df71:cff1 with SMTP id y23-20020a2e9797000000b002b6df71cff1mr1515717lji.52.1700718521202;
        Wed, 22 Nov 2023 21:48:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05600c538f00b0040849ce7116sm1424154wmb.43.2023.11.22.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:48:40 -0800 (PST)
Date: Thu, 23 Nov 2023 08:48:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: pkshih@realtek.com, kvalo@kernel.org, nathan@kernel.org,
	ndesaulniers@google.com, trix@redhat.com, lizetao1@huawei.com,
	linville@tuxdriver.com, Larry.Finger@lwfinger.net,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an
 undefined bitwise shift behavior
Message-ID: <caf95d1d-f893-4553-9d0a-91d16f04182d@suswa.mountain>
References: <2ec14802-78b0-4a3f-a730-19e95ec8d359@suswa.mountain>
 <a9032c3a-8221-11fb-ed15-2c57c3933d28@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9032c3a-8221-11fb-ed15-2c57c3933d28@nfschina.com>

On Thu, Nov 23, 2023 at 09:33:06AM +0800, Su Hui wrote:
> On 2023/11/22 21:02, Dan Carpenter wrote:
> > On Wed, Nov 22, 2023 at 05:02:12PM +0800, Su Hui wrote:
> > > Clang staic checker warning:
> > > drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
> > > 	The result of the left shift is undefined due to shifting by '32',
> > > 	which is greater or equal to the width of type 'u32'.
> > > 	[core.UndefinedBinaryOperatorResult]
> > > 
> > > If the value of the right operand is negative or is greater than or
> > > equal to the width of the promoted left operand, the behavior is
> > > undefined.[1][2]
> > > 
> > > For example, when using different gcc's compilation optimizaation options
> > > (-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
> > > other is old value of data. Adding an u64 cast to fix this problem.
> > > 
> > > [1]:https://stackoverflow.com/questions/11270492/what-does-the-c-
> > > standard-say-about-bitshifting-more-bits-than-the-width-of-type
> > > [2]:https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> > > 
> > > Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to regular tree")
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > ---
> > >   drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> > > index 6df270e29e66..89713e0587b5 100644
> > > --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> > > +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> > > @@ -106,7 +106,7 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
> > >   		regaddr, bitmask);
> > >   	originalvalue = rtl_read_dword(rtlpriv, regaddr);
> > >   	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
> > > -	returnvalue = (originalvalue & bitmask) >> bitshift;
> > > +	returnvalue = (u64)(originalvalue & bitmask) >> bitshift;
> > This is a right shift, not a left shift. << vs >>.
> 
> Hi,
> 
> It's same for right shift and having a really weird result.
> 
> The result of '(u32)data >> 32' is different when using different compiler.
> Clang: "(unsigned int)41 >> 32" = 2077469672
> Gcc: "(unsigned int)41 >> 32" = 0

Ah.  Sorry.  I had forgotten that it was undefined either way...

regards,
dan carpenter


