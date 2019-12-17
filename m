Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750E9122E44
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfLQOOt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 09:14:49 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:54831 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbfLQOOt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 09:14:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576592088; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IQ/h7WGtsxPAeTcFQEEn1Y2mtfDbwOvIuZQCUrAuAQg=; b=o2nmbjJx6X5bTKOf0y8rtDlF6XsbRwCBJZ+Ixk573QLU4JyW9yCMVue+WxtuHZtFVymcrFmj
 qdAGwuzPyM6PXdZlTzeMjLP/kqL9LPbwffBZxhO5n4QrNi1dwGT2WjWzcMJ1+x1xM80G7cze
 nmte3IO8sluqtU8Bbjl4VxGuxd8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8e2d1.7f9b740f11f0-smtp-out-n02;
 Tue, 17 Dec 2019 14:14:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF7CCC433CB; Tue, 17 Dec 2019 14:14:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27ACCC43383;
        Tue, 17 Dec 2019 14:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27ACCC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     govinds@codeaurora.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt: bindings: add dt entry flag to skip SCM call for msa region
References: <20191111042508.12628-1-govinds@codeaurora.org>
        <20191111042508.12628-2-govinds@codeaurora.org>
        <20191114191640.GA8426@bogus>
        <0101016e8d2426fc-31499903-e1a0-44b3-83eb-73ba4f4a8b4a-000000@us-west-2.amazonses.com>
Date:   Tue, 17 Dec 2019 16:14:36 +0200
In-Reply-To: <0101016e8d2426fc-31499903-e1a0-44b3-83eb-73ba4f4a8b4a-000000@us-west-2.amazonses.com>
        (govinds@codeaurora.org's message of "Thu, 21 Nov 2019 08:46:27
        +0000")
Message-ID: <87pngnavjn.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

govinds@codeaurora.org writes:

> On 2019-11-15 00:46, Rob Herring wrote:
>> On Mon, Nov 11, 2019 at 09:55:07AM +0530, Govind Singh wrote:
>>> Add boolean context flag to disable SCM call for statically
>>> mapped msa region.
>>
>> Can't this be implied by the compatible string?
>>
>
> same soc compatible will be used in older TZ vs new TZ.
> Due to this reason I added this.

So what should we do? Rob, any suggestions?

Full patch here:

https://patchwork.kernel.org/patch/11236535/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
