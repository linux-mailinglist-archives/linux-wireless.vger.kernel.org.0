Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93672A7C1B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgKEKp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 05:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEKp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 05:45:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07980C0613CF;
        Thu,  5 Nov 2020 02:45:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so1001055edv.11;
        Thu, 05 Nov 2020 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IMVkHJO7JLg28HsvV0WBH6yL0f8Cdr48oJLO9uM0Wkg=;
        b=Vg7kV5Tbo5kaprD1H2htnWR8dpQgiDd4wRk20/kGmBFpoUU+O3txfXLvm1qLylUbDG
         r4A7Kb350UsHxodrfSk/op9gEevUur92WxprtJ6a5x0PZVkFSp3glFtra13wgvaT9HDQ
         /Rns89jzi3itY9dynJxlQHhfO1IQaKw9Hp06A0e8mk4RtbGD4Lft7bypD5MHsRAcnN7U
         RG6J8xE0OA91mUvPa8HsjNT6biMksf/VpjcHjUv+4W0f8szb+Fvoq98iw/F7osUUB5jk
         D4zZK5xXXYIhI0B+JKd+3KXW3OtOeVRt9nTdh+C+tOSaq9qfbryqoRBIZxWPBsWGTk0w
         Ed6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMVkHJO7JLg28HsvV0WBH6yL0f8Cdr48oJLO9uM0Wkg=;
        b=Z8Mqoz66nSH3aPtjvQwJo8H7CE7GPlikBIz45bzVBClIhglfBvZwmaG3zpVk6f4UOs
         70OkG/PO10/wsdadsNsB/cnRFB6C/njSo8nUDhVpXhIOH7L6uqipZy/wR9KgX0UUZTDn
         o4MzG8UF7muCX3yv0D8E09WVl5Xr5SAqz4ZXnmPGcBfUk/4mBS7wXdBrhcNueGjvhjbJ
         87xOLMRDYQJacVMVW5bRCE/KyETpOOOJ5IeRABGkyXprLIb+r9scSR/WKt1JWiNCFb4s
         ylk/N25v7pgVQ+Uf7Y4s2jfz8FrTfhj5HRdHze+YrujMHc47wMHKNIR2xfdgXzBoonoH
         LOCA==
X-Gm-Message-State: AOAM532n38Zze5dkzk8mpJFnMAXP6aCePD3lQe2c125miqtoMDJAVyD7
        3u/wW8d2wnB3ri1K4QLSOxxtkRJVXfaKsw==
X-Google-Smtp-Source: ABdhPJwPJ+gqIrSwQTnqg88CYYjf/5dOo878RuJVyiGZsWelxdKOsIVyfdMh+rz3Cd4oTxHVYrq+AQ==
X-Received: by 2002:aa7:ce82:: with SMTP id y2mr1907303edv.6.1604573157369;
        Thu, 05 Nov 2020 02:45:57 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c? (2a02-a44f-d2f0-0-7cde-5457-f7ce-ec3c.fixed6.kpn.net. [2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c])
        by smtp.gmail.com with ESMTPSA id b6sm672312edu.21.2020.11.05.02.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 02:45:56 -0800 (PST)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Vlastimil Babka <vbabka@suse.cz>,
        Kalle Valo <kvalo@codeaurora.org>, david@redhat.com
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
 <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Message-ID: <2dfa9cd3-5b95-3e0b-8ffa-64d38540c573@gmail.com>
Date:   Thu, 5 Nov 2020 11:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 05.11.2020 om 11:42 schreef Vlastimil Babka:
> Let me paste from the ath11k discussion:
> 
>> * Relevant errors from the log:
>> # journalctl -b | grep -iP '05:00|ath11k'
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link 
>> at 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Requested to power ON
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Power on setup success
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> 
> This seems to be ath11k_qmi_respond_fw_mem_request(). Why is it failure with error 0? No idea.
> 
> What would happen if all the GFP_KERNEL in the file were changed to GFP_DMA32?
> 
> I'm thinking the hardware perhaps doesn't like too high physical addresses or something. But if I think correctly, 
> freeing to tail should actually move them towards head. So it's weird.

Well, in fact I still have this particular error, although the hardware works correctly. This is my current log:

# journalctl -b | grep -iP '05:00|ath11k|Linux version'
Nov 05 09:43:31 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34 
p6) 2.34.0) #4 SMP Thu Nov 5 09:26:00 CET 2020
Nov 05 09:43:31 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
Nov 05 09:43:31 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
Nov 05 09:43:31 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
Nov 05 09:43:31 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 
0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
Nov 05 09:43:31 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
Nov 05 09:43:32 razor kernel: mhi 0000:05:00.0: Requested to power ON
Nov 05 09:43:32 razor kernel: mhi 0000:05:00.0: Power on setup success
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
Nov 05 09:43:32 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id
Nov 05 09:43:33 razor NetworkManager[777]: <info>  [1604565813.8043] rfkill1: found Wi-Fi radio killswitch (at 
/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
Nov 05 09:43:35 razor ModemManager[720]: <info>  Couldn't check support for device 
'/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
