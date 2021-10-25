Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54810439E88
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 20:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhJYSbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 14:31:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56501 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhJYSbl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 14:31:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635186559; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YOrCbTJeTMRNTykWwTzEtImkq2ZbQq7O47VLGj4ULmI=; b=E0lPJDbRjmkxkbJOAXhAba6F2Vu8V/bstOcDSNxL2hA6Jsw7NZ4uyCDAzC7L0yx8CROyIcW8
 kIOlQ14p+KgwsbG+tV9cJI/rlnWif7dnMnEX6NPtz0qLSzlHYrKLR59BlXnht1sT2XIppEy2
 8g2NsnSx4pHjgo+yvVLYg57jlSY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6176f76efd91319f0fbf700d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 18:29:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B36DBC4360C; Mon, 25 Oct 2021 18:29:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D4C5C4338F;
        Mon, 25 Oct 2021 18:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2D4C5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: Add chained transfer support for AMSDU
References: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
        <163516812328.10163.3396652728924346112.kvalo@codeaurora.org>
        <CAMZdPi9uUXiQZjLLu_ccG6PZgdvdgEKtZQDspEoM1=tXdS0ggg@mail.gmail.com>
        <3e226886-ab82-82f5-65bc-e0fb10fad46c@linaro.org>
Date:   Mon, 25 Oct 2021 21:28:58 +0300
In-Reply-To: <3e226886-ab82-82f5-65bc-e0fb10fad46c@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 25 Oct 2021 16:39:06 +0100")
Message-ID: <87a6ix9cwl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 25/10/2021 16:46, Loic Poulain wrote:
>> But it's better than the previous situation IMHO, since we check the
>> buffer descriptor to prevent skb breakage.
>
> Let's apply it and see how we go..

Sounds good to me. And we can revert it if doesn't go well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
