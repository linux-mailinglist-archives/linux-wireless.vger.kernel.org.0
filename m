Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE7442572
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 03:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhKBCJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 22:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhKBCJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 22:09:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA23C061714
        for <linux-wireless@vger.kernel.org>; Mon,  1 Nov 2021 19:07:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f8so13570741plo.12
        for <linux-wireless@vger.kernel.org>; Mon, 01 Nov 2021 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X0KNTb2us3Ia9srw3GHvBgjPWtgzHHzGdeUNjD9VS7c=;
        b=oFA1lx6vBl6yIhF83Eitiqkl/iCFrRIAb2Bz1ntR4/IBN9sLpATiJZPs1Nh3JdvWiM
         beZs948NAx0x7C5oucGbGHXtv3ZZn4nchu/JmOCEQHMaRbFrwUX76O85p9Fah5ZZ+eBz
         59y6n7ThaziDuv/yCuf2LQB0yeFdpHdQjlR+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X0KNTb2us3Ia9srw3GHvBgjPWtgzHHzGdeUNjD9VS7c=;
        b=W9CmFKYR496qhBnH09dXrSHBjXrBHuhbbSyQoLRGRg6Lv427BP75CIyrR809AifwpS
         MwbIPgl+d3w5KCL9lNynHymm5pdOZv2N/cZBb/tsNeEWKFJmERQdmRwuSMLLrSk+KXiI
         5CcSx25pk+/4fZdWXR1WI3nCTQVkH7BnQuYvVCdzRgSoun+tkWjRtLQvKRr11XE9/r5M
         cFPwbxGekGa+JhBEpIdIEt2c9jWsiopvXL3Upr1KRNKQG69XhAb/oA6DRvejnsjfpWMv
         w9EPrhx3+Rlq3i5JWVGfSJjqfsvJWNp2mXX+9FtynMBqb8qnu/rCNYCNCOxnw6rjl0Sm
         qJDw==
X-Gm-Message-State: AOAM532+UMMz4H+ttSIvMXspNvIoqc2rDcEu41HrdCz8mXAOBEY2hBSo
        qyHujjmJbIzoqxdBTpNFEzmXjn6td2p8zA==
X-Google-Smtp-Source: ABdhPJyvIPrHQ4IOx1U4WwlWF1Rb1XjHEvMaX1sCqRKZTwfE51bG+gmQbTY6TZ4adny4Lm9eZcZqzQ==
X-Received: by 2002:a17:902:f687:b0:141:cf6b:fee7 with SMTP id l7-20020a170902f68700b00141cf6bfee7mr14721171plg.75.1635818821927;
        Mon, 01 Nov 2021 19:07:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:789b:da3e:14cf:ccbb])
        by smtp.gmail.com with ESMTPSA id s2sm16001017pfe.215.2021.11.01.19.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 19:07:01 -0700 (PDT)
Date:   Mon, 1 Nov 2021 19:06:59 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        kevin_yang@realtek.com
Subject: Re: [PATCH v2 1/4] rtw89: fill regd field of limit/limit_ru tables
 by enum
Message-ID: <YYCdQwCo3E8hH4c3@google.com>
References: <20211101093106.28848-1-pkshih@realtek.com>
 <20211101093106.28848-2-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101093106.28848-2-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 01, 2021 at 05:31:03PM +0800, Ping-Ke Shih wrote:
> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> This modification just replaces the number filled in the regd field
> with the corresponding enum. No assignment of a value in a table is
> changed. Doing this first is because the follow-up patches may adjust
> the order of enum declarations.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  .../wireless/realtek/rtw89/rtw8852a_table.c   | 10458 ++++++++--------
>  1 file changed, 5229 insertions(+), 5229 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> index 3a4fe7207420..c7ebeed043c5 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> @@ -43384,5248 +43384,5248 @@ static const u8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
>  const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
>  				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
>  				 [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
> -	[0][0][0][0][0][0] = 56,

FWIW, these transformations worked out for me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

These files are still enormous though, which an enormous amount of
repetition. I can't help but think there's a better way to do these
things. For instance, if there's a repeated/shared pattern, one could
just save that array once, and generate the repeated copies at runtime.
Or instead of exposing an enormous const array directly to the "core",
add some kind of abstraction function, where the function can perform
more custom (and presumably more targeted, with less duplication?) logic
to determine the answer.

But that's food for thought for the future.

Brian
