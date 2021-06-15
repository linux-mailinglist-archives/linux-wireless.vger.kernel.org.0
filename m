Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB763A7740
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFOGnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 02:43:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52652 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhFOGne (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 02:43:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623739290; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IrWIzyFhsweiJjY1aKk/mgQQqzzgtEW9y60KQT2lMdc=; b=ZlgKAV5PASGvXKbBTFCagf3N/jtT2H6HFL2EHpwAjl2EBwUY2Vtxly3HKltKIyySF/wNVxR+
 iJdwS8qxzxK3YZpwYIllsNblEsS3k+lSruuwW9szG4lbmCMDQzOreO7g1UgEitU4hh0UKm8l
 00NSnoAD+ZUS5G9DJlY7hP3FB2Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60c84b95ed59bf69cc82779b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 06:41:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3B2CC4323A; Tue, 15 Jun 2021 06:41:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E7AEC433F1;
        Tue, 15 Jun 2021 06:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E7AEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v6 01/12] wcn36xx: Return result of set_power_params in suspend
References: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
        <20210614151850.9DCE7C433D3@smtp.codeaurora.org>
        <87mtrsmprx.fsf@tynnyri.adurom.net>
        <eaceab2f-baf6-4843-ac9a-cad4870c70bf@linaro.org>
Date:   Tue, 15 Jun 2021 09:41:17 +0300
In-Reply-To: <eaceab2f-baf6-4843-ac9a-cad4870c70bf@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 14 Jun 2021 16:36:28 +0100")
Message-ID: <87a6nrk4tu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 14/06/2021 16:25, Kalle Valo wrote:
>> BTW, I'm not sure about CONFIG_IPV6 checks but they looked minor so I
>> applied these anyway. But can you check them anyway and send a followup
>> patch if my hunch is correct?
>
> np

Thanks. The less ifdefs we have the better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
