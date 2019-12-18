Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61581125197
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 20:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLRTMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 14:12:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:25259 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfLRTMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 14:12:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576696373; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DzTVsP1VogpMHkWNF9D06rFfZMG1jWECCz2mUrfk124=; b=cyBAV+VBJKeoSmd//FXfJpuQaGyavu3TRwH007+v8gxGm+aI8fMsGoMf5u0EdS9jh9iKZhJh
 AYNkum06iNJk/uwNk2fAqZa8WcMjNkXnYAYzv33iv1AsR1mCTwN9OGuNMNPTv6zkO7qKiSip
 anBbHBljDd2EyHVUUGaojC1iwx8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa7a31.7f6fc4517c38-smtp-out-n02;
 Wed, 18 Dec 2019 19:12:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E10CBC4479C; Wed, 18 Dec 2019 19:12:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADEFEC4479F;
        Wed, 18 Dec 2019 19:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADEFEC4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        <linux-wireless@vger.kernel.org>, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] MAINTAINERS: update Ganapathi Bhat's email address
References: <1575620268-4613-1-git-send-email-gbhat@marvell.com>
        <20191218185936.B6A77C43383@smtp.codeaurora.org>
        <87tv5x3183.fsf@tynnyri.adurom.net>
Date:   Wed, 18 Dec 2019 21:12:43 +0200
In-Reply-To: <87tv5x3183.fsf@tynnyri.adurom.net> (Kalle Valo's message of
        "Wed, 18 Dec 2019 21:03:40 +0200")
Message-ID: <87pngl30t0.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Ganapathi Bhat <gbhat@marvell.com> wrote:
>>
>>> I'd like to use this email-id from now on.
>>> 
>>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>>
>> Patch applied to wireless-drivers-next.git, thanks.
>>
>> d0b103a52b72 MAINTAINERS: update Ganapathi Bhat's email address
>
> Actually please ignore that email, I should have applied this to
> wireless-drivers. There will be a new email with correct commit id.

But of course I forgot to remove the commit from w-d-next. So forget all
I said above, this goes wireless-drivers-next and the commit id above is
correct. I'm going to bed now before I make more mistakes :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
