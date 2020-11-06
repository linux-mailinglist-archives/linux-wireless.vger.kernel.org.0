Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B22A9EA8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgKFUlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 15:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbgKFUlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 15:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604695305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LX5gdTm6EDzi00pjEtiFhtYuinFfaUY5Wq0ZilW4doE=;
        b=QQ5dBaaKTwG5vRvhh2NgszlapLdyMRJ7kgmltYuJKXyS9RdMsdSic5V4FmasAPUTjeua9H
        jKrrcsn8WMSu9k7FbrxaqDDeLxZLc5VY0Fe8mm+dPNsCZBJJXBjrBMlsxSWbTVVah1I6Hy
        FDD8rJiTD3Is3m5mgJyA1ZC0s5d545s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-f3i3Bcf9PK2FKNMjgLE_TQ-1; Fri, 06 Nov 2020 15:41:43 -0500
X-MC-Unique: f3i3Bcf9PK2FKNMjgLE_TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D15F802B74;
        Fri,  6 Nov 2020 20:41:41 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDAA46EF6D;
        Fri,  6 Nov 2020 20:41:38 +0000 (UTC)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <225718f1-c4b0-8683-427a-059148a39350@gmail.com>
 <C3FD015A-8E51-4752-AD76-6ABE4583E268@redhat.com>
 <15e33a0a-9a76-0966-125a-5941e2cdfb09@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <31f66d70-95eb-12dd-1d01-0830d118f55a@redhat.com>
Date:   Fri, 6 Nov 2020 21:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <15e33a0a-9a76-0966-125a-5941e2cdfb09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06.11.20 18:32, Pavel Procopiuc wrote:
> Op 05.11.2020 om 21:23 schreef David Hildenbrand:
>>> So just to make sure I understand you correctly, you'd like to see if the problem with ath11k driver on my hardware persists when I boot pristine 5.10-rc2 kernel (without reverting commit 7fef431be9c9ac255838a9578331567b9dba4477) and with page_alloc.shuffle=1, right?
>>>
>>
>> Right, but as lists are randomized then it might take a couple of tries to reproduce. I‘ll have a look at the driver code / failing path on Monday, when back to work.
> 
> I have done 5 boots of pristine 5.10-rc2 with page_alloc.shuffle=1. Out of those: 1st, 2nd, 4th and 5th resulted in
> working ath11k driver, logs were the same as with the commit 7fef431be9c9ac255838a9578331567b9dba4477 reverted. The 3rd
> one failed, but in a different way, I just had no output from the driver after initialization lines:
> 
> Nov 06 18:19:41 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #8 SMP Fri Nov 6 18:14:36 CET 2020
> Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 06 18:19:42 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 06 18:19:42 razor kernel: mhi 0000:05:00.0: Power on setup success
> 
> I had this before and usually it was fixed after rebooting into Windows and back. This time I just went and rebooted
> into Linux again and driver was working on that boot (4th).

I'm sorry, but "WARNING: ath11k PCI support is experimental!" and such 
occasional issues don't give me the best feeling that everything is 
operating as it should :)

> 
> After that I removed page_alloc.shuffle=1 and did 2 additional boots, both of them resulted in a non-working driver with
> the error messages about not being able to talk to firmware like I had before on the clean 5.10-rc2:
> 
> Nov 06 18:24:07 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> p6) 2.34.0) #9 SMP Fri Nov 6 18:22:43 CET 2020
> Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> Nov 06 18:24:08 razor kernel: mhi 0000:05:00.0: Requested to power ON
> Nov 06 18:24:08 razor kernel: mhi 0000:05:00.0: Power on setup success
> Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> Nov 06 18:24:13 razor kernel: ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> Nov 06 18:24:13 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> Nov 06 18:25:39 razor kernel: mhi 0000:05:00.0: Device failed to exit MHI Reset state
> 

Okay, that means that you should be able to reproduce 
pre-7fef431be9c9ac255838a9578331567b9dba4477 with page_alloc.shuffle=1 
as well ... it just might take a lot of tries to get a problematic page.

I could also imagine that loading the driver deferred, after quite some 
system/mm activity could result in the same issue.

Looks like something either cannot handle a specific address we received 
via dma_alloc_coherent(), or something is reading out of bounds, and the 
content after our allocated page doesn't have the expected value anymore 
(e.g., used to be zero, now no longer zero).

What puzzles me is that "err: 0". That should have been properly set by 
HW, no?

-- 
Thanks,

David / dhildenb

