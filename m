Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBE9642B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfHTPVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:21:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50963 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHTPVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:21:50 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i05xD-0008OY-PT
        for linux-wireless@vger.kernel.org; Tue, 20 Aug 2019 15:21:48 +0000
Received: by mail-pl1-f197.google.com with SMTP id t2so4305669plq.11
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 08:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gg4UWhjzg+SPpftjkPGG7/RD9yTU+a1qg/GcmIh9oGU=;
        b=MobVPmv5PNVWYQ+KkFRNU7F6CGzxmPi822kNca+5gikXzaSvKaKh09zvl8a14Kn06S
         uM7CBEvGJlmsIlWuB/2/LfPwFwQ5BDc0RabwfGU+EkxFfhFdSGyzSzvfs5TjH11+OZDt
         x9X8sEz7jH5e02PD2nxgZMwGqYxwcN+Two/UDMjdaHFW4oPAOsFmnNbansxvyPfcH339
         B/wrA950Tkvkr7A+xOF2orQ8Xo6+QG2P2Yxe2Ldpf+jeoh/b3ciDpBNIBPvz+ww8JdAQ
         RYoRjQZOmxly8BzuZ8iusFLOur2bQ36TK9QVT683Yk36xfrbu+4mOyjsRG/TUhw8gkm4
         u++A==
X-Gm-Message-State: APjAAAVnhhlMb5LBBN6qlWXqn7ErkF2amb7OOLDXZnn51edUrL2kEC/p
        jOPP9lG149pbHLhU5lhw9gATts1xVURSokai4Ma0ZS0J2qEfBJCWVlkRQqQk64JJpl7KDhWdmuc
        O692r9W7VieWTUvY1On67v560pvdrIGbCfoi2cvu3zYjA
X-Received: by 2002:a63:5b23:: with SMTP id p35mr24637466pgb.366.1566314506429;
        Tue, 20 Aug 2019 08:21:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQvy34A5FPpPrC6Pj2xbhJsTTD2MtC2IkGXVZICXluakh8q47ob3atBkv875VDD5XH5cW9EA==
X-Received: by 2002:a63:5b23:: with SMTP id p35mr24637442pgb.366.1566314506005;
        Tue, 20 Aug 2019 08:21:46 -0700 (PDT)
Received: from 2001-b011-380f-3c42-fd52-eb03-2880-db41.dynamic-ip6.hinet.net (2001-b011-380f-3c42-fd52-eb03-2880-db41.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:fd52:eb03:2880:db41])
        by smtp.gmail.com with ESMTPSA id b13sm220596pjz.10.2019.08.20.08.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:21:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
Date:   Tue, 20 Aug 2019 23:21:41 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely@gmail.com" <jano.vesely@gmail.com>
Content-Transfer-Encoding: 8bit
Message-Id: <1F1A57A7-3240-4595-B4A9-EF28A54B77E0@canonical.com>
References: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
 <20190730195703.GA224792@google.com>
 <F7CD281DE3E379468C6D07993EA72F84D18855BB@RTITMBSVM04.realtek.com.tw>
 <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

at 00:51, Brian Norris <briannorris@chromium.org> wrote:

> On Thu, Aug 1, 2019 at 2:21 AM Tony Chuang <yhchuang@realtek.com> wrote:
>>> Subject: Re: [PATCH] rtw88: pci: enable MSI interrupt
>>> On Tue, Jul 30, 2019 at 07:50:14PM +0800, yhchuang@realtek.com wrote:
>>>> --- a/drivers/net/wireless/realtek/rtw88/pci.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
>>>> @@ -874,6 +878,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int  
>>>> irq,
>>> void *dev)
>>>>    if (!rtwpci->irq_enabled)
>>>>             goto out;
>>>>
>>>> +   rtw_pci_disable_interrupt(rtwdev, rtwpci);
>>>
>>> Why exactly do you have to mask interrupts during the ISR? Is there a
>>> race in rtw_pci_irq_recognized() or something?
>>
>>
>> I think there is a race between SW and HW, if we do not stop the
>> IRQ first, write 1 clear will make the interrupt to be lost.
>
> This doesn't need to slow down this patch (I think v2 is fine), but I
> still don't quite understand. Before this addition, the sequence is:
> (a) read out your IRQ status
> (b) ack the un-masked IRQs you see
> (c) operate on those IRQs
>
> Even if a new IRQ comes in the middle of (b), shouldn't it be
> sufficient to move on to (c), where you're still prepared to handle
> that IRQ?
>
> Or if the IRQ comes after (b), you won't ACK it, and you should
> immediately get a new IRQ after you return?
>
> I guess that's assuming that these registers are Write 1 to Clear. But
> if so, that means rtw_pci_irq_recognized() is effectively atomic, no?
>
> Also, somewhat unrelated: but why do you unmask HIMR1, when you're not
> actually handling any of its IRQ bits?

According to user feedback [1], this patch makes rtw88 work.
I’ll make it merged into Ubuntu’s kernel for now, hopefully this will be in  
upstream version soon.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1838133/comments/48

Kai-Heng

>
> Brian
>
>>>>    rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
>>>>
>>>>     if (irq_status[0] & IMR_MGNTDOK)


