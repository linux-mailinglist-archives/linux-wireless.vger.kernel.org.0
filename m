Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76AC2D8489
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 05:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438275AbgLLEju (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 23:39:50 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:60517 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392046AbgLLEj2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 23:39:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607747944; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=i8zqkVg2ktWijVXZg6xHLf1LawcHpSQx6Vhiil725vw=;
 b=RmwkfSqfo1q/VaCUyPSKflBwhh40/nRXMjOplVOLi0E+KS3dMVqzChX9cdtf6BRR5tfRfifX
 CjJWxW9WXIH6MUd43HpQ4EViwV9t8ei3aQTP+Pyh/0uMrj3OSP5bYpUPWoWUjEBN/lmmK/g2
 Nx5ulIXKr8bc/uW7QGMzEnmNjzQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fd44962fa3411972b72b0e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Dec 2020 04:38:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90C84C433ED; Sat, 12 Dec 2020 04:38:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16E90C433CA;
        Sat, 12 Dec 2020 04:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16E90C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND PATCH] ath11k: use MHI provided APIs to allocate and free
 MHI
 controller
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1605634436-36506-1-git-send-email-bbhatt@codeaurora.org>
References: <1605634436-36506-1-git-send-email-bbhatt@codeaurora.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201212043858.90C84C433ED@smtp.codeaurora.org>
Date:   Sat, 12 Dec 2020 04:38:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:

> Use MHI provided APIs to allocate and free MHI controller to
> improve MHI host driver handling. This also fixes a memory leak
> as the MHI controller was allocated but never freed.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

57449b07eafc ath11k: use MHI provided APIs to allocate and free MHI controller

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1605634436-36506-1-git-send-email-bbhatt@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

