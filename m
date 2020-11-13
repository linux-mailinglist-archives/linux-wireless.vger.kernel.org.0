Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9402B1CBE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKMN4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 08:56:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgKMN4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 08:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uItuPISD7qFedNEsC3ywS9bnXtTDrUFhBkgpWbFW2AQ=;
        b=Rj14fnuJG1Ou+LrJF8T0pn4GblXlOEabUoNCgovxW/zEcjJFsd+9BkD+1FP/1ADS27Zakm
        OsaR8wTjMXbos88+2T2IS8Yge3+bmOGdUAp4Jz+13h3gtmkIhKUTS1kg/bQCrOHA8Imlw0
        1N7hn4hfm4WJ/nHTwAJ7hevCr7KOb1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-dr8wAl2vMuisuqrwhbmUDw-1; Fri, 13 Nov 2020 08:56:25 -0500
X-MC-Unique: dr8wAl2vMuisuqrwhbmUDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F481084D69;
        Fri, 13 Nov 2020 13:56:22 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F6776EF5F;
        Fri, 13 Nov 2020 13:56:19 +0000 (UTC)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     wi nk <wink@technolu.st>,
        Pavel Procopiuc <pavel.procopiuc@gmail.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org>
 <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
 <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
 <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org>
 <3e30ac52-6ad4-fa7b-8817-bca35a80d268@gmail.com>
 <CAHUdJJXnSd614ff+GDOAtUQV_vdUnOkVooFAzp_LA6CbbW=NDA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <719c1497-f48e-9f1e-359b-dbc5e4a4c11a@redhat.com>
Date:   Fri, 13 Nov 2020 14:56:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHUdJJXnSd614ff+GDOAtUQV_vdUnOkVooFAzp_LA6CbbW=NDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13.11.20 14:36, wi nk wrote:
> On Fri, Nov 13, 2020 at 1:52 PM Pavel Procopiuc
> <pavel.procopiuc@gmail.com> wrote:
>>
>> Op 13.11.2020 om 12:08 schreef Carl Huang:
>>> Checked some logs. Looks when the error happens, the physical address are
>>> very small. Its' between 20M - 30M.
>>>
>>> So could you have a try to reserve the memory starting from 20M?
>>> Add "memmap=10M\$20M" to your grub.cfg or edit in kernel parameters. so ath11k
>>> can't allocate from these address.
>>>
>>> Or you can try to reserve even larger memory starting from 20M.
>>
>> That worked, booting with memmap=12M$20M resulted in the working wifi:
>>
>> $ journalctl -b | grep -iP '05:00|ath11k|Linux version|memmap'
>> Nov 13 13:45:34 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
>> p6) 2.34.0) #1 SMP Fri Nov 13 13:29:48 CET 2020
>> Nov 13 13:45:34 razor kernel: Command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
>> memmap=12M$20M quiet
>> Nov 13 13:45:34 razor kernel:   DMA zone: 64 pages used for memmap
>> Nov 13 13:45:34 razor kernel:   DMA32 zone: 5165 pages used for memmap
>> Nov 13 13:45:34 razor kernel:   Normal zone: 255840 pages used for memmap
>> Nov 13 13:45:34 razor kernel: Kernel command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
>> memmap=12M$20M quiet ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 memmap=12M$20M quiet
>> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
>> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
>> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
>> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
>> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
>> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
>> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Requested to power ON
>> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Power on setup success
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x2100000 524288 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x2180000 524288 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x2200000 524288 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x2280000 294912 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x2300000 524288 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x2380000 524288 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x2400000 458752 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x20c0000 131072 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x2480000 524288 4
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x2500000 360448 4
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x20a4000 16384 1
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
>> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50
>> fw_build_id
>> Nov 13 13:45:37 razor NetworkManager[782]: <info>  [1605271537.1168] rfkill1: found Wi-Fi radio killswitch (at
>> /sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
>> Nov 13 13:45:39 razor ModemManager[722]: <info>  Couldn't check support for device
>> '/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
>> Nov 13 13:45:45 razor kernel: ath11k_pci 0000:05:00.0: failed to enqueue rx buf: -28
>>
>> --
>> ath11k mailing list
>> ath11k@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/ath11k
> 
> When I attempt to boot my 5.10rc2 kernel with that memmap option, my
> machine immediately hangs.  That said, it seems to have done something
> bizarre, as immediately afterwards, if I remove that option and let
> 5.10 boot normally, it seems to boot and bring up the wifi adapter ok
> (which didn't happen before).  Now that I've managed to boot 5.10
> twice, the first time after a couple of minutes my video started going
> nuts and displaying all sorts of artifacts[1].  This time things seem
> to be functioning nominally (wifi is online and the machine is
> behaving properly).  I may just never turn it off again :D.

Honestly, that FW sounds horribly flawed. :)

Would be interesting what happens when you boot back to 5.9 now ...

-- 
Thanks,

David / dhildenb

