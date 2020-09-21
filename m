Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57D5271E58
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIUIuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 04:50:22 -0400
Received: from z5.mailgun.us ([104.130.96.5]:11204 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgIUIuU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 04:50:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600678219; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tK9/FpUCIZ6/F2Ta1f57g+G/2zaP836a8ydhyiqzVGE=; b=lvLHK++YUGPcH7LrjtI4ZzfXnMaI4lMdc0umI0AXoKyKF4pdPllhKr4pRTnKGvYbTBCM+Ibw
 uHG38hkbiiPupJsJnZwWZMmmg3uSBYtxZRHNYz71Vvmn1lsnQDr0Peu9uxwH3HiIWOU82w+W
 HTPnfBLYmWTgklDh3ELtQklsZ18=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f68694a0915d3035788b6be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 08:50:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44371C433C8; Mon, 21 Sep 2020 08:50:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85899C433CB;
        Mon, 21 Sep 2020 08:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85899C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in re-configure
References: <20200525165317.2269-1-greearb@candelatech.com>
        <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
        <c53fd2d0-3ffb-3700-f12e-34c1867dded4@candelatech.com>
        <7f2722c9d30bb1a4715398b4f29309b1f383593b.camel@sipsolutions.net>
        <6a0f46b1-54c0-c090-56e6-7cca3b295691@candelatech.com>
        <2bcd9fbd6d141d6e78f606fd7f96fb99573810d2.camel@sipsolutions.net>
        <98996ee9-a9cc-521b-05cc-1404d3b9b251@candelatech.com>
        <cbe230f7270587e14ccee835561c437362e3933d.camel@sipsolutions.net>
Date:   Mon, 21 Sep 2020 11:50:14 +0300
In-Reply-To: <cbe230f7270587e14ccee835561c437362e3933d.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 30 Jul 2020 17:03:30 +0200")
Message-ID: <87h7rrbjjt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2020-07-30 at 07:52 -0700, Ben Greear wrote:
>
>> > Consider
>> > 
>> > add interface wlan0
>> > add interface wlan1
>> > iterate active interfaces -> wlan0 wlan1
>> > add interface wlan2
>> > iterate active interfaces -> wlan0 wlan1 wlan2
>> > 
>> > If you apply this scenario to a restart, which ought to be functionally
>> > equivalent to the normal startup, just compressed in time, you're
>> > basically saying that today you get
>> > 
>> > add interface wlan0
>> > add interface wlan1
>> > iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
>> > add interface wlan2
>> > iterate active interfaces -> wlan0 wlan1 wlan2
>> > 
>> > which yeah, totally seems wrong.
>> > 
>> > But fixing that to be
>> > 
>> > add interface wlan0
>> > add interface wlan1
>> > iterate active interfaces ->
>> > <nothing>
>> > add interface wlan2
>> > iterate active interfaces -> <nothing>
>> > (or
>> > maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)
>> > 
>> > seems equally wrong?
>> 
>> So, looks like there is a flags option passed to the iterate logic,
>> and it is indeed called
>> directly from drivers. So, I could just add a new flag value, and |
>> it in when calling from ath10k.
>> 
>> I'm not sure it would really solve the second case, but at least in practice,
>> that one doesn't seem to be a problem with ath10k, and the first case *was*
>> a problem.
>> 
>> If that sounds OK to you, I'll work on the patch as described.
>
> Right, that'd be the option 2. I described earlier. I can live with that
> even if I'd prefer to fix it as per 1. to "make sense". But I guess
> there could even be "more legitimate" cases to not want to iterate while
> restarting, even if I'm not really sure where that'd make sense?
>
> I guess Kalle should comment on whether he'd accept that into the
> driver.
>
> Kalle, as you can see above mac80211 appears to be broken wrt. iterating
> "active" interfaces during a restart - the iteration considers all
> interfaces active that were active before the restart, not just the ones
> that were already re-added to the driver. Ben says this causes trouble
> in ath10k.
>
> IMHO the right fix for this would be to fix the iteration to only reach
> the ones that have been re-added, like I've said above. OTOH, Ben isn't
> really convinced that that's right, and has experience with a patch that
> makes mac80211 return *no* interfaces whatsoever in the iteration when
> done while in restart. Like I say there, it seems wrong to me.
>
> But depending on what ath10k actually _does_ with this list, perhaps
> it's not an issue. Perhaps it's just transient state that it derives
> from it, so if it does it again after the reconfig is completed, it
> would in fact get all the information it needed.
>
> I'm pretty sure this would break iwlwifi, so one option (less preferred)
> would be to add a flag to say "skip iteration in reconfig".

To me it sounds fine to have such flag in ath10k. I just want the ath10k
patch test tested with upstream ath10k and firmware because Ben's driver
and firmware might behave differently.

> actually does the driver know it's in reconfig? Perhaps it could even do
> that completely on its own?

We do have ar->state which tracks the reconfig process. For example, in
ath10k_reconfig_complete() we have this check:

	/* If device failed to restart it will be in a different state, e.g.
	 * ATH10K_STATE_WEDGED
	 */
	if (ar->state == ATH10K_STATE_RESTARTED) {
		ath10k_info(ar, "device successfully recovered\n");
		ar->state = ATH10K_STATE_ON;
		ieee80211_wake_queues(ar->hw);
	}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
