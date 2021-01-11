Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0C2F1184
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbhAKLb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:31:56 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:47789 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbhAKLb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:31:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610364698; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9YKEubIpA2/mkaokMYRkji6Udfic3Z5mmkmPsxslvMc=; b=XLCeWM4dQVeSzFiUSDC2tUkqh8XGzT93BBClXBP902+x+Z22qHJxOXbUi53c/LJTPhh/KUkQ
 I32ADWfOZfnZRkJ7+EhukcqVar4bJdUHeHQvOJwDsFkSBxUZ4+Zi+1L6zSOuPI6N5Je1xp5Y
 vERLVDFAthZR+ve6YcnCmoHp7Jo=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ffc36fd415a6293c5740099 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:31:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F4CEC43467; Mon, 11 Jan 2021 11:31:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8852C43466;
        Mon, 11 Jan 2021 11:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8852C43466
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
        <20201228162839.369156-12-bryan.odonoghue@linaro.org>
Date:   Mon, 11 Jan 2021 13:31:04 +0200
In-Reply-To: <20201228162839.369156-12-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 28 Dec 2020 16:28:37 +0000")
Message-ID: <87wnwjk8w7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> If a scan is in progress do not attempt to enter into suspend. Allow the
> scan process to quiesce before proceeding.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Why? I would have considered the opposite and if we go to suspend we
cancel the scan. No strong feelings, just don't see the need for scan
results during suspend. But of course I might be missing something...

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
