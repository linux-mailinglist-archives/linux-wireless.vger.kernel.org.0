Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1343F1C2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJ1VfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJ1Vep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 17:34:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CDC06118D
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 14:32:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l13so331036pls.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uy4mRbBBqA+oiG8IXstn8KcE/N1G+FCE7sqsdumsmms=;
        b=AyjigdjLgocQsgIuq8Ha1vmKHdVArVun9BzEHdA6o8NBbDsP7D4xtGjqa5F4lhuphX
         fNQeGBADxcDGvgylDZeHtre71zUQlq2CLEzawVYj7LTm9gcA49bXpCdQHr8a2F5ieO7z
         jWdWhywQ1F4B+TT5+tyjEWDj3LMPqQ6HDFmfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uy4mRbBBqA+oiG8IXstn8KcE/N1G+FCE7sqsdumsmms=;
        b=KmdnVY+qooFL60okW6gz8THHoYgvwql9v0oBlrGxd3WOnQP9p2LLTOBMp07h9c/O3p
         HNbJ3sKCu6m3uYnzpCTuxpM9APSGlcNuhr24szLGlZIEfm6hoewjzVyOPsaTGEo7ld6o
         P5Bgi5R4XetIWsS/SDj7xYPwXYU/uRazOlOAnIGstGEtjUiaPZkZg7PMJsw6k+XeuzYe
         8q0Y6rvfABb+0NlRIcNFDzb1peMNGc9/HiSFF0a3rkOa6USJworDyx/42DfJuy1ZAh2/
         9w9Q664ZaviRIfcjNRuTaYSMiXTRdzT7uKFV5j6sOiL89nhILsmqyIfF49h586Okh2g4
         oHAQ==
X-Gm-Message-State: AOAM532Dg1Q8bt3qbQXSwaTOv0Zja80QX/DrXX8zDTXDeowpVRmOxff7
        t5K5xMz7uKrf2OSYp2PIYy9qCOvb9aUx6g==
X-Google-Smtp-Source: ABdhPJwWVexu+q9+KrhJQxOn+ubq2XpJHScki+SynJ+d7Vk7PZNW3Y8qnXl8vPdXNVMdGCpGZmSy4g==
X-Received: by 2002:a17:90a:b783:: with SMTP id m3mr15700631pjr.183.1635456730920;
        Thu, 28 Oct 2021 14:32:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:dd0:1290:5368:ac15])
        by smtp.gmail.com with ESMTPSA id k73sm2751154pgc.63.2021.10.28.14.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:32:10 -0700 (PDT)
Date:   Thu, 28 Oct 2021 14:32:08 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        kevin_yang@realtek.com
Subject: Re: [PATCH 1/2] rtw89: update tx power limit/limit_ru tables to R54
Message-ID: <YXsW2K1BWQjX1w4x@google.com>
References: <20211028084054.12962-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028084054.12962-1-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 04:40:53PM +0800, Ping-Ke Shih wrote:
> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Support QATAR in rtw89_regulation_type and reorder the enum.
> Update tx power limit table and tx power limit_ru table to configure QATAR
> and adjust indexes to align rtw89_regulation_type enum.
> 
> Besides, if an unassigned entry of limit/limit_ru tables is read,
> return the corresponding WW value for the unconfigured case.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/core.h     |    9 +-
>  drivers/net/wireless/realtek/rtw89/phy.c      |   12 +
>  .../wireless/realtek/rtw89/rtw8852a_table.c   | 5199 +++++++++++------
>  3 files changed, 3488 insertions(+), 1732 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> index c2885e4dd882..3729abda04f9 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -411,12 +411,13 @@ enum rtw89_regulation_type {
>  	RTW89_NA	= 4,
>  	RTW89_IC	= 5,
>  	RTW89_KCC	= 6,
> -	RTW89_NCC	= 7,
> -	RTW89_CHILE	= 8,
> -	RTW89_ACMA	= 9,
> -	RTW89_MEXICO	= 10,
> +	RTW89_ACMA	= 7,
> +	RTW89_NCC	= 8,
> +	RTW89_MEXICO	= 9,
> +	RTW89_CHILE	= 10,
>  	RTW89_UKRAINE	= 11,
>  	RTW89_CN	= 12,
> +	RTW89_QATAR	= 13,
>  	RTW89_REGD_NUM,
>  };
>  
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
> index ab134856baac..0620ef02e275 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c

> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> index 3a4fe7207420..6a61549ffac7 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
> @@ -43556,1346 +43556,1850 @@ const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
>  	[0][0][0][0][1][0] = 56,
>  	[0][0][0][0][3][0] = 68,
>  	[0][0][0][0][5][0] = 76,
> -	[0][0][0][0][6][0] = 56,
> -	[0][0][0][0][9][0] = 56,
> -	[0][0][0][0][8][0] = 60,
> +	[0][0][0][0][6][0] = 76,
> +	[0][0][0][0][7][0] = 56,
> +	[0][0][0][0][10][0] = 60,
... 

If one of these colums is based on an enum, you should probably *use*
the enum in the table. Then this patch would probably much much smaller,
and it would be clear what parts are changes and what parts are just
renumbering...

I'd suggest splitting this into at least one more patch, where the first
patch should replace all the magic numbers (0..12) with the appropriate
rtw89_regulation_type values.

Brian
