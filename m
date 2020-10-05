Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23662841A5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgJEUqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEUqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 16:46:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1280C0613CE
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 13:46:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l85so10124949oih.10
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+uNhD+4AgMJ3UI4o+Rf2/frVQbx9NhA9mvczUyfdx8k=;
        b=LZbLanhaLkK3jbmuKVsaVBdvPbFwsIA7w97nYACfSPk8Py+epzYGvEQ7s8GuCi8ZO6
         w8dVjZQrcXnb6e34fdDbhoDpG4uwt9PzGy0ytEuCT9I3kM7ad0pdKqtQvqgWzdQ9Q2jb
         5slRguFFvc+QvCawGCTuwuqr8Bbnfg9foN4k1BDoLnPEn2G5qO56bN7VXzKaPAqWJBQF
         9xaYxTXi/stwEfPGopbA9bjS5Uo2QRD+fPgKhdvyaVHgNI4QdwjQAu42p2AHrlTyeuzb
         dN6Lt6piFTNJBxioQZh9mCo2b0LGaV5PLIObN0rlcv/nHqVEOBpEoHwogxAF8SIRU+IM
         smGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+uNhD+4AgMJ3UI4o+Rf2/frVQbx9NhA9mvczUyfdx8k=;
        b=g3WrPteDKRU2wv4GOokWukQnUxzkgjX/Q4cj0RVkPOYQemon7QV6szRYWV2xSOaVFK
         CS+pBTpbB2Fo3vQWqy1Bg6Q+wcGSj3Tw5mTj7/ubR/szT2ZYgB3u79qwtlYQ5IIkfE2Y
         f+5HuelzVXVxgIpbud7Z4KRl5xtc670ahaEhmkmaTlwz12Y9fihnuk3MVnpYtUN4rI9O
         PRvh7uNmvykauKbNMFDnS0zIvb6di/uUWedcEomWU+3QnM/8N3mWx2s0EwMQ0oZfocRd
         3/YWfeOtMt3EfZu5PXR9fmb3WQZTuWLOob2Ku8vJANISoktmdTlvgA7ihslccKCKHnBZ
         OBRg==
X-Gm-Message-State: AOAM533XM1OMKkP0bnRUgG+ku3eqdcYnsSPy2Dq1dn6P6ODzOHaFaUcW
        6FJBtIsgjzAz7lqcoOGYBXAlZUDEBiM=
X-Google-Smtp-Source: ABdhPJwwHptasxnkZoc3J0B29BQLHJLuyybelqXTA1UtMqOQtPY18gwlWvX9anSLZJIYmNGiIptd1Q==
X-Received: by 2002:aca:da8b:: with SMTP id r133mr729831oig.163.1601930776111;
        Mon, 05 Oct 2020 13:46:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i23sm308823oos.17.2020.10.05.13.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:46:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Cristian Llanos <cristian.llanos@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
Date:   Mon, 5 Oct 2020 15:46:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/5/20 2:46 PM, Cristian Llanos wrote:
> Hi, my name is Cristian, I'm writing from Chile
> 
> I'm trying to install the driver for my RTL8821CE card. I'm following
> the instructions from the repo https://github.com/lwfinger/rtw88 (I
> took the email from there) but when I try to run the "make" command, I
> get the following error:
> 
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> ‘rtw_core_init’:
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> implicit declaration of function ‘tasklet_setup’
> [-Werror=implicit-function-declaration]
>   1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> 
> 
> this is the output from "sudo lshw -C network" and the full log of the error.
> 
> ===========
> 
> 
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
> sudo lshw -C network
>    *-network
>         description: Ethernet interface
>         product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>         vendor: Realtek Semiconductor Co., Ltd.
>         physical id: 0
>         bus info: pci@0000:01:00.0
>         logical name: enp1s0
>         version: 15
>         serial: 84:2a:fd:5a:7f:6e
>         capacity: 1Gbit/s
>         width: 64 bits
>         clock: 33MHz
>         capabilities: pm msi pciexpress msix bus_master cap_list
> ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd
> autonegotiation
>         configuration: autonegotiation=on broadcast=yes driver=r8169
> firmware=rtl8168h-2_0.0.2 02/26/15 latency=0 link=no multicast=yes
> port=MII
>         resources: irq:19 ioport:4000(size=256)
> memory:80504000-80504fff memory:80500000-80503fff
>    *-network UNCLAIMED
>         description: Network controller
>         product: RTL8821CE 802.11ac PCIe Wireless Network Adapter
>         vendor: Realtek Semiconductor Co., Ltd.
>         physical id: 0
>         bus info: pci@0000:02:00.0
>         version: 00
>         width: 64 bits
>         clock: 33MHz
>         capabilities: pm msi pciexpress cap_list
>         configuration: latency=0
>         resources: ioport:3000(size=256) memory:80400000-8040ffff
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
> 
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$ ls
> bf.c             debug.o         mac80211.o    phy.c
> rtw8723de.h       rtw8821c_table.c  rtw8822ce.c          sec.c
> bf.h             dkms.conf       mac.c         phy.h
> rtw8723d_fw.bin   rtw8821c_table.h  rtw8822ce.h          sec.h
> bitfield.h       efuse.c         mac.h         ps.c         rtw8723d.h
>         rtw8822b.c        rtw8822c_fw.bin      sign-file
> certificate.p12  efuse.h         main.c        ps.h
> rtw8723d_table.c  rtw8822be.c       rtw8822c.h           tx.c
> certificate.pem  fw.c            main.h        README.md
> rtw8723d_table.h  rtw8822be.h       rtw8822c_table.c     tx.h
> coex.c           fw.h            main.o        regd.c       rtw8821c.c
>         rtw8822b_fw.bin   rtw8822c_table.h     util.c
> coex.h           hci.h           Makefile      regd.h
> rtw8821ce.c       rtw8822b.h        rtw8822c_wow_fw.bin  util.h
> compiler.h       kernel_key.pem  openssl.conf  reg.h
> rtw8821ce.h       rtw8822b_table.c  rx.c                 util.o
> debug.c          key.pem         pci.c         rtw8723d.c
> rtw8821c_fw.bin   rtw8822b_table.h  rx.h                 wow.c
> debug.h          mac80211.c      pci.h         rtw8723de.c  rtw8821c.h
>         rtw8822c.c        sch_generic.h        wow.h
> 
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$ make
> make -C /lib/modules/5.4.0-42-generic/build
> M=/home/cristian/Downloads/realtek_drivers/rtw88 modules
> make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
>    CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> rtw_core_init:
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> implicit declaration of function tasklet_setup
> -Werror=implicit-function-declaration
>   1623   tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> 
> cc1: some warnings being treated as errors
> make2: *** scripts/Makefile.build:275:
> /home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
> make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw88 Error 2
> make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
> make: *** Makefile:79: all Error 2
> 
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
> sudo make install
> sudo password for cristian:
> make -C /lib/modules/5.4.0-42-generic/build
> M=/home/cristian/Downloads/realtek_drivers/rtw88 modules
> make1: Entering directory '/usr/src/linux-headers-5.4.0-42-generic'
>    CC M  /home/cristian/Downloads/realtek_drivers/rtw88/main.o
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c: In function
> rtw_core_init:
> /home/cristian/Downloads/realtek_drivers/rtw88/main.c:1623:2: error:
> implicit declaration of function tasklet_setup
> -Werror=implicit-function-declaration
>   1623 |  tasklet_setup(&rtwdev->tx_tasklet, rtw_tx_tasklet);
> 
> cc1: some warnings being treated as errors
> make2: *** scripts/Makefile.build:275:
> /home/cristian/Downloads/realtek_drivers/rtw88/main.o Error 1
> make1: *** Makefile:1731: /home/cristian/Downloads/realtek_drivers/rtw88 Error 2
> make1: Leaving directory '/usr/src/linux-headers-5.4.0-42-generic'
> make: *** Makefile:79: all Error 2
> 
> cristian@cristian-HP-240-G7-Notebook-PC:~/Downloads/realtek_drivers/rtw88$
> 
> 
> ===========

You need to do a git pull. The missing tasklet_setup was fixed on Sep. 26.

Larry

