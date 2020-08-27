Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79612254818
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgH0MOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgH0MOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:14:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863CC061233
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:14:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so5174111wro.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ekjfb6Sf6mANsgF0KqhEnPQMEOzKt6dtLU96j3CPtgg=;
        b=GDQ1TKl2/iDAzJxhE1Z5lMfgwiQlwWjbf09jpTl2+AuUDzQ/wJheaaCy3mYuelKJca
         qhRxSWX09KbStDspCwPlp1EJRTJ56oycoh97ud+3Ctd4QTV/cFH7r0zoDOglv8RV1N22
         eJIaiDXU9hFKuFYwjuxcXgVO6ZEyXectjOH1txFrysGx+gQjqLlxGZhVE9V2ficAsh89
         52cnO2neBd5hSLef6IfzxWlmU6qJQZZkI1FzE5FSAMCMzRlkeoxH1USuvwQIJCh+5thJ
         qFxCkow5jLYNFOI+36aJ3LiaZzNDQX5Z2P5/802qs43HA7OhBwpA48MZ3SxfUHJWXm0y
         caCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ekjfb6Sf6mANsgF0KqhEnPQMEOzKt6dtLU96j3CPtgg=;
        b=Idt9E7lSaU+ypNJdqFcjjui1lQr8fOyjCWAJP+UJH/cqaNMOvr9+j7NQnDtf/3CkSr
         wsBwXhwkD8ENFlQQyXSvsw6SGVPGuYAfdivzX+zGhCxBAevaEO5GoZQVcdlM57ULQm1M
         xgi/uWtQVEEYzztomYz4TISXVh1sfBGfDEgQ9oJnnLjKpfVCCdH2fULg1RNMM1pBHb4n
         ou7v6lVtOyKuuvR0u+tJUBfFrnRGfwDgnwEpekZA6zMue/ZADnSz29G3wo6A19ynAjWb
         tx7/+mQgBE5y8XT5b4i/NHF4baLjf7DHuZnfcQBiXqvxqm36TI+5jZ4buo7yHLny1XVh
         o4+w==
X-Gm-Message-State: AOAM532Pi34rkycm4P6zJILVbFEy3KpWxpcr50uOKw083qVbOl4tjTqB
        GH1WIYfsw3TR7xbomzBCVcIEDw==
X-Google-Smtp-Source: ABdhPJzomTvDIDWXCuEcyS33gAAp/nwPzZVLkwg48iNvf3HKA7HDg+tln7igV6uhPtB69oGfCXuhAQ==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr2056985wrm.256.1598530443604;
        Thu, 27 Aug 2020 05:14:03 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id 3sm4533378wms.36.2020.08.27.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:14:02 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:14:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/30] Set 3: Rid W=1 warnings in Wireless
Message-ID: <20200827121401.GD1627017@dell>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
 <87y2m09tye.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2m09tye.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 27 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > There are quite a few W=1 warnings in the Wireless.  My plan
> > is to work through all of them over the next few weeks.
> > Hopefully it won't be too long before drivers/net/wireless
> > builds clean with W=1 enabled.
> 
> How much patches are there going to be? I was first positive about the
> idea but now I am really starting to wonder if this is worth the effort,
> these patches are spamming my patchwork significantly and taking too
> much time. At least please hold of on any new patches for at least a
> week so I can catch up with all patches I have.

1 more set to go.  drivers/wireless was pretty dirty in this regard
starting with over 6000 warnings.

> And like I said already before, follow the title style we use so that I
> don't need to edit every patch myself:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong

Sure.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
