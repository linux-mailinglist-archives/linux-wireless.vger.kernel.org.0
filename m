Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC08263303
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgIIQzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbgIIPwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:52:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6BC061371
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 07:17:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so3159480wrx.7
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YTINV8fXf0M3n9PBAJO84TZ3ZWqVa/k8IvPy7N9wgi4=;
        b=ISIjZ5JQj4TVnnSGapFb7wbJQYYctJNyBV/BPiddD36GRemkQ2jjGJozi7ZZ/kNFgX
         L+a9BRRcxvMgswArV5WD4NYsCit9c2oH3aiX4oPX4bd3Jz2GsnLqByOiF29v5yx3b5iD
         uDbebTiq0Z5y1HyVnJZ+YOiaS2S0q+WjKtZ6Tef9eHw7YRu85EZSVkNInnykwrXTIC+n
         P5rhgZr4VBrBEVyX5ti/2W5iurPZAztgCxVQu0luBxCahAI/N4dSAyW9VNbxVRuO4gwp
         I7Snb8LSDhaMGjreOX/81es+gdR7Eb9OtmYjiXDDWcimTmOxMQjfw/bK/6V7yYEScTk0
         wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YTINV8fXf0M3n9PBAJO84TZ3ZWqVa/k8IvPy7N9wgi4=;
        b=mYsTxYE8WzbkFDt2z8J6+pfMeq+bYa3/FeokQA8qHzfOJlrfX1o5zD6ESxkQg50ziL
         HPy5U/+ZfSDLYnpwcWwbWNxFcs1f6OuikpemG0Meg1jNBAM/TCWU2bfH6CW9Gwt70s0f
         d7Qp3vLC+JVrqx5X9OiWxti3t/aVbwlVK2Ff5wABqIA+IRHlz+hnYsJ3uDZqTHGl2xEK
         EXTC2q1KOVcGegEn/Hx5fA96w61rgFQhyXZzELl+zA4TcHj9ZpUsnfgQ3oBeS8NGZla0
         mqyp1SA2/TRsGpqXtrXdsch4EqFdPQk82aHNvgUnSEUSwRSuCgP9pWjC/KW4bIxdHOp8
         D3mw==
X-Gm-Message-State: AOAM533I3b4qdhSOoz76G1DTSnsixj0IexAZwE4rzXynlYyK4BVSuV7/
        6Pe8p8nKvTRbNCxr3+2opA4RoA==
X-Google-Smtp-Source: ABdhPJyylZV7lGE0N2Ov626dsFCzQyMBnovybUKfA++XerEYgGcuyp66iCHpW/4W3EGC5UFcCO7ASQ==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr4682690wrc.60.1599661042100;
        Wed, 09 Sep 2020 07:17:22 -0700 (PDT)
Received: from dell ([91.110.221.208])
        by smtp.gmail.com with ESMTPSA id m3sm2774942wrs.83.2020.09.09.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:17:21 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:17:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: Re: [PATCH 01/32] wireless: marvell: mwifiex: sdio: Move 'static
 const struct's into their own header file
Message-ID: <20200909141719.GD218742@dell>
References: <20200821071644.109970-2-lee.jones@linaro.org>
 <20200901091541.3974FC433C6@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200901091541.3974FC433C6@smtp.codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 01 Sep 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Only include these tables in the 1 source file they are used.
> > 
> > Fixes hundreds of W=1 warnings!
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  In file included from drivers/net/wireless/marvell/mwifiex/main.h:59,
> >  from drivers/net/wireless/marvell/mwifiex/main.c:22:
> >  drivers/net/wireless/marvell/mwifiex/sdio.h:705:41: warning: ‘mwifiex_sdio_sd8801’ defined but not used [-Wunused-const-variable=]
> >  705 | static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
> >  | ^~~~~~~~~~~~~~~~~~~
> > 
> >  NB: There were 100's of these - snipped for brevity.
> > 
> > Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> > Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> > Cc: Xinming Hu <huxinming820@gmail.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I don't think static const variables should be in a .h file. Wouldn't
> sdio.c be the right place for these? At least from a quick look I got
> that impression.

That's a bone of contention.  I personally do not like to see C-files
overwhelmed by a sea of structs/tables and tend to ferry them off into
*-tables.h header files instead.

As the gate-keeper, what you say goes.  So if you insist we move these
450 lines of tables into the source file which references them, I will
of course do as you ask.

> Patch set to Changes Requested.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
