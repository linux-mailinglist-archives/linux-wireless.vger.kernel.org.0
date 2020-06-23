Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC01204A14
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgFWGmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 02:42:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41437 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730540AbgFWGmC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 02:42:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592894521; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=N4/GpdSXrdvWiK6U8fh1EZiXdjYys4Gz3YS+KkT6+54=; b=V1qMMWXHzYRT5GaO/k5n1NqcVvsMaDO3o0H334EfbsKdGPKgiKvn1UnaqrjQTE970ubCGhdv
 GbI1u4No8CROPfVFK0BtYIwv2L9xNO2Z3thEnvuR5NxX7gm5cxjOUdibhrqlY+FqK/NJ9KmZ
 Fgu4sxve3DI4GCaKes6quPrW6mQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5ef1a439567385e8e7bdcdb7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 06:42:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47C64C433C6; Tue, 23 Jun 2020 06:42:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F4F1C433C8;
        Tue, 23 Jun 2020 06:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F4F1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
References: <20200617212505.62519-1-tony@atomide.com>
        <20200617212505.62519-2-tony@atomide.com>
        <875zbjgpbj.fsf@codeaurora.org> <20200622160628.GL37466@atomide.com>
Date:   Tue, 23 Jun 2020 09:41:56 +0300
In-Reply-To: <20200622160628.GL37466@atomide.com> (Tony Lindgren's message of
        "Mon, 22 Jun 2020 09:06:28 -0700")
Message-ID: <87wo3ye11n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kalle Valo <kvalo@codeaurora.org> [200622 14:15]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > We need the spinlock to check if we need to run the queue. Let's use
>> > spin_trylock instead and always run the queue unless we know there's
>> > nothing to do.
>> 
>> Why? What's the problem you are solving here?
>
> To simplify the flags and locking use between the threaded irq
> and tx work.
>
> While chasing an occasional hang with an idle wlan doing just a
> periodic network scans, I noticed we can start simplifying the
> locking between the threaded irq and tx work for the driver.
>
> No luck so far figuring out what the occasional idle wlan hang is,
> but I suspect we end up somewhere in a deadlock between tx work
> and the threaded irq.
>
> We currently have a collection of flags and locking between the
> threaded irq and tx work:
>
> - wl->flags bitops
> - wl->mutex
> - wl->wl_lock spinlock
>
> The bitops flags do not need a spinlock around them, and
> wlcore_irq() already holds the mutex calling wlcore_irq_locked().
> And we only need the spinlock to see if we need to run the queue
> or not.
>
> So I think eventually we can remove most of the spinlock use in
> favor of the mutex. I guess I could leave out the trylock changes
> here if this is too many changes at once.
>
> Or do you see some problem in general with this approach?

My only problem was lack of background information in the commit logs.
Conditional locking is tricky and I didn't figure out why you are doing
that and why it's safe to do. So if you could send v2 with the
information above in the commit log I would be happy.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
