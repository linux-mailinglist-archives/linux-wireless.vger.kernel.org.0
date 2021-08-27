Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF03F9926
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbhH0Mox (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 08:44:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34372 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhH0Mow (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 08:44:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630068244; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=u+0kQZv41mny+Fwi1KMh+dQh0dHtpUUvJt6TRvhKLhs=; b=wyR686FyOTWNls3L2a+kcRK/hC4/luKnrNTg3J/IhppOFGaUooWRvFWGUX0nRsPRDY9mysA7
 V5QIUunRTUFL84v/5/VQhF13NHQK4H4Fr7gdidJxmEHk+bZciBKiTsxXynSnSJppimcVLPU7
 udWoBKjWjpdjoxxsTFscF7/F8uo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6128de13d6653df767c4fa29 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 12:44:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16994C4360D; Fri, 27 Aug 2021 12:44:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A485DC4338F;
        Fri, 27 Aug 2021 12:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A485DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wren Turkal <wt@penguintechs.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
        <87y28sqq4l.fsf@codeaurora.org>
        <d2795e7c-69cf-557d-19c4-f800c3a80997@penguintechs.org>
Date:   Fri, 27 Aug 2021 15:43:58 +0300
In-Reply-To: <d2795e7c-69cf-557d-19c4-f800c3a80997@penguintechs.org> (Wren
        Turkal's message of "Mon, 23 Aug 2021 09:17:19 -0700")
Message-ID: <87o89j5a7l.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wren Turkal <wt@penguintechs.org> writes:

> On 8/23/21 5:53 AM, Kalle Valo wrote:
>> Do you get the same mhi error as in the forum post?
>>
>> qcom_mhi_qrtr: probe of mhi0_IPCR failed with error -22
>>
>> MHI folks, any ideas? I have XPS 13 9310 myself but I'm not able to test
>> v5.14-rc6 kernel right now.
>
> Yes, I get that same message in my logs.
>
> FWIW, ath11k_pci now does not get loaded on boot. I can manually load
> it, but it doesn't seem to do anything.

Do you know if this automatic module loading is related to this qrtr
regression or a separate problem? Can you try Linus' tree and report if
the module load problem still exists? The qrtr regression is fixed now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
