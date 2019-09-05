Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5898BAA332
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbfIEM3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:29:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfIEM3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:29:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0BAC761156; Thu,  5 Sep 2019 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567686585;
        bh=w28KEsOScY0eiDy8iwTbqHacHS1x80YGi2SWuFeJWgU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eko1zFENroTN9NzY/YjIQHB/9daem2+xOnPMEmPNtpIm+eOQHkz1/ykMIGrs3u54T
         Yz7mKjttsOWCANtkzVJeWLnMBnRuaf0/BEGb5GbvdFJVvcKY4dreqz+JFYsdu6CgQv
         Lcx3J3bFFZN6TRdXSTnwJ233db69GEceTTzhlVxQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 179CC601D4;
        Thu,  5 Sep 2019 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567686584;
        bh=w28KEsOScY0eiDy8iwTbqHacHS1x80YGi2SWuFeJWgU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jXJiqHaKSQ7rOb9wXwPlsxaJuWeigwU7+8o0J/jQGY7LtDV+JCMsOPGg5/pR0myPc
         wNzNUwCb8nOjdv0eVPgz1cOLXlYgOjlxwpx24sMnT6DqnrV1GDplaVgFj2vuL694gF
         bKYrJNBFdSyPrUyQLE2GZESs1QMjds73xYkEUPoQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 179CC601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
        <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
        <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
        <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org>
        <878sr3nfz8.fsf@kamboji.qca.qualcomm.com>
        <8e90a557c1659995d117c6dc8b728d7f@codeaurora.org>
Date:   Thu, 05 Sep 2019 15:29:40 +0300
In-Reply-To: <8e90a557c1659995d117c6dc8b728d7f@codeaurora.org> (Vasanthakumar
        Thiagarajan's message of "Thu, 05 Sep 2019 17:28:53 +0530")
Message-ID: <87woenkjt7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:

> On 2019-09-05 16:54, Kalle Valo wrote:
>> Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:
>>
>>> On 2019-08-21 02:16, Johannes Berg wrote:
>>>> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
>>>>
>>>>> +static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32
>>>>> changed)
>>>>> +{
>>>>> +	struct ath11k *ar = hw->priv;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	/* mac80211 requires this op to be present and that's why
>>>>> +	 * there's an empty function, this can be extended when
>>>>> +	 * required.
>>>>> +	 */
>>>>
>>>> Well, oops. Maybe it shouldn't be required?
>>>
>>> I think we require this for some configuration handling. The comment
>>> is to be updated with proper information. We'll address that.
>>
>> The way I'm understanding Johannes' comment is that maybe we should
>> change mac80211 to require this op to be present. Should be easy to fix
>> in mac80211, right?
>
> Ok. So make this callback optional in mac80211? should be a simple
> code change.

Yeah, I was supposed to write:

"maybe we should change mac80211 to not require this op to be present"

But of course I could have just misunderstood, let's see what Johannes
says :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
