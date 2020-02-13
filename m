Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2942215BDB6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBMLfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:35:42 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:24543 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgBMLfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:35:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581593741; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7YtMdqz2y/HUhn+uy6/B1++9LOzhEXSrWKV2NhwmZnI=; b=irZl9xyQ5RwpMHYVwd9HvMzaycb80JsAaTJ+R+25kNxihPykeWlQ66EwJd97tT9P9x93PqqV
 DfkmlKvRoISGQXnt+MvzxPAFCIWHPhYPtRMP0zDLbbJCb1kOOivgqQBvpLP7XU+S+iLaj5UT
 MrqGAoqlWbQx3L2jFTp3tJk2140=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e453483.7fb06b20cdf8-smtp-out-n01;
 Thu, 13 Feb 2020 11:35:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7979AC43383; Thu, 13 Feb 2020 11:35:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10F06C43383;
        Thu, 13 Feb 2020 11:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10F06C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add retry mechanism for ath10k_start
References: <20200120025609.6060-1-wgong@codeaurora.org>
Date:   Thu, 13 Feb 2020 13:35:27 +0200
In-Reply-To: <20200120025609.6060-1-wgong@codeaurora.org> (Wen Gong's message
        of "Mon, 20 Jan 2020 10:56:09 +0800")
Message-ID: <87mu9mwwhs.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When simulate random transfer fail for sdio write and read, it happened
> "Could not init core: -110" and then wlan up fail.
>
> Test steps:
> 1. Add config and update kernel:
> CONFIG_FAIL_MMC_REQUEST=y
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
>
> 2. Run simulate fail:
> cd /sys/kernel/debug/mmc1/fail_mmc_request
> echo 100 > probability
> echo 1000 > interval
> echo 1 > times && enter system suspend
> press power button to wakeup system
>
> 3. It happened Could not init core: -110.
> [   66.432068] ath10k_sdio mmc1:0001:1: unable to send the bmi data to the device: -110
> [   66.440012] ath10k_sdio mmc1:0001:1: unable to write to the device
> [   66.453375] ath10k_sdio mmc1:0001:1: Could not init core: -110

[...]

> Add retry mechanism for ath10k_start to make sure wlan up success.

I'm not convinved about this. ath10k assumes that SDIO bus works
reliably and there's no data loss. In my opinion if the SDIO is not
working reliably we should fail immediately with a clear error message
for the user, instead of having an unstable connection. And I understand
from the logs that ath10k fails cleanly in this simulated failure.

So what you do here is ignore the assumption that the SDIO bus should
always work reliably and add a workaround by trying to restart the
firmware multiple times, and hope that by luck it works during one of 10
retry attempts. But then what? Isn't the WLAN connection flaky as SDIO
bus is not reliable? So if we were to follow that design logic,
shouldn't we add retries for _all_ ath10k SDIO transactions? But that
would make ath10k even more complex as it is.

Because I think this patch makes things worse for the user, so I would
like to understand the real life use case this patch is trying to fix
and how it would help the user.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
