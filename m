Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3E2AF8FC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 20:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKKTYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 14:24:17 -0500
Received: from z5.mailgun.us ([104.130.96.5]:59333 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbgKKTYR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 14:24:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605122656; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=M4SsU8FP+jl6ohrQU3bV14ExeyBJ5Y9zbmdarZ+H4wI=; b=JG9Zqr4h5Jcf4rjlCFHLs3aJbnM+dzfOhGl2svOPQ5EbFZGwtGHgg0YYzNzw+JSECSZzPSSh
 Zdd25B0d5LoDR2AE/eSSYTy889XHu4xBQgST+jOjoqDnRJWAeIsD8WJEQNbJPMzoRWxpEpum
 dBjCEYYL/iQN0YJQaihRFe5TzI4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fac3a408e090a8886b22722 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 19:23:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA8A0C433F0; Wed, 11 Nov 2020 19:23:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71CEEC433C9;
        Wed, 11 Nov 2020 19:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71CEEC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-wireless@vger.kernel.org,
        Pavel Procopiuc <pavel.procopiuc@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, ath11k@lists.infradead.org
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to tail in __free_pages_core()"
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
        <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
Date:   Wed, 11 Nov 2020 21:23:39 +0200
In-Reply-To: <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com> (David
        Hildenbrand's message of "Thu, 5 Nov 2020 12:13:43 +0100")
Message-ID: <87eekz4s04.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

>> Am 05.11.2020 um 11:42 schrieb Vlastimil Babka <vbabka@suse.cz>:
>>=20
>> =EF=BB=BFOn 11/5/20 10:04 AM, Kalle Valo wrote:
>>> (changing the subject, adding more lists and people)
>>> Pavel Procopiuc <pavel.procopiuc@gmail.com> writes:
>>>> Op 04.11.2020 om 10:12 schreef Kalle Valo:
>>>>> Yeah, it is unfortunately time consuming but it is the best way to get
>>>>> bottom of this.
>>>>=20
>>>> I have found the commit that breaks things for me, it's
>>>> 7fef431be9c9ac255838a9578331567b9dba4477 mm/page_alloc: place pages to
>>>> tail in __free_pages_core()
>>>>=20
>>>> I've reverted it on top of the 5.10-rc2 and ath11k driver loads fine
>>>> and I have wifi working.
>>> Oh, very interesting. Thanks a lot for the bisection, otherwise we would
>>> have never found out whats causing this.
>>> David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
>>> ath11k) failed on v5.10-rc1. After bisecting he found that the commit
>>> below causes the regression. I have not been able to reproduce this and
>>> for me QCA6390 works fine. I don't know if this needs a specific kernel
>>> configuration or what's the difference between our setups.
>>> Any ideas what might cause this and how to fix it?
>>> Full discussion:
>>> http://lists.infradead.org/pipermail/ath11k/2020-November/000501.html
>>> commit 7fef431be9c9ac255838a9578331567b9dba4477
>>> Author:     David Hildenbrand <david@redhat.com>
>>> AuthorDate: Thu Oct 15 20:09:35 2020 -0700
>>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>>> CommitDate: Fri Oct 16 11:11:18 2020 -0700
>>>     mm/page_alloc: place pages to tail in __free_pages_core()
>>=20
>> Let me paste from the ath11k discussion:
>>=20
>>> * Relevant errors from the log:
>>> # journalctl -b | grep -iP '05:00|ath11k'
>>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 cla=
ss 0x028000
>>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: reg 0x10: [mem
>>> 0xd2100000-0xd21fffff 64bit]
>>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: PME# supported from D0 =
D3hot D3cold
>>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: 4.000 Gb/s
>>> available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
>>> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
>>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
>>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: WARNING:
>>> ath11k PCI support is experimental!
>>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: BAR 0:
>>> assigned [mem 0xd2100000-0xd21fffff 64bit]
>>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: enabling
>>> device (0000 -> 0002)
>>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Requested to power ON
>>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Power on setup success
>>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: Respond mem
>>> req failed, result: 1, err: 0
>>=20
>> This seems to be ath11k_qmi_respond_fw_mem_request(). Why is it
>> failure with error 0? No idea.
>>=20
>> What would happen if all the GFP_KERNEL in the file were changed to GFP_=
DMA32?
>>=20
>> I'm thinking the hardware perhaps doesn't like too high physical
>> addresses or something. But if I think correctly, freeing to tail
>> should actually move them towards head. So it's weird.
>
> It depends in which order memory is exposed to MM, which might depend
> on other factors in some configurations.
>
> This smells like it exposes an existing bug. Can you reproduce also
> with zone shuffling enabled?

I think I can reproduce this bug now on my NUC box by disabling vt-d in
the BIOS, but I'm not sure yet if it really is the same problem or not.
I included some debug messages to this ath11k patch:

https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-=
1-git-send-email-kvalo@codeaurora.org/

Pavel, can you test with that patch on v5.10-rc2 and provide the ath11k
log messages? Preferably both before and after reverting commit
7fef431be9c9. Do note that I'm not expecting the debug patch to fix
anything, in your case it's just for providing more debug info.

With vt-d disabled on v5.10-rc2 before the revert I see:

ath11k_pci 0000:06:00.0: WARNING: ath11k PCI support is experimental!
ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
ath11k_pci 0000:06:00.0: MSI vectors: 1
NET: Registered protocol family 42
mhi 0000:06:00.0: Requested to power ON
mhi 0000:06:00.0: Power on setup success
ath11k_pci 0000:06:00.0: Respond mem req failed, result: 1, err: 0
ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-22
ath11k_pci 0000:06:00.0: req mem_seg[0] 0x1580000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[1] 0x1600000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[2] 0x1680000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[3] 0x1700000 294912 1
ath11k_pci 0000:06:00.0: req mem_seg[4] 0x1780000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[5] 0x1800000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[6] 0x1880000 458752 1
ath11k_pci 0000:06:00.0: req mem_seg[7] 0x1520000 131072 1
ath11k_pci 0000:06:00.0: req mem_seg[8] 0x1900000 524288 4
ath11k_pci 0000:06:00.0: req mem_seg[9] 0x1980000 360448 4
ath11k_pci 0000:06:00.0: req mem_seg[10] 0x1540000 16384 1
ath11k_pci 0000:06:00.0: qmi failed memory request, err =3D -110
ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110

With vt-d disabled on v5.10-rc2 and reverting commit 7fef431be9c9 I see:

ath11k_pci 0000:06:00.0: WARNING: ath11k PCI support is experimental!
ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
ath11k_pci 0000:06:00.0: MSI vectors: 1
mhi 0000:06:00.0: Requested to power ON
mhi 0000:06:00.0: Power on setup success
ath11k_pci 0000:06:00.0: Respond mem req failed, result: 1, err: 0
ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-22
ath11k_pci 0000:06:00.0: req mem_seg[0] 0x76300000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[1] 0x76380000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[2] 0x76a00000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[3] 0x76a80000 294912 1
ath11k_pci 0000:06:00.0: req mem_seg[4] 0x76b00000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[5] 0x76b80000 524288 1
ath11k_pci 0000:06:00.0: req mem_seg[6] 0x76400000 458752 1
ath11k_pci 0000:06:00.0: req mem_seg[7] 0x761a0000 131072 1
ath11k_pci 0000:06:00.0: req mem_seg[8] 0x76480000 524288 4
ath11k_pci 0000:06:00.0: req mem_seg[9] 0x76500000 360448 4
ath11k_pci 0000:06:00.0: req mem_seg[10] 0x76580000 16384 1
ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0=
xffffffff
ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-2=
4 19:50 fw_build_id=20

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
