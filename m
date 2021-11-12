Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB144E1DA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 07:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhKLGYn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 01:24:43 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:11336 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhKLGYm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 01:24:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636698112; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6nIcNXPV5prkfTFgLgI5YBGuFPaoFzepLRzzC40Dcg0=; b=bE++Xt/SoMEA++ulOq+dOciHFPh7H3+Rna/fBUzrNHEgvEBOoKhhgszd+CHVtjzsN4OFGRuC
 JgtRqSkuYvV8oU+wiijyQog/Tse6EQy5PYoNeVTg0RyKIB+WrxA7fKsVcrHSjAnmDwvgXCfF
 Zda9d4boZKtgGUaNYfimpe2r9so=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 618e07f4a06361a254691a26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 06:21:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2B32C4360C; Fri, 12 Nov 2021 06:21:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 474B1C4360D;
        Fri, 12 Nov 2021 06:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 474B1C4360D
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
        <87pmr8nyb7.fsf@codeaurora.org>
        <CANUX_P137LnjGus5oO2JYyau-kMsAUOPZPx5JP_UW1jAjUC0ig@mail.gmail.com>
Date:   Fri, 12 Nov 2021 08:21:34 +0200
In-Reply-To: <CANUX_P137LnjGus5oO2JYyau-kMsAUOPZPx5JP_UW1jAjUC0ig@mail.gmail.com>
        (Emmanuel Grumbach's message of "Wed, 10 Nov 2021 11:51:51 +0200")
Message-ID: <874k8hnbbl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> On Wed, Nov 10, 2021 at 11:40 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Emmanuel Grumbach <egrumbach@gmail.com> writes:
>>
>> >> So if I'm understanding correctly, enabling CONFIG_IWLMEI will break
>> >> existing iwlwifi setups? Or am I missing something?
>> >
>> > Ok, I'll share more details.
>> > The coexistence between iwlwifi and CSME has never really been taken care
>> > of. CSME is a feature meant for enterprise and those systems typically run
>> > Windows which is why the Windows driver has had this feature for years
>> > but not Linux.
>> > iwlmei will not do anything if you don't have CSME configured to use the
>> > WLAN device. Someone needs to actively configure CSME to use WLAN for
>> > this to happen. Very few systems have this configuration.
>>
>> So in a case when CSME/AMT WLAN (or whatever the feature under
>> discussion is called) is disabled in the BIOS and CONFIG_IWLMEI is
>> enabled in the kernel build, iwlwifi will work as before? This is the
>> most important part for me, we must not break people's network access
>> when they upgrade the kernel.
>
> Yes.

Very good, this is most important for me.

>> > The only way to prevent this situation would be to know what device
>> > the user has from iwlmei in the mei bus enumeration but this is
>> > unfortunately not possible.
>> >
>> > I hope that made things clearer. I know all this is confusing, many
>> > pieces of details that I hoped I wouldn't have to bore you with :)
>>
>> It would have been a lot easier and faster to mention all this in the
>> commit logs from the beginning. Dumping me patches without commit logs
>> and no clear explanation is not really building confidence for me.
>>
>
> I understand. There are loads of details and I didn't really want to bother you
> with all of them, I guess I now know that you are the type of person who want
> the details and I'll be clearer the next time.

It's really comes down to trusting the patches, if I don't even
understand what the patches do I will have a hard time trusting them.

> Practically speaking, I owe you a v8 with the WARNING I mentioned plus
> the bugfix I talked about.
>
> Do you want it now or you want me to wait for more comments?

I'm not planning to review v7 anymore, so please do submit v8.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
