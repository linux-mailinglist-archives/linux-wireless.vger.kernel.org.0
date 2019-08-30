Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39479A3F0D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfH3UgP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 16:36:15 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36050 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3UgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 16:36:14 -0400
Received: by mail-ot1-f47.google.com with SMTP id k18so8199153otr.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QRUvOObB2bApT9R/NlY0yu/F4vFRVuVcOjsOEt25/VM=;
        b=RVl3laEvYLI/AyeqKcMJR9zxhlv8PZ4JO3OMGdeSqaPbx+iInPD2sb7+wxOMKd2PvI
         RmMIWsE8h2zCe4ZZibGm3GnPK1WZqVvWAI7LnM2u9f84qAGAVfQPVUs8KuQMv04rpwmB
         /WfmVWTf7I8RwX0FoADYLKQ4EGcpaQBu5tdPMe+SuXWVO9uFC7hU003CW8E4NfBcKTCM
         ictf7zgZO7Va/zWxkcjQkasVDiSu/XLJ8yxuYNvSwQT6cA+gdR6K+SK6uGu/voryRUKg
         TxWs70jB5wN0fPTIixo7ij1p+Hy21W4Cpu5S9yprrp76mA+evIo5aLNhgY1uHFmxWOQV
         EL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRUvOObB2bApT9R/NlY0yu/F4vFRVuVcOjsOEt25/VM=;
        b=GIT5oR5xsC9gG7EUUDb1GX+sQCygwXhNFRh4EmUZGCbUl5hLyxHHnVLE7wOkZqe+Q+
         /9Xd1K9K7WlHg6ei++CLzMdyG+Kx2UMuvjfNfA5MrJeodzxSIUJkPzyWHdEQ3LzvHrxJ
         hrwCd1k/xpmzQHIiATyg20DQeqZSZIqo1be4tsrFliSBpXwv/xzZQr7nxKGd/j6pOrTh
         JSJy9krA8yckyRSrQhitV9RsI41JnO/u7ypLTccACqn/ePQl1I4mnrzEWxwqGtWCKVe5
         Qzi+x/mCrjWMWCNlvKgRq4jvFjMTA2OfxIeYHIXIBnURVHgkrUYjdMksj94MqMvEbfsM
         rhAg==
X-Gm-Message-State: APjAAAXsLutHReYOBOsT1B+lUfQ3TmFLj2ayhnGegt7XSg6PWjIHLywU
        3l2YUG05P3x21YrJSPoKkYnXroT8
X-Google-Smtp-Source: APXvYqwdr8A2ST9SabeotOdhbjtK6/Vku72LlH1AAF+rtWKxC8i8jBc2BG20EkbfUAoneWA5/c87ZQ==
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr13341525otq.221.1567197373748;
        Fri, 30 Aug 2019 13:36:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k6sm2399512otp.57.2019.08.30.13.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 13:36:12 -0700 (PDT)
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Sergey Kharitonov <haritonovsb@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
 <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net>
Date:   Fri, 30 Aug 2019 15:36:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
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

I have completed but not yet sent some updates for rtl8192ee. Using them and 
kernel 5.3-rc6, I am getting the following:

--- 192.168.1.1 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99134ms
rtt min/avg/max/mdev = 0.881/1.487/8.198/0.844 ms

This is using the "old" firmware with the following md5sum:

c8d25646cbc9efdcb818fc95ad5836a9  /lib/firmware/rtlwifi/rtl8192eefw.bin

The new driver patches convert a set of macros to read and write the descriptors 
into inline routines. The calling sequences are also converted from u8 * to 
__le32 *, but I would not expect much improvement with the latter changes.

Using a local speed test web site, I am getting 100 Mbps download and 80 Mbps 
upload rates.

Larry



