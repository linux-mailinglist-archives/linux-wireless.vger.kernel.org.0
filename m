Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA982B1B64
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 13:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKMMw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 07:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgKMMw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99FC0613D1;
        Fri, 13 Nov 2020 04:52:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 7so13242240ejm.0;
        Fri, 13 Nov 2020 04:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuCJcUhyNAetcwF4fPhVBqozu/KcU1Q+RJ08yAHGbAA=;
        b=hUI0eBfqU0w1yExM6W8SAFrbZ6k1375+aLC32yarSsP7pWi8vwbxjN2MrKYHrGLzWh
         A5IQmJb/HLQuEe0p465ZG5dqwvOkKQeM5PrkKgI5W0zOimpZqNnCN251hl18Dwf2QE3V
         JbeBqrI7GWZ0T4Gl/bmfVIga0kQkoE1b3xi7t+Fbux3wl12EHD4PumpTm2pkAImahzF8
         OmB3nb1X4W48jGQYQlvCw+9OtjtX5FhHPDQqo4qnD5xHfrNevOOKYfUYwgsiEYj03DuT
         VjkNtIj3l8R9em53upaKiEa7RAsw/o5gpqopIbibrQNBDDrJ68B1rBAXYIZwETpKD0ON
         hpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuCJcUhyNAetcwF4fPhVBqozu/KcU1Q+RJ08yAHGbAA=;
        b=HAAhdreGunBkKeCE5CzNpSRftUrTz1HwVzL+zcslgnmvTUzRrd/0rEJaKYY0fMu+Fs
         rsTIkYzLHsDa0rgZAZOLwMg7I9dxMEpniiflnZVn6lj+TWiy49//lrLJorcDuXYtfSTF
         x6sRjLQXCTgrrf5/EnYTloJ0xtUIxWEmS+v9KM/cWqQl6dtDCmtNp81dI8TqKWOZEdQK
         TOjzegaw3K6ChJZRaQHJsNgpqoPDMhu9dKViV6IHw8/xTRd9F+NzQpjpa9EQZsOIdtuB
         +HJNaSZIGtT/yoXSgr3IsykqfLchYZkFSH0drcnIHaIKmrwp+97aBVelsZ10r3PCaCBh
         KSOA==
X-Gm-Message-State: AOAM532AOrNEFElGXknuU625UeQhwTaRFeYINdfnxNxj2aMruKayvOgf
        fR1M1W4AH9XT5UzhellyA1c=
X-Google-Smtp-Source: ABdhPJxg2vc9f758PsryEv65PE3xa58lduxKwj8uExD5gj4DBpIMrqU6DL4dO19CHRq1tD864opx2A==
X-Received: by 2002:a17:907:c05:: with SMTP id ga5mr1710885ejc.212.1605271947174;
        Fri, 13 Nov 2020 04:52:27 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:c3b4:9d8c:2c4a:f7c1? (2a02-a44f-d2f0-0-c3b4-9d8c-2c4a-f7c1.fixed6.kpn.net. [2a02:a44f:d2f0:0:c3b4:9d8c:2c4a:f7c1])
        by smtp.gmail.com with ESMTPSA id i21sm1607937edt.92.2020.11.13.04.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 04:52:26 -0800 (PST)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        ath11k@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org>
 <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
 <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
 <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org>
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Message-ID: <3e30ac52-6ad4-fa7b-8817-bca35a80d268@gmail.com>
Date:   Fri, 13 Nov 2020 13:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 13.11.2020 om 12:08 schreef Carl Huang:
> Checked some logs. Looks when the error happens, the physical address are
> very small. Its' between 20M - 30M.
> 
> So could you have a try to reserve the memory starting from 20M?
> Add "memmap=10M\$20M" to your grub.cfg or edit in kernel parameters. so ath11k
> can't allocate from these address.
> 
> Or you can try to reserve even larger memory starting from 20M.

That worked, booting with memmap=12M$20M resulted in the working wifi:

$ journalctl -b | grep -iP '05:00|ath11k|Linux version|memmap'
Nov 13 13:45:34 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34 
p6) 2.34.0) #1 SMP Fri Nov 13 13:29:48 CET 2020
Nov 13 13:45:34 razor kernel: Command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 
memmap=12M$20M quiet
Nov 13 13:45:34 razor kernel:   DMA zone: 64 pages used for memmap
Nov 13 13:45:34 razor kernel:   DMA32 zone: 5165 pages used for memmap
Nov 13 13:45:34 razor kernel:   Normal zone: 255840 pages used for memmap
Nov 13 13:45:34 razor kernel: Kernel command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 
memmap=12M$20M quiet ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 memmap=12M$20M quiet
Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 
0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Requested to power ON
Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Power on setup success
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x2100000 524288 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x2180000 524288 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x2200000 524288 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x2280000 294912 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x2300000 524288 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x2380000 524288 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x2400000 458752 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x20c0000 131072 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x2480000 524288 4
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x2500000 360448 4
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x20a4000 16384 1
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 
fw_build_id
Nov 13 13:45:37 razor NetworkManager[782]: <info>  [1605271537.1168] rfkill1: found Wi-Fi radio killswitch (at 
/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
Nov 13 13:45:39 razor ModemManager[722]: <info>  Couldn't check support for device 
'/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
Nov 13 13:45:45 razor kernel: ath11k_pci 0000:05:00.0: failed to enqueue rx buf: -28
