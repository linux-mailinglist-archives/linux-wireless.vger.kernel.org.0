Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD352263398
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIRG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:06:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgIIPjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:39:05 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kG0eZ-0003l9-DD
        for linux-wireless@vger.kernel.org; Wed, 09 Sep 2020 14:00:51 +0000
Received: by mail-pj1-f71.google.com with SMTP id ic18so1724725pjb.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 07:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UerQpWjJx3zsxSv3XMGQ5IVVVoYrVWKrJqPq+tgaZ10=;
        b=kx1tYh/G0XLsEaQTJEkL9+kEpDBBoDzt/buUcc4RjQXZLtIqKfezQpelxpwD0Qp/Ff
         q9f2b19gQXEkZTB/NouOrnkzKS70Zb9taB14tqMdVao88wXCwemhvu2jZDSldAAPOdmP
         y7iURlqw94fkZJfJt7BdAHFmW3OBgv0HktsO5t9sJOM+uGj63bR22XonwKUgvFlJd7zw
         YFwHd2d7YARnm22JFaIOWmrjgf+XGo4IhuRd5XJ/VMpviXJerPc1MKYkQmpsd9ubUoav
         61kEWpTGKxKS1E8FkKyzFPE2hdoZIf928IGZVxQXM1XJSwsPzpjzaDTBJRhjEKvH+BQV
         HmcQ==
X-Gm-Message-State: AOAM533JWe+N2IEHLgeKtD/AMpgUzoZsxFb6fugvHS9te80EzBMl5aww
        kb+uDhkBaFfcmolcqGiSleI8pCDuvWepmwLRVaamVzc24qo1+UL4c7TOfCe+DvVSsvM/XCbk2VK
        6+0zB2WaOgcf4zDpz2zDZyAoBSewAQOILGybiY/KJ3hhT
X-Received: by 2002:a17:90a:528a:: with SMTP id w10mr920284pjh.107.1599660049893;
        Wed, 09 Sep 2020 07:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAVNY/MPKZMX7OIaxd4G9JHrM+Ztrkv6RcCSI8EBNgFRgFk435b1SjpHlYvCKVazyifx3ojQ==
X-Received: by 2002:a17:90a:528a:: with SMTP id w10mr920244pjh.107.1599660049443;
        Wed, 09 Sep 2020 07:00:49 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id n7sm2871604pfq.114.2020.09.09.07.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:00:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] rtw88: pci: Power cycle device during shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
Date:   Wed, 9 Sep 2020 22:00:45 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2AE780E-6ED6-4732-8A51-D6431E472C7E@canonical.com>
References: <20200824093225.13689-1-kai.heng.feng@canonical.com>
 <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Aug 26, 2020, at 08:27, Brian Norris <briannorris@chromium.org> wrote:
> 
> On Mon, Aug 24, 2020 at 2:32 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Sometimes system freeze on cold/warm boot when rtw88 is probing.
>> 
>> According to [1], platform firmware may not properly power manage the
>> device during shutdown. I did some expirements and putting the device to
>> D3 can workaround the issue.
>> 
>> So let's power cycle the device by putting the device to D3 at shutdown
>> to prevent the issue from happening.
>> 
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206411#c9
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Can you at least include some more details, like which hardware
> version and firmware?

8723DE, 8822BE and 8822CE are affected [1].

> And which platform?

Many x86 laptops.

Some users claim BIOS update can fix the issue, however some are still affected.

> It seems a bit harsh to
> include a platform workaround to run for everyone, unless there's
> truly no downside. But even then, it's good to log what you're working
> with, in case there are ever problems with this in the future.

Ok. I can send V2 with more detailed commit message.

[1] https://bugs.launchpad.net/bugs/1872984

Kai-Heng

> 
> Brian

