Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3652B0309
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 11:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKLKsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 05:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgKLKsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 05:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605178116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvJqsLix0FAAyFANAo+QJp7fuXI1chlloF8HPvKaqi0=;
        b=iiBABjz2ujft5nAV/4qs/wqNpIr66QVNayt8aF1kFXzpaPb/m+qWThDRBvsWSOuP7/BKS4
        7mC6V/os7/xp34cantxDuBtOCLgnx7gtTvZF9kbFywQTt5HKANbNnYpbR28Lyu99laDLKQ
        A3qIyaWKKQjfadrIS4JUfcTVJMfz1lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-gE52x8i6Mj2qAtXutCLHkA-1; Thu, 12 Nov 2020 05:48:34 -0500
X-MC-Unique: gE52x8i6Mj2qAtXutCLHkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F6E803F4D;
        Thu, 12 Nov 2020 10:48:32 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B05DE1002C1A;
        Thu, 12 Nov 2020 10:48:30 +0000 (UTC)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, ath11k@lists.infradead.org
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org>
 <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com>
Date:   Thu, 12 Nov 2020 11:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11.11.20 21:41, Pavel Procopiuc wrote:
> Op 11.11.2020 om 20:23 schreef Kalle Valo:
>> Pavel, can you test with that patch on v5.10-rc2 and provide the ath11k
>> log messages? Preferably both before and after reverting commit
>> 7fef431be9c9. Do note that I'm not expecting the debug patch to fix
>> anything, in your case it's just for providing more debug info.
>>
>> With vt-d disabled on v5.10-rc2 before the revert I see:
>>
>> ath11k_pci 0000:06:00.0: WARNING: ath11k PCI support is experimental!
>> ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
>> ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
>> ath11k_pci 0000:06:00.0: MSI vectors: 1
>> NET: Registered protocol family 42
>> mhi 0000:06:00.0: Requested to power ON
>> mhi 0000:06:00.0: Power on setup success
>> ath11k_pci 0000:06:00.0: Respond mem req failed, result: 1, err: 0
>> ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-22
>> ath11k_pci 0000:06:00.0: req mem_seg[0] 0x1580000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[1] 0x1600000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[2] 0x1680000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[3] 0x1700000 294912 1
>> ath11k_pci 0000:06:00.0: req mem_seg[4] 0x1780000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[5] 0x1800000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[6] 0x1880000 458752 1
>> ath11k_pci 0000:06:00.0: req mem_seg[7] 0x1520000 131072 1
>> ath11k_pci 0000:06:00.0: req mem_seg[8] 0x1900000 524288 4
>> ath11k_pci 0000:06:00.0: req mem_seg[9] 0x1980000 360448 4
>> ath11k_pci 0000:06:00.0: req mem_seg[10] 0x1540000 16384 1
>> ath11k_pci 0000:06:00.0: qmi failed memory request, err = -110
>> ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110
>>
>> With vt-d disabled on v5.10-rc2 and reverting commit 7fef431be9c9 I see:
>>
>> ath11k_pci 0000:06:00.0: WARNING: ath11k PCI support is experimental!
>> ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
>> ath11k_pci 0000:06:00.0: MSI vectors: 1
>> mhi 0000:06:00.0: Requested to power ON
>> mhi 0000:06:00.0: Power on setup success
>> ath11k_pci 0000:06:00.0: Respond mem req failed, result: 1, err: 0
>> ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-22
>> ath11k_pci 0000:06:00.0: req mem_seg[0] 0x76300000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[1] 0x76380000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[2] 0x76a00000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[3] 0x76a80000 294912 1
>> ath11k_pci 0000:06:00.0: req mem_seg[4] 0x76b00000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[5] 0x76b80000 524288 1
>> ath11k_pci 0000:06:00.0: req mem_seg[6] 0x76400000 458752 1
>> ath11k_pci 0000:06:00.0: req mem_seg[7] 0x761a0000 131072 1
>> ath11k_pci 0000:06:00.0: req mem_seg[8] 0x76480000 524288 4
>> ath11k_pci 0000:06:00.0: req mem_seg[9] 0x76500000 360448 4
>> ath11k_pci 0000:06:00.0: req mem_seg[10] 0x76580000 16384 1
>> ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
>> ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id
> 
> I have had VT-d turned on the whole time in my previous tests. I have tried turning it off for some of this tests and it
> doesn't seem to affect my main bug. Here are the results:
> 
> 1. Without reverting the 7fef431be9c9, VT-d on (wifi doesn't work):
> Nov 11 21:19:20 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #1 SMP Wed Nov 11 21:12:24 CET 2020
> Nov 11 21:19:20 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 11 21:19:20 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:19:20 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 21:19:20 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 11 21:19:20 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
> Nov 11 21:19:21 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 11 21:19:21 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x1500000 524288 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x1580000 524288 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x1600000 524288 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x1680000 294912 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x1700000 524288 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x1780000 524288 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x1800000 458752 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x11e0000 131072 1
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x1880000 524288 4
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x1900000 360448 4
> Nov 11 21:19:21 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x1980000 16384 1
> Nov 11 21:19:26 razor kernel: ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> Nov 11 21:19:26 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> 
> 2. With reverting 7fef431be9c9, VT-d on (wifi does work):
> Nov 11 21:21:50 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #2 SMP Wed Nov 11 21:20:51 CET 2020
> Nov 11 21:21:50 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 11 21:21:50 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:21:50 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 21:21:50 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 11 21:21:50 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
> Nov 11 21:21:51 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 11 21:21:51 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x3f100000 524288 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x3f180000 524288 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x3f200000 524288 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x3f280000 294912 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x3f300000 524288 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x3f380000 524288 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x3fc00000 458752 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x3f0c0000 131072 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x3fc80000 524288 4
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x3fd00000 360448 4
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x3f0a4000 16384 1
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> Nov 11 21:21:51 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50
> fw_build_id
> Nov 11 21:21:53 razor NetworkManager[786]: <info>  [1605126113.1294] rfkill1: found Wi-Fi radio killswitch (at
> /sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
> Nov 11 21:21:55 razor ModemManager[724]: <info>  Couldn't check support for device
> '/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
> 
> 3. Without reverting the 7fef431be9c9, VT-d off (wifi doesn't work):
> Nov 11 21:32:41 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #3 SMP Wed Nov 11 21:31:35 CET 2020
> Nov 11 21:32:41 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 11 21:32:41 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:32:41 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 21:32:41 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 1
> Nov 11 21:32:42 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 11 21:32:42 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x1480000 524288 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x1500000 524288 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x1580000 524288 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x1600000 294912 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x1680000 524288 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x1700000 524288 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x1780000 458752 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x1800000 131072 1
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x1880000 524288 4
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x1900000 360448 4
> Nov 11 21:32:42 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x10e4000 16384 1
> Nov 11 21:32:47 razor kernel: ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> Nov 11 21:32:47 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> 
> 4. With reverting 7fef431be9c9, VT-d off (not sure if wifi works, system hung shortly thereafter):
> Nov 11 21:28:16 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #2 SMP Wed Nov 11 21:20:51 CET 2020
> Nov 11 21:28:16 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 11 21:28:16 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:28:16 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 21:28:16 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 1
> Nov 11 21:28:17 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 11 21:28:17 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x3f900000 524288 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x3f980000 524288 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x3fa00000 524288 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x3fa80000 294912 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x3fb00000 524288 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x3fb80000 524288 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x40800000 458752 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x3f8c0000 131072 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x40880000 524288 4
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x40900000 360448 4
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x3f8a4000 16384 1
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> Nov 11 21:28:17 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50
> fw_build_id
> Nov 11 21:28:19 razor NetworkManager[782]: <info>  [1605126499.2535] rfkill1: found Wi-Fi radio killswitch (at
> /sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
> Nov 11 21:28:21 razor ModemManager[717]: <info>  Couldn't check support for device
> '/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
> Nov 11 21:28:58 razor kernel: ath11k_pci 0000:05:00.0: failed to receive scan abort comple: timed out
> Nov 11 21:28:58 razor kernel: ath11k_pci 0000:05:00.0: failed to abort scan: -110
> Nov 11 21:29:01 razor kernel: ath11k_pci 0000:05:00.0: wmi command 12289 timeout
> Nov 11 21:29:01 razor kernel: ath11k_pci 0000:05:00.0: failed to send WMI_START_SCAN_CMDID
> Nov 11 21:29:01 razor kernel: ath11k_pci 0000:05:00.0: failed to start hw scan: -11
> 

Trying to understand the code, it looks like there are always two rounds 
of reqests. The first one always fails ("requesting one big chunk of DMA 
memory"), the second one (providing multiple chunks of DMA memory) is 
supposed to work - and we do allocate memory.


In the *working* cases we have

Respond mem req failed, result: 1, err: 0
qmi failed to respond fw mem req:-22
...
chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff

We don't fail in qmi_txn_wait() - second request w


In the *non-working* cases we have

Respond mem req failed, result: 1, err: 0
qmi failed to respond fw mem req:-22
...
qmi failed memory request, err = -110
qmi failed to respond fw mem req:-110

We fail in qmi_txn_wait(). We run into a timeout (ETIMEDOUT).

Can we bump up the timeout limit and see if things change? Maybe FW 
needs more time with other addresses.

-- 
Thanks,

David / dhildenb

