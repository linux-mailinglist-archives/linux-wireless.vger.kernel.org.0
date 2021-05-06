Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65643759AB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhEFRuM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 13:50:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44408 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhEFRuL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 13:50:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620323353; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ft7TUtBEdfOrFnaq7PjoD6JGt/OipKZ96jhb7jcLtCg=;
 b=PwdDiG95yUGm4CRPLoUfM+cqLDhAuArzU97WbKN2o7DhWSfJIiTSY7GEB2GNjfaLv3Mjz/wK
 iAfgiiemGB0/lWIgo8zLg6Qn1mUYFaEq1j8oib4AkjK9xFXQRFHlxnLNgytbCko7p/wW+9SV
 IKdj3oOWDcWRthKlHysekh+f+v8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60942c129a9ff96d95b77c64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 17:49:06
 GMT
Sender: tmariyap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD206C4338A; Thu,  6 May 2021 17:49:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tmariyap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EE1BC433D3;
        Thu,  6 May 2021 17:49:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 06 May 2021 23:19:06 +0530
From:   Thiraviyam Mariyappan <tmariyap@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2] mac80211: increment rx stats according to USES_RSS flag
In-Reply-To: <ec30381c062e3eb87abb724641a15331cfc3d11c.camel@sipsolutions.net>
References: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org>
 (sfid-20210217_125904_154301_738B3086)
 <c0aef41d2ecf09188de372fe4f7d6b1954e54e07.camel@sipsolutions.net>
 <1ee8d562986128767c037d20aedb96a5@codeaurora.org>
 <ec30381c062e3eb87abb724641a15331cfc3d11c.camel@sipsolutions.net>
Message-ID: <df6e33fe198e179f1c1f31ca6d55e995@codeaurora.org>
X-Sender: tmariyap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-23 13:28, Johannes Berg wrote:
> On Wed, 2021-04-21 at 22:18 +0530, Thiraviyam Mariyappan wrote:
>> In case of Mesh fast_rx is not applicable, but still USES_RSS can be
>> enabled from driver when parallel RX is supported by HW/Driver,
>> right? 
> 
> Yes, I guess that's true.
> 
>> Hence checked for USES_RSS support to update per cpu stats.Please
>> correct me if the meaning of USES_RSS is misunderstood and it applies
>> only when fast_rx for a STA is enabled.
>> 
> 
> Well, actually using multi-queue is pointless or even 
> counter-productive
> when you don't have fast-RX, since then you'll run into a common lock,
> and doing much processing on multiple CPUs but under a common lock 
> might
> well be worse than doing it on a single CPU in the first place, since
> you'll bounce the lock around all the time.
> 
> However, you're right that the driver might generally advertise
> USES_RSS, but then not do it for mesh, but that throws off some
> statistics.
> 
> Something like this might then be a much better fix though?
Below fix good to me and working fine.
> 
> 
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index ec6973ee88ef..f87e883862d9 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2092,7 +2092,7 @@ sta_get_last_rx_stats(struct sta_info *sta)
>  	struct ieee80211_local *local = sta->local;
>  	int cpu;
> 
> -	if (!ieee80211_hw_check(&local->hw, USES_RSS))
> +	if (!sta->pcpu_rx_stats)
>  		return stats;
> 
>  	for_each_possible_cpu(cpu) {
> @@ -2192,9 +2192,7 @@ static void sta_set_tidstats(struct sta_info 
> *sta,
>  	int cpu;
> 
>  	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
> -		if (!ieee80211_hw_check(&local->hw, USES_RSS))
> -			tidstats->rx_msdu +=
> -				sta_get_tidstats_msdu(&sta->rx_stats, tid);
> +		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->rx_stats, tid);
> 
>  		if (sta->pcpu_rx_stats) {
>  			for_each_possible_cpu(cpu) {
> @@ -2308,8 +2306,7 @@ void sta_set_sinfo(struct sta_info *sta, struct
> station_info *sinfo,
> 
>  	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
>  			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
> -		if (!ieee80211_hw_check(&local->hw, USES_RSS))
> -			sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
> +		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
> 
>  		if (sta->pcpu_rx_stats) {
>  			for_each_possible_cpu(cpu) {
> 
> 
> johannes
