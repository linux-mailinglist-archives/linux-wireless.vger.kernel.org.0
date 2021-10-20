Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617104346F7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTIck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 04:32:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49840 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhJTIcj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 04:32:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634718625; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KFF8eDr9y/nxX6PGHVZHlXylrlhkwPaCiD+AFXJ53Uo=; b=CbUMyVABRoQjaO/m8I1rjedMb0URCNrT+L77gybfw9WNz9X6Ttk4TvGfFiYiDoGonl621pQ5
 VQ6ywan7fL+lXVoOL0QgDEQfleBlg9GNBIhUVLdypXize1/YmE+YGaN42R8Xslve4u46rIMh
 1ak670fFC5cFFNyKxgn2saD1RCA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 616fd38e5baa84c77be86fd1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 08:30:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9825C43460; Wed, 20 Oct 2021 08:30:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 901C6C4338F;
        Wed, 20 Oct 2021 08:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 901C6C4338F
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
Date:   Wed, 20 Oct 2021 11:30:00 +0300
In-Reply-To: <CANUX_P2e80pVMJJRUuyPGoXZtYGMM9pJWqd5Ut6rW3aDRmr7cQ@mail.gmail.com>
        (Emmanuel Grumbach's message of "Mon, 18 Oct 2021 14:03:50 +0300")
Message-ID: <87lf2of69j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> On Mon, Oct 18, 2021 at 1:58 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>>
>> > CSME in two words
>> > -----------------
>> > CSME stands for Converged Security and Management Engine. It is
>> > a CPU on the chipset and runs a dedicated firmware.
>> > AMT (Active Management Technology) is one of the applications
>> > that run on that CPU. AMT allows to control the platform remotely.
>> > Here is a partial list of the use cases:
>> > * View the screen of the plaform, with keyboard and mouse (KVM)
>> > * Attach a remote IDE device
>> > * Have a serial console to the device
>> > * Query the state of the platform
>> > * Reset / shut down / boot the platform
>>
>> [...]
>>
>> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
>> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
>> > @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
>> >         If unsure, don't enable this option, as some programs might
>> >         expect incoming broadcasts for their normal operations.
>> >
>> > +config IWLMEI
>> > +     tristate "Intel Management Engine communication over WLAN"
>> > +     depends on INTEL_MEI
>> > +     depends on PM
>> > +     depends on IWLMVM
>> > +     help
>> > +       Enables the iwlmei kernel module. This allows to communicate with
>> > +       the Intel Management Engine over Wifi. This is supported starting
>> > +       from Tiger Lake platforms and has been tested on 9260 devices only.
>> > +       Enabling this option on a platform that has a different device and
>> > +       has Wireless enabled on AMT can prevent WiFi from working correctly.
>>
>> I don't understand the last sentence, please elaborate. Are you saying
>> that enabling CONFIG_IWLMEI will break wi-fi in some cases?
>
> Since we don't support all the devices (yet), and we haven't integrated it
> with all our devices, then yes, it shouldn't be enabled unless you know
> exactly what platform this kernel runs on. 

So if I'm understanding correctly, enabling CONFIG_IWLMEI will break
existing iwlwifi setups? Or am I missing something?

If that's the case when we have a major problem as that would be a
regression. A kconfig option is not a free pass to do all sort of crazy
stuff, and especially it cannot break already working hardware. That
would be considered as a regression and we have a strong rule for
regressions.

> This is basically a warning for distros not to enable this kernel
> option (just as many others that are specific to a certain use case).
> The plan is to add support for more and more devices so that we will
> be able to remove this comment and be confident that it can be enabled
> on generic platforms as well.

I barely missed the warning and I consider myself as an extra careful
person, I can only imagine how many regular users will enable this
option without thinking twice. And people can use allmodconfig etc as
well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
