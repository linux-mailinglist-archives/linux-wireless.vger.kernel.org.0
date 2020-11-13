Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5592B1F2A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKMPt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgKMPt7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 10:49:59 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B7C0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 07:49:58 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id y4so5393232edy.5
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVlWoDydEByYn03GAfLZLkCKYayDuYZvcrvjeh0wrC8=;
        b=BI/wSOgQ7xqPYwoj7D5cqctKxWKmSkzT23D56soZ3cGIULJh+l6YXXO8EuncNAzoPP
         WhXRFyDrDFGSbKeS1l6QYfYT7abnlfMfBNPA3Ip1KI8fvNtLyOiMqMn4SAqO9xyP50lr
         i6sjM/hV2H+I9Xg7/lShhy7JeoB2KroL5vrDIUfesyZzTArR/GBIjgajeo/eb1AMTMg4
         2f2cGXBQ0OKlnlgg/Bekzd6BJ401HHR8gII9pHnG/+h82WwQuWU4hB56vSH0AtY3GoUp
         zAzYw9UKVZCXxCs7W79u/7deJdCmuJZPXVE16elyt1yJ4LKSsr/AkJCNPt6FLbK31lFT
         MgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVlWoDydEByYn03GAfLZLkCKYayDuYZvcrvjeh0wrC8=;
        b=IbtviUzVCMfQmqv6PHQrhOA/NP0M/WUzrHH5eK9bRW9lmaUdfw2V2fT9QyFI07ePhF
         1OrEaP/o9CoopXEemFGumRbuyvpmE7xK3iUO/qDzvNfOfoCQyw90ipenk4GUJ1wOJIDT
         B7wcdk3CQOqZ4G8imCCW9xfxS8+RGHN17cUfuKTv88D2EA9wMj4We/rE1soHAcBOLHLL
         5VToIPNBkHflo2mxrM+e4oK4pnFYGJ9wFtxm8brKyeofq1d3jQTIGWyFG3zHHIj4KUmU
         NwrLDQobZHk/NLWyP672IG1HIGH5gX1kWLJ4M8L9rzjHsMMbbsYfrNMwNltx8tcPuWFk
         fHtg==
X-Gm-Message-State: AOAM53158hayu5t6dvlrU5EZ6AVkU0DVTD0MVo3qzyJO0cnY0U3dhBN+
        A4y4CdQwLVjizBEez+aZ5QYU8cbWdKY9cqFXMW6RyA==
X-Google-Smtp-Source: ABdhPJxEh+UO+lr3IL2XV2Z0DmJIcTaJ1unFAa7BkNHqyrX3dcU/kV7DWJBl1ZWdTClOD84SzMfKaeUg/x4T0XLldJo=
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr3187598edr.371.1605282592615;
 Fri, 13 Nov 2020 07:49:52 -0800 (PST)
MIME-Version: 1.0
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz> <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
 <87eekz4s04.fsf@codeaurora.org> <9d307c40-5ea1-8938-819d-f1742cb99945@gmail.com>
 <cd8d1b1d-a646-b9b1-ed2a-4aa7070efe00@redhat.com> <dd24598f-7635-c2e2-9c6d-f320770e3b9e@gmail.com>
 <f1f471905ea99ad9b9c8a8eeae616ff9@codeaurora.org> <3e30ac52-6ad4-fa7b-8817-bca35a80d268@gmail.com>
 <CAHUdJJXnSd614ff+GDOAtUQV_vdUnOkVooFAzp_LA6CbbW=NDA@mail.gmail.com> <719c1497-f48e-9f1e-359b-dbc5e4a4c11a@redhat.com>
In-Reply-To: <719c1497-f48e-9f1e-359b-dbc5e4a4c11a@redhat.com>
From:   wi nk <wink@technolu.st>
Date:   Fri, 13 Nov 2020 16:49:41 +0100
Message-ID: <CAHUdJJVu-r6ubP6ekYnJB82rPvtHCnZfg3_0eG1KY0LsAE943Q@mail.gmail.com>
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Procopiuc <pavel.procopiuc@gmail.com>,
        Carl Huang <cjhuang@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 13, 2020 at 2:56 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.11.20 14:36, wi nk wrote:
> > On Fri, Nov 13, 2020 at 1:52 PM Pavel Procopiuc
> > <pavel.procopiuc@gmail.com> wrote:
> >>
> >> Op 13.11.2020 om 12:08 schreef Carl Huang:
> >>> Checked some logs. Looks when the error happens, the physical address are
> >>> very small. Its' between 20M - 30M.
> >>>
> >>> So could you have a try to reserve the memory starting from 20M?
> >>> Add "memmap=10M\$20M" to your grub.cfg or edit in kernel parameters. so ath11k
> >>> can't allocate from these address.
> >>>
> >>> Or you can try to reserve even larger memory starting from 20M.
> >>
> >> That worked, booting with memmap=12M$20M resulted in the working wifi:
> >>
> >> $ journalctl -b | grep -iP '05:00|ath11k|Linux version|memmap'
> >> Nov 13 13:45:34 razor kernel: Linux version 5.10.0-rc2 (root@razor) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34
> >> p6) 2.34.0) #1 SMP Fri Nov 13 13:29:48 CET 2020
> >> Nov 13 13:45:34 razor kernel: Command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
> >> memmap=12M$20M quiet
> >> Nov 13 13:45:34 razor kernel:   DMA zone: 64 pages used for memmap
> >> Nov 13 13:45:34 razor kernel:   DMA32 zone: 5165 pages used for memmap
> >> Nov 13 13:45:34 razor kernel:   Normal zone: 255840 pages used for memmap
> >> Nov 13 13:45:34 razor kernel: Kernel command line: ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2
> >> memmap=12M$20M quiet ro root=/dev/nvme0n1p2 resume=/dev/nvme1n1p1 zram.num_devices=2 memmap=12M$20M quiet
> >> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class 0x028000
> >> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000-0xd21fffff 64bit]
> >> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> >> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at
> >> 0000:00:1c.1 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
> >> Nov 13 13:45:34 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0xd2100000-0xd21fffff 64bit]
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: MSI vectors: 32
> >> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Requested to power ON
> >> Nov 13 13:45:35 razor kernel: mhi 0000:05:00.0: Power on setup success
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req failed, result: 1, err: 0
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-22
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[0] 0x2100000 524288 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[1] 0x2180000 524288 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[2] 0x2200000 524288 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[3] 0x2280000 294912 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[4] 0x2300000 524288 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[5] 0x2380000 524288 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[6] 0x2400000 458752 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[7] 0x20c0000 131072 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[8] 0x2480000 524288 4
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[9] 0x2500000 360448 4
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: req mem_seg[10] 0x20a4000 16384 1
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> >> Nov 13 13:45:35 razor kernel: ath11k_pci 0000:05:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50
> >> fw_build_id
> >> Nov 13 13:45:37 razor NetworkManager[782]: <info>  [1605271537.1168] rfkill1: found Wi-Fi radio killswitch (at
> >> /sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0/ieee80211/phy0/rfkill1) (driver ath11k_pci)
> >> Nov 13 13:45:39 razor ModemManager[722]: <info>  Couldn't check support for device
> >> '/sys/devices/pci0000:00/0000:00:1c.1/0000:05:00.0': not supported by any plugin
> >> Nov 13 13:45:45 razor kernel: ath11k_pci 0000:05:00.0: failed to enqueue rx buf: -28
> >>
> >> --
> >> ath11k mailing list
> >> ath11k@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/ath11k
> >
> > When I attempt to boot my 5.10rc2 kernel with that memmap option, my
> > machine immediately hangs.  That said, it seems to have done something
> > bizarre, as immediately afterwards, if I remove that option and let
> > 5.10 boot normally, it seems to boot and bring up the wifi adapter ok
> > (which didn't happen before).  Now that I've managed to boot 5.10
> > twice, the first time after a couple of minutes my video started going
> > nuts and displaying all sorts of artifacts[1].  This time things seem
> > to be functioning nominally (wifi is online and the machine is
> > behaving properly).  I may just never turn it off again :D.
>
> Honestly, that FW sounds horribly flawed. :)
>
> Would be interesting what happens when you boot back to 5.9 now ...
>
> --
> Thanks,
>
> David / dhildenb
>

Well nothing super interesting....rebooting to 5.9 hard locked the
machine once the adapter associated, before I could do much.
Rebooting back to 5.10 and it booted fine (I'm sending this email with
it).  There's definitely something non deterministic causing the
driver to work occasionally and fail/panic a bit more often.  Are
there other memory / device allocation settings I can tweak to see if
something settles it down?
