Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3492181DDE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgCKQbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:31:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13655 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729511AbgCKQbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:31:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583944263; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=FuX6jHTN4rvyPzYI5f4BFjj3vh0elEt4FR+gnyaTJcU=;
 b=uwKIxefMbQuVqhsUg5xPVnHF111aOpXOWX9hwRS9IdrAjcP6A1SqMRBid/nI9CcM+dk5mTss
 Enpc8vWrbtz7WXJvGyiMLE9pYa7iGmxXBnm62IQeqUSlNym9uWpNpiIDob2CpQp5kniJGm0w
 3d7kAWi+m63+qH5ii977E13xtyk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691246.7fb99e3eaf80-smtp-out-n02;
 Wed, 11 Mar 2020 16:31:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62B83C432C2; Wed, 11 Mar 2020 16:31:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3785C433D2;
        Wed, 11 Mar 2020 16:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3785C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: avoid consecutive OTP download to reduce boot time
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
References: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311163102.62B83C432C2@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:31:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Currently, OTP is downloaded twice in case of "pre-cal-dt"
> and "pre-cal-file" to fetch the board ID and takes around
> ~2 sec more boot uptime.
> 
> First OTP download happens in "ath10k_core_probe_fw" and
> second in ath10k_core_start. First boot does not need OTP
> download in core start when valid board id acquired.
> 
> The second OTP download is required upon core stop/start.
> 
> This patch skips the OTP download when first OTP download
> has acquired a valid board id. This patch also marks board
> id invalid in "ath10k_core_stop", which will force the OTP
> download in ath10k_core_start and fetches valid board id.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.6-00104
> 
> Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a4b9f641e858 ath10k: avoid consecutive OTP download to reduce boot time

-- 
https://patchwork.kernel.org/patch/11320473/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
