Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167C3A7FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFONdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:33:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19849 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhFONd2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:33:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623763884; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2vmjjCqYp2IGrZRLwLdGiKPr9RqLUKejyjM7y1Tka7A=;
 b=F7Fag+c1vnLBBam1h75kQFuIoHMRYSF7LCYLrnh8jLI/n60vQownCsbnt4XM0OQvpdn9zkJu
 Nt/LU+MLc2w0/b40UMT/pmUWEs/TPvG7jKi9A+dkN7g8pTCidzUT+z37Aj9ovhjbWoU2DOAd
 SFlgzdWPBvPKf6ca4XXTTc8e9Iw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60c8ab97e27c0cc77f14ed85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:31:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E774C43145; Tue, 15 Jun 2021 13:31:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FF15C433D3;
        Tue, 15 Jun 2021 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FF15C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: protect against divide by zero in
 mwifiex_set_ibss_params
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210521024834.8354-1-yguoaz@cse.ust.hk>
References: <20210521024834.8354-1-yguoaz@cse.ust.hk>
To:     Yiyuan GUO <yguoaz@gmail.com>
Cc:     briannorris@chromium.org, linux-wireless@vger.kernel.org,
        amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        yguoaz@gmail.com, Yiyuan GUO <yguoaz@cse.ust.hk>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133102.7E774C43145@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:31:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yiyuan GUO <yguoaz@gmail.com> wrote:

> In function mwifiex_set_ibss_params, the variable index may remain
> zero if it is never altered inside the loop, leading to a potential
> divide by zero problem.
> 
> Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>

Brian explains in the report why the code is ok:
https://bugzilla.kernel.org/show_bug.cgi?id=212993#c1

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210521024834.8354-1-yguoaz@cse.ust.hk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

