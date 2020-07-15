Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B72207FD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgGOJAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:00:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34261 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729856AbgGOJAe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:00:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594803633; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ssy+mJ3WUw+4Ibxmrp4FGlduPLUF4cjOfzpMem7+HHc=; b=OqkmsxAxqytklhWvI19DAionnDf6IFftsrPe2br1kvZu6fgi7obBhCYwBC/MDqWlqpyquHnO
 nNACBI2TAQK/xJv+K5rnT4U+So5zNQqkvTeT+HzfPz4VirzAqd0OhORG9cgBB5myAcuUb0ek
 w7iyE3wezZ+8SzaCO4iWKaz6DXs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f0ec59f03c8596cdb176312 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:00:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CEC8C43391; Wed, 15 Jul 2020 09:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30866C433C6;
        Wed, 15 Jul 2020 09:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30866C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo\@codeaurora.org" <kvalo@codeaurora.org>,
        "kernel\@iuliancostan.com" <kernel@iuliancostan.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "i\@outv.im" <i@outv.im>,
        "trevor\@shartrec.com" <trevor@shartrec.com>
Subject: Re: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with module parameter
References: <20200605074703.32726-1-yhchuang@realtek.com>
        <20200610213720.3sopcuimas375xl2@linutronix.de>
        <a2aac609b5e2416b899c5842817da4bb@realtek.com>
        <20200616133531.7eyfu6jniywhak7h@linutronix.de>
        <fbf8d9cb6b864004b11372f6d70b734b@realtek.com>
        <20200617072938.dx56qsvcrpmtrrgu@linutronix.de>
Date:   Wed, 15 Jul 2020 12:00:10 +0300
In-Reply-To: <20200617072938.dx56qsvcrpmtrrgu@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 17 Jun 2020 09:29:38 +0200")
Message-ID: <87mu41b1b9.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2020-06-17 05:30:22 [+0000], Tony Chuang wrote:
>> 0000], Tony Chuang wrote:
>> > > > On 2020-06-05 15:47:03 [+0800], yhchuang@realtek.com wrote:
>> > > > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> > > > >
>> > > > > Some platforms cannot read the DBI register successfully for the
>> > > > > ASPM settings. After the read failed, the bus could be unstable,
>> > > > > and the device just became unavailable [1]. For those platforms,
>> > > > > the ASPM should be disabled. But as the ASPM can help the driver
>> > > > > to save the power consumption in power save mode, the ASPM is still
>> > > > > needed. So, add a module parameter for them to disable it, then
>> > > > > the device can still work, while others can benefit from the less
>> > > > > power consumption that brings by ASPM enabled.
>> > > >
>> > > > Can you set disable_aspm if rtw_dbi_read8() fails? Or make a test if it
>> > > > is save to use?
>> > > >
>> > > > If someone notices the warning they still have to search for the warning
>> > > > in order to make the link towards loading the module with the
>> > > > disable_aspm=1 paramter.
>> > > > Is it known what causes the failure?
>> > > >
>> > >
>> > > I think as long as the rtw_dbi_read() fails, the consequent register
>> > > operation will also fail, and still get an error read/write the register.
>> > > And this is some sort of PCI issue, and I am not really familiar with it.
>> > > Such as the root cause or how it fails.
>> > 
>> > Then it does not sound safe to enable it by default.
>> 
>> We have had a discussion about this, but I cannot find the thread now.
>> People suggested that the module parameter should not be used.
>> And they think that if the ASPM can help for power consumption, then
>> it should be default enabled. But I think it should be based on that the
>> other platforms will not just fail to bring up the device. However, the
>> platforms are less than the others, not sure if default enable or disable
>> is better.
>
> What I fail to understand is if this error affects other PCI devices as
> well or just this one. And if it is possible to reset the wifi device
> and everything gets back no normal. Or is it just the register reading,
> that spams the log and would affect the system otherwise if you would
> just avoided after the first fail.
>
>> > > If we can default disable it, then we can help those platforms, but
>> > > then other platform will suffer from higher power consumption.
>> > 
>> > So for those platform, where the error occurs, you expect that the user
>> > manages to read the error message (a backtrace from rtw_dbi_read8()) and
>> > connects this the need to set a certain module option.
>> 
>> Yes, we can discuss if it should be default enabled or not. Otherwise the
>> people with those platforms can only do that to prevent this. Really bad.
>
> It would be good to know the root cause of this. So then default enable
> would depend on it.
> You could have a allow/forbid list based on DMI once you identified
> good/bad systems but this includes additional maintenance.

I think there should be this kind of quirk list in rtw88 which would
disable ASPM automatically on problematic platforms. We should not
require the user to figure out the problem on their own and disable ASPM
manually using the module parameter.

> I think that at the very least, if the read fails you should give the
> user additional information how to stop this from happening again. And
> either stop issuing the commands again or skip driver loading (depending
> what it means for device stability).

Yes, if we can guess that this is an ASPM problem giving additional
information is very helpful for the user, please do that as well.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
