Return-Path: <linux-wireless+bounces-133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB27FAEF8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 01:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A1B1C20B28
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB27EB;
	Tue, 28 Nov 2023 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHW7zeIR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FE18B
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 16:22:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4076878b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701130932; x=1701735732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcF7EbG17wMf5A1vywn815C2rgzGBSTBqW3p8rKvm+Q=;
        b=gHW7zeIRSF2utN8brgCdiO6Rlba0fYGpE5dOK8IlsXWocIGrDthTK5MYK0qlDsXkw7
         gFpNyvoRmnbTa9zIL+TKPdtU+tCYSBjZCzJl7etvG6bAJe4ozoVqClXacnhoUodVz1en
         hBAKMVsquMEFYQFKpaTNhfdkxzuY5rGCExqIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701130932; x=1701735732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcF7EbG17wMf5A1vywn815C2rgzGBSTBqW3p8rKvm+Q=;
        b=eVhWAKYonWMHfbulGAr4E+N0xAgr1hxY8CVUqnF2goFZiG+lpbNmzdoWCfw+u2O9UV
         NyzV9vBEAzGCiPGT2sF6GQd6IFcFz4TEv+M/ZxD2TEHoJmzqG/ukw1PTqfEEsO3K7aVm
         UNswZuDqltu223YZVQ+w2vOVscVTUV90mgadnTLadN65Ffmf6q+nNRGBYJ+YTxSmkU3L
         DnHPDeb3MJqBcP82BGTWrC4yakrb9BDF51INm/rCk0WmNkzMHjAQQ7+ksGVKVdXcKPKE
         HvXbLLBgC2Qlv0lenDbM7e5ZMmFV09kqFkWWAMyToj/vvHeHY0lRdS1IkDvGb2m6fDsX
         e+IQ==
X-Gm-Message-State: AOJu0Yw6EHotYPyI2kmUx/Maxziy9uNFLH+uL23mjlimn5GqaxaAoX1+
	YMvHCxrgMp8cYSHZxUTlNZuOeuvec/e/03AK0dlUiA==
X-Google-Smtp-Source: AGHT+IGUgQLH74WqDwY1dXBnMXs3poKbhgyhnJWjJs8YpFTvm4lBIManweCNuXmLfe1LHnljM+TKyg==
X-Received: by 2002:a05:6a00:88f:b0:6b3:f29c:dde1 with SMTP id q15-20020a056a00088f00b006b3f29cdde1mr14055045pfj.21.1701130932417;
        Mon, 27 Nov 2023 16:22:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fh23-20020a056a00391700b006cc02a6d18asm4752811pfb.61.2023.11.27.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:22:11 -0800 (PST)
Date: Mon, 27 Nov 2023 16:22:11 -0800
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Will Deacon <will@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] uapi: propagate __struct_group() attributes to the
 container union
Message-ID: <202311271620.B0CB21B@keescook>
References: <20231120110607.98956-1-dmantipov@yandex.ru>
 <f0bebfe0f7e02bb51676d8f6a80be0444e2b8662.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0bebfe0f7e02bb51676d8f6a80be0444e2b8662.camel@sipsolutions.net>

On Fri, Nov 24, 2023 at 06:37:14PM +0100, Johannes Berg wrote:
> On Mon, 2023-11-20 at 14:05 +0300, Dmitry Antipov wrote:
> > Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
> > in an old and unmaintained wil6210 wireless driver.
> > 
> 
> Heh. I guess it wasn't unmaintained enough for someone to touch it and
> add struct_group() to it...

It needed it since it was using memcpy across fields. But it's been a
while since that change happened, so finding this bug now is pretty
impressive. :)

> 
> >  include/uapi/linux/stddef.h | 2 +-
> > 
> 
> No idea what tree this should go through, but I guess wireless isn't
> appropriate.

I'll take it; thanks for the find Dmitry!

-- 
Kees Cook

