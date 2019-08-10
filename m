Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6B88D12
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfHJTpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 15:45:18 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36602 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJTpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 15:45:18 -0400
Received: by mail-ot1-f43.google.com with SMTP id k18so13381885otr.3
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2019 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cEjxnBDQT9xC+Upr3ugrYInA03HpwyrxHbJXvDdGzqY=;
        b=p/TBU64ZFp0S+RM5l2e3o5Hv3ucsxcfyFLI8PColNYdwO/Ae6dfH2caBk2ltQZTl6K
         xWT/YYlNj/2Lg7Z8SFL1U4kocZfXmAVdH29cb8lLuK0fwdKyFQeAOdLNLuNtokH292vc
         oQvuzdtn0D1hQC5LO9GoHRdo1i7gZk8wGfYIcI5yKC3VbJ6AVsd1FU3JkxO+eJkiE+Co
         K1DdSOOwko40YVALEzuS2CgaJZUe5NthkyGmPvSqx3rwijqLhuzDSlI75vA+CqZ4he4n
         gt4puXULOwW1gHl2uB7kHhadHexKKwWno+CiPnKuvvEF6amogwv01qSCYjB54SBBHbO8
         C54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cEjxnBDQT9xC+Upr3ugrYInA03HpwyrxHbJXvDdGzqY=;
        b=bQgGCdM3fuYQgpUmAydN0pxquvCzqVFDQb6iJXeE9ie3OsI6QzBMB0p8MamvhXplIb
         CSRvDX/kMlFxlc+MIad0gY/xYqdXgVVqBVDcYVsvb3W/ui1M5TN55esDQBH6FhnyGf1W
         kOvp/2x8lhLh+T2R9dM8+K5VF0XQTv4QpCuzjQTwDy0zaUqPSnS6ltthZYP9LN22jz/u
         wden9VBWSY462NWnjTkbcZWQurOImBPNH/2QHZQu8HVKEmqc3mrGIk6dVBVeeR0Pk0rt
         q0redhOFm7Jm2fKOAyCObwL6DhxPGD5WzrPTjIeVxKtFJiHLocoSOMVnU1gz0Btegr49
         uvTA==
X-Gm-Message-State: APjAAAUIRpyjLyQ+qstJz4NswPKoUYNto6TFpTSGIHWrWAyqj/NgEMhH
        UtgC7hO1B6to5feOEWMvBr1fGDmg
X-Google-Smtp-Source: APXvYqyDK81u1S9dkaytUlpN8cp5QfEcgJGNc3KJESLZ88OFS0thgyNmiJmJSY5pl6Cbf3QErdcb1g==
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr24394253otq.262.1565466317057;
        Sat, 10 Aug 2019 12:45:17 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s2sm33021394oif.46.2019.08.10.12.45.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 12:45:16 -0700 (PDT)
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Sergey Kharitonov <haritonovsb@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
 <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <cd9429e4-96dc-42dd-9dd6-b3ca46cac9bb@lwfinger.net>
Date:   Sat, 10 Aug 2019 14:45:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/10/19 1:13 PM, Sergey Kharitonov wrote:
> Dear Mr. Finger!
> Thank you for paying attention to the problem. I've just posted an
> updated information to that bug before receiving this message.
> 
> I get these results
> ~]$ ping 192.168.88.1
> PING 192.168.88.1 (192.168.88.1) 56(84) bytes of data.
> 64 bytes from 192.168.88.1: icmp_seq=1 ttl=64 time=0.746 ms
> 64 bytes from 192.168.88.1: icmp_seq=2 ttl=64 time=0.868 ms
> 64 bytes from 192.168.88.1: icmp_seq=3 ttl=64 time=0.853 ms
> 64 bytes from 192.168.88.1: icmp_seq=4 ttl=64 time=0.868 ms
> 64 bytes from 192.168.88.1: icmp_seq=5 ttl=64 time=0.818 ms
> 64 bytes from 192.168.88.1: icmp_seq=6 ttl=64 time=0.844 ms
> 64 bytes from 192.168.88.1: icmp_seq=7 ttl=64 time=0.841 ms
> 64 bytes from 192.168.88.1: icmp_seq=8 ttl=64 time=0.913 ms
> 64 bytes from 192.168.88.1: icmp_seq=9 ttl=64 time=0.844 ms
> 64 bytes from 192.168.88.1: icmp_seq=10 ttl=64 time=0.886 ms
> ^C
> --- 192.168.88.1 ping statistics ---
> 10 packets transmitted, 10 received, 0% packet loss, time 387ms
> rtt min/avg/max/mdev = 0.746/0.848/0.913/0.044 ms
> 
> with a driver from rtl8192ee_revised.tar.bz2 file in
> https://github.com/lwfinger/rtlwifi_new/tree/extended repository built
> against Linux 4.19.65-1-lts ArchLinux current LTS kernel.
> 
> Connection speed and stability on a heavy load are also perfect.
> 
> Hope this info would help solving current rtl8192ee problem.
> 
> Please let me know if any additional info is needed.

That driver is totally different from the one in the kernel. It comes from the 
group that writes the combined drivers for Windows, FreeBSD, and Linux. The 
coding there is  completely inappropriate for inclusion in the kernel. I'm glad 
that it works for you.

I will use its PCI communications to see what it does differently from the 
kernel version, and I will extract the embedded firmware in that driver and try 
it with the kernel driver.

Larry



