Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE92A9AEC
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 18:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgKFRdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 12:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbgKFRcy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 12:32:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C4C0613D2;
        Fri,  6 Nov 2020 09:32:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so2085900eds.3;
        Fri, 06 Nov 2020 09:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0akvYm3LWuyidPI3Eup0Whc5esafMG3ay7ZZN8eQJ7w=;
        b=ESZTf1V+OlQeUgAjPKmzjKXb6DgBC0tIF5CKMJOsbzpSOiNGXxwTST2SCdE1Cx57Xg
         YPGUEimechCp27bUN5x0I4wxiw2IfE7+qtAlrqFIgT0Ge9WMpv5ee/se0oIfoA+q14qz
         rZrUMNDXLkpbh6JUyDjW9PWh8pNCB/RQYTkXfxuiCjuqLUqSAGRcYOXEaTACpWCwpd2K
         xVi005xy//NHdnSGMkdDFPKfwYWmxAuTX5nX1A1qCJ26ylMbj2G3876me/6r+sohRHpw
         T2IAF8KLSgPakUXT86gZeTs4Jfi30CkbzR8/dDuNL73/hK2NY8Cg5mefMn4vhpwD2fZr
         RzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0akvYm3LWuyidPI3Eup0Whc5esafMG3ay7ZZN8eQJ7w=;
        b=iTpxZhwk/TKsANhJljIgrlV5IlCI7xbwVDd9pCERpRe6txZ11tWTM5/JoSfSgvf9/7
         QIGw9JOOBMraOL8Z+jf71NPTItp4AqE/l+VeQaSbToCBvI3fHF82aCOvLZ0SgqoMd2zU
         CNIo8EtptuV9ESevfxK+UaZ24qk1ZIIOzZihXGEhBs7LPEaKWsGAe+in45OHpswd7fN1
         ojaGVTmMZxu3nloh5DV5XG9cmz0Gvdbf06NBujfAMm7woOf01KAK5kAHSh+8OK/Hpf8w
         M1aUbQoui788dIuoxyfJ8bIFJGHpuujiMhmP3tpbGUT0OxWWxTxr8CU1FBAhJFMG6Y5T
         HGKw==
X-Gm-Message-State: AOAM530r1fuolYsNK8IJAD4dJJav/36V8jlcsqDdloOp2t4XX6veqmzl
        c5Kog084zZPjkEU37H2fr/6SEHzccHOcKg==
X-Google-Smtp-Source: ABdhPJwVOFKV6htTkjiZ17Bw6V+JQG3DcdObwCZYhbzKWl/6A+V0gKwErFsUcV67WtcP647Yt+e7Lw==
X-Received: by 2002:a50:bf41:: with SMTP id g1mr3089025edk.165.1604683972538;
        Fri, 06 Nov 2020 09:32:52 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:4c98:2052:ada4:62d5? (2a02-a44f-d2f0-0-4c98-2052-ada4-62d5.fixed6.kpn.net. [2a02:a44f:d2f0:0:4c98:2052:ada4:62d5])
        by smtp.gmail.com with ESMTPSA id la9sm1354054ejb.121.2020.11.06.09.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:32:51 -0800 (PST)
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <225718f1-c4b0-8683-427a-059148a39350@gmail.com>
 <C3FD015A-8E51-4752-AD76-6ABE4583E268@redhat.com>
Message-ID: <15e33a0a-9a76-0966-125a-5941e2cdfb09@gmail.com>
Date:   Fri, 6 Nov 2020 18:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <C3FD015A-8E51-4752-AD76-6ABE4583E268@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 05.11.2020 om 21:23 schreef David Hildenbrand:
>> So just to make sure I understand you correctly, you'd like to see if the problem with ath11k driver on my hardware persists when I boot pristine 5.10-rc2 kernel (without reverting commit 7fef431be9c9ac255838a9578331567b9dba4477) and with page_alloc.shuffle=1, right?
>>
> 
> Right, but as lists are randomized then it might take a couple of tries to reproduce. I‘ll have a look at the driver code / failing path on Monday, when back to work.

I have done 5 boots of pristine 5.10-rc2 with page_alloc.shuffle=1. Out of those: 1st, 2nd, 4th and 5th resulted in 
working ath11k driver, logs were the same as with the commit 7fef431be9c9ac255838a9578331567b9dba4477 reverted. The 3rd 
one failed, but in a different way, I just had no output from the driver after initialization lines:

Nov 06 18:19:41 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34 
p6) 2.34.0) #8 SMP Fri Nov 6 18:14:36 CET 2020
Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 
0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
Nov 06 18:19:41 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
Nov 06 18:19:42 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
Nov 06 18:19:42 razor kernel: mhi 0000:05:00.0: Requested to power ON
Nov 06 18:19:42 razor kernel: mhi 0000:05:00.0: Power on setup success

I had this before and usually it was fixed after rebooting into Windows and back. This time I just went and rebooted 
into Linux again and driver was working on that boot (4th).

After that I removed page_alloc.shuffle=1 and did 2 additional boots, both of them resulted in a non-working driver with 
the error messages about not being able to talk to firmware like I had before on the clean 5.10-rc2:

Nov 06 18:24:07 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34 
p6) 2.34.0) #9 SMP Fri Nov 6 18:22:43 CET 2020
Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 
0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
Nov 06 18:24:07 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
Nov 06 18:24:08 razor kernel: mhi 0000:05:00.0: Requested to power ON
Nov 06 18:24:08 razor kernel: mhi 0000:05:00.0: Power on setup success
Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
Nov 06 18:24:08 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
Nov 06 18:24:13 razor kernel: ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
Nov 06 18:24:13 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
Nov 06 18:25:39 razor kernel: mhi 0000:05:00.0: Device failed to exit MHI Reset state
