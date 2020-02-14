Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDF15D1BD
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgBNFqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 00:46:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:21158 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgBNFqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 00:46:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581659194; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vCNfsv+IxSspdzcRH0QvkQtkHuzPYVw4qQQP7xcBxt4=;
 b=ab7WEsGGxD+ftd0NQCGxcFDGS5AAbNIWmPRuICXB6csQ9BGsRW4rjWBOP1DYX9L0ipaCXfrd
 BNQNQKTqA1kYuL8zEKTEYdJk/mBXG21zjMAhLFnbJq83pHRQXxjcY68QpAZYwYSNtReEjXkA
 Xe2WWQG6pc4Ofl53SalCdHF1stI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e463436.7f0eca28eae8-smtp-out-n02;
 Fri, 14 Feb 2020 05:46:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2DE3CC433A2; Fri, 14 Feb 2020 05:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A96CC43383;
        Fri, 14 Feb 2020 05:46:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Feb 2020 11:16:29 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, Vikas Patel <vikpatel@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: avoid consecutive OTP download to reduce boot
 time
In-Reply-To: <87pnei7exs.fsf@codeaurora.org>
References: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
 <f1b4007f9d7e882c4ed2db67dc64cc96@codeaurora.org>
 <87pnei7exs.fsf@codeaurora.org>
Message-ID: <0a3ff5df5e16e2657f76214d1448d0ad@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-13 19:43, Kalle Valo wrote:
> Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:
> 
>> On 2020-01-07 11:53, Maharaja Kennadyrajan wrote:
>> 
>> [Maha]: Please ignore/drop this duplicate patch as I sent it already.
>> Regret for inconvenience caused.
> 
> Are you sure I should drop this? In the first patch I think you forgot
> to CC linux-wireless and that's why I didn't see it. But this second
> patch was CCed to linux-wireless and I see it on patchwork. So my plan
> is to put this back to my queue, please let me know if I have
> misunderstood.

[Maha]: Hi Kalle, I sent the same patch twice. So I asked to ignore one 
duplicate patch.
You can pick up this patch to put it in your queue and please ignore the 
duplicate patch.
