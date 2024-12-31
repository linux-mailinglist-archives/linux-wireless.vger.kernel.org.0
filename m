Return-Path: <linux-wireless+bounces-16948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F59FF0C9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 18:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B99162483
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603D19AD70;
	Tue, 31 Dec 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC4MTdRj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477133CFC
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664455; cv=none; b=Wke2WCGMOnETkWVnExHQC5Ea+OG+dk0iT74U57UR5xs3QKp/IjvnkxZsHya2zlvgFUoJ0EHERRvW6iGGzH7rq6MfERvOzVvHlcKggwfxOYAtIiOlgspuOlO13C1T7p4wxKVyCFrp9cVqinwKWW0YkZj/+e0i089+fQWON60HWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664455; c=relaxed/simple;
	bh=wAx6jU+wiTpUn7XDg7n3yTBDsYxGO4w1hJDUYRU7LQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2nICAFNNNpFZkbrkBjxssNEVT4g8pFEihrrgXTLTWle8FbKcaj4pHdDLWxTXFrTXGOcanFz0m3PVDuM5vH0h7bBz/eaqqOhVr6u09yGKulpQZJE8Xrf8Ml4FbSdnYtGojhpEchoq3KW2syfYF8izn7AcsjlPKofS8JSMYlZjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC4MTdRj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso11178848a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735664453; x=1736269253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM+euzvcGBU1BG7kciJaDpg3mpYlp/vuYIUydkBefoA=;
        b=GC4MTdRjJUM9g1Bu5Z6gTQsCM7PWmB5nH4oRJH53bap21z2VjO1OqoRqPxNE1Bbyn9
         sthCC/sG0UF2xAMXS29k/f0q+97jw3HxdDR6nQzVbJyOM7o9BDlQD85uTx56OMtYHo62
         uDqG9llUkg+FhlYNbFvCUajG+jAlpne+5yNO2hACbdd7rkfP/DH1PpF6OTXf5zGkFpFo
         UaJHsMI0C6wfKwx7K7Z1/y659Rw3+ZAUOhurHDOWQNNuJMZVxaUF+dvOXY1kyqDyBy+7
         r2r/a71L/sse8D/i6q3HwIggGIBpuZRe9vdAW6f1JRmIZkT6cN2nMaoCdku7LpR6fJcx
         0brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735664453; x=1736269253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM+euzvcGBU1BG7kciJaDpg3mpYlp/vuYIUydkBefoA=;
        b=KV5MCryLdZFpLqXane8ZQ4ugg2otAwjGSIqjxeo5YXd8e9nmm43poDDnLurmUZGbSI
         ctMreoGEjlQo28oIGJOAYMat60fUfaqpjMLvuUJiB8xqLn1NBGecIlcxsVlWK5rSDp73
         yUtFRJ1LTMuOYfCrEvT//PL2lP+iba0hSNVTyXHK0P+D5tFKTvL4w8Yv7IeJbPaqXH0Q
         ZWvGYvGdbjnFau6hLQUq7kV8fotEHjrBk2XAGsZ0Kg5s9BVvTam+h+bHrMmL7O0wsk2j
         S8lAOQFcGV78CHOVjLgDvZ8mx51AWoErteBAUfTOj7XPqZQohQNJS99jMEE+JHbm4/W6
         rdig==
X-Forwarded-Encrypted: i=1; AJvYcCVZphiiOUd0iia0W1rNNJIkgIr+u3gxsJ2/FYWmBIbLM2o6jw7SzlS5l47aZ3DMttkGCJRkfj8f5fyvyAy2LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuahfJsE+eGA53jhOSLqKDsEdx9fXiK9MYwP4J3g9C0rwNkWCV
	OE14Kngz4NhR/oNmekApyN++NiCU6cFbNkrSdP0U5I33OiCN4sTupAG3HfdDSohMp/Q5yGTEPrC
	G2akKsZBGPRMhGv5yhNcMpG3UV2U=
X-Gm-Gg: ASbGncuU3BzhX1ZhJXMlgvu/cFPYFCo0DNO7asUxqOQ3aqYX7aNVbJPpQfUoa90lkFR
	eArnylg3ChPhfYGBzwiNFnWZ47RCnTcZ6uBI4pA==
X-Google-Smtp-Source: AGHT+IHsK0loIxnf5jfB1LJLVizfGPYzLnbkhGtyRO72OcRynQCr/lu1bC+jGWYWMXdofzfvp9O4X1WVNqusQS/VUuk=
X-Received: by 2002:a17:90b:2dc3:b0:2ee:8e75:4ae1 with SMTP id
 98e67ed59e1d1-2f452e48804mr52143343a91.21.1735664453055; Tue, 31 Dec 2024
 09:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
 <20241206065324.91702-1-renjaya.zenta@formulatrix.com> <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_Mv=GemEk=7Rwp-vPsi2Lb=2AY8rPQHFHHaNHde2Rq2Rg@mail.gmail.com>
 <1939c554048.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_MSHWUxK_PzHJw6zSV+8OMWxK6ip0ROG0nPNmDEcsM05w@mail.gmail.com>
In-Reply-To: <CAG17S_MSHWUxK_PzHJw6zSV+8OMWxK6ip0ROG0nPNmDEcsM05w@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 31 Dec 2024 11:00:41 -0600
Message-ID: <CAG17S_MfSSwYtqU9Hm=1ZcC4DdpDA07UN0qm=vOMvOZ6wUwrpQ@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:44=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 8:17=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On December 6, 2024 2:29:06 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > > I built the kernel and got this:
> > > root@jackrune(rw):~# uname -a
> > > Linux jackrune 6.6.63-v8+ #3 SMP PREEMPT Tue Dec  3 10:09:16 CST 2024
> > > aarch64 GNU/Linux
> > >
> > > I must've done something wrong, though, as I get this:
> > > Dec 06 07:08:10 jackrune kernel: ------------[ cut here ]------------
> > > Dec 06 07:08:10 jackrune kernel: WARNING: CPU: 0 PID: 42 at
> > > net/wireless/nl80211.c:3822 nl80211_send_chandef+0x188/0x1a0
> > > [cfg80211]
> >
> > The warning originates from here:
> >
> > int nl80211_send_chandef(struct sk_buff *msg, const struct
> > cfg80211_chan_def *chandef)
> > {
> >  if (WARN_ON(!cfg80211_chandef_valid(chandef)))
> >   return -EINVAL;
> >
> > Let me know if next round goes better/same/worse.
> >
> > Regards,
> > Arend
> >
> >
> I re-built the kernel clean (w/o the patch) and I get the fail message:
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0x100c fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0x100d fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0x100e fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd022 fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd026 fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd02a fail, reason -52
> Dec 06 22:38:24 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd02e fail, reason -52
> When I re-build with the patch, I get the kernel panic
> Is there a revised patch?
> Keith

With the newest brcmfmax firmware and teh kernel patch to make WPA3
work on the Pis, I get lost of this in the journal:
Dec 30 23:20:25 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd022 fail, reason -52
Dec 30 23:20:25 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd026 fail, reason -52
Dec 30 23:20:25 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02a fail, reason -52
Dec 30 23:20:25 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02e fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd034 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd038 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd03c fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd040 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd064 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd068 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd06c fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd070 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd074 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd078 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd07c fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd080 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd084 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd088 fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd08c fail, reason -52
Dec 30 23:20:26 runeaudio kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd090 fail, reason -52

I tried the line in  /etc/modprobe.d/brcmfmac.conf
brcmfmac feature_disable=3D0x200000
but do not know what to do with the rest of these. The messages repeat
over and over and fill the log.

it does not seem to affect the function of the wlan as I can still
connect to APs

