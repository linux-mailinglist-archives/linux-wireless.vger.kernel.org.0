Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021AF16107
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEGJfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 05:35:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEGJfG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 05:35:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EA5A60A44; Tue,  7 May 2019 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557221704;
        bh=7K2V1Ddc4Z/m3cpGaaZI/ZeUDtHdniq8QxH66RWvYKI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JTwySL2MxJhnSsphrzwbkr2srNkgQ6z5bfwEw01fNbht90LtHpD8NlxzUhrdZyRwH
         rDK8UWngDSyH52SVrKDS/GOuHnAisVS+iqIXmL970S+5rKqNO0b2dz+bO4BuEfWlCN
         aCe7HXVMPDgcOEtTQ42bZUqQ59LxS1k2yW4vk6/M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-65-53.rev.dnainternet.fi [37.136.65.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDBDC6055D;
        Tue,  7 May 2019 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557221703;
        bh=7K2V1Ddc4Z/m3cpGaaZI/ZeUDtHdniq8QxH66RWvYKI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q3V3HR0Ga4X9jUurdGNmv2KfWD5tiLnu+7psiRUJZR2vUeC1Yj/O3yC6FHVpgSQtG
         PIMpanilxVAoHSuAXm+ModD98ilLLJMXpRXQllKuYlowdquR2/P1Zzrj2Mf5tBmZC4
         XlpHRPMZ5sbAILrzSNosezkjESAigxxIH61GgmUE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDBDC6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Grant Grundler <grundler@google.com>,
        Wen Gong <wgong@codeaurora.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ath10k: remove mmc_hw_reset while hif power down
References: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
        <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
        <36950ff25c0747629e60ccb68819e93a@aptaiexm02f.ap.qualcomm.com>
Date:   Tue, 07 May 2019 12:34:59 +0300
In-Reply-To: <36950ff25c0747629e60ccb68819e93a@aptaiexm02f.ap.qualcomm.com>
        (Wen Gong's message of "Tue, 7 May 2019 05:05:21 +0000")
Message-ID: <87pnour4jg.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Ulf to give comments from SDIO point of view

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Grant
>> Grundler
>> Sent: Saturday, May 4, 2019 2:01 AM
>> To: Wen Gong <wgong@codeaurora.org>
>> Cc: linux-wireless@vger.kernel.org; ath10k@lists.infradead.org
>> Subject: [EXT] Re: [PATCH] ath10k: remove mmc_hw_reset while hif power
>> down
>> 
>> [repeating comments I made in the gerrit review for Chrome OS :
>> https://chromium-
>> review.googlesource.com/c/chromiumos/third_party/kernel/+/1585667
>> ]
>> 
>> On Sat, Apr 27, 2019 at 7:17 PM Wen Gong <wgong@codeaurora.org> wrote:
>> >
>> > For sdio 3.0 chip, the clock will drop from 200M Hz to 50M Hz after load
>> > ath10k driver, it is because mmc_hw_reset will reset the sdio's power,
>> > then mmc will consider it as sdio 2.0 and drop the clock.
>> 
>> Wen,
>> 5468e784c0600551ca03263f5255a375c05f88e7 commit message gives
>> reasons
>> for adding the mmc_hw_reset() call. The commit message for removing
>> gives different reason for removal. Both are good but second one is
>> incomplete.
>> 
>> The commit message for removal should ALSO explain why adding this
>> call wasn't necessary in the first place OR move the call to a
>> different code path.
>> 
>> > Remove mmc_hw_reset will avoid the drop of clock.
>> 
>> This commit message makes it clear the original patch introduced a new
>> problem. But the original patch fixed a different problem and that
>> this proposed change seems likely to re-introduce and the commit
>> message should explain why that isn't true (or how the original was
>> fixed differently)
>
> The mmc_hw_reset's effect depends on the hardware layout/configure
> software's behavior, recently it will effect the clock of sdio for the
> platform I used. And it will still work well without mmc_hw_reset for
> the platform I Used currently. If sdio cannot work on other platform,
> I think it can add flag in ath10k_hw_params_list for the platform to
> call the mmc_hw_reset depends on the flag.

I don't see how you can use ath10k_hw_params_list to separate SDIO
controller functionality, I assume that's the real reason for difference
of functionality? Maybe this is a bug on the SDIO controller?

Ulf, what do you think? Any suggestions? Full discussion here:

https://patchwork.kernel.org/patch/10920563/

-- 
Kalle Valo
