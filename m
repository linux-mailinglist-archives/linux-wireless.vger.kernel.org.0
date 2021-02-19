Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8691C31F561
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 08:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBSHfo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 02:35:44 -0500
Received: from z11.mailgun.us ([104.130.96.11]:12713 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSHfl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 02:35:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613720121; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7cvf68vx9VU5mYJG34AqEwCISJhEcsFqTk8A+BH/d2g=; b=UaqVh9DvaklcNvRY9ttJCpW0f9tU8+kVmXiNZG2udl5n4b0P1VSa5/XCs0L0xl/IyTg3wxxn
 SN6RiQaoGKehGK7cSVhMhlQudsduQZHj2d/C/eWrvW3hIvYcPku1+4LIDDu0WXY2zCDopgqk
 F6yH/jDsUIrTFhr/t1ZCnJMscdo=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 602f6a1b994664385950245c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Feb 2021 07:34:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9290DC43462; Fri, 19 Feb 2021 07:34:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7EA9C433C6;
        Fri, 19 Feb 2021 07:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7EA9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger\@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] rtlwifi: 8821ae: upgrade PHY and RF parameters
References: <20210219052607.7323-1-pkshih@realtek.com>
        <87zh00jzlk.fsf@codeaurora.org> <1613719728.11718.3.camel@realtek.com>
Date:   Fri, 19 Feb 2021 09:34:46 +0200
In-Reply-To: <1613719728.11718.3.camel@realtek.com> (pkshih@realtek.com's
        message of "Fri, 19 Feb 2021 07:28:51 +0000")
Message-ID: <87v9aojysp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Fri, 2021-02-19 at 09:17 +0200, Kalle Valo wrote:
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > New parameters with new format and its parser are updated by the
>> > commit 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser."),
>> > but some parameters are missing. Use this commit to update to the novel
>> > parameters that use new format.
>> >
>> > Fixes: 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser")
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> 
>> What does this fix from user's point of view?
>> 
>
> The signal strength of 5G is quite low, so user can't connect to an AP far away.

Thanks, I'll add that to the commit log and queue the patch to v5.12.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
