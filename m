Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9D2A7C17
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgKEKmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 05:42:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:40898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgKEKmg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 05:42:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FC27AD18;
        Thu,  5 Nov 2020 10:42:34 +0000 (UTC)
To:     Kalle Valo <kvalo@codeaurora.org>,
        Pavel Procopiuc <pavel.procopiuc@gmail.com>, david@redhat.com
Cc:     ath11k@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <fa22cf0f-3bac-add6-8c71-6f6cad5206d8@gmail.com>
 <87lffjodu7.fsf@codeaurora.org>
 <fa338986-8de4-fde1-6805-d46793c947e4@gmail.com>
 <c9cc0ec6-4dda-2608-3575-0e6dfb6d0852@gmail.com>
 <87ft5rszcs.fsf@codeaurora.org> <87ft5qsem9.fsf@codeaurora.org>
 <f99862f4-9b3a-03e5-cd26-1de6136f9e46@gmail.com>
 <87blgdscxd.fsf@codeaurora.org>
 <229c31e7-9aff-18e6-a6db-be7b46331173@gmail.com>
 <87361onphy.fsf_-_@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
Message-ID: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
Date:   Thu, 5 Nov 2020 11:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87361onphy.fsf_-_@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/5/20 10:04 AM, Kalle Valo wrote:
> (changing the subject, adding more lists and people)
> 
> Pavel Procopiuc <pavel.procopiuc@gmail.com> writes:
> 
>> Op 04.11.2020 om 10:12 schreef Kalle Valo:
>>> Yeah, it is unfortunately time consuming but it is the best way to get
>>> bottom of this.
>>
>> I have found the commit that breaks things for me, it's
>> 7fef431be9c9ac255838a9578331567b9dba4477 mm/page_alloc: place pages to
>> tail in __free_pages_core()
>>
>> I've reverted it on top of the 5.10-rc2 and ath11k driver loads fine
>> and I have wifi working.
> 
> Oh, very interesting. Thanks a lot for the bisection, otherwise we would
> have never found out whats causing this.
> 
> David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
> ath11k) failed on v5.10-rc1. After bisecting he found that the commit
> below causes the regression. I have not been able to reproduce this and
> for me QCA6390 works fine. I don't know if this needs a specific kernel
> configuration or what's the difference between our setups.
> 
> Any ideas what might cause this and how to fix it?
> 
> Full discussion: http://lists.infradead.org/pipermail/ath11k/2020-November/000501.html
> 
> commit 7fef431be9c9ac255838a9578331567b9dba4477
> Author:     David Hildenbrand <david@redhat.com>
> AuthorDate: Thu Oct 15 20:09:35 2020 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Fri Oct 16 11:11:18 2020 -0700
> 
>      mm/page_alloc: place pages to tail in __free_pages_core()
> 

Let me paste from the ath11k discussion:

> * Relevant errors from the log:
> # journalctl -b | grep -iP '05:00|ath11k'
> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0

This seems to be ath11k_qmi_respond_fw_mem_request(). Why is it failure with 
error 0? No idea.

What would happen if all the GFP_KERNEL in the file were changed to GFP_DMA32?

I'm thinking the hardware perhaps doesn't like too high physical addresses or 
something. But if I think correctly, freeing to tail should actually move them 
towards head. So it's weird.

> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 02 10:41:32 razor kernel: ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> Nov 02 10:41:32 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> Nov 02 10:42:58 razor kernel: mhi 0000:05:00.0: Device failed to exit MHI Reset state

