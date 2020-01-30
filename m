Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2014DC38
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 14:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgA3Noe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 08:44:34 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49050 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgA3Noe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 08:44:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580391873; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=n8OOjPhZnJqBUlxbtz/kzal18dAlHK3V7n0AErr+wL8=; b=PS32cEgMHc0icUPtvBN+mFTamPeJOPlH1VbDhSwDwDQ0tUUhf+/5CV5SbXJnz3W1uG5CAwWH
 YE2m6KCMwCCnoeP6ELHNe0a3hg4dD0RiAbpFZiXBpkzyUqpRKF3xtfEhdJk5F0f5oETMF2nJ
 7cXc1wdgD+qLlnRZTl3i7/NS4no=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e32ddc0.7f58cfaa7500-smtp-out-n03;
 Thu, 30 Jan 2020 13:44:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 824CAC43383; Thu, 30 Jan 2020 13:44:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68E97C433CB;
        Thu, 30 Jan 2020 13:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68E97C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-01-27
References: <ec25181f-3a2e-0374-a30e-2744e247aea6@nbd.name>
        <87o8um8iqt.fsf@codeaurora.org>
        <2f1b9312-c13d-d793-c8cf-6c00eb6769ee@nbd.name>
Date:   Thu, 30 Jan 2020 15:44:27 +0200
In-Reply-To: <2f1b9312-c13d-d793-c8cf-6c00eb6769ee@nbd.name> (Felix Fietkau's
        message of "Thu, 30 Jan 2020 13:09:55 +0100")
Message-ID: <87y2tpawjo.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-01-29 15:00, Kalle Valo wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>> 
>>> here's my pull request for 5.6
>> Sorry, too late. Linus released v5.5 on Sunday which opened the merge
>> window for v5.6. And I need to get everything ready for net-next before
>> the merge window opens.
>> 
>> So this has to wait for v5.7 and I'll pull this after the merge window
>> has closed.
>
> No problem. Please ignore this pull request then, I will send a new one
> after the merge window has closed.

Ok, dropped.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
