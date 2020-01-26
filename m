Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3D149B8A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgAZPnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:43:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63483 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgAZPnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:43:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053392; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HzBCnPTWmWauNJU/IjSBdsEMg/VCwJOcKm6L7UJMJJM=;
 b=l2UdefceWoIusgtf6s/1og/cZnrDcEU+S4qiB+vBlXIi8s6DWR7EGe0a/JNlMn8t4B0HzZTG
 WwvQ8traPN7+9Uo5bMAZB+OuckvvHBWP8Y0NOib4qCyCtIAVo51bSzPsXrkJT9tFmHgK/XsX
 HVbGoi8CixI/1kFr+l24+nDhFOw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db38f.7f8827f873b0-smtp-out-n01;
 Sun, 26 Jan 2020 15:43:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D342AC447A4; Sun, 26 Jan 2020 15:43:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A544EC447A5;
        Sun, 26 Jan 2020 15:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A544EC447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: use shorter delay time to poll PS state
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200107142729.17716-1-yhchuang@realtek.com>
References: <20200107142729.17716-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126154311.D342AC447A4@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:43:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> When TX packet arrives, driver should leave deep PS state to make
> sure the DMA is working. After requested to leave deep PS state,
> driver needs to poll the PS state to check if the mode has been
> changed successfully. The driver used to check the state of the
> hardware every 20 msecs, which means upon the first failure of
> state check, the CPU is delayed 20 msecs for next check. This is
> harmful for some time-sensitive applications such as media players.
> 
> So, use shorter delay time each check from 20 msecs to 100 usecs.
> The state should be changed in several tries. But we still need
> to reserve ~15 msecs in total in case of the state just took too
> long to be changed successfully. If the states of driver and the
> hardware is not synchronized, the power state could be locked
> forever, which mean we could never enter/leave the PS state.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

Patch applied to wireless-drivers-next.git, thanks.

6b6c150b8464 rtw88: use shorter delay time to poll PS state

-- 
https://patchwork.kernel.org/patch/11320947/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
