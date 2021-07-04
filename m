Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5493BADC4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jul 2021 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhGDQR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jul 2021 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhGDQR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jul 2021 12:17:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DAC061574
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jul 2021 09:14:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 10so3224107oiq.9
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jul 2021 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XvS5s0+DQUCZDJ3/gVR/qqIkg86aDxwyHLGenUJ1igw=;
        b=MCs4wAabgek7RQXfj2X9EoxFHqHJMQTzE0OzCo9ezE5wcXNi9QX7bCusnoVscFvkm/
         SHWEmKIJ04Q4nWPuQOqaiPxXemaNV9VqKCrPddiMtWGEcoyx5O7IYOTpTvEfwd0o/V94
         nLn6nJSfal6TuahhNXkRd+jHyBTuj7M3xDrcIxpxbc8TpxVVvyFLX9jev6i/H7UDv9bE
         5KEbqj6MYGKxiIpkPSvp2pb9aMG0B30CKNLRjvDnz6oX7JFwn4bMj7vXaXxa/x7Io9FA
         iGTHXCXKoG9Oy6e42PqdapOcY3Rx+/IwnjyIAuHcAZqC9YoJr7f0O+ca01B0yrTs0hxf
         nspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvS5s0+DQUCZDJ3/gVR/qqIkg86aDxwyHLGenUJ1igw=;
        b=HRN5lLhuXEsb00w26DjoAnAGBE0Q7nvM6h6s55QC/OavDuseiCrIyeFqvHOTMtJjb4
         5chlzxYM/ZO6dgAR897MPSIDYsJuo/49vytOKM4yBvvRQq8HN5O6Jcl6Ko3z1uJiDUxT
         3e80W9Yr63Kon/UcO97N6i1n9Ze07RXaa8tmsAjdi4piKSBbGp4cVobF09AikiU9fqyo
         PMzU8uOh/79fRkq0RIjvU+QehvhHb967UfsMeDcdYyzPOpVyk3OMuANRUG7LzmIzWidX
         RyihNy57e5XB8qEgvyPzG9VSQL/NBkM2EUNODwxEHTA7DsnFa3jMWQQsIzhzu1NcnntQ
         kDQQ==
X-Gm-Message-State: AOAM533dauQqWTDkvblJ1EwdkIc3MegqCv1j+92YxrsGrNjgivCIVTvu
        +D675NwnF9w2KN/e2Z96PjOxECNSm/o=
X-Google-Smtp-Source: ABdhPJzNi0Ws2oDQ8hfwEjV+i2IJIwIWQN8Cc4LWCjezpYZL+GYhTNINR2SqieeEb3oDrGB7xH9vZA==
X-Received: by 2002:aca:4f83:: with SMTP id d125mr7131646oib.117.1625415291668;
        Sun, 04 Jul 2021 09:14:51 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id y193sm2157990oia.48.2021.07.04.09.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 09:14:51 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Make Issues
To:     Dan Clark <D@nielClark.com>, linux-wireless@vger.kernel.org
References: <3b25cb09-02f8-c35e-c564-f3abac4d6a32@nielClark.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <49a79dcf-565a-47a6-be2b-ec138c10ace4@lwfinger.net>
Date:   Sun, 4 Jul 2021 11:14:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b25cb09-02f8-c35e-c564-f3abac4d6a32@nielClark.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/4/21 6:33 AM, Dan Clark wrote:
> Dear L. W. Finger,
> 
> I'm a new Linux user and I'm trying to follow your rtw89 guide to install the 
> code for my Realtek 8852AE WiFi drivers.
> 
> When running the make command i run into issues, I've included the terminal 
> output so far. Any advice on how to proceed or about what I may be doing wrong?
> 
> Thanks in advance,
> 
> Dan
> 
> 
> dan@Legion-5-15ACH6H:~$ git clone https://github.com/lwfinger/rtw89.git -b v5
> Cloning into 'rtw89'...
> remote: Enumerating objects: 364, done.
> remote: Counting objects: 100% (364/364), done.
> remote: Compressing objects: 100% (219/219), done.
> remote: Total 364 (delta 250), reused 250 (delta 142), pack-reused 0
> Receiving objects: 100% (364/364), 1.17 MiB | 2.13 MiB/s, done.
> Resolving deltas: 100% (250/250), done.
> dan@Legion-5-15ACH6H:~$ cd rtw89
> dan@Legion-5-15ACH6H:~/rtw89$ make
> make -C /lib/modules/5.11.0-22-generic/build M=/home/dan/rtw89 modules
> make[1]: Entering directory '/usr/src/linux-headers-5.11.0-22-generic'
>    CC [M]  /home/dan/rtw89/core.o
>    CC [M]  /home/dan/rtw89/debug.o
>    CC [M]  /home/dan/rtw89/mac80211.o
>    CC [M]  /home/dan/rtw89/mac.o
>    CC [M]  /home/dan/rtw89/phy.o
>    CC [M]  /home/dan/rtw89/fw.o
>    CC [M]  /home/dan/rtw89/rtw8852a.o
>    CC [M]  /home/dan/rtw89/rtw8852a_table.o
>    CC [M]  /home/dan/rtw89/rtw8852a_rfk.o
>    CC [M]  /home/dan/rtw89/rtw8852a_rfk_table.o
>    CC [M]  /home/dan/rtw89/cam.o
>    CC [M]  /home/dan/rtw89/efuse.o
>    CC [M]  /home/dan/rtw89/regd.o
>    CC [M]  /home/dan/rtw89/coex.o
>    CC [M]  /home/dan/rtw89/ps.o
>    CC [M]  /home/dan/rtw89/sar.o
>    CC [M]  /home/dan/rtw89/ser.o
>    CC [M]  /home/dan/rtw89/util.o
>    LD [M]  /home/dan/rtw89/rtw89core.o
>    CC [M]  /home/dan/rtw89/pci.o
> /home/dan/rtw89/pci.c:598:18: warning: ‘struct rtw89_pci_isrs’ declared inside 
> parameter list will not be visible outside of this definition or declaration
>    598 |           struct rtw89_pci_isrs *isrs)
>        |                  ^~~~~~~~~~~~~~
> /home/dan/rtw89/pci.c: In function ‘rtw89_pci_recognize_intrs’:
> /home/dan/rtw89/pci.c:600:6: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    600 |  isrs->halt_c2h_isrs = rtw89_read32(rtwdev, R_AX_HISR0) & 
> rtwpci->halt_c2h_intrs;
>        |      ^~
> /home/dan/rtw89/pci.c:601:6: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    601 |  isrs->isrs[0] = rtw89_read32(rtwdev, R_AX_PCIE_HISR00) & 
> rtwpci->intrs[0];
>        |      ^~
> /home/dan/rtw89/pci.c:602:6: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    602 |  isrs->isrs[1] = rtw89_read32(rtwdev, R_AX_PCIE_HISR10) & 
> rtwpci->intrs[1];
>        |      ^~
> /home/dan/rtw89/pci.c:604:40: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    604 |  rtw89_write32(rtwdev, R_AX_HISR0, isrs->halt_c2h_isrs);
>        |                                        ^~
> /home/dan/rtw89/pci.c:605:46: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    605 |  rtw89_write32(rtwdev, R_AX_PCIE_HISR00, isrs->isrs[0]);
>        |                                              ^~
> /home/dan/rtw89/pci.c:606:46: error: invalid use of undefined type ‘struct 
> rtw89_pci_isrs’
>    606 |  rtw89_write32(rtwdev, R_AX_PCIE_HISR10, isrs->isrs[1]);
>        |                                              ^~
> /home/dan/rtw89/pci.c: In function ‘rtw89_pci_enable_intr’:
> /home/dan/rtw89/pci.c:612:29: error: ‘RTW89_PCI_FLAG_DOING_RX’ undeclared (first 
> use in this function)
>    612 |  if (exclude_rx || test_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags))
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/dan/rtw89/pci.c:612:29: note: each undeclared identifier is reported only 
> once for each function it appears in
> /home/dan/rtw89/pci.c:612:60: error: ‘struct rtw89_pci’ has no member named ‘flags’
>    612 |  if (exclude_rx || test_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags))
>        | ^~
> /home/dan/rtw89/pci.c: In function ‘rtw89_pci_interrupt_threadfn’:
> /home/dan/rtw89/pci.c:634:24: error: storage size of ‘isrs’ isn’t known
>    634 |  struct rtw89_pci_isrs isrs;
>        |                        ^~~~
> /home/dan/rtw89/pci.c:634:24: warning: unused variable ‘isrs’ [-Wunused-variable]
> /home/dan/rtw89/pci.c: In function ‘rtw89_pci_ops_start’:
> /home/dan/rtw89/pci.c:1180:12: error: ‘RTW89_PCI_FLAG_DOING_RX’ undeclared 
> (first use in this function)
>   1180 |  clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
>        |            ^~~~~~~~~~~~~~~~~~~~~~~
> /home/dan/rtw89/pci.c:1180:43: error: ‘struct rtw89_pci’ has no member named 
> ‘flags’
>   1180 |  clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
>        |                                           ^~
> /home/dan/rtw89/pci.c: In function ‘rtw89_pci_napi_poll’:
> /home/dan/rtw89/pci.c:2792:10: error: ‘RTW89_PCI_FLAG_DOING_RX’ undeclared 
> (first use in this function)
>   2792 |  set_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
>        |          ^~~~~~~~~~~~~~~~~~~~~~~
> /home/dan/rtw89/pci.c:2792:41: error: ‘struct rtw89_pci’ has no member named 
> ‘flags’
>   2792 |  set_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
>        |                                         ^~
> /home/dan/rtw89/pci.c:2803:44: error: ‘struct rtw89_pci’ has no member named 
> ‘flags’
>   2803 |   clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
>        |                                            ^~
> make[2]: *** [scripts/Makefile.build:287: /home/dan/rtw89/pci.o] Error 1
> make[1]: *** [Makefile:1848: /home/dan/rtw89] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-5.11.0-22-generic'
> make: *** [Makefile:52: all] Error 2
> 

Dan,

It is now fixed. Do a 'git pull'.

Larry
