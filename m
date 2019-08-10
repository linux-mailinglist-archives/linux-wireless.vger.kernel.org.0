Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7488C6B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHJRQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 13:16:51 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43281 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJRQv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 13:16:51 -0400
Received: by mail-ot1-f51.google.com with SMTP id e12so471235otp.10
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2019 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dyo9npJ9gkT4wSxsq+2Y1h9P+q7j8n3um5cYa+RLBrQ=;
        b=OyNa6Neqxoue5/S7shexOtGofroymcDg+zwka4O7RjoKRZTluBtA27h8KQvq7QfIrg
         7h2xHp9pzbz64tbsIGekWsKAFLxwX6BF7YV3tERVF68hNaGX35hVVggJxuN4Y0OwEPyT
         GRbkNPsJ0hk15cMZEnMcGPSaUTNnsmuO/9BdDE2KmlAlrrYp81vE48s3xrsM6DoK1let
         EcSLfu9Z5TX8x8qx7N9XJPxOk6noIk7xVuypu3O5dwVpAU/nkaYAoiLq/91GcJXvYbc6
         0PDiGMXJDvOYKB45X4eRkz7Gr71bdpz19+AjKgbQ2KJy01VbGlc3Bjg5VbsHIljH+X0g
         U86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dyo9npJ9gkT4wSxsq+2Y1h9P+q7j8n3um5cYa+RLBrQ=;
        b=F0yBL0ZHEcMjy2kDgfGFyejcQnRW+8FDTZrdSFwg4PYsYCftrqXZkiMW7vAlJ9VFof
         r4u7itEYgaTP+ViEON1O9gGKJ4mIuI73YKl88+YLmxNuQI6At8XvxahaTIPGkBkTzdFu
         GHh5ZU3oCbBswdQtChtTgtiLwoh55HkGnOM0Oh1+BIjmTXqV6fFfDpeXRrUX1NWVJ7XO
         5aRmAJ54suyF9ZKNrq0PeJd0ibp2lqGmY2dfWu7L/YzlDpccfW+ohNA8FgcS/cfS+1u8
         /vEup7mD36sBvdehnNmIpvoBmuE/0wb6ABW6DYky84usRkfJKJPmG39yotPXzuFjsjoG
         gxWw==
X-Gm-Message-State: APjAAAVuKvpmeK+ApM782Gj4//A/zuLGvRshktGshRwctQNUHPBHV0IZ
        wurhTaUAbLi/EcRryLo//rWMhPXc
X-Google-Smtp-Source: APXvYqxvH6/vAz6nAzAy+fxhDPSXER1XnRZjInncQSEdNh0G5sZpMsEAgfPV1WVb2VZBHJaCpEsGEw==
X-Received: by 2002:aca:4711:: with SMTP id u17mr10533916oia.115.1565457410169;
        Sat, 10 Aug 2019 10:16:50 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 9sm30960616oij.25.2019.08.10.10.16.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 10:16:49 -0700 (PDT)
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Sergey Kharitonov <haritonovsb@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
Date:   Sat, 10 Aug 2019 12:16:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/9/19 12:25 AM, Sergey Kharitonov wrote:
> Dear Linux-Wireless,
> Some time ago a bug was reported
> https://bugzilla.kernel.org/show_bug.cgi?id=202943 related to
> rtl8192ee, the essence of which is high ping latency (even to the
> access point) without downloading something. If you generate a network
> load with a background download or just ping -i 0.001 -s 512.... the
> latency stabilizes and stays low.
> I tested my TP-Link TL-WN881ND v2 adapters (I got two of them in my
> PCs plugged in different motherboards (ASUS and MSI)) and the problem
> still persists in kernel 5.2.6 (archlinux current default). Just to
> mention, I tested with different module options and also two available
> firmwares I found (rtlwifi/rtl8192eefw.bin and
> rtlwifi/rtl8192eefw_new.bin).
> Would you please take some time to look at the bug? I can provide any
> additional information needed.
> Please let me know if we can make rtl8192ee driver better.

Sergey,

I have plans to make some improvements on the driver, and I will investigate 
your issue.

I do handle the issues on the drivers I have posted at GitHub.com under the user 
lwfinger, and I follow this list, but I do not look at the kernel bugzilla for 
Realtek wifi issues.

Larry

