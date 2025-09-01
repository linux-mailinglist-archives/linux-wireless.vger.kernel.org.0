Return-Path: <linux-wireless+bounces-26888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A2B3DA1F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 08:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AC6189727C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFD23D7F3;
	Mon,  1 Sep 2025 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX1BJgWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20D18EB0
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708934; cv=none; b=kbGj7KZwLCWTpSAGFZfMcV30H1W4+A67Az9w5gekF1dfTiPeMw87ye50NZk/0qAA6GdIcHCjQXrxmDafZXaUNGalqG1XUmYB2kMVMHsmNOrYg5Uqbn9aKKEGhBDoVNPmUn8HCyMChK1sqYxNUAo4kGp4A6fkLs3jyXg0OyNdPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708934; c=relaxed/simple;
	bh=RDikeEDf+XQN2VpXBRECh3gYJI6TYrhkR6p+1KtP7P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XC6gighUArFjX/TOWp23xslQXQSR6rbaozosCgTDsQnsBY3R7Rm/jTR5MH6U3GZ73zXFqQB7eyIaSdX0RHaykuWtLoautsAywThyaRcj2iN3pmYEfThT20RxXfh7EZ1Ph5YPTEkZ2gMCasxx2fdgCKPiXjqRPxHNrvMajphE8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX1BJgWo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051aeafso33621087b3.2
        for <linux-wireless@vger.kernel.org>; Sun, 31 Aug 2025 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756708931; x=1757313731; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBR0plrAgBgn1y2kWNbwi2JPjxaNfxU2eG5Z9H6EtiM=;
        b=kX1BJgWoaLom6AkLk6pKjGVA87FaybzYXtsCYHpuJc+CEhGbR3AUgQqmgcW5j4sk+K
         5AvgHWY/8yWbusvBvITKvpaApRMMUKjH3s42cNyL7QaSg2v8fwaP4YLXuIQEojbWsvAr
         rhusosXIRkuPrTCIzXjuczSidpKeVosx0TE8E7zyZrJ14JLDKs0SrEE14khKZJ2et0TC
         CPrsNPTHxd1jh8rMgOPhubZgJQ401x5kN7p3zyitRzP/z6+1CX+3UcplRnhHUFH6MD/s
         YvXeTtyCz0uf4yCM2KvVk7lJc8jln5RJvDRbVVHjKA8ThFBgzRHtk4ALpZ8jTxcuVFjz
         YXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756708931; x=1757313731;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBR0plrAgBgn1y2kWNbwi2JPjxaNfxU2eG5Z9H6EtiM=;
        b=k+MUWIPRXyHuFjRNh7jeOCg3bSig0M9lq5QwbLpKYGYp1KYsFqBeSHFynHRhuOzVLH
         jD8I0siJ1HKQUWH6Plr3+E8O0PuzayLOcKAjpoTOptLeIgTf448LNayeHDlz8CDvy3g7
         rJaNKhm14v/OjnhB3hbCXLy99pVFn0sxSD09lTTrMirk69xBa7PX3cJpN8232vA3I1dD
         9I6RP/SXxPG4XWTqbxQ3i+LrZIycyYMorKlDdDBfIYDXHL/RqL4G1KO4NP9fWrjbYVIi
         CU+rkZYwLr0n4Ez5t3W3sEE+c1GSffFr2pgeq40DQr7SkXJkvFA2FW4CpBwgh/iFakcE
         98ew==
X-Gm-Message-State: AOJu0YwZFUvS022q3HPQfb8r+hDG1H3NkQWAYmCFguiH+y6Fi2/nx3Yd
	g9H3Vvw4Ud6jvX39hwo5YjlIUiUNW8v1ingNDAXlUAuYsvOXW1ymziwUcQJMBv+rumYA0oPuo8J
	OaiKUxb5JwbzXd4MEivJSqtXcKqdx0aOEOEaEfMk=
X-Gm-Gg: ASbGncsFx/yM2f2dt8eYUDqhJptHReRs3vCdT/d/Q2QMYrFOuAdOH0SlakukqHnaQ44
	/zdrGHNTxK1u3JaLjq45gSPzxYJrpu1zBRKQ5aTYvL3kSaHmeu5ZZS5hkWz9b5UnzQ5BgbQuA/e
	bNLeZHvI70l8mOgMYDLaToH++axNrJgRPgYJkrbPcQlP+rD/T3wfZE7kdM6tn3A7AIHXrjJ20g0
	Qo+0W/7VHW0m0pUvQ==
X-Google-Smtp-Source: AGHT+IHAUw2r1e0PXfY+oFqGkFQibP+R9IHcXX/h0RggVkCyoeBfPXLmArQTLjWLAhOW6po3n8MQC33/sdfKR1ueRoA=
X-Received: by 2002:a05:690c:3681:b0:721:29fe:1d44 with SMTP id
 00721157ae682-7227635f6b9mr77099287b3.13.1756708931344; Sun, 31 Aug 2025
 23:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH3TfsRyY1Rr9_y-v3ZcJvUzBt0y10x5i3nV43U0h6dkmUp5yA@mail.gmail.com>
In-Reply-To: <CAH3TfsRyY1Rr9_y-v3ZcJvUzBt0y10x5i3nV43U0h6dkmUp5yA@mail.gmail.com>
From: XiaoYan Li <lxy.lixiaoyan@gmail.com>
Date: Mon, 1 Sep 2025 14:42:00 +0800
X-Gm-Features: Ac12FXyqCBWmSXyqNfo529PaYwccCoDgHkrxkNKz9DQH_WMgT473_OWT4PE2ywo
Message-ID: <CAH3TfsR1_tfO+eOcUKofqEEJ3Y_Zo8vS-COLEOKui+iA3LOqMA@mail.gmail.com>
Subject: Re: [Bug] mt7925e: cannot resume from suspend
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested this issue on the following newer kernels with the latest
kernel firmware (20250808), and the problem still exists.
- 6.16.3-200.fc42.x86_64 (stable, fedora kernel)
- 6.17.0-0.rc3.250831.c8bc81a5.234.vanilla.fc42 (mainline, vanilla kernel)

I tried disabling the ASPM with `pcie_aspm=3Doff
mt7925e.disable_aspm=3D1`, and the resume somehow works, though the
kernel is still in a corrupted state. The network card is completely
unusable and starting new programs may cause them to freeze. Some
"task ... is blocked on a mutex likely owned by task ..." logs appear
after the resume.

The kernel logs output the following lines after resume, when ASPM is disab=
led:
  kernel: mt7925e 0000:61:00.0: driver own failed
  kernel: mt7925e 0000:61:00.0: PM: dpm_run_callback(): pci_pm_resume retur=
ns -5
  kernel: mt7925e 0000:61:00.0: PM: failed to resume async: error -5
  kernel: mt7925e 0000:61:00.0: Message 00020015 (seq 4) timeout
  kernel: ------------[ cut here ]------------
  kernel: Hardware became unavailable upon resume. This could be a
software issue prior to suspend or a hardware issue.
Full logs can be located at https://pastes.dev/hubqGyfV8N

Thanks,
Xiaoyan Li

On Wed, Aug 20, 2025 at 3:15=E2=80=AFPM XiaoYan Li <lxy.lixiaoyan@gmail.com=
> wrote:
>
> * Originally reported at https://bugzilla.kernel.org/show_bug.cgi?id=3D22=
0395
>
> Hi,
>
> I recently upgraded my laptop's network card to MT7925 and discovered
> an issue with the new network card when system suspending
> (s2idle/s0ix). I can no longer resume my laptop from suspend; the
> screen remains dark. After forcefully rebooting, I can see that the
> dmesg of the previous boot ends with those two lines.
>
>   kernel: PM: suspend entry (s2idle)
>   kernel: Filesystems sync: 0.010 seconds
>
> After running `sudo rmmod mt7925e`, the problem disappeared. I'm not
> sure if it's a regression.
>
> Detailed informations:
>
>   Distro: Fedora 42 (Silverblue)
>   Kernel: 6.15.8-200.fc42.x86_64 (Firmware: 20250708)
>   Device: Yoga ASP9 (Laptop)
>   Processor: AMD Ryzen AI 9 365
>   Network Card: MT7925
>
> Please let me know if any further information is needed.
>
> Thanks,
> Xiaoyan Li

