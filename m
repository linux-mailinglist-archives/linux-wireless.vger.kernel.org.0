Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62F82E77E8
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 11:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgL3K6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 05:58:50 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:45339 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL3K6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 05:58:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609325905; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=osdqX7f+Gzj2BYYE5PSLepRpNoJSJdoe2RuEdG6h+08=;
 b=MW8YVdV2gjxAIRjF1xpSF1EaWoMI/n7amgdmRtqjLKE20fFwc8VbT7FVD56t2fPPZ8HkDpcu
 ndA3wT4mQhvXyrp6zo5gmu4bQ8N6xPsEM/Fnye6CdlZaG5lqOGrSSoQxiZPCiPlc19TwUb2B
 h43aXj5NbjzXxVjIPwkjBGeL0Pw=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fec5d2eca7aa4490a9ea2e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Dec 2020 10:57:50
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25709C43462; Wed, 30 Dec 2020 10:57:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 305BBC433CA;
        Wed, 30 Dec 2020 10:57:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 30 Dec 2020 18:57:49 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com, linux-wireless-owner@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] wireless: fix wrong 160/80+80 MHz setting
In-Reply-To: <20200826143139.25976-1-shay.bar@celeno.com>
References: <20200826143139.25976-1-shay.bar@celeno.com>
Message-ID: <34893f267fa37b43d21c19d4c08c090e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-26 22:31, Shay Bar wrote:
> Fix cfg80211_chandef_usable():
> consider IEEE80211_VHT_CAP_EXT_NSS_BW when verifying 160/80+80 MHz.
> 
When station with below 2 bit and connect to a 160MHZ 11ac mode AP, it 
will try to use 160Mhz width after this patch,
but it does not support 160M in fact according spec of IEEE 802.11
.... .... .... .... .... .... .... 00.. = Supported Channel Width Set: 
Neither 160MHz nor 80+80 supported (0x0)
01.. .... .... .... .... .... .... .... = Extended NSS BW Support: 0x1

refer to spec of IEEE 802.11.
Table 9-250—Setting of the Supported Channel Width Set subfield and 
Extended NSS BW Support subfield at a STA transmitting the VHT 
Capabilities Information field
value of the 160Mhz is 1/2 in the table for upper configure.
NOTE 2—1/2× or 3/4× Max VHT NSS support might end up being 0, indicating 
no support.

> Based on:
> "Table 9-272 — Setting of the Supported Channel Width Set subfield and
> Extended NSS BW
> Support subfield at a STA transmitting the VHT Capabilities Information 
> field"
> From "Draft P802.11REVmd_D3.0.pdf"
> 
> Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
> Signed-off-by: Shay Bar <shay.bar@celeno.com>
> ---
>  net/wireless/chan.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 90f0f82cd9ca..a51d11d3be33 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -912,6 +912,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>         struct ieee80211_sta_vht_cap *vht_cap;
>         struct ieee80211_edmg *edmg_cap;
>         u32 width, control_freq, cap;
> +       bool support_80_80 = false;
> 
>         if (WARN_ON(!cfg80211_chandef_valid(chandef)))
>                 return false;
> @@ -979,9 +980,16 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>                         return false;
>                 break;
>         case NL80211_CHAN_WIDTH_80P80:
> -               cap = vht_cap->cap & 
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
> +               cap = vht_cap->cap;
> +               support_80_80 =
> +                       ((cap &
> +                         
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ) ||
> +                       (cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ 
> &&
> +                        cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) ||
> +                       ((cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
> +                                   IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT 
> > 1));
>                 if (chandef->chan->band != NL80211_BAND_6GHZ &&
> -                   cap != 
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
> +                   !support_80_80)
>                         return false;
>                 /* fall through */
>         case NL80211_CHAN_WIDTH_80:
> @@ -1001,7 +1009,8 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>                         return false;
>                 cap = vht_cap->cap & 
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
>                 if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
> -                   cap != 
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
> +                   cap != 
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ &&
> +                   !(vht_cap->cap & 
> IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>                         return false;
>                 break;
>         default:
> --
> 2.17.1
> 
> ________________________________
> The information transmitted is intended only for the person or entity
> to which it is addressed and may contain confidential and/or
> privileged material. Any retransmission, dissemination, copying or
> other use of, or taking of any action in reliance upon this
> information is prohibited. If you received this in error, please
> contact the sender and delete the material from any computer. Nothing
> contained herein shall be deemed as a representation, warranty or a
> commitment by Celeno. No warranties are expressed or implied,
> including, but not limited to, any implied warranties of
> non-infringement, merchantability and fitness for a particular
> purpose.
> ________________________________
