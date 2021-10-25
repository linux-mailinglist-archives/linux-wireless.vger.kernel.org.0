Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E664391C9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhJYI4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:56:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20166 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232260AbhJYI4d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:56:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635152051; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jFQAFqDptd4cpkFMwQb5sAbRbA7cJUW5bQ6MudQOVl0=; b=pDU+d8RaXQiedS8YMQ64+ZJAivUSoEsp9BznnhSAxyExb508NCtMeoMygl/eqB4Ub81WlsXd
 LIQtSN9T/ABZMGVrnN7bySaR/6lP6rUNulY1B+9igAWGMvimtgAReovKKzlgLC9rrl5E2IjD
 vt/dSPqTBpqdND0ZEOEFi2w5c4c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 617670af5baa84c77b8b7ca6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 08:54:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F227C43460; Mon, 25 Oct 2021 08:54:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4276AC4338F;
        Mon, 25 Oct 2021 08:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4276AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        Benjamin Li <benl@squareup.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/1] Revert "wcn36xx: Enable firmware link monitoring"
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
        <20211022141008.2846454-2-bryan.odonoghue@linaro.org>
        <CAMZdPi-muvfLNb4Zv5b9C+Sg8MQcC6GYyQSt_yhfB7=XB75YPw@mail.gmail.com>
Date:   Mon, 25 Oct 2021 11:54:03 +0300
In-Reply-To: <CAMZdPi-muvfLNb4Zv5b9C+Sg8MQcC6GYyQSt_yhfB7=XB75YPw@mail.gmail.com>
        (Loic Poulain's message of "Fri, 22 Oct 2021 17:05:17 +0200")
Message-ID: <87zgqxcwno.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> On Fri, 22 Oct 2021 at 16:08, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Benjamin Li <benl@squareup.com>
>
> Should it get a 'Fixes' tag?

But this patch is not really fixing anything, right? I wonder if there's
patch 2 missing?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
