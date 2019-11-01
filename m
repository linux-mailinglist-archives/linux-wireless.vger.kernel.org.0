Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A8EBF37
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfKAIbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 04:31:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfKAIbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 04:31:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B70B60A96; Fri,  1 Nov 2019 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572597062;
        bh=ams945pLxCO9gEGCVF/wRln1a+5KrlGC+3FRBJlFWX0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=X/eRvxpJux1xr1fgNclInEmnWEKYVViQU3GppFN9vVjbJutX9x7CeJTlstcBDteZp
         GsykKgbV1Go91Oji9AblJFxrL38uh48hh+76nO3eVFy/zfs2Sq9bmW1oKmQdTLxxew
         zDXpOMk9jA0CeHvpa/vfYFlNI0/3t6O3Ix/u95C0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (176-93-46-192.bb.dnainternet.fi [176.93.46.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9E866049C;
        Fri,  1 Nov 2019 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572597061;
        bh=ams945pLxCO9gEGCVF/wRln1a+5KrlGC+3FRBJlFWX0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dGeyYvJ2f+KHJmro82HBaekytQXJ8q0t9tivF+QBxrUau08D4/fycMD0P7hXWswq9
         H8uDgbvDNcKlTjXj5NYYtDDx0X80OPUx1BQYz99CzNUw6SKNrLufgQiu+mjjgB94oW
         pFy6ImUMplUm0+cEgP59mq9z4JggtuWGmb90x4NU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9E866049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>,
        "g.schlmm\@googlemail.com" <g.schlmm@googlemail.com>
Subject: Re: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
References: <20191025093345.22643-4-yhchuang@realtek.com>
        <20191031075911.3CCB86079C@smtp.codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D1914F4C@RTITMBSVM04.realtek.com.tw>
Date:   Fri, 01 Nov 2019 10:30:57 +0200
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1914F4C@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Thu, 31 Oct 2019 08:17:37 +0000")
Message-ID: <87imo40zi6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

> From: Kalle Valo
>> <yhchuang@realtek.com> wrote:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > If the number of packets is less than the LPS threshold, driver
>> > can then enter LPS mode.
>> > And driver used to take RTW_LPS_THRESHOLD as the threshold. As
>> > the macro can not be changed after compiled, use a parameter
>> > instead.
>> >
>> > The larger of the threshold, the more traffic required to leave
>> > power save mode, responsive time could be longer, but also the
>> > power consumption could be lower.
>> >
>> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> > Reviewed-by: Chris Chiu <chiu@endlessm.com>
>> 
>> I don't think a module parameter should be used to control power save
>> level, instead there should be a generic interface for that. Also the commit
>> log does not give any explanation why this needs to be a module parameter.
>> 
>> Tony, there's a high barrier for adding new module parameters. It's a
>> common
>> phrase for me to say "module parameters are not windows .ini files". And to
>> make it
>> easier for everyone always submit controversial patches separately, do not
>> hide
>> within a bigger patchset.
>> 
>
> Alright, I was thinking module parameters as a convenient tool for driver to
> control the behavior for debugging or out-of-band adjusting. But it seems like
> you treat it more carefully.
>
> Actually this is just going to allow us to set different default values for different
> use cases. So is there a better way to control it. Or I should just change the
> value to a better one. By our experience, set this to 50 is a more reasonable
> value, such that some web surfing or background traffic wouldn't make the
> driver to leave PS mode.

I recall having a similar discussion something like 10 years ago. (Yes,
I have been here for way too long). I think at the time recommendation
was to use latency value from the QoS framework to make it possible for
user space to change wireless power save aggressiveness. But I don't
know if anyone really used that.

I was feeling nostalgic and decided to find some pointers:

https://lore.kernel.org/linux-wireless/1271850458-32437-2-git-send-email-juuso.oikarinen@nokia.com/

And it seems the patch was even applied:

195e294d21e8 mac80211: Determine dynamic PS timeout based on ps-qos network latency

This is for mac80211 dynamic ps feature, but I imagine we could somehow
extend it to driver settings like the LPS threshold here. Something like
this would be much more acceptable than having custom module parameters
for each driver.

-- 
Kalle Valo
