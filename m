Return-Path: <linux-wireless+bounces-26206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B008B1D932
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87947168209
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B525BF16;
	Thu,  7 Aug 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgLLZBtf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1538255F3F
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573966; cv=none; b=XSEheOQazPbLGFHOhoMJRj8/yWab137k/H0E63xjDVWu6k9fqXzGULQhFcG3lWfhBdPQgRrCQC3rdYtbJ4jS1z5mzRN7MOuFKe3dbHJHNraH8+wKGjU2oOuI4NyctkHL5Kt7Ok7WRv544mptLrCJLQsFvQo0++AmL2L+HliczyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573966; c=relaxed/simple;
	bh=LL4Hn8xvsHjmCbR0Up4BTpc7Nhfe+eU0Cc7WHVRV/2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kHIRAecue/58u5nVUr7vU954zoZu8M4M6i+wB5hdbs2WKmUFClal4JC7qXQz6QhRpwE0I7f7CF6KeaOizbE2yncxGz6R9YVY4ZFKm73KXZsC2rWV/jU2+05UkIbhkk+QIQR+oGMnV5ikwF7ApAwl8cZKB3+F5+7lecXmhfol8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgLLZBtf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78315ff04so738733f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754573963; x=1755178763; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xio5y0lXCspCluJXgo9hDhsD3UsJmR4wlHE4U9B6BAU=;
        b=OgLLZBtfGrP3+qAvMFhXbuRXbd4mvxhZPGifFoZMSNXhDY3vCZYb/pBY6HzZZX+z28
         bEwJC142Xysrku+jWd4ggSCYeGUUxWecdG2GIkDKGqUmjpiKmGKKedqL6oSua+Q7+cZw
         iMCeiiF8c+6w8tlNOVBsMFIAGncfUFb51c9FpGQKwWStmz8QfqEnFya4JNu+8a349ELf
         pibj20EK3roPfLspGnKXDb7aJ3hw/YnIyc31I5OB5mYoT1TuEx4E35725ynrGqwKhWds
         OQedHrG7Zx5Q2Gle/w1yqpg2q8N2J0toTNCYLJfwv2WxJfQ2TXcZqgXuoB+e8+aOCmUf
         L8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573963; x=1755178763;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xio5y0lXCspCluJXgo9hDhsD3UsJmR4wlHE4U9B6BAU=;
        b=ABFk2i6lEY18AkeLZiP2fZ80wdYoX5o7wDmWpG3V/geR+TN7WIApAsmYq3QBzfFmXi
         jhYWxlhUdmoMrAyfv6C2QdnUup9HQtqsCY6sIwlBHKXJZhF8wDvVB9OD7Ja6cJvpluOQ
         MEltu5egUwJf41Iar6HhIy0ZbCASWcn+ilIyYogSoQtgDxRZ+mByVwWHHctFpDfuuLpW
         RYrYeW7jJYV0WQm5EbAQszNrMafomCNAUpbN28A96FPhXYR1UXlegiSc+8KTxJa3ZOqH
         CDh9QRmFaCMq5JZpj7L2eksFtMLqSPkOHp+kXu0px9jgwB5r0JhgXA4bNAnGW5FwDyUp
         bCHw==
X-Forwarded-Encrypted: i=1; AJvYcCUQw0/eLc1k4kAnd2hsXwZeJJkqXz2aEmwj6eKLj0ds3pqhOdnAoZ0qB1xONibs1oXyDvxy+XVfKgTBBBjMaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUvJypWtdU8yEjdoGP7Ri06HI4zsYZADXdcnJ7zniZ7dBMSdw
	e7mVA6NINwlz4+k52XJj4tLQAn2EUil6wiwkRKVyBJEbD9MZl727ILnlgWN9xA==
X-Gm-Gg: ASbGncsvc/Cg8EKfzj3HkSfUEizMyVkcAdu4BRLNSGNIOKopJAOWPRm8sXtkkFz3xbV
	Z9RvSoTsTr6g/IYGuqztO6WJSeFx8SF1Ss9Ho6B/PvsZElkiFitHYBiuaXToyzInuHUbkvMNarh
	Q85G4IfQGy9AuUUHzW+uYd4QbBpQjYcb+O8mLDuGlSN5XJHrJRHyUf+zT5HCLh/eAqJaKDnEEcD
	0d/Puh0ddV3v1MSZw/OETL22YCKxbArqCBMVcAW4pRjJRCZrqmc8Oi4QZqXs8VcRBEpmnSKHcuG
	nI5DJidImWate7g2Vboc11aX9kKVKtXA0jR1P+eSWncDEtOqlB6QBFUbBz3f8EPBQ8q41eol6Qq
	xslTNUGzp+hIS79IgFNB8glMYfx26dHM=
X-Google-Smtp-Source: AGHT+IFpqmsveJ+G5NUkHgXYl584B8zuFrATJyaI3aJYgC8hKZ91YmLJTJqksXB7fQTdVV/jjE6Bxw==
X-Received: by 2002:a05:6000:2287:b0:3b7:868d:435e with SMTP id ffacd0b85a97d-3b8f41ad8cbmr6078436f8f.41.1754573962864;
        Thu, 07 Aug 2025 06:39:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:0:2480:67b:cbff:fea5:a121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dcb86d6asm149772725e9.5.2025.08.07.06.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Aug 2025 15:39:21 +0200
Message-Id: <DBW8K6K30OQS.U5Z6UMSMEY7B@gmail.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX
 Queue Updates
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Nithyanantham Paramasivam" <nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com> <DBVM2YZDTS15.1WAPW69YQ5XOA@gmail.com> <CAD1Z1J+jXWng4ma9_BPJh4N8b7AhTvRKtJ=tg1dTyk8E3wqupA@mail.gmail.com>
In-Reply-To: <CAD1Z1J+jXWng4ma9_BPJh4N8b7AhTvRKtJ=tg1dTyk8E3wqupA@mail.gmail.com>

On Thu Aug 7, 2025 at 2:31 PM CEST, Nithyanantham Paramasivam wrote:
> On Thu, Aug 7, 2025 at 1:32=E2=80=AFAM Nicolas Escande <nico.escande@gmai=
l.com> wrote:
>>
>> On Wed Aug 6, 2025 at 1:17 PM CEST, Nithyanantham Paramasivam wrote:
>> > During stress test scenarios, when the REO command ring becomes full,
>> > the RX queue update command issued during peer deletion fails due to
>> > insufficient space. In response, the host performs a dma_unmap and
>> > frees the associated memory. However, the hardware still retains a
>> > reference to the same memory address. If the kernel later reallocates
>> > this address, unaware that the hardware is still using it, it can
>> > lead to memory corruption-since the host might access or modify
>> > memory that is still actively referenced by the hardware.
>> >
>> > Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
>> > command during TID deletion to prevent memory corruption. Introduce
>> > a new list, reo_cmd_update_rx_queue_list, in the dp structure to
>> > track pending RX queue updates. Protect this list with
>> > reo_rxq_flush_lock, which also ensures synchronized access to
>> > reo_cmd_cache_flush_list. Defer memory release until hardware
>> > confirms the virtual address is no longer in use, avoiding immediate
>> > deallocation on command failure. Release memory for pending RX queue
>> > updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
>> > if hardware confirmation is not received.
>> >
>> > Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
>> > likelihood of ring exhaustion. Use a 1KB cache flush command for
>> > QoS TID descriptors to improve efficiency.
>> >
>>
>> Hello,
>>
>> I'm not sure I fully understand so please correct where I'm wrong but fr=
om what
>> I got looking at the code:
>>   - you increase the ring size for reo cmd
>>   - you enable releasing multiple tid buffer at once
>>   - as soon as you allocate the tid you create an entry in the list flag=
ging it
>>     as active
>>   - when you need to clean up a tid
>>     - you mark it as inactive in the list, then
>>     - try to process the whole list by
>>       - sending the reo command to release it
>>       - if it succeed you release it and remove the entry from the list
>>   - on core exit, you re process the list
>>
>> What is bothering me with this is that when a vdev which has multiple st=
a goes
>> down, you will have a lot of those entries to push to the firmware at on=
ce:
>>
>>   - So increasing the ring size / being able to release multiple entries=
 at once
>>     in one reo cmd may or may not be enough to handle the burst. It seem=
s
>>     that increasing those is just band aids on the underlying problem bu=
t I
>>     understand it's just to be on the safe side.
>>   - If entries do not get send/accepted by the firmware, we will need to=
 wait
>>     for another station removal before retrying, which could be a wile.
>>   - Or in the worst case (one vdev going down and needing to release tid=
 of
>>     all its stations) the more entries we have in the list the less like=
ly we
>>     will be to be able to push the delete of all stations + the ones sti=
ll in
>>     queue
>>
>> So, on station removal, why not make just things completely async. Push =
the tid
>> deletes in a list and wake a workqueue that tries to push those to the f=
irmware.
>> If the ring is full, retry periodically.
>>
>> Thanks
>
> Hi Nicolas,
Hi
>
> Thanks for the detailed observations and suggestions.
>
> You're right in your understanding of the flow. To clarify further:
>
> When the host fails to obtain a buffer from the hardware to send a
> command=E2=80=94due to the REO command ring being full
> (ath12k_hal_reo_cmd_send returning -ENOBUFS)=E2=80=94we treat it as a com=
mand
> send failure and avoid deleting the corresponding entry immediately.
>
> This situation typically arises in the flow:
>
> ath12k_dp_rx_process_reo_cmd_update_rx_queue_list =E2=86=92
> ath12k_dp_rx_tid_delete_handler =E2=86=92 returns -ENOBUFS
>
> Given the command ring size is 256, and each peer generally has 16
> TIDs, each TID sends 2 commands (RXQ update and cache flush). So,
> deleting one peer involves up to 32 commands. This means we can delete
> up to 8 peers (8 =C3=97 32 =3D 256 commands) before hitting the ring limi=
t.
>
> From the 9th peer onward, we may encounter ring exhaustion. However,
> we handle retries in the REO command callback
> (ath12k_dp_rx_tid_del_func). If commands fail to send, they remain in
> the pending list and can be retried via the success callback of
> earlier commands.
That was the part I did not get, I thought it was just another peer removal=
 that
would cause the whole list of pending entries to be reprocessed and pushed =
to
the ring.
>
> Do we foresee any issue with this ?
>
Nope, it should work.
> Regarding your suggestion to make the deletion process fully
> asynchronous via a workqueue, that=E2=80=99s a valid point. Workqueue-bas=
ed
> handling is a good idea, but we need to account for potential delays
> if the worker thread isn=E2=80=99t scheduled promptly. We also need to
> consider timeout-based rescheduling, especially during command
> failures, to ensure retries happen in a timely manner. We=E2=80=99ll eval=
uate
> this suggestion further and get back to you.
>
IMHO it feels like it would simplify the code to just push + wake to a wq o=
n
delete, and reschedule if no space is available in the ring. The timing sho=
uld
not be such a big deal right ? The important part is to eventually push all=
 reo
commands to the firmware but it should not have impact on the rest of the
operation if it reaches the firmware later that sooner right ?

> Thanks again for the insightful feedback!
Thanks for all the explanations
>
> Best Regards,
> Nithy


