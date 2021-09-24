Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B3416E17
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhIXIit (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 04:38:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14930 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244864AbhIXIis (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 04:38:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632472636; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sFHIE4zJB+Alz/t8lIYIlIY1gRwMFajWERj2jYFYL78=; b=mxw1M4Nrh8Z7q69/hj3KMAWUUBhABIm0TjLBVlXKv0IOoyAbqoF8RhGoWneUf92MfvzWM/qd
 s43xdqqTEMaWG8TJ31VNxg3RkHdx90FfVllLEJg/rQlxU1Xwuh65tfeUNEYEM1BMroRj9/ve
 Klp3pnXRAlAtgBBTNXOaQkO/6Us=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 614d8e21ec62f57c9a803e38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 08:36:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3B1AC43635; Fri, 24 Sep 2021 08:36:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D652C43460;
        Fri, 24 Sep 2021 08:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0D652C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
References: <871r5p0x2u.fsf@codeaurora.org>
        <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
Date:   Fri, 24 Sep 2021 11:36:41 +0300
In-Reply-To: <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
        (Loic Poulain's message of "Thu, 16 Sep 2021 12:18:10 +0200")
Message-ID: <877df6tlnq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> Hi Kalle,
>
> On Thu, 16 Sept 2021 at 10:00, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Hi Loic and Mani,
>>
>> I hate to be the bearer of bad news again :)
>>
>> I noticed already a while ago that commit 020d3b26c07a ("bus: mhi: Early
>> MHI resume failure in non M3 state"), introduced in v5.13-rc1, broke
>> ath11k resume on my NUC x86 testbox using QCA6390. Interestingly enough
>> Dell XPS 13 9310 laptop (with QCA6390 as well) does not have this
>> problem, I only see the problem on the NUC. I do not know what's causing
>> this difference.
>
> I suppose the NUC is current PCI-Express power during suspend while
> the laptop maintains PCIe/M2 power.

Sorry, I'm not able to parse that sentence. Can you elaborate more?

>> At the moment I'm running my tests with commit 020d3b26c07a reverted and
>> everything works without problems. Is there a simple way to fix this? Or
>> maybe we should just revert the commit? Commit log and kernel logs from
>> a failing case below.
>
> Do you have log of success case?

A log from a successful case in the end of email, using v5.15-rc1 plus
revert of commit 020d3b26c07abe27.

> To me, the device loses power, that is why MHI resuming is failing.
> Normally the device should be properly recovered/reinitialized. Before
> that patch the power loss was simply not detected (or handled at
> higher stack level).

Currently in ath11k we always keep the firmware running when in suspend,
this is a workaround due to problems between mac80211 and MHI stack.
IIRC the problem was something related MHI creating struct device during
resume or something like that.

[  164.088772] PM: suspend entry (deep)
[  164.089867] Filesystems sync: 0.000 seconds
[  164.140383] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  164.146245] OOM killer disabled.
[  164.148024] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  164.151767] printk: Suspending console(s) (use no_console_suspend to debug)
[  164.155767] wlan0: deauthenticating from <SENSORED> by local choice (Reason: 3=DEAUTH_LEAVING)
[  164.197460] e1000e: EEE TX LPI TIMER: 00000011
[  164.787849] ACPI: EC: interrupt blocked
[  164.863887] ACPI: PM: Preparing to enter system sleep state S3
[  164.898479] ACPI: EC: event blocked
[  164.898483] ACPI: EC: EC stopped
[  164.898487] ACPI: PM: Saving platform NVS memory
[  164.898496] Disabling non-boot CPUs ...
[  164.910527] numa_remove_cpu cpu 1 node 0: mask now 0,2-7
[  164.911609] smpboot: CPU 1 is now offline
[  164.929506] numa_remove_cpu cpu 2 node 0: mask now 0,3-7
[  164.930593] smpboot: CPU 2 is now offline
[  164.947111] numa_remove_cpu cpu 3 node 0: mask now 0,4-7
[  164.948192] smpboot: CPU 3 is now offline
[  164.965687] numa_remove_cpu cpu 4 node 0: mask now 0,5-7
[  164.967133] smpboot: CPU 4 is now offline
[  164.983150] numa_remove_cpu cpu 5 node 0: mask now 0,6-7
[  164.984211] smpboot: CPU 5 is now offline
[  164.992047] numa_remove_cpu cpu 6 node 0: mask now 0,7
[  164.993549] smpboot: CPU 6 is now offline
[  165.004382] numa_remove_cpu cpu 7 node 0: mask now 0
[  165.005456] smpboot: CPU 7 is now offline
[  165.009866] ACPI: PM: Low-level resume complete
[  165.010106] ACPI: EC: EC started
[  165.010109] ACPI: PM: Restoring platform NVS memory
[  165.012344] Enabling non-boot CPUs ...
[  165.012978] x86: Booting SMP configuration:
[  165.012984] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  165.014850] numa_add_cpu cpu 1 node 0: mask now 0-1
[  165.023818] CPU1 is up
[  165.024455] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  165.026190] numa_add_cpu cpu 2 node 0: mask now 0-2
[  165.034904] CPU2 is up
[  165.035479] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  165.037193] numa_add_cpu cpu 3 node 0: mask now 0-3
[  165.046102] CPU3 is up
[  165.046639] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  165.047005] numa_add_cpu cpu 4 node 0: mask now 0-4
[  165.058328] CPU4 is up
[  165.058976] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  165.059342] numa_add_cpu cpu 5 node 0: mask now 0-5
[  165.070520] CPU5 is up
[  165.071192] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  165.071574] numa_add_cpu cpu 6 node 0: mask now 0-6
[  165.082952] CPU6 is up
[  165.083609] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  165.083980] numa_add_cpu cpu 7 node 0: mask now 0-7
[  165.095544] CPU7 is up
[  165.099137] ACPI: PM: Waking up from system sleep state S3
[  166.045084] ACPI: EC: interrupt unblocked
[  166.045242] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  166.056234] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  166.057410] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  166.057413] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  167.210794] ACPI: EC: event unblocked
[  167.258815] nvme nvme0: 8/0/0 default/read/poll queues
[  167.694965] atkbd serio0: Unknown key released (translated set 2, code 0x7c on isa0060/serio0).
[  167.695953] OOM killer enabled.
[  167.697336] atkbd serio0: Use 'setkeycodes 7c <keycode>' to make it known.
[  167.750241] Restarting tasks ... done.
[  167.770450] PM: suspend exit

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
