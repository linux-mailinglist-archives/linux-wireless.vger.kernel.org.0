Return-Path: <linux-wireless+bounces-15992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51109E7E3E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 05:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D0728603C
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F9823D1;
	Sat,  7 Dec 2024 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq97IW1m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3665B216
	for <linux-wireless@vger.kernel.org>; Sat,  7 Dec 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733546704; cv=none; b=r3baR0GJMuBV/hfkHx1A7xfGBaJFg5HrOWqk5U3ubFJpNwSVIl4FPd4+CSsBskmafzREwpQmRSDKeRA4Z+tA10+DEbhCJCsoakJQocwKVRpWwdD+tU7GIHVx6aFORaUEqW/X5MMmqiejFaimvolC8OMuthWY2jG4YX1/74A2aLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733546704; c=relaxed/simple;
	bh=4qAsxKcb0W8igOGSdhm4xtlBQh4xu49YqyXJHLXUFAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnQVhNTGrLdE8j3j+pl9phNqJEL6IVf9bX8P6r4Mx1XG2L0/7gbMtVx5Bg3K7BDxR+ZhzaFUBti5mgGVGiTjxHbf7QIhBSJuPD5GHJ64u9EXUY6VBFUTPKyi584OvPlK+hhg+++TS9DMUMPDlCT0NmbdSWz2YT5q+DlcWhsi7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq97IW1m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd21e4aa2eso1317413a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733546703; x=1734151503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40KBzs6uSxGX34H7W2eGb+nCd0K+n+qbuJ13C4RppDY=;
        b=Kq97IW1mPgjJVPFR+1uqWngICQCXwivLAAn+akNoGAG/bf3yYHV6Z5akj6sKR+d5f/
         dGjsbSwp6Npv/8sMIoDAtbHnvXEqEDDYVPeMBRclGbGoe2E8EptHzMVe/lHNSO/QPHDm
         AjECZ/L6ePNJIgQck0grzd0xrXOUp8fXQ3Ckqh22naU4q/0wIA/0MR/GRB+HWMg09FcE
         w0AzC6mAQ3rUIWi0r2khmav6zwpN4caUB3lF8+cThH0paGUaaMeR67MpMamRv4p3N8nV
         YwtlgNzcCLVGFlT8irDY3H5YjNDMdJp5lK2e7+tyNlVGuRwYpEJnDR8OlwHXVSPoINhc
         D1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733546703; x=1734151503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40KBzs6uSxGX34H7W2eGb+nCd0K+n+qbuJ13C4RppDY=;
        b=bWNw5UtFbEXoYm6HreM9/Ybrq7Znxk5oFIJTDPB0ygsj+uxGhBFlM4l/IG97ZqpnuB
         nk9xbMnOFnnXJ8Td56JQJWZ5slBslDok1/cFnkAGr6aSZGwy8/Iebt6jkTWfAR0KqmG/
         Cxv6FXNsn1e2Qsa7not7Y0xyZJh0F54V/Gt9e9kg0+DJ02kaMvIXV0etKqmP8HndWDjK
         ITiGrgqPjs5b07HISPvqJ/8DrKWxxfaC+uIpCzhtEB2O0JOYunKMEBO3WA6s1ksM5pi2
         qCCkzYIJdFx+GpEZ4AbytXybBmCBAV2U0ztjKjq9P0heXdsqJUt4oB8Jct4fSHhNu2Qn
         UN+A==
X-Forwarded-Encrypted: i=1; AJvYcCWigzEDFW6T7ZYfe3+v7TKeICJDjRRgQyXr2/dcDs4IMRQJQfRQwFkRCB1QM4u3R5UFNvrOSlDqY42z+0NREA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcL2/g3DzkWQD88YgvM/Ww2TltRJihDqT7AZaPAocWFPURSEc
	FbPnQIEcgJJ+Dae/QXopxAvXNAbtKGbd72N0Kn6jFkGJH9eNz2bjaKaTY+T8t/+vF4/7oj8+ykF
	6ozhphii0C5MatNxlvSfNE31W+QPufva1
X-Gm-Gg: ASbGncsE0ag6pDYgNZf/Jn7jWwpRtlwI1Q7jwyTlA5FXIuLsyUlSQEIeVQg4cvTV4G+
	0rXwjSJnZbTnWdmr7iSArKTk4M+2lNB0=
X-Google-Smtp-Source: AGHT+IEZ1weGY7xiCEA54OyhfMBMFjSB5CBf/l535XjwyAZSL0hqIiSQKBlQzEOeNQDeaTMozo75j8vV3MF34DHzBJQ=
X-Received: by 2002:a17:902:f54d:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-21614d4ac70mr78752875ad.24.1733546702646; Fri, 06 Dec 2024
 20:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
 <20241206065324.91702-1-renjaya.zenta@formulatrix.com> <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_Mv=GemEk=7Rwp-vPsi2Lb=2AY8rPQHFHHaNHde2Rq2Rg@mail.gmail.com> <1939c554048.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1939c554048.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 6 Dec 2024 22:44:50 -0600
Message-ID: <CAG17S_MSHWUxK_PzHJw6zSV+8OMWxK6ip0ROG0nPNmDEcsM05w@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:17=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 6, 2024 2:29:06 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > I built the kernel and got this:
> > root@jackrune(rw):~# uname -a
> > Linux jackrune 6.6.63-v8+ #3 SMP PREEMPT Tue Dec  3 10:09:16 CST 2024
> > aarch64 GNU/Linux
> >
> > I must've done something wrong, though, as I get this:
> > Dec 06 07:08:10 jackrune kernel: ------------[ cut here ]------------
> > Dec 06 07:08:10 jackrune kernel: WARNING: CPU: 0 PID: 42 at
> > net/wireless/nl80211.c:3822 nl80211_send_chandef+0x188/0x1a0
> > [cfg80211]
>
> The warning originates from here:
>
> int nl80211_send_chandef(struct sk_buff *msg, const struct
> cfg80211_chan_def *chandef)
> {
>  if (WARN_ON(!cfg80211_chandef_valid(chandef)))
>   return -EINVAL;
>
> Let me know if next round goes better/same/worse.
>
> Regards,
> Arend
>
>
I re-built the kernel clean (w/o the patch) and I get the fail message:
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0x100c fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0x100d fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0x100e fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd022 fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd026 fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02a fail, reason -52
Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02e fail, reason -52
When I re-build with the patch, I get the kernel panic
Is there a revised patch?
Keith

