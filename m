Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D331B53D6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 06:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWExS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 00:53:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31645 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgDWExS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 00:53:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587617597; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3gaGITc2mtUH4RMdNO+XHqahY0BeFHkvQfICw+F+45I=;
 b=OhU1PEt3PkeFK49S4sd4iCamEtB4P2O3+X48jsGzpkjv4bGmcQ13zoOX/k8iRzgKEXpsPDYV
 l1+Wd437m3vmaUeP+P7BIsZpoKa//H0BwdF9TeR9r7DirdtJ1O8ACfGP6gLb9koWL1eIps2B
 KLK6KzDPpW/Sj0Ab3M/721asNN8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea11f2b.7f6670cb7df8-smtp-out-n05;
 Thu, 23 Apr 2020 04:52:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 053FEC433D2; Thu, 23 Apr 2020 04:52:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB336C433CB;
        Thu, 23 Apr 2020 04:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB336C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix the invalid tx/rx chainmask configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587495512-29813-1-git-send-email-mkenna@codeaurora.org>
References: <1587495512-29813-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423045259.053FEC433D2@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 04:52:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> The driver is allowing the invalid tx/rx chainmask configuration
> (other than 1,3,7,15) set by the user. It causes the firmware
> crash due to the invalid chainmask values.
> 
> Hence, reject the invalid chainmask values in the driver by not
> sending the pdev set command to the firmware.
> 
> Tested hardware: QCA9888
> Tested firmware: 10.4-3.10-00047
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

aac392d8553f ath10k: Fix the invalid tx/rx chainmask configuration

-- 
https://patchwork.kernel.org/patch/11502099/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
