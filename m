Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8F19561C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0LQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 07:16:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:39177 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgC0LQI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 07:16:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585307768; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9LK10OXgzi/rnLsXdPOkiREm+deDTcfebaSPGXR+HEQ=; b=XMconDCVrItWeq8VEnjZtvU2UjkbIgEkKpUqi6KwK4Sa9HS35WCEpFZoYsypDnX0w3SsZz/N
 pzROaILRpopmlyKNQSDN+e4LfzEGSVuGq9GIZLrQY8XILOGR3vMMoGoPp6b2U7jEc7EaR0F0
 Z2XeU7E0Q1cofnY1U7nnDnFnFxM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7de076.7f47fbeeb1f0-smtp-out-n05;
 Fri, 27 Mar 2020 11:16:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81092C43636; Fri, 27 Mar 2020 11:16:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3418C433D2;
        Fri, 27 Mar 2020 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3418C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v6 00/17] wilc1000: move out of staging
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
Date:   Fri, 27 Mar 2020 13:16:01 +0200
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Fri, 27 Mar 2020 06:33:07 +0000")
Message-ID: <87ftduoxou.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> This patch series is to review and move wilc1000 driver out of staging.
> Most of the review comments received in [1] & [2] are addressed in the
> latest code. Please review and provide your inputs.
>
> [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>
> Changes since v5:
>  - handle DT binding review comments suggested in below link:
>   * https://lore.kernel.org/driverdev-devel/20200320175920.GA31641@bogus
>  - merged latest driver from staging which contains few cleanup patches
>    and changes to use crc7 from existing library instead of having
>    private implementation.

This is already the third version this month, please avoid spamming the
list unnecessarily. What you can do to speed up the acceptance is to get
Reviewed-by tags from people, the more I see those the more confident I
get about the driver. I will also review this again once I find some
free time, but don't know when that will happen.

But it would be good to document in the cover letter what commit id are
you using as the baseline. That way it's easy to review rest of the
changes Greg has applied separately and you don't need to resend the
whole driver everytime.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
