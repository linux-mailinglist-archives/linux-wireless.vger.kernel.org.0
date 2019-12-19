Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A6126481
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLSOWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 09:22:02 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:22442 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbfLSOWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 09:22:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576765321; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UmveuUtZWLgWspyGtVGArhySgeISuX0U1mjzVzlm+5c=; b=l048cI+lodI3RJgdmquJHrLMTJWJgo6Xus97WMvN4nhKZecwZo+2Nr83RW5ZFRtIg6gkXOpw
 Dj5jizcdAFTx89fdRGJOtJ8Iz/VNP015B++LW/pHO3A2tATXWVYOuU9FM0mNeHtAsAzrQR6/
 8jeZcJRJot/l6WE0+rIzjqjG1MU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb8788.7f2e05bef688-smtp-out-n03;
 Thu, 19 Dec 2019 14:22:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B656C5380F; Thu, 19 Dec 2019 14:22:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5340C5380C;
        Thu, 19 Dec 2019 14:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5340C5380C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     akolli@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG when safe
References: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
        <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
        <87woas5slt.fsf@kamboji.qca.qualcomm.com>
        <38bf1f75-0554-920a-0f29-354e70cfc077@linaro.org>
Date:   Thu, 19 Dec 2019 16:21:55 +0200
In-Reply-To: <38bf1f75-0554-920a-0f29-354e70cfc077@linaro.org> (Bryan
        O'Donoghue's message of "Thu, 19 Dec 2019 14:15:37 +0000")
Message-ID: <87sglg5rb0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 19/12/2019 13:53, Kalle Valo wrote:
>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>
>>> ath10k_pci_dump_memory_reg() will try to access memory of type
>>> ATH10K_MEM_REGION_TYPE_IOREG however, if a hardware restart is in progress
>>> this can crash a system.
>>>
>>> Individual ioread32() time has been observed to jump from 15-20 ticks to >
>>> 80k ticks followed by a secure-watchdog bite and a system reset.
>>>
>>> Work around this corner case by only issuing the read transaction when the
>>> driver state is ATH10K_STATE_ON.
>>>
>>> Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> What ath10k hardware and firmware did you test this on? I can add that
>> to the commit log.
>>
>
> HW = QCA9988
> FW = ??
>
> Not quite sure how to find the firmware version TBH

'dmesg | grep ath10k' should show it.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
