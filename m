Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5EF2AB739
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 12:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgKILgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 06:36:40 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:20472 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgKILdI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604921587; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YgFwD2NhEFfID7L84oU3VRRTNzxsxISwyjQEu4AV+l4=; b=kMKdpYaYlH7raQDgDZd1Hqf9erBjb7vjJuEEvNfv9oMgPPas51wzS8BEsyv7snenhTZbAaO9
 /6FJI5w9+TjCE8x/9kx3ExwhVT96k5UTD/VvRCWHqSgPJztVtjZa5UhaCRfc4H6aSt+snM9h
 H/1inL0XHbpkHBunf+b2kFiWoAw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa928f282aad55dcbd09aa0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 11:33:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6714CC43385; Mon,  9 Nov 2020 11:33:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1CCAC43387;
        Mon,  9 Nov 2020 11:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1CCAC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/8] cfg80211: remove WDS code
References: <20201109095747.113720-1-johannes@sipsolutions.net>
        <20201109105103.8f5b98e4068d.I5f5129041649ef2862b69683574bb3344743727b@changeid>
        <87lffa6azd.fsf@tynnyri.adurom.net>
        <ef27c87e34c173e015ce41242dab3bdf2d312d8d.camel@sipsolutions.net>
Date:   Mon, 09 Nov 2020 13:33:02 +0200
In-Reply-To: <ef27c87e34c173e015ce41242dab3bdf2d312d8d.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 09 Nov 2020 12:12:21 +0100")
Message-ID: <87a6vqg3yp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2020-11-09 at 13:11 +0200, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>> > From: Johannes Berg <johannes.berg@intel.com>
>> > 
>> > Remove all the code that was there to configure WDS interfaces,
>> > now that there's no way to reach it anymore.
>> > 
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> 
>> [...]
>> 
>> > @@ -675,10 +673,8 @@ int wiphy_register(struct wiphy *wiphy)
>> >  		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
>> >  		return -EINVAL;
>> >  
>> > -#ifndef CONFIG_WIRELESS_WDS
>> >  	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
>> >  		return -EINVAL;
>> > -#endif
>> 
>> What about out-of-tree drivers? Should we have (or do we already have?)
>> a some kind safe guard if an out of tree driver tries to use WDS?
>
> That's what happens here, no? We warn and return invalid - now
> unconditionally, before we allowed it if CONFIG_WIRELESS_WDS was
> enabled.

Argh, I'm blind. I read that the whole if block was removed :) Sorry for
the noise.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
