Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FE388818
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhESHZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 03:25:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33722 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhESHZA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 03:25:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621409021; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Xi6rm+02wfE8iimkDrJVtwRuysvJH7sJ44vjdfKzLeY=;
 b=t0cZ8u5aTtuHisgBi1uVr5aZ2GNt8tZw3PT6zUSW00wdp8NjkjRFCi4cKDX6D5taC3hz48xc
 SF5oSe2seT5eKSoXLY/NgAJJHQfhWzf1ntxFidiOS/y9RPpuq5xsJ6DP6IjB5Qn8pUgLtaKD
 vX1Hfy2llCAG1YgUPbJU/C5iPUA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60a4bcdd2bff04e53be67a21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 07:23:09
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B258FC4338A; Wed, 19 May 2021 07:23:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDCC9C4338A;
        Wed, 19 May 2021 07:23:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 19 May 2021 15:23:08 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com, linux-wireless-owner@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] wireless: fix wrong 160/80+80 MHz setting
In-Reply-To: <20200826143139.25976-1-shay.bar@celeno.com>
References: <20200826143139.25976-1-shay.bar@celeno.com>
Message-ID: <dbf4ca6dc2b49b55d7272e4d8eba94db@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-26 22:31, Shay Bar wrote:
> Fix cfg80211_chandef_usable():
> consider IEEE80211_VHT_CAP_EXT_NSS_BW when verifying 160/80+80 MHz.
> 
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
in Table 9-251—Supported VHT-MCS and NSS Set subfields, it has Subfield 
VHT Extended
NSS BW Capable, its Definition is:
Indicates whether the STA is capable of
interpreting the Extended NSS BW
Support subfield of the VHT Capabilities
Information field

so it should check the Subfield VHT Extended NSS BW Capable in 
vht_cap->vht_mcs firstly, if
it is 0, then not allowed to check IEEE80211_VHT_CAP_EXT_NSS_BW_MASK of 
vht_cap->cap.
please correct me if wrong.

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
