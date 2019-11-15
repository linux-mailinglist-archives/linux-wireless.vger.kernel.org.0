Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6AFDD4B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKOMS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 07:18:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKOMS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 07:18:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 153F460E74; Fri, 15 Nov 2019 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573820336;
        bh=inze6281I3ANNET/l8NKpBp9h8VIMrF912CJ7dHN7+A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JpxOoizO7ox0s0XNIQP7DhP2NAcT5h/gYB7AiUhYpKSXisoMZb8M5UfIN0w+9YRuB
         oZjfb54s3e0s0tSLDiJZ8rbmkzFNeZ8e8hJxr1LBaA0NT/dcT/lM4tNGmtYpQmgK5T
         AgHamU5mGCBeWn1KNvyipt72dyEoIc9YhCs5RkCU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (unknown [83.145.195.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94BD460E0D;
        Fri, 15 Nov 2019 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573820335;
        bh=inze6281I3ANNET/l8NKpBp9h8VIMrF912CJ7dHN7+A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ba1l6i6aLpDlf3qPWmkIfATaLTtPKY6zvhq7QjXtkNjwvKuz6QOXkQSJMPN6eC146
         OCei/xWmBF+SjcF/JfGSqR4+l63sDChWC8RD6zbnyMb4W1RjPTCRYqGexxjpEasr2f
         NczvT3Mdi5NcAlGAvr/+xG8cpIgDVuq5awkfaKPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94BD460E0D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v2 01/49] dt: bindings: net: add qcom,ath11k.yaml
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
        <1571565847-10338-2-git-send-email-kvalo@codeaurora.org>
        <20191025213028.GA5117@bogus>
        <87k18by9w0.fsf@kamboji.qca.qualcomm.com>
Date:   Fri, 15 Nov 2019 14:18:50 +0200
In-Reply-To: <87k18by9w0.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Thu, 07 Nov 2019 17:38:23 +0200")
Message-ID: <8736epwcwl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Rob Herring <robh@kernel.org> writes:
>
>> On Sun, Oct 20, 2019 at 01:03:19PM +0300, Kalle Valo wrote:
>>> ath11k is a driver for Qualcomm IEEE 802.11ax devices. Add a
>>> bindings document for the driver, first documenting IPQ8074 which is the
>>> only device ath11k currently supports.
>>> 
>>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> [...]
>
>>> +  interrupts:
>>> +    minItems: 53
>>> +    maxItems: 53
>>
>> Assuming the list below has 53 entries min/maxItems is implied.
>
> There's actually 52 entries in the items list below this, I need to
> check if we are missing an entry or is this just a miscalculation.

I got a confirmation internally, 52 entries is correct.

-- 
Kalle Valo
