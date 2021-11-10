Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62644BDF3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKJJno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 04:43:44 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:54447 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhKJJno (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 04:43:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636537257; h=Content-Type: MIME-Version: Message-ID: Date:
 References: Subject: Cc: To: From: Sender;
 bh=07QO91JxyxAYVQJxcDkyKDoiZGFWNy5xnj8FuOfbkAQ=; b=YtxxrB3SGdoelPAJ1rdlmM8zSsm9GWQaWTX4nEaxmlIpqAWsnf+KCrMy+BYzMRjaM9TLgfU7
 X0nnLUjeL/Ybknd9S4h9a+OKEkVHxgWthxJONc4fNh34RmjMlKSZDPsLgRRAgyVJwdvB51rI
 DRkWVd/QtF4WXEI36loKqpXEqmg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 618b93920f34c3436a3c4e7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Nov 2021 09:40:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AC6CC43460; Wed, 10 Nov 2021 09:40:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F2B1C4338F;
        Wed, 10 Nov 2021 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6F2B1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-2-emmanuel.grumbach@intel.com>
        <87tuhevbx2.fsf@codeaurora.org>
        <CANUX_P2e80pVMJJRUuyPGoXZtYGMM9pJWqd5Ut6rW3aDRmr7cQ@mail.gmail.com>
        <87lf2of69j.fsf@codeaurora.org>
        <CANUX_P1h3rL8i7K_V5VKtO3A=6voL_GR8C+6u0kBosGDmU_vBg@mail.gmail.com>
Date:   Wed, 10 Nov 2021 11:40:28 +0200
Message-ID: <87pmr8nyb7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

>>
>> Emmanuel Grumbach <egrumbach@gmail.com> writes:
>>
>> > On Mon, Oct 18, 2021 at 1:58 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >>
>> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>> >>
>> >> > CSME in two words
>> >> > -----------------
>> >> > CSME stands for Converged Security and Management Engine. It is
>> >> > a CPU on the chipset and runs a dedicated firmware.
>> >> > AMT (Active Management Technology) is one of the applications
>> >> > that run on that CPU. AMT allows to control the platform remotely.
>> >> > Here is a partial list of the use cases:
>> >> > * View the screen of the plaform, with keyboard and mouse (KVM)
>> >> > * Attach a remote IDE device
>> >> > * Have a serial console to the device
>> >> > * Query the state of the platform
>> >> > * Reset / shut down / boot the platform
>> >>
>> >> [...]
>> >>
>> >> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
>> >> >         If unsure, don't enable this option, as some programs might
>> >> >         expect incoming broadcasts for their normal operations.
>> >> >
>> >> > +config IWLMEI
>> >> > +     tristate "Intel Management Engine communication over WLAN"
>> >> > +     depends on INTEL_MEI
>> >> > +     depends on PM
>> >> > +     depends on IWLMVM
>> >> > +     help
>> >> > +       Enables the iwlmei kernel module. This allows to communicate with
>> >> > +       the Intel Management Engine over Wifi. This is supported starting
>> >> > +       from Tiger Lake platforms and has been tested on 9260 devices only.
>> >> > +       Enabling this option on a platform that has a different device and
>> >> > +       has Wireless enabled on AMT can prevent WiFi from working correctly.
>> >>
>> >> I don't understand the last sentence, please elaborate. Are you saying
>> >> that enabling CONFIG_IWLMEI will break wi-fi in some cases?
>> >
>> > Since we don't support all the devices (yet), and we haven't integrated it
>> > with all our devices, then yes, it shouldn't be enabled unless you know
>> > exactly what platform this kernel runs on.
>>
>> So if I'm understanding correctly, enabling CONFIG_IWLMEI will break
>> existing iwlwifi setups? Or am I missing something?
>
> Ok, I'll share more details.
> The coexistence between iwlwifi and CSME has never really been taken care
> of. CSME is a feature meant for enterprise and those systems typically run
> Windows which is why the Windows driver has had this feature for years
> but not Linux.
> iwlmei will not do anything if you don't have CSME configured to use the
> WLAN device. Someone needs to actively configure CSME to use WLAN for
> this to happen. Very few systems have this configuration.

So in a case when CSME/AMT WLAN (or whatever the feature under
discussion is called) is disabled in the BIOS and CONFIG_IWLMEI is
enabled in the kernel build, iwlwifi will work as before? This is the
most important part for me, we must not break people's network access
when they upgrade the kernel.

> Now the question is what happens today (without iwlmei) when CSME is
> configured to use WLAN compared to what happens with iwlmei, or in other
> words, do we have a "regression"?
>
> Today: there is some mechanism that allows iwlwifi to tell CSME not to touch
> the device. This mechanism is not very well tested because only Linux uses it
> and the assumption in Linux has almost always been that CSME is not
> configured on systems that run Linux.
>
> with iwlmei: we will be using the same interface as windows towards CSME which
> is a well tested interface and we will be able to use the features
> that CSME provides
>
> Why the warning then? The integration with CSME has been done on 9260
> only and not on newer devices. We do have plans to add support for
> more devices but the current code doesn't support them.
>
> What will happen if a user enables iwlmei on a system that has a
> post-9260 device and CSME configured to use WLAN? Most probably, it'll
> work, but this has not been tested yet

I hope you are printing an understandable info message when CSME is
enabled so that the situation is easy to notice and debug.

> This configuration is far from the default and considered illegal by
> Intel at this point I know that a user can always do something stupid,
> but he can likewise disable mac80211 and complain that his wifi
> doesn't work.

A user cannot compile iwlwifi unless mac80211 is enabled and likewise
iwlwifi module won't load unless mac80211 is loaded first. So we do have
checks for a lot of stuff.

> My suggestion is to add a WARNING (or an dev_err print) in iwlwifi if
> we detect this situation so that it'll be very easy to catch this
> problem in the configuration.

Heh, exactly what I was thinking above.

> The only way to prevent this situation would be to know what device
> the user has from iwlmei in the mei bus enumeration but this is
> unfortunately not possible.
>
> I hope that made things clearer. I know all this is confusing, many
> pieces of details that I hoped I wouldn't have to bore you with :)

It would have been a lot easier and faster to mention all this in the
commit logs from the beginning. Dumping me patches without commit logs
and no clear explanation is not really building confidence for me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
