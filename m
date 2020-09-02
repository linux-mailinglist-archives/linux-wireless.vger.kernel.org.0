Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEDF25AB05
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBMTl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 08:19:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42877 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgIBMTc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 08:19:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599049172; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=rS1ZBzOIZJmryIkPz/1rCmI6J+HnX8XyIQs6a2EiJWQ=; b=YQjP+UOa+j+F67IP7VUzpktDUYKqWgqgOcF9yWJDmen6cyzax/0PmEoOnNbKZNN+BwD0yetb
 T4kcdrXeD0u8j0ZBtGyNk4VrI9f+CSpRXoF0fkamFYloLyN+KeRH7IK6WFzJ9CKxLumD2goh
 lsl4UW+FjAvMh2m5A5ynCvVUq2w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4f8dc67f21d51b30c07d08 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 12:19:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C90F7C433C9; Wed,  2 Sep 2020 12:19:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA0BBC433CA;
        Wed,  2 Sep 2020 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA0BBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
Subject: Re: [PATCH v2 01/12] wcn36xx: Add VHT fields to parameter data structures
References: <20200829033908.2167689-2-bryan.odonoghue@linaro.org>
        <20200902085942.05A42C433C6@smtp.codeaurora.org>
        <2b2d04fb-14bc-fc6f-9c63-f3cefc4c9a43@linaro.org>
Date:   Wed, 02 Sep 2020 15:19:13 +0300
In-Reply-To: <2b2d04fb-14bc-fc6f-9c63-f3cefc4c9a43@linaro.org> (Bryan
        O'Donoghue's message of "Wed, 2 Sep 2020 10:39:14 +0100")
Message-ID: <87tuwg4bi6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 02/09/2020 09:59, Kalle Valo wrote:
>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>>
>>> In order to pass VHT parameters to wcn3680 we need to use a super-set of
>>> the V1 data-structures with additional VHT parameters tacked on.
>>>
>>> This patch adds the additional fields to the STA and BSS parameter
>>> structures with some utility macros to make calculation of the structure
>>> size easier.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> New warnings:
>>
>> drivers/net/wireless/ath/wcn36xx/smd.c:1257:1: warning:
>> 'wcn36xx_smd_set_sta_params_v1' defined but not used
>> [-Wunused-function]
>>   1257 | wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/wcn36xx/smd.c:150:1: warning:
>> 'wcn36xx_smd_set_bss_vht_params' defined but not used
>> [-Wunused-function]
>>    150 | wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I'm declaring a series of functions in patches for later use, in
> patches 03-10.
>
> Do you want those squashed into the patch/patches where they are first
> used ?

Yeah, squashing them is better. Every patch should compile on it's own
and be warning free. Kbuild bot will even check that and report if there
are warnings in-between patches.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
