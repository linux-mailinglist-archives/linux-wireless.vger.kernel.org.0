Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3C11ED48
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMV5k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:57:40 -0500
Received: from nbd.name ([46.4.11.11]:48618 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMV5k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hqJWgd2z0F2AajwugLpuOsxxtGv/nBITeRZwwSgmUEY=; b=BFNqBWBIdMCD8Q6+51x+OB4Gjk
        rqgwZA0+VE1AoYk85Sxg/k3obp2ei6xa6X6bQcLbbKMwK4uKvjKYMM8IDMh2DC40Jl81L9WYADMUs
        2jMf0X5jEDIsXxiVxYUpg0g3fMBhXoykWxSOVGopH/f8OMnHbrsJkdNTzxJowYa8kovw=;
Received: from p4ff13e83.dip0.t-ipconnect.de ([79.241.62.131] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ifswJ-000337-Ma; Fri, 13 Dec 2019 22:57:35 +0100
Subject: Re: [PATCH v3] mt76: use AC specific reorder timeout
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>, kvalo@codeaurora.org
References: <20191210122005.7504-1-markus.theil@tu-ilmenau.de>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <864e68a0-8e67-bf5a-8276-a4e5a546d777@nbd.name>
Date:   Fri, 13 Dec 2019 22:57:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210122005.7504-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-10 13:20, Markus Theil wrote:
> Before this patch, mt76 handled rx traffic for all TIDs  equally,
> when released from reorder buffer early. This patch uses an AC specific
> reorder timeout, in order to release partial aggregated frames for voice
> or video ACs earlier. For example, ath10k also uses AC specific reorder
> timeouts (reported by firmware in that case).
> 
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
> v3: fix changelog
> v2: use static const mapping arrays
> 
>  drivers/net/wireless/mediatek/mt76/agg-rx.c | 30 ++++++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt76.h   |  2 ++
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> index 53b5a4b2dcc5..572cf26b0fa1 100644
> --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -4,7 +4,27 @@
>   */
>  #include "mt76.h"
> 
> -#define REORDER_TIMEOUT (HZ / 10)
> +static unsigned long mt76_aggr_tid_to_timeo(u8 tidno)
> +{
> +	static const int ieee802_1d_to_ac[8] = {
> +		IEEE80211_AC_BE,
> +		IEEE80211_AC_BK,
> +		IEEE80211_AC_BK,
> +		IEEE80211_AC_BE,
> +		IEEE80211_AC_VI,
> +		IEEE80211_AC_VI,
> +		IEEE80211_AC_VO,
> +		IEEE80211_AC_VO
> +	};
> +	static const int ac_to_timeout[] = {
> +		[IEEE80211_AC_VO] = HZ / 30,
> +		[IEEE80211_AC_VI] = HZ / 25,
> +		[IEEE80211_AC_BE] = HZ / 10,
> +		[IEEE80211_AC_BK] = HZ / 10
> +	};
> +
> +	return ac_to_timeout[ieee802_1d_to_ac[tidno & 7]];
In the current implementation, voice traffic always runs without
aggregation, so it does not need special timeout handling.

Given that tid values 0-3 are BE/BK and you use the same timeout for
those, you could simplify this function to:
return HZ / (tidno >= 4 ? 25 : 10);

- Felix
