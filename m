Return-Path: <linux-wireless+bounces-11812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097095BDA8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFFF1C21FB7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773D1CCECC;
	Thu, 22 Aug 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gb2MnRyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CA1CB138
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348793; cv=none; b=i8FeCzYdz/tVCoi0vbqR2AUTpYbsryUAW5YjHKADruURfwsDTigNQgRlurn9gY2ueYPxjXmDtZA1TVYeWT/ZrUgFNym29Dw0l4A1ozF+ijxq3oNK7z71IYky75VfDK+gVFJrIdet/tt4Mcx8/61ExP85wSqTYbfWiXpyaOkzfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348793; c=relaxed/simple;
	bh=7Cg4Cb79uBvSL9Q/CzeY8cde8LpE8z/qbnsP+4Iz4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsbUlYEOOzzjYRRFczgLkFyr/LQt4YHuPozmTfo/cIotFix7KotezXQRxzCyNZcLfNTyDpAwBp0dlciJqXM5Xkehf74ae7FZkKOJD1UdJ+nQszh2mHP+z7uvehIAosH6m0kSdqq6iOOVux2+DQ2Q+nCmCaqH9Cb6NGaQgKr/qvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gb2MnRyM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fae21398so8746225ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724348791; x=1724953591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPxtm48V/PPdhN8wSURGWZ+5uOKyuKnvjhxgqACifgk=;
        b=gb2MnRyMXS9yyc40FkOAsWofNWnip6HLoNLAXtze/10YgrRm0rExZmJGlR5cUK3pn7
         dEax3+J5pxWhD//1eeu1gijbeU/CYCs2JEpfwHAC2xjNbPLWJ6gXNecDNtZZGoqbDrgp
         bYHlYuIwKPNY2IWFyg3wnBDOuLOcEStAhLs2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348791; x=1724953591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPxtm48V/PPdhN8wSURGWZ+5uOKyuKnvjhxgqACifgk=;
        b=ZI3xG6chNsugELSqYhUJX5CTt/OythOBac9aFPaLVvfGkVFb5UD2IKnBHn6WrK8bse
         Mi1MQ0m8PR+6goHKrNMnJUbWT/J0KtMl9dsLTmBv3C5ne0lV69EcRrtCaB7/UU+Ti9I1
         8cPmcVM8m8UIUdH5/r6S1SyaBA43UheP10lSZYyNDzy0+QjoEdJc4G1bPZGZ+c3avLiD
         ZBOgc8yYDIIJm167ZeJFqBQOCXohqEUqXn/KgCkOnlmTcMsMGnVe69bcZtvCCSMjGauj
         IgeQztcMRrynOm1IYkIHSKsRbSw70J0sVgP9Arm0vvJUYuMVhBe8B6eMnJH5OQhDsOg0
         x2sw==
X-Forwarded-Encrypted: i=1; AJvYcCUpXKTLXC+Z7YyAbP5YVnP5M10a6r6HubyL0EOY57t+7QyywCumKAR0Yvyzv0+VJL3pXz0gs37UkqajCrUiaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+FUBwC6FyRk6sAESPEV5OHkrBL+vxCJDAMvCbPAaM6P0nJmX
	zsuwCn7V1leUsnfuvv88Z5RTTT1IkqBJN5tHoKjHrFI9StknJi3XEc46Yrmh6A==
X-Google-Smtp-Source: AGHT+IEHvyAehqf/sUVvhH1XQLyhGtO7mHKAv+wdaxRKZtKrVcP//nm5YXV4qVZAoJjlfxKJ5ELPZg==
X-Received: by 2002:a17:902:e812:b0:1fd:9c2d:2f27 with SMTP id d9443c01a7336-20367d2b1b9mr71582405ad.24.1724348791138;
        Thu, 22 Aug 2024 10:46:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-203855dc28bsm15269055ad.133.2024.08.22.10.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:46:30 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:46:29 -0700
From: Brian Norris <briannorris@chromium.org>
To: Chen Yufan <chenyufan@vivo.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] wifi: mwifiex: Convert to use jiffies macro
Message-ID: <Zsd5ddqiIgxaEPKs@google.com>
References: <20240822102906.141488-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822102906.141488-1-chenyufan@vivo.com>

On Thu, Aug 22, 2024 at 06:29:04PM +0800, Chen Yufan wrote:
> Use time_after macro instead of using
> jiffies directly to handle wraparound.
> The modifications made compared to the previous version are as follows:
> 1. Added a typecast to unsigned long for rssi_jiffies
> to resolve the compilation error.

Can we just change the type in mwifiex_auto_tdls_peer::rssi_jiffies?
Fewer casts is generally better.

Brian

> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
> index 6c60621b6..e48e8affd 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -1439,8 +1439,8 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
>  
>  	spin_lock_bh(&priv->auto_tdls_lock);
>  	list_for_each_entry(tdls_peer, &priv->auto_tdls_list, list) {
> -		if ((jiffies - tdls_peer->rssi_jiffies) >
> -		    (MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
> +		if (time_after(jiffies, (unsigned long)tdls_peer->rssi_jiffies +
> +					 MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
>  			tdls_peer->rssi = 0;
>  			tdls_peer->do_discover = true;
>  			priv->check_tdls_tx = true;
> -- 
> 2.39.0
> 

