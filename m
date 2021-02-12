Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E123A319CB7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBLKfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 05:35:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhBLKfD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 05:35:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lAVmF-0001yo-TT; Fri, 12 Feb 2021 10:34:19 +0000
Subject: Re: [PATCH] mac80211: fix rate mask reset
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20210212112213.36b38078f569.I8546a20c80bc1669058eb453e213630b846e107b@changeid>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <9a1b0da8-d5fb-1101-3dba-45c488821b61@canonical.com>
Date:   Fri, 12 Feb 2021 10:34:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212112213.36b38078f569.I8546a20c80bc1669058eb453e213630b846e107b@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/02/2021 10:22, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Coverity reported the strange "if (~...)" condition that's
> always true. It suggested that ! was intended instead of ~,
> but upon further analysis I'm convinced that what really was
> intended was a comparison to 0xff/0xffff (in HT/VHT cases
> respectively), since this indicates that all of the rates
> are enabled.
> 
> Change the comparison accordingly.
> 
> I'm guessing this never really mattered because a reset to
> not having a rate mask is basically equivalent to having a
> mask that enables all rates.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: 2ffbe6d33366 ("mac80211: fix and optimize MCS mask handling")
> Fixes: b119ad6e726c ("mac80211: add rate mask logic for vht rates")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/cfg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index c4c70e30ad7f..68a0de02b561 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -2950,14 +2950,14 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
>  			continue;
>  
>  		for (j = 0; j < IEEE80211_HT_MCS_MASK_LEN; j++) {
> -			if (~sdata->rc_rateidx_mcs_mask[i][j]) {
> +			if (sdata->rc_rateidx_mcs_mask[i][j] != 0xff) {
>  				sdata->rc_has_mcs_mask[i] = true;
>  				break;
>  			}
>  		}
>  
>  		for (j = 0; j < NL80211_VHT_NSS_MAX; j++) {
> -			if (~sdata->rc_rateidx_vht_mcs_mask[i][j]) {
> +			if (sdata->rc_rateidx_vht_mcs_mask[i][j] != 0xffff) {
>  				sdata->rc_has_vht_mcs_mask[i] = true;
>  				break;
>  			}
> 

Looks good to me, thanks Johannes.

Reviewed-by: Colin Ian King <colin.king@canonical.com>
