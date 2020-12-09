Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD82D3F0B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 10:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgLIJpE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 04:45:04 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:13529 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgLIJpE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 04:45:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607507085; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zSCxs19M3ik8lZVKqhn6kFS5Lb33IxpHTR6aKOySOAk=; b=huHUjr499yBVr5x1OXZyvc4mTb7OhQhS8qFfAPL/aC12ywd6Oxgi1DewI04kGO4evdlc/LVN
 S27Dx8IPfttIsGsOUlHE9al4rC/anaW+ZYMPEE90FshVfDG73ymOLhohirdgoqwSFMsBos25
 mJQtCa6I/r5b75jF24EaxB7DTxQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fd09c6608e22599782802d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 09:44:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B91A8C433C6; Wed,  9 Dec 2020 09:44:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA021C433CA;
        Wed,  9 Dec 2020 09:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA021C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Subject: Re: [PATCH v8 2/2] rtw88: add adaptivity support for EU/JP regulatory
References: <20200731024607.5817-1-yhchuang@realtek.com>
        <20200731024607.5817-3-yhchuang@realtek.com>
        <CA+ASDXMXfTBdK2G_QbrUOz2GpR27TcSxd-RHVdpyKu7k_d-qGQ@mail.gmail.com>
Date:   Wed, 09 Dec 2020 11:44:01 +0200
In-Reply-To: <CA+ASDXMXfTBdK2G_QbrUOz2GpR27TcSxd-RHVdpyKu7k_d-qGQ@mail.gmail.com>
        (Brian Norris's message of "Tue, 8 Dec 2020 15:10:36 -0800")
Message-ID: <87mtynb9ge.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> + Tony's new address
>
> On Thu, Jul 30, 2020 at 7:46 PM <yhchuang@realtek.com> wrote:
>>
>> From: Tzu-En Huang <tehuang@realtek.com>
>>
>> From MIC Ordinance Regulating Radio Equipment article 49.20,
>> ETSI EN-300-328 and EN-301-893, the device should be able to
>> dynamically pause TX activity when energy detected on the air.
>>
>> To achieve this, add Energy Detected CCA (EDCCA) support to
>> detect the energy in the channel. Driver will set corresponding
>> thresholds to the device, if the energy detected exceeds the
>> threshold, the TX activity will be halted immediately.
>>
>> As this could lead to performance downgrade when the environment
>> is noisy, add a debugfs to disable this for debugging usage.
>>
>> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> I see that this patch series is still marked Deferred:
> https://patchwork.kernel.org/project/linux-wireless/patch/20200731024607.5817-2-yhchuang@realtek.com/
> https://patchwork.kernel.org/project/linux-wireless/patch/20200731024607.5817-3-yhchuang@realtek.com/
>
> and I'm still rebasing these patches in my tree. I realize the docs
> say "the maintainer will revisit the patch in a later time":
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork
> but I figured 4-5 months might be long enough to wait ;)

Yeah, I have 145 patches in the notorious deferred state at the moment:

https://patchwork.kernel.org/project/linux-wireless/list/?state=10&delegate=25621&order=date

I am trying to make it shorter but always more important things pop up
so it's no easy task.

> Was there something controversial about this patch set that makes it
> difficult? Or should it get moved back to New? Or do Realtek folks
> need to rebase/resubmit/

I would need to check the old discussions what was the holdback, but
first thing after looking at the patchset I see this:

+config RTW88_REGD_USER_REG_HINTS
+	bool "Realtek rtw88 user regulatory hints"
+	depends on RTW88_CORE
+	default n
+	help
+	  Enable regulatoy user hints
+
+	  If unsure, say N. This should only be allowed on distributions
+	  that need this to correct the regulatory.

Why is this needed? The help text is not really helpful, what does "to
correct the regulatory" mean? If someone would ask me who, when and why
this should be enabled I would not have an answer.

And yes, I know there's a similar CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS.
I don't know what it does either (and no time to check right now).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
