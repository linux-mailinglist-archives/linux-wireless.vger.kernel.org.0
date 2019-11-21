Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169FB104AD6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 07:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUGxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 01:53:19 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:55532
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfKUGxT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 01:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574319198;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=PdXtZxXNzM09gOAdV88/V32i+22CDDtZzHxwCbfcmoE=;
        b=W7xkIpuFM6QCFhaC1rK8SgXVqvbm1bzKOoZ3VqZiMFNCuhfmqQPbqcYYrWj3PJxA
        kIy+gqB5fTJhfytJH93hlkHWA2kc6h4MQDd9IratGGibdlZCCUGJzemgRNfHeSNXyuH
        t1G2fiIW5ptjJ5vbnUPio3aZDYc9rh8wm44KnE8Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574319198;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=PdXtZxXNzM09gOAdV88/V32i+22CDDtZzHxwCbfcmoE=;
        b=XCLsdUAQnC2/FVOZyjJmCVa7aMQdd14CrPPlBW0HJhwC1hglOQjHkLZcabBH06Ik
        dC1X9ez+wSuC1AJL7L/dbbRygpq6EHv98hwEaVjS7ntIUYF++H8BWZBMapeo0PzqAEK
        X8YgMs5bmL91PEiO8XjTq4Iheh7gB3DMKdRIgkPE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B01CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: fix fix ampdu locking
References: <20191120200531.11344-1-markus.theil@tu-ilmenau.de>
        <9413ca21-94c3-857b-1156-e4a949acf390@nbd.name>
Date:   Thu, 21 Nov 2019 06:53:18 +0000
In-Reply-To: <9413ca21-94c3-857b-1156-e4a949acf390@nbd.name> (Felix Fietkau's
        message of "Wed, 20 Nov 2019 21:14:07 +0100")
Message-ID: <0101016e8cbc907e-e065156e-ccc2-46bd-8e51-45a1494ce723-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.21-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-11-20 21:05, Markus Theil wrote:
>> The current ampdu locking code does not unlock its mutex in the early
>> return case. This patch fixes it.
>> 
>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>
> Acked-by: Felix Fietkau <nbd@nbd.name>
>
> Kalle, I think this should go on top of my pull request quickly, since
> it fixes a regression in a commit from that pull request (introduced via
> rebase on top of Johannes' last change of that code).
> Do you want me to send another pull request with just this patch, or can
> you take it directly?

A lot easier to take it directly, so let's do that. I now assigned this
patch to me on patchwork and I'll try to remember apply it later today.

> In the latter case, feel free to also remove one of the two "fix"
> words in the subject :)

Ok, will fix (no pun intended ;)

-- 
Kalle Valo
