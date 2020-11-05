Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE72A7CBA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgKELNv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 06:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbgKELNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 06:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604574828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4k4SKFvZRyxZUUectJ8LVntk4jaYo6zD7QcqD9bzQo=;
        b=UU5lZp48kjhzXG0aypGnKC6eojuydh5UIPFqcO3koQW14VNJNtrDEU4QYMKSPnjFXwS0Of
        4HJqVF1vvIUwlnLr9iWaVYg7F2GgpFIYgV7obYNACA+67Ghm+SN6YpRQR5Wc8OQB2gmDBy
        oq+toTi0tNOmA9SLcOT4XAy4iEnA8i8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-EHpI2uR_MMuMP0DWndpSaQ-1; Thu, 05 Nov 2020 06:13:47 -0500
X-MC-Unique: EHpI2uR_MMuMP0DWndpSaQ-1
Received: by mail-ed1-f70.google.com with SMTP id f20so388619edx.23
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 03:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=R4k4SKFvZRyxZUUectJ8LVntk4jaYo6zD7QcqD9bzQo=;
        b=ovd1d6WpP56eG8/DmyEBoNw8N653uyX+HoQJzE11m1CIMlpucCwXlgV9ugKP+JiiQz
         e6byUk+Ytm5awnuFb0kXESHcI2jij3SUMR1h6Aok3X4wfd6BkNyvXtAsJcGsI1b1u4C5
         Pp2QRkTDsGOlimJx/5wiKYUWBdw2+6NjTKXSFKDvp/AV+v2ptEIrLTT2E6x9nhwNUBUk
         W5hDAW5VUZFZQb6NYb6e1lByH3Kfe8Tf9PupsOwRaxOB+1mhaCyQNgiitmSdWvWI/I49
         +8ZArfEZbUFCZG6P3X2YBymCQFjffXnQNB9NMoloFitIXbiaRPy4g45deUAd2wwS1ir/
         Wyfw==
X-Gm-Message-State: AOAM5315ZlB86ARv2ArYDWHl8rlCkDyPQYTjoNJ5WTltA28SgfE6feus
        BlPG0wyRz/zD9xAl1qafIgk0+IhYgaE8wMNEdRHSOZWmr1wPzFieub6DD6NugEQVvQgfC7SCkra
        9w+Qf8fL1Awlx03MMssjRHCti/5I=
X-Received: by 2002:a50:c945:: with SMTP id p5mr1928195edh.55.1604574825535;
        Thu, 05 Nov 2020 03:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMWEEePBbN5mYNTiJIeSojG5bngWsmvejr1D1k6BEnMf3C+wxb81JDQRgnZ9/PS9P4/dmEmw==
X-Received: by 2002:a50:c945:: with SMTP id p5mr1928180edh.55.1604574825274;
        Thu, 05 Nov 2020 03:13:45 -0800 (PST)
Received: from [10.167.228.65] (tmo-098-193.customers.d1-online.com. [80.187.98.193])
        by smtp.gmail.com with ESMTPSA id z13sm744106ejp.30.2020.11.05.03.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:13:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to tail in __free_pages_core()"
Date:   Thu, 5 Nov 2020 12:13:43 +0100
Message-Id: <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Pavel Procopiuc <pavel.procopiuc@gmail.com>, david@redhat.com,
        ath11k@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> Am 05.11.2020 um 11:42 schrieb Vlastimil Babka <vbabka@suse.cz>:
>=20
> =EF=BB=BFOn 11/5/20 10:04 AM, Kalle Valo wrote:
>> (changing the subject, adding more lists and people)
>> Pavel Procopiuc <pavel.procopiuc@gmail.com> writes:
>>> Op 04.11.2020 om 10:12 schreef Kalle Valo:
>>>> Yeah, it is unfortunately time consuming but it is the best way to get
>>>> bottom of this.
>>>=20
>>> I have found the commit that breaks things for me, it's
>>> 7fef431be9c9ac255838a9578331567b9dba4477 mm/page_alloc: place pages to
>>> tail in __free_pages_core()
>>>=20
>>> I've reverted it on top of the 5.10-rc2 and ath11k driver loads fine
>>> and I have wifi working.
>> Oh, very interesting. Thanks a lot for the bisection, otherwise we would
>> have never found out whats causing this.
>> David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
>> ath11k) failed on v5.10-rc1. After bisecting he found that the commit
>> below causes the regression. I have not been able to reproduce this and
>> for me QCA6390 works fine. I don't know if this needs a specific kernel
>> configuration or what's the difference between our setups.
>> Any ideas what might cause this and how to fix it?
>> Full discussion: http://lists.infradead.org/pipermail/ath11k/2020-Novembe=
r/000501.html
>> commit 7fef431be9c9ac255838a9578331567b9dba4477
>> Author:     David Hildenbrand <david@redhat.com>
>> AuthorDate: Thu Oct 15 20:09:35 2020 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Fri Oct 16 11:11:18 2020 -0700
>>     mm/page_alloc: place pages to tail in __free_pages_core()
>=20
> Let me paste from the ath11k discussion:
>=20
>> * Relevant errors from the log:
>> # journalctl -b | grep -iP '05:00|ath11k'
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: [17cb:1101] type 00 class=
 0x028000
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: reg 0x10: [mem 0xd2100000=
-0xd21fffff 64bit]
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: PME# supported from D0 D3=
hot D3cold
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: 4.000 Gb/s available PCIe=
 bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:1c.1 (capable of 7.8=
76 Gb/s with 8.0 GT/s PCIe x1 link)
>> Nov 02 10:41:26 razor kernel: pci 0000:05:00.0: Adding to iommu group 21
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: WARNING: ath11k PC=
I support is experimental!
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: BAR 0: assigned [m=
em 0xd2100000-0xd21fffff 64bit]
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: enabling device (0=
000 -> 0002)
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Requested to power ON
>> Nov 02 10:41:27 razor kernel: mhi 0000:05:00.0: Power on setup success
>> Nov 02 10:41:27 razor kernel: ath11k_pci 0000:05:00.0: Respond mem req fa=
iled, result: 1, err: 0
>=20
> This seems to be ath11k_qmi_respond_fw_mem_request(). Why is it failure wi=
th error 0? No idea.
>=20
> What would happen if all the GFP_KERNEL in the file were changed to GFP_DM=
A32?
>=20
> I'm thinking the hardware perhaps doesn't like too high physical addresses=
 or something. But if I think correctly, freeing to tail should actually mov=
e them towards head. So it's weird.

It depends in which order memory is exposed to MM, which might depend on oth=
er factors in some configurations.

This smells like it exposes an existing bug. Can you reproduce also with zon=
e shuffling enabled?=

