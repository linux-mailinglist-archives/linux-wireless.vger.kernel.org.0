Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB612513A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLRTDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 14:03:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:22074 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbfLRTDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 14:03:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695826; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fNUGCpnJGL72nQUvjwBoafFHvNb1ZS1aEf6evuL4H8Q=; b=lmR98I5pkGefiXt6JHWLLX49vvN4qxS1IQZpK/P/csEe5U6+I/WzfKmDK2uqKoCJrQ/1Qz4h
 A7vP4kfd4asKeoWy6QP9mTWm9y9aUtlEry9hVp7PIfODjlEetSCo2+m0SuAj0vJAF0006TK/
 1dU+nJ75fpo2+MD85QeFmzI178g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa7811.7fe27fa6f340-smtp-out-n02;
 Wed, 18 Dec 2019 19:03:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D66ACC433A2; Wed, 18 Dec 2019 19:03:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDC7EC43383;
        Wed, 18 Dec 2019 19:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDC7EC43383
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
Date:   Wed, 18 Dec 2019 21:03:40 +0200
In-Reply-To: <20191218185936.B6A77C43383@smtp.codeaurora.org> (Kalle Valo's
        message of "Wed, 18 Dec 2019 18:59:36 +0000 (UTC)")
Message-ID: <87tv5x3183.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Ganapathi Bhat <gbhat@marvell.com> wrote:
>
>> I'd like to use this email-id from now on.
>> 
>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>
> Patch applied to wireless-drivers-next.git, thanks.
>
> d0b103a52b72 MAINTAINERS: update Ganapathi Bhat's email address

Actually please ignore that email, I should have applied this to
wireless-drivers. There will be a new email with correct commit id.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
