Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126792C897A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgK3Q2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 11:28:10 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:32236 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgK3Q2K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 11:28:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606753669; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bHViouyBscQ2dCsxF/KylKF2/Zi6HjqkgDP3KxuO8ds=; b=jjAC7uqx+3ktNigIKgVna1WDK8bQcIMH/TaMJldHNKM93LxwqCILC30nlY0MZuzR7YLkOnSI
 oDyYWvs0Ouo+JvPIeHeYS9eBlpn6pAZZHLuPdew0RruwQxQvQ18qnQEzlw19gyWDsqm5ysPg
 1rS0C6IAr8pRGAKSCNOggyBMbgs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fc51d610b1f6587dd09d046 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 16:27:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B563FC433ED; Mon, 30 Nov 2020 16:27:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2CA1C43460;
        Mon, 30 Nov 2020 16:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2CA1C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     akolli@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2] ath11k: fix rmmod failure if qmi sequence fails
References: <1605076699-21924-1-git-send-email-akolli@codeaurora.org>
        <87mtz5pm8a.fsf@codeaurora.org>
        <013d9ee1c0f88863013f2672b6b2197a@codeaurora.org>
Date:   Mon, 30 Nov 2020 18:27:08 +0200
In-Reply-To: <013d9ee1c0f88863013f2672b6b2197a@codeaurora.org>
        (akolli@codeaurora.org's message of "Mon, 30 Nov 2020 19:25:21 +0530")
Message-ID: <878saikdyb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

akolli@codeaurora.org writes:

> On 2020-11-25 19:33, Kalle Valo wrote:
>> Anilkumar Kolli <akolli@codeaurora.org> writes:
>>
>>> QMI sequence fails if caldata file is not available.
>>> It is observed that 'rmmod ath11k' fails if qmi message fails.
>>> With this patch rmmod/insmod is working.
>>>
>>> Logs:
>>> Direct firmware load for IPQ8074/caldata.bin failed with error -2
>>> Falling back to user helper
>>> qmi failed to load CAL: IPQ8074/caldata.bin
>>> qmi failed to load board data file:-11
>>>
>>> Tested-on: IPQ8074 hw2.0 AHB
>>> WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>>
>> With this patch reloading ath11k (which has worked fine before) crashes
>> the kernel on QCA6390 hw2.0:
>>
>> Nov 25 16:00:52 nuc1 [  393.188277] BUG: unable to handle page fault
>> for address: ffffffffc05b8e38
>> Nov 25 16:00:52 nuc1 [  393.188300] #PF: supervisor read access in
>> kernel mode
>> Nov 25 16:00:52 nuc1 [  393.188312] #PF: error_code(0x0000) - 
>> not-present page
>
> I will test this in QCA6390 and update.
> Which branch should I use for testing. master or
> ath11k-qca6390-bringup ?

Please use master branch.

ath11k-qca6390-bringup is just a temporary branch for collecting all
important QCA6390 patches in one place.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
