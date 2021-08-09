Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C613E4D36
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 21:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhHITmH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 15:42:07 -0400
Received: from ixit.cz ([94.230.151.217]:45932 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhHITmG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 15:42:06 -0400
Received: from [192.168.1.138] (ixit.cz [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 868532029F;
        Mon,  9 Aug 2021 21:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1628538104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EwEcJ1rbb/Lvh6mB9DNV1T4J84NctEuqSvvbEiPFkGw=;
        b=1L9BD9Kjr1QgaF4331h4EchLUl/vBObQ9UlEPsWyZL3boHzPktY4BGoHNsdto2X3VVPiQF
        TeLw2bPYBevvr2ClbZ/V7XkgtF+eXK+1qjWQbgnQlj+KT4L4Sp9rldvvL/UoF2bYvucQvO
        wIHqiju1Ejik45YICX7mqiORji6PBDI=
Date:   Mon, 09 Aug 2021 21:40:38 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race
 condition
To:     Brian Norris <briannorris@chromium.org>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Message-Id: <QZ7LXQ.RQD9UODPTG672@ixit.cz>
In-Reply-To: <CA+ASDXOHFijzJeRFEFy6okgNYNZKdc6HZtzZ9-6mdkYEfzL-2g@mail.gmail.com>
References: <3PGKXQ.OUNHZGPTI7091@ixit.cz>
        <CA+ASDXOHFijzJeRFEFy6okgNYNZKdc6HZtzZ9-6mdkYEfzL-2g@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you,

you're right, I messed up Reply-to. I'll follow the Option 2.

Thank you
Best regards
David Heidelberg

On Mon, Aug 9 2021 at 12:01:45 -0700, Brian Norris 
<briannorris@chromium.org> wrote:
> (NB: I think your Reply-To header was wrong, so I've chosen to modify
> that in hopes of actually reaching you.)
> 
> On Mon, Aug 9, 2021 at 2:52 AM David Heidelberg <david@ixit.cz> wrote:
>>  since I noticed this issue is very common (at least for me and some
>>  others) on 4.14 kernels [1] [2] would you think that backporting 
>> this
>>  patch into stable would make sense? I assume that at some point it
>>  could help some OpenWRT/LEDE and other devices (since for Turris 
>> it'll
>>  be most likely backported anyway).
>> 
>>  Thank you for the working on this!
>>  David
>> 
>>  [1]
>>  
>> https://forum.turris.cz/t/5-2-4-patch-wifi-fails-after-while-wmi-mgmt-tx-queue-is-full/15510
>>  [2] https://forum.turris.cz/t/unstable-wifi-on-mox-b/11065/
> 
> Seems reasonable to me. The right way to submit such a request is
> documented here:
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Because this wasn't identified as a -stable candidate when first
> submitted, you'll need either Option 2 or Option 3.
> 
> Regards,
> Brian


