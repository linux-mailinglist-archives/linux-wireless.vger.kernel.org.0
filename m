Return-Path: <linux-wireless+bounces-30321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E625ACF0C06
	for <lists+linux-wireless@lfdr.de>; Sun, 04 Jan 2026 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D0F300A869
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jan 2026 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A821BD035;
	Sun,  4 Jan 2026 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX4Dc2WW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1B3A1E63
	for <linux-wireless@vger.kernel.org>; Sun,  4 Jan 2026 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767514785; cv=none; b=SjINRCfvDLNXFgB3j5VLCwJdSXQyaoiZ6oA0uw+5aIq9rIxfMAy1pBnRPGljIxP3XgLLyh4UOauzWF9ZHS5gRmW8tDHb/bpOQHAoriTn8OgmxKlM5gg2Goj+mISgdAXMl2ocJxXWzwqKdKNoPdYkImzgzaktYg0j6PM6ySJO8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767514785; c=relaxed/simple;
	bh=j6CAbguKJMlcQJcQqsle3uxpQlDXJD9ulDClzCnndXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejwSl10tsFUpsn9utThlwcJj4twi/lTjjiGkJaWbTGYuAcrfxtSyOGSr5aSMC4tX5SRVmh6gE5iI2jFl8tZwjBw59Sp1oPb30xgLaJ6gz8zXG5xrSMuSnFy+l3oNoyNu9OlMkFjPTAqtX5dBhX/VFexztI6M0Uv8E8mblsg3tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX4Dc2WW; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so11000007f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 00:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767514782; x=1768119582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNhnPWPphu+I4t9H5XuMrO/46QkiDHIIBXPeXwdimwk=;
        b=DX4Dc2WWJfV8VGcF8iXXYJ8l3tt1hGWMvXE5h2j7FAklVnWBJUVBcNXtxZozW1GGiK
         zIZLneLOpjD64y4/axJgG4ZZkckYQ0W/hlhzp2FNpmfzdT54tSX6IUfBj7xWnQ6EbTKl
         QCTvvBy29M0tMk2yay9voY5hjPgE5YHq/o2TnH9F/5LtVvUV3tbFetVeBMkO+iGdXmDs
         jJM4Vuj5wgaoRfFgqBaRLtvgZbs5x+p7F155zFufxkoLXDFENc3bliUUCsJ8kMpyUQo9
         +EuGiTFAdbajSJfd2DMJ3m+BN5fZhuHBYJccQdSO+hJbyeYhNviNdrKp260MnxLkcBsM
         CZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767514782; x=1768119582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNhnPWPphu+I4t9H5XuMrO/46QkiDHIIBXPeXwdimwk=;
        b=XvcGlyQGk/nrv+7IvxynVJ2JistGk1FgU/SFJrCKJVs8q0AtJGNm7CAaRfEeHv9/5L
         A3dzNAKaqWgzK0+VmbmOob64jcykZAc+EHnkHPsZ+1k427kDZuwP1gv1pZafHjb8fn/s
         4GdrCw/BFXpT3i33y7NtuC4WQqF4DeYlsjdkl9V+NnbZnlu4uE5PAYXGn32qHZ+tIJVJ
         +tMqZpyp897G58e3FyF8ud+bIhmKetgZDlxtqxbDa2zRupQwUwhaIR3pN3BJbAWYyWNi
         XPYzU++dj/qjgEP6TQ0K3ZnEHwoIDF3tcCU6RhFEpoR0MRYOxyl5TtRQyFI5QKs9QvnC
         frgg==
X-Gm-Message-State: AOJu0YyJiRzVxlYRnb5fLpQBKFv4j4hxrGlkA5zWp/mDccEvbQ7uDMjd
	LRydoULrJjQ85fVgjvwPiPC1e5S5ZooHKdmy8qtQWmgT82k7Y1KqV467
X-Gm-Gg: AY/fxX7Zz3qhclmCtq48XimJ2GMYh7UbOlzZOAZmZAzf5MeMtYMFX0rxcpX/EV7C3az
	3l/w41Ft9a7mQlXqaehmFD7lJdL16yTqoRmzNA12nJtIu8EkVn52JC8vGl+nIKEXWcHoLDANN/y
	VIS0w4oMO8pHELJT68Oogv7po65No/EGSHq2KlQA6pkYwNM9YxAqRdoJk/K7PD0myG0tfjwW7Qj
	g9wc1gYxX8ZZUQoyPBU2NKvP1+cCAYaHIvT8gc+dIQFCbKSoyXWA5nIcim2Ao7cxk2dkdJJ8QD7
	m3PLHT5xP48yZTAVl7siLRR5N2MAx6D5qs+mnuwlGzSY8dVtbqh67q/vb5LFdLRezNZXYeIYtEU
	rrpPGZLXuRtvR/KiGe7ospmnWg2sB2EiSiXYIyQfuHryrT5ld9hTVeHRizaeHzSCM7fPeIx2ua1
	VF5VZ7goBZfwr0kCjGl3hNARKMQa/j3c/p0b5e3qHSDTxXG9mihmaoAH2r5bZyVeSCA4s5zw==
X-Google-Smtp-Source: AGHT+IGVE35w/mIgbVKF7jo1kXk2fItEl+1AN6nAuaTpOUbgrAhK9/MHCuZ5Z8ur0F6HzR9C5wPA4w==
X-Received: by 2002:a05:6000:2907:b0:432:8504:f67a with SMTP id ffacd0b85a97d-4328504f681mr35577584f8f.20.1767514781753;
        Sun, 04 Jan 2026 00:19:41 -0800 (PST)
Received: from fedora.fritz.box (dynamic-adsl-84-220-246-20.clienti.tiscali.it. [84.220.246.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm95843304f8f.18.2026.01.04.00.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 00:19:41 -0800 (PST)
From: moosager90 <moosager90@gmail.com>
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
Subject: Re: mt7921e: repeated driver own failures cause hanging
Date: Sun, 04 Jan 2026 09:19:39 +0100
Message-ID: <2715401.vYhyI6sBWr@fedora.fritz.box>
In-Reply-To:
 <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
References:
 <4870974.vXUDI8C0e8@fedora.fritz.box>
 <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Sean,

I'm resending this because I forgot to Cc the mailing lists.

On Sat, Jan 3, 2026 at 7:24 PM moosager90 <moosager90@gmail.com> wrote:
> Hi Sean,
>
> I have updated the firmware using the files you recommended (and I will w=
ait
> for the issue to occur again), but I believe my distro's (Fedora 43) pack=
ages
> were already up to date, as the files already present on my system had the
> same hash as the newly downloaded ones; so the issue has been happening on
> the latest firmware (it was also happening on earlier ones, but I don't
> know since when).
>
> > Could you please share more details on how this issue can be
> > reproduced? For example, does it occur after suspend/resume, under
> > heavy traffic, or during normal runtime?
>
> There are no specific circumstances for it, it just happens during normal
> runtime: no heavy load is required to trigger it. I haven't ever seen the=
 issue
> happen immediately after suspend/resume either; I don't believe that's re=
lated.
> I have a feeling that it has happened more often when connected to a
> public, password-less Wi-Fi network, though I'm not sure; it also
> happens any other network.
>
> > Also, please confirm which firmware version you are using.
>
> The dmesg output given by my distro's firmware files was:
> [   16.313264] mt7921e 0000:62:00.0: enabling device (0000 -> 0002)
> [   16.329376] mt7921e 0000:62:00.0: ASIC revision: 79220010
> [   16.405931] mt7921e 0000:62:00.0: HW/SW Version: 0x8a108a10, Build Tim=
e: 20251118163143a
> [   16.790050] mt7921e 0000:62:00.0: WM Firmware Version: ____000000, Bui=
ld Time: 20251118163234
> which is identical to that given by the latest firmware files from git.
>
> More precisely, the firmware from my distro is that at [1]
> (mt7xxx-firmware-20251125-1.fc43.noarch.rpm is relevant), which I believe
> corresponds to branch [2] of linux-firmware, which is the latest one.
>
> > As a debugging step, could you also try disabling PCIe ASPM and check
> > whether the issue still occurs?
>
> I have now added pcie_aspm=3Doff to my boot options; however, I had alrea=
dy done
> that in the past and the issue still happened. Here is an excerpt of the =
log
> from that time:
>
> kernel: Linux version 6.17.8-wifibuild+ ... (gcc (GCC) 15.2.1 20251022 (R=
ed Hat 15.2.1-3), GNU ld version 2.45-1.fc43) #1 SMP > PREEMPT_DYNAMIC Fri =
Nov 14 12:24:21 CET 2025
> kernel: Command line: ... BOOT_IMAGE, root, ro, rootflags and rd.luks.uui=
d options ... quiet loglevel=3D3 udev.log-priority=3D3 > pcie_aspm=3Doff
> ... messages ...
> kernel: mt7921e 0000:62:00.0: enabling device (0000 -> 0002)
> kernel: mt7921e 0000:62:00.0: ASIC revision: 79220010
> kernel: mt7921e 0000:62:00.0: HW/SW Version: 0x8a108a10, Build Time: 2025=
0523103150a
> kernel: mt7921e 0000:62:00.0: WM Firmware Version: ____000000, Build Time=
: 20250523103234
> ... messages ...
> ... repeated sequences of driver own failures ...
> kernel: mt7921e 0000:62:00.0: Message 00020003 (seq 6) timeout
> kernel: mt7921e 0000:62:00.0: Message 00020003 (seq 7) timeout
> kernel: mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: mt7921e 0000:62:00.0: driver own failed
> kernel: mt7921e 0000:62:00.0: Timeout for driver own
> kernel: mt7921e 0000:62:00.0: Message 00020003 (seq 8) timeout
> kernel: mt7921e 0000:62:00.0: driver own failed
>
> I had built the vanilla kernel myself at that time, hence the tag. That w=
as
> before November 25, but I believe I might have been running the same firm=
ware
> as today as it was provided by Fedora's testing packages at that time.
>
> [1] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2865762
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwa=
re.git/commit/?> h=3D20251125&id=3D4ee5122b3f58e4c07951746c4425e2f4f42e860f
>
> On Sat, Jan 3, 2026 at 8:10 AM Sean Wang <sean.wang@kernel.org> wrote:
> > Hi moosager90,
> >
> > Could you please share more details on how this issue can be
> > reproduced? For example, does it occur after suspend/resume, under
> > heavy traffic, or during normal runtime? Also, please confirm which
> > firmware version you are using.
> >
> > It would be helpful to test with the latest linux-firmware version:
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
=2Egit/commit/mediatek?> id=3D5cf85776762a544ad27c4447b61eaabb0d4716e7
> >
> > As a debugging step, could you also try disabling PCIe ASPM and check
> > whether the issue still occurs?
> >
> >                Sean
> >
> > On Fri, Jan 2, 2026 at 4:35=E2=80=AFAM moosager90 <moosager90@gmail.com=
> wrote:
> > >
> > > Hello,
> > >
> > > There is an issue with mt7921e which causes repeated failures in chip=
 resets,
> > > bringing the network down and causing hanging on every command or act=
ion on the
> > > system; the only workaround is to reboot. This is what the kernel out=
put looks
> > > like at those times:
> > >
> > > mt7921e 0000:62:00.0: driver own failed
> > > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > > kernel: mt7921e 0000:62:00.0: driver own failed
> > > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > > kernel: mt7921e 0000:62:00.0: driver own failed
> > > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > > kernel: mt7921e 0000:62:00.0: driver own failed
> > > kernel: mt7921e 0000:62:00.0: chip reset failed
> > > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > > kernel: Console: switching to colour frame buffer device 360x112
> > > kernel: fbcon: Taking over console
> > > kernel: mt7921e 0000:62:00.0: Message 00020001 (seq 1) timeout
> > >
> > > I have observed the issue on many untainted kernels, and I have had i=
t happen on
> > > vanilla kernels not provided by my distro as well.
> > >
> > > Mine and some other people's reports are available at [1]. More logs =
of the
> > > issue on my system are in the attachments of my original report on th=
e Red Hat
> > > Bugzilla [2].
> > >
> > > In the past, the issue was reported at [3], which resulted in a patch=
 [4] that
> > > only keeps the system running instead of panicking. This means the dr=
iver still
> > > causes system hangs.
> > >
> > > I still don't know the root cause of the issue and I would like to ge=
t to the
> > > bottom of this; any help or guidance is appreciated. Crucially, I hav=
e not found
> > > a way to reproduce the issue at will.
> > >
> > > Best regards.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220353
> > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2411854
> > > [3] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F2=
90E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/> T/#u
> > > [4] https://patchwork.kernel.org/project/linux-wireless/patch/> 727eb=
5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/
> > >
> > >
> > >
> > >
> >




