Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680E11059A5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKUSgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 13:36:45 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:54506
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbfKUSgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 13:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574361404;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=5Zc5n8VvGZgHSgrERRhNOfDMNRo0kaEB5426/85xE9o=;
        b=ZSHM+8yVpgvwbtE5eql09VKYknyRsZo7EC+hXHK+eOjHvtLKKn+GDXS2bD9kfb9D
        AJeaedwZHNz8zsM96p2qUJwCMigBxX4R35trJOk6r+Vak30+YaBn1UGW7UasSHdvtiE
        NBu9JOt+OZeYTuKpzYtaVkrBi3rKqLVJbVKTgOY4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574361404;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=5Zc5n8VvGZgHSgrERRhNOfDMNRo0kaEB5426/85xE9o=;
        b=UJd6rg4v2JIQ9AY7P1EOSkBcp+ZMwvBIiN/rP4CaI6gxQQaFKt2QLxvpCwUErmn/
        d7GkzRsuCcWzPwWZdl2vzF+LpDhjoIdNv9qZ5HPnJdyTqF1nb0u8WQHpT3NbJQCrOKw
        4vqM1cqy9Oj6b2c2NHKd5RynJ3d7bYqg9qSwuR2k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17CD1C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: fix ampdu locking
References: <20191120200531.11344-1-markus.theil@tu-ilmenau.de>
        <0101016e8f3ec7ca-c8443d20-4cae-48f6-b3fd-a7b91be56ea4-000000@us-west-2.amazonses.com>
Date:   Thu, 21 Nov 2019 18:36:44 +0000
In-Reply-To: <0101016e8f3ec7ca-c8443d20-4cae-48f6-b3fd-a7b91be56ea4-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Thu, 21 Nov 2019 18:34:46 +0000")
Message-ID: <0101016e8f4091d8-25fb3419-9034-4a7f-8fec-e4810e7e0c24-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.21-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Markus Theil <markus.theil@tu-ilmenau.de> wrote:
>
>> The current ampdu locking code does not unlock its mutex in the early
>> return case. This patch fixes it.
>> 
>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> Acked-by: Felix Fietkau <nbd@nbd.name>
>
> Patch applied to wireless-drivers-next.git, thanks.
>
> 3e870c205d66 mt76: fix ampdu locking

I made a mistake, please ignore that commit id. There will be a new id soon.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
