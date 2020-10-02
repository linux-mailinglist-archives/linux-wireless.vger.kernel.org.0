Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4953281B35
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgJBSzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 14:55:55 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48740 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSzz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 14:55:55 -0400
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3599F13C2B0;
        Fri,  2 Oct 2020 11:55:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3599F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1601664954;
        bh=ULTKM6Z1kFbSvXWfaT+WHWyC4lwocS0KQXvuv60vh5E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r4XAMTjMT6N8UfUmUJ0IY+SGtsT+ontsqMS6DioygMqUp5DoXxOoW6NFSvGoFklu1
         Z/q/LSBu2K9RF/frsPIYngEjxjW1gc+QVrgyJMKkBLnmfkcy2LuQLg9Sf/C8D6JrOs
         aicHMqKxN5/yqgo2r96Xoue1PUy20TUcKI90MRRY=
Subject: Re: [PATCH 1/2] mac80211: handle lack of sband->bitrates in rates
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20201002175308.16374-1-thomas@adapt-ip.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f8d1c99d-f678-309a-80fb-0f886d1531c8@candelatech.com>
Date:   Fri, 2 Oct 2020 11:55:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002175308.16374-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/2/20 10:53 AM, Thomas Pedersen wrote:
> Even though a driver or mac80211 shouldn't produce a
> legacy bitrate if sband->bitrates doesn't exist, don't
> crash if that is the case either.
> 
> This fixes a kernel panic if station dump is run before
> last_rate can be updated with a data frame when
> sband->bitrates is missing (eg. in S1G bands).
> 
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
> ---
>   net/mac80211/cfg.c      | 3 ++-
>   net/mac80211/sta_info.c | 4 ++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index da70f174d629..e40160114824 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -709,7 +709,8 @@ void sta_set_rate_info_tx(struct sta_info *sta,
>   		u16 brate;
>   
>   		sband = ieee80211_get_sband(sta->sdata);
> -		if (sband) {
> +		WARN_ON(sband && !sband->bitrates);

Maybe WARN_ON_ONCE to keep the spam down in case this is hit repeatedly
for some reason?

Same below...

Thanks,
Ben

> +		if (sband && sband->bitrates) {
>   			brate = sband->bitrates[rate->idx].bitrate;
>   			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
>   		}
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index f2840d1d95cf..0efb66b8f185 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2122,6 +2122,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
>   		int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);
>   
>   		sband = local->hw.wiphy->bands[band];
> +
> +		if (WARN_ON(!sband->bitrates))
> +			break;
> +
>   		brate = sband->bitrates[rate_idx].bitrate;
>   		if (rinfo->bw == RATE_INFO_BW_5)
>   			shift = 2;
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
