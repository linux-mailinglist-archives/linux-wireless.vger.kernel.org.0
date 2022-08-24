Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78835A0231
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Aug 2022 21:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiHXTi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Aug 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiHXTiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Aug 2022 15:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53591792E1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 12:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6BC4B8262C
        for <linux-wireless@vger.kernel.org>; Wed, 24 Aug 2022 19:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EFAC433C1;
        Wed, 24 Aug 2022 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661369928;
        bh=R4hfsdp6uroBMrUMR69RZsiOlaN6utlNy+v5ZpGfvgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnM8BYNvJ3y80vZ1pnymZP99kITzdjDzOsxjAnVk7lkEVkqMev87N7epMndF94wKw
         k+2zle/3UNJ5yWLpmaJrt6IwzB+ih0OmcKTaHAwUPmSkZ5yDRC+wNh0qoGDCltUr3n
         YhnngFaGSSyOyBlPoi3xfl2kAvg7CyrB3Hl+p0/5Wl1gV9dXHXS70veQMToMwPT3Ax
         gxBwWJnyRuHQf00AB94H+v+AzV0ojIhxFLCih8tl+a2cug3Oy4ss1FfAlUIaebmt9r
         4/bWNkyVXTvpVrdJkJGfcRmn0r+/W3K0uoz7otvbiQUx+16prKLn3jgmW1dxSjCL3C
         QhIuF8ReRk5Ww==
Date:   Wed, 24 Aug 2022 12:38:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: fix uninitialized use of primary channel
 index
Message-ID: <YwZ+RsHL+n02gHZx@dev-arch.thelio-3990X>
References: <20220815062004.22920-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815062004.22920-1-pkshih@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 15, 2022 at 02:20:04PM +0800, Ping-Ke Shih wrote:
> clang reports uninitialized use:
> 
> >> drivers/net/wireless/realtek/rtw88/main.c:731:2: warning: variable
>    'primary_channel_idx' is used uninitialized whenever switch default is
>    taken [-Wsometimes-uninitialized]
>            default:
>            ^~~~~~~
>    drivers/net/wireless/realtek/rtw88/main.c:754:39: note: uninitialized
>    use occurs here
>            hal->current_primary_channel_index = primary_channel_idx;
>                                                 ^~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/realtek/rtw88/main.c:687:24: note: initialize the
>    variable 'primary_channel_idx' to silence this warning
>            u8 primary_channel_idx;
>                                  ^
>                                   = '\0'
> 
> This situation could not happen, because possible channel bandwidth
> 20/40/80MHz are enumerated.
> 
> Fixes: 341dd1f7de4c ("wifi: rtw88: add the update channel flow to support setting by parameters")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Can we get this into -next soon? This warning is breaking our builds due
to CONFIG_WERROR.

> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 790dcfed1125d..5a74dda977563 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -697,6 +697,7 @@ void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
>  
>  	switch (bandwidth) {
>  	case RTW_CHANNEL_WIDTH_20:
> +	default:
>  		primary_channel_idx = RTW_SC_DONT_CARE;
>  		break;
>  	case RTW_CHANNEL_WIDTH_40:
> @@ -728,8 +729,6 @@ void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
>  			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_channel - 4;
>  		}
>  		break;
> -	default:
> -		break;
>  	}
>  
>  	switch (center_channel) {
> -- 
> 2.25.1
> 
> 
