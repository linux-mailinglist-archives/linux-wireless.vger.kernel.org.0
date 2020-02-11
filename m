Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040B91598DD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgBKSk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 13:40:26 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:15593 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728375AbgBKSk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 13:40:26 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 13:38:14 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581446426; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=i8JWRaqLLnKS6hp/iBIFajBriYclmeNwP2z9sVxerX4=;
 b=ePqAU2T7i8pqzZFbN+3NiD094vjkqI/M+OCOdEtCEnGGwQP2b/4LBH55x1MSir0LwC6Aly/1
 Am4fI89QzZryC30FalSu1WGByAE4R4Z9XMJdKjMq4KU1VZG6qVvONr+/D/yagnD6gh560kpy
 I2YItjz6Z0/7oos4/+oQAab8kmE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42f3eb.7fa9d43034c8-smtp-out-n01;
 Tue, 11 Feb 2020 18:35:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5117C433A2; Tue, 11 Feb 2020 18:35:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E2B2C43383;
        Tue, 11 Feb 2020 18:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E2B2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fixing dangling pointer issue upon peer delete
 failure
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1580891515-15054-1-git-send-email-vnaralas@codeaurora.org>
References: <1580891515-15054-1-git-send-email-vnaralas@codeaurora.org>
To:     Venkateswara Rao Naralasetty <vnaralas@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200211183523.D5117C433A2@smtp.codeaurora.org>
Date:   Tue, 11 Feb 2020 18:35:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Rao Naralasetty <vnaralas@codeaurora.org> wrote:

> When there is WMI command failure, 'peer->sta' was not getting
> cleaned up, and mac80211 frees the 'sta' memory, which is causing
> the below page fault.
> 
> Cleaning up the sta pointer in ath11k whenever peer delete command
> is sent.
> 
> Unable to handle kernel paging request at virtual address 200080000006a
> pgd = ffffffc02a774000
> [200080000006a] *pgd=0000000000000000, *pud=0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> .
> .
> .
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.4.60 #1
> Hardware name: Qualcomm Technologies, Inc. IPQ807x/AP-HK01-C1 (DT)
> task: ffffffc00083c6d0 ti: ffffffc00083c6d0 task.ti: ffffffc00083c6d0
> PC is at ath11k_dp_rx_process_mon_status+0x114/0x4e0 [ath11k]
> LR is at ath11k_dp_rx_process_mon_status+0xe8/0x4e0 [ath11k]
> pc : [<ffffffbffcf8e544>] lr : [<ffffffbffcf8e518>] pstate: 60000145
> sp : ffffffc000833a30
> 
> Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

58595c9874c6 ath11k: Fixing dangling pointer issue upon peer delete failure

-- 
https://patchwork.kernel.org/patch/11365881/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
