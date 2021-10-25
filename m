Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE194391C5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJYIzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:55:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:43629 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJYIzY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:55:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635151982; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=AbXlBzu/MEaL0KyJBZ8oMQHDtyVwMdaW1n/FBdrv/CM=; b=WZENANuprfBwW9MRRkwUBwRP9q2KIu1ZWeGli20qlN82tCwo/ratTbLXwWPDaQ/5efxuR6/s
 BXLcjppe4EXOyzAJAvuqh9ySB3S86fMznLQ+Z1hEphVB7hpKSbJR6tXnGvNZr+P6LLMEoesG
 Hpk70jVzFGeMq8JzwXnuNDSaUH0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61767069321f2400512ca9ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 08:52:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FDC9C43616; Mon, 25 Oct 2021 08:52:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37955C4338F;
        Mon, 25 Oct 2021 08:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 37955C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 0/1] wcn36xx: Revert firmware link monitoring
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
Date:   Mon, 25 Oct 2021 11:52:52 +0300
In-Reply-To: <20211022141008.2846454-1-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Fri, 22 Oct 2021 15:10:07 +0100")
Message-ID: <874k95eba3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> We can get this working with
>
> - Secure APs PS on/off
> - Open APs PS on
>
> by setting firmware feature bit WLANACTIVE_OFFLOAD 
>
> Open APs PS off though is non-functional even with the above bit enabled
> and three quaters of a wheel is useless.
>
> So unfortunately for now zap it off.

Avoid using acronyms as much as possible, PS meaning power save might
not be clear for everyone.

And please try to be more specific, I'm not sure what power save feature
you are meaning here. (802.11 protocol power save, BMPS or what?)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
