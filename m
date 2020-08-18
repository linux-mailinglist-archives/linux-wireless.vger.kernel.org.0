Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6709E247E56
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHRGPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 02:15:48 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:27250 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgHRGPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 02:15:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597731347; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=N2ThwtTU/tbRaIjH90yRpZUhmzxqpP917E1jmCkS58k=; b=MCnXuWlTYkCyM9aX2arKxD7Oi6aXrElJw+RXpLMUb4aMHUBWVUkXgJZCsCKH6bO4BOc3V0wH
 PN7GxnV3ovcjfqfEQWO4EkOdxrM3g238dp6Z0gsMS/mwALczDpf2wKPprdAi15bAZ0V5BnbI
 KHzLxBdIQu3evEWpoOYYs0RtKr4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f3b7204f2b697637aea6b90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 06:15:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A39DC433CB; Tue, 18 Aug 2020 06:15:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3DF8C433CA;
        Tue, 18 Aug 2020 06:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3DF8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     bryan.odonoghue@linaro.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
Date:   Tue, 18 Aug 2020 09:15:27 +0300
In-Reply-To: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Mon, 17 Aug 2020 18:01:15 +0200")
Message-ID: <87pn7ojx8g.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> For software-driven scan, rely on mac80211 software scan instead
> of internal driver implementation. The internal implementation
> cause connection trouble since it keep the antenna busy during
> the entire scan duration, moreover it's only a passive scanning
> (no probe request). Therefore, let mac80211 manages sw scan.
>
> Note: we fallback to software scan if firmware does not report
> scan offload support or if we need to scan the 5Ghz band (currently
> not supported by the offload scan...).
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

What changed since v2? Please always include a changelog so that I don't
need to guess what you have changed in the patch. No need to resend, a
reply is enough.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
