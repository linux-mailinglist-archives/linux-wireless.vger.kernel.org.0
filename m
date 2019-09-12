Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E89B0F0E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfILMrl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 08:47:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfILMrk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 08:47:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95AF9602F8; Thu, 12 Sep 2019 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568292459;
        bh=AWN62OfRj3SQmc/u/jmlMyQII1/8N63safwuJap2dr8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y/SbeYRal4cbdFf1KpphAMFh4mjh+5YC/JynFTTneUDw4nazL8fJnE1ZRuSFz7nNQ
         QNGistiGUDK3m33KLwFlNITlZ11lRimVopiIX937FQ/voeHDyrJxFqzhSJqYaYg0IJ
         +mk73O3OqRWJ4lO3YAHdRnQhFluxasSTdl805mq4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 535F5602FE;
        Thu, 12 Sep 2019 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568292459;
        bh=AWN62OfRj3SQmc/u/jmlMyQII1/8N63safwuJap2dr8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y/SbeYRal4cbdFf1KpphAMFh4mjh+5YC/JynFTTneUDw4nazL8fJnE1ZRuSFz7nNQ
         QNGistiGUDK3m33KLwFlNITlZ11lRimVopiIX937FQ/voeHDyrJxFqzhSJqYaYg0IJ
         +mk73O3OqRWJ4lO3YAHdRnQhFluxasSTdl805mq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 535F5602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Free beacon buf later in vdev teardown.
References: <20190227162756.13048-1-greearb@candelatech.com>
        <20190910131244.267AF602F2@smtp.codeaurora.org>
        <89712e32-1fb2-f002-15ed-046871c161ce@candelatech.com>
Date:   Thu, 12 Sep 2019 15:47:35 +0300
In-Reply-To: <89712e32-1fb2-f002-15ed-046871c161ce@candelatech.com> (Ben
        Greear's message of "Tue, 10 Sep 2019 06:19:35 -0700")
Message-ID: <87v9txk7fc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 09/10/2019 06:12 AM, Kalle Valo wrote:
>> greearb@candelatech.com wrote:
>>
>>> My wave-1 firmware often crashes when I am bringing down
>>> AP vdevs, and sometimes at least some machines lockup hard
>>> after spewing IOMMU errors.
>>>
>>> I don't see the same issue in STA mode, so I suspect beacons
>>> are the issue.
>>>
>>> Moving the beacon buf deletion to later in the vdev teardown
>>> logic appears to help this problem.  Firmware still crashes
>>> often, but several iterations did not show IOMMU errors and
>>> machine didn't hang.
>>
>> I'm not really fond of fixing issues just by luck but after a quick look at the
>> code I can't see any harm in this change either. So I guess it's ok.
>>
>> But can you provide the exact hardware and firmware you used for testing, I'll
>> add it to the commit log. I want to document that in every commit:
>
> I used Compex WLE900VX hardware, and the firmware was ath10k-ct something or other,
> it has been a long time, so I don't recall the exact firmware version.

Ok, I added QCA9880 and unspecified version of ath10k-ct firmware to the
commit log.

> The real fix for this is to have the firmware do proper beacon tx
> completion logic so that the driver can know when it can safely free
> buffers. I implemented this in my ath10k-ct firmware/driver, but
> unless you want to start accepting patches for my firmware, then that
> will not help upstream ath10k.

It's a challenge enough to support so many differerent QCOM firmware
branches and still try to avoid bloating the driver too much to keep it
maintainable. Adding support for a new firmware branch/fork with a
significantly different interface would make everything so much harder.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
