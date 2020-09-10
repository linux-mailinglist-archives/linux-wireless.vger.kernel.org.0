Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB2263EA8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJHYB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:24:01 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:56620
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbgIJHXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 03:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599722628;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=rBdxxxmDhpAfoIEEJUGR//NUhzr+yOlKNMkan6WiZag=;
        b=lbyYS0wk/dHrFob5sp7wdBNFi4vJDZ3U9lS+2uy97YWB+67lAxh0yXm8erl3vl5/
        5/1GOmhg7qIwssMnW3+RHRXN9y73gTJg6EXENk948hXx1tgbr8ZBmJHy5vIl4p+NRCj
        Klf/QaQQALWa15SBFPuUSNZhvOACOp4hUBgkj1+I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599722628;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=rBdxxxmDhpAfoIEEJUGR//NUhzr+yOlKNMkan6WiZag=;
        b=kohVCh69KUJKCNnZg7wun4zs2vdhkIYo7pnnQRsGx4+K+q9o/83XNzWjCaCyJ+Y4
        eRnbUBdUlnORvpVIsX3W6ZwW+RhwX4hbuh2NIaY2Dk2IdsBkt62vIgdGY0/Yu7G5+0X
        6e1z0vgvFK93my6KweLBOqKz7RYEh7Ge7+y4aKfA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F09E4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath11k@lists.infradead.org
Subject: Re: linux-next: Tree for Sep 9 (ath11k)
References: <20200909202624.2cc6c3d1@canb.auug.org.au>
        <3f8649d7-c64a-4b0a-a2db-69f1b11e31e5@infradead.org>
        <0101017476bd06e1-16ca4de8-647e-4423-9630-753fb5675e8b-000000@us-west-2.amazonses.com>
Date:   Thu, 10 Sep 2020 07:23:48 +0000
In-Reply-To: <0101017476bd06e1-16ca4de8-647e-4423-9630-753fb5675e8b-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Thu, 10 Sep 2020 06:38:53 +0000")
Message-ID: <0101017476e62656-22a95a04-af3b-4d23-b454-70e8a6d8a45c-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.10-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Randy Dunlap <rdunlap@infradead.org> writes:
>
>> On 9/9/20 3:26 AM, Stephen Rothwell wrote:
>>> Hi all,
>>> 
>>> Changes since 20200908:
>>> 
>>
>> on x86_64:
>>
>> ld: drivers/net/wireless/ath/ath11k/core.o: in function `ath11k_core_init':
>> core.c:(.text+0x121f): undefined reference to `rproc_get_by_phandle'
>
> This is because CONFIG_REMOTEPROC is not, I'll fix the dependency in
> ath11k. Thanks for the report.

Patch sent:

ath11k: fix link error when CONFIG_REMOTEPROC is disabled

https://patchwork.kernel.org/patch/11766849/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
