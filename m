Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9534391CD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhJYI55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:57:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20166 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhJYI55 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:57:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635152135; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bzN73iGJqaysN5qGjvaDZWTGpN3xBPAHgC9ASc84VT0=; b=F0Z66cFROmIHLGhPigmXp54u1JkoqcANhSyUGuPDckY4Zh5QPYo6P7WXyTXQTKjZUxv6j4/5
 nQTUm1YM8k5PUpaevG+hHvc6GJajTSwXwwqmw4K1MAmPMV4zZVwpSZhfulOvqJ+q4zQk1ztt
 G54akFKGjEWDc1Brb51euEbmKLY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61767107321f2400512e0ad0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 08:55:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AAE9C4360D; Mon, 25 Oct 2021 08:55:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F77EC4338F;
        Mon, 25 Oct 2021 08:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6F77EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 1/1] Revert "wcn36xx: Enable firmware link monitoring"
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
        <20211022141008.2846454-2-bryan.odonoghue@linaro.org>
Date:   Mon, 25 Oct 2021 11:55:31 +0300
In-Reply-To: <20211022141008.2846454-2-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Fri, 22 Oct 2021 15:10:08 +0100")
Message-ID: <87v91lcwl8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

The commit log should answer to question "why?". Please move the
explanation from the cover email to the commit log.

> Signed-off-by: Benjamin Li <benl@squareup.com>

Why Benjamin's s-o-b?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
