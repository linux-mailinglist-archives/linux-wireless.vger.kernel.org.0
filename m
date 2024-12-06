Return-Path: <linux-wireless+bounces-15972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C979E6F48
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D42286D76
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CB207DE8;
	Fri,  6 Dec 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1gm2Vaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55C207669
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491747; cv=none; b=UlkTwNvneVsqz+hzZk3UQLCQbVcCiaP8y64Ta6r85YizrROE/xI22z5S2Lb1BLjIK+ILCbavh/J/hsIUVY0VpEAe/464bm3fCqEq1r4aQ5zj6Ley3jHASaMpz5CWBsTbzo09xBxRxspV6Hn2LOhEOC/MTg8QcURoZkGEEexFNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491747; c=relaxed/simple;
	bh=aAbfucC1rOrmNeZvgCvA6bJptKShvex8Y2h4+qkxIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHdlJAxaNSYxYXptTFMbjufojT8DaVVUMu+wtDMJpjU2m3lIHEFeJY3ScMDygmTKg3pGQJtBGmglgZkH2oxwfx9wk5XPz+wtSaatIyzRHA26PWN4kxGFKxjerPY5NL8zdNw0odEDVt97BGmJLzAnf7ANWA0++pM9nJAAgEQkM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1gm2Vaj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215c4000c20so21328155ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733491745; x=1734096545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD237uIrxMUUWMzUYWqkgHvCHRuFywJyU1ngJ/xhta8=;
        b=V1gm2Vaj0Hk5xqEDx+dLjzjDWxSMVrqTpbJ/HEpe+OWM/mI5IiSJe63pfAyNOicLOF
         08EUv5u3T7wA5QZJHtmSiuUqh1dQ41NdrxR8+YKNRPeo9QdrAGChjXdEG1kyU+0lcg7/
         lQANOqaAuB5m2vjoK/4o5hl0orMGYOO7/1Yg/8FGI6S5LmgpdfFgTUMPSnEFqzNP/uka
         quiYm8oZ0tz7efNmYDCzoGQBCkZl+F9Fbo84J5fPat9Jt7qPe9M8gHNDciQ+zYaJAmk5
         wXj/nmCFlv6iMEtLpTaBp45mvcDB1zx0+Z/pjr67ntgw/vPl2b+tgO5DSJ1c1iB0cxJo
         TqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733491745; x=1734096545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD237uIrxMUUWMzUYWqkgHvCHRuFywJyU1ngJ/xhta8=;
        b=lRz/g9cWrLnKhLAZpLyaim7tWagF/qFz5ejpKikHRsy+ny2umEPI4Nv31NXcZP7qMY
         b8NuKpCFMO85GnQyA8capuck/lAG5bJNx0R1/sq9FQOUQLh/CcDOW1/gXbBvtF4HenfK
         bymkoEaIQI7dnG/uOiNSbw0POOD9EBWIE9NoKzpHnN7akNAlyoWcq/35ZEkgXAFgm8hB
         TrrQaJ4kw2sWwalxU7fS5b9ciB9PTkDSNYRriyQ31fv9Aap09k+dBOA1O+NnqQaX4oIM
         Gh04L3RKWTC4zQQ917GLlHBqNQQs/VHo0BJIqb8tk9QJEiPEkd7tA26ILQnKx1lM/LJp
         OhHA==
X-Forwarded-Encrypted: i=1; AJvYcCXp/hHOqks/S2ijcgVjsh2nPHJu06ju2y1fJEOrYM06+N0IRF4SF5S13LN1jqy5lmEOGXByUpVlZdKLc3f6mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywKkL4fGa68CkoNjM8F+yS4GhI+1d+5sH4pDDv0QMEX13YE0yq
	Vnh9WFAFEohTqCtS3o5LgLACnuMBHvRfY/Np7ecsWyEamesRlS9IvTOgakZoR/TfbWBBonTU0Gr
	WdG4fwTJPwOfjZJICf56+rVn0ymXqxQkn
X-Gm-Gg: ASbGncskw1f+CMwQnP7eSYv1YNzJwvCWcTSWMDzzjLdOYFD/KHgnVLNAAxT3Kfh2Uoy
	YACVBJ5kefqU1yGHsmrmgt2xf0sktums=
X-Google-Smtp-Source: AGHT+IGX4OSlcGyzJeRN1DVuTxz9hdZzLry4rYBO8OEWZS4kRb5ojcIKVI7nflOxNgYjrv70wwTPx7uSI/lhInemqJQ=
X-Received: by 2002:a17:903:2447:b0:215:a2f4:d4a7 with SMTP id
 d9443c01a7336-21614dd19famr33677045ad.57.1733491744938; Fri, 06 Dec 2024
 05:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
 <20241206065324.91702-1-renjaya.zenta@formulatrix.com> <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 6 Dec 2024 07:28:53 -0600
Message-ID: <CAG17S_Mv=GemEk=7Rwp-vPsi2Lb=2AY8rPQHFHHaNHde2Rq2Rg@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I built the kernel and got this:
root@jackrune(rw):~# uname -a
Linux jackrune 6.6.63-v8+ #3 SMP PREEMPT Tue Dec  3 10:09:16 CST 2024
aarch64 GNU/Linux

I must've done something wrong, though, as I get this:
Dec 06 07:08:10 jackrune kernel: ------------[ cut here ]------------
Dec 06 07:08:10 jackrune kernel: WARNING: CPU: 0 PID: 42 at
net/wireless/nl80211.c:3822 nl80211_send_chandef+0x188/0x1a0
[cfg80211]
Dec 06 07:08:10 jackrune kernel: Modules linked in: brcmfmac_wcc
binfmt_misc brcmfmac brcmutil cfg80211 hci_uart bcm2835_codec(C) btbcm
bluetooth bcm2>
Dec 06 07:08:10 jackrune kernel: CPU: 0 PID: 42 Comm: kworker/0:2
Tainted: G         C         6.6.63-v8+ #3
Dec 06 07:08:10 jackrune kernel: Hardware name: Raspberry Pi 3 Model B
Plus Rev 1.3 (DT)
Dec 06 07:08:10 jackrune kernel: Workqueue: events request_firmware_work_fu=
nc
Dec 06 07:08:10 jackrune kernel: pstate: 40000005 (nZcv daif -PAN -UAO
-TCO -DIT -SSBS BTYPE=3D--)
Dec 06 07:08:10 jackrune kernel: pc : nl80211_send_chandef+0x188/0x1a0
[cfg80211]
Dec 06 07:08:10 jackrune kernel: lr : nl80211_send_chandef+0x3c/0x1a0 [cfg8=
0211]
Dec 06 07:08:10 jackrune kernel: sp : ffffffc08048b710
Dec 06 07:08:10 jackrune kernel: x29: ffffffc08048b710 x28:
ffffff80045e1014 x27: ffffffec8b872308
Dec 06 07:08:10 jackrune kernel: x26: ffffffecf2a4d870 x25:
ffffffecf26b5008 x24: ffffffc08048bb68
Dec 06 07:08:10 jackrune kernel: x23: ffffffc08048b7d8 x22:
ffffff8007b48000 x21: ffffff8004c8b000
Dec 06 07:08:10 jackrune kernel: x20: ffffff8003e27d00 x19:
ffffffc08048b7d8 x18: 0000000000000000
Dec 06 07:08:10 jackrune kernel: x17: ffffff93456ad000 x16:
ffffffecf2119150 x15: 0000000000000000
Dec 06 07:08:10 jackrune kernel: x14: 0000000000000000 x13:
0000000000636570 x12: 730000d022000000
Dec 06 07:08:10 jackrune kernel: x11: 0000000000000097 x10:
0000000000001a60 x9 : ffffffec8b88656c
Dec 06 07:08:10 jackrune kernel: x8 : ffffff8007b48528 x7 :
ffffff8007b48528 x6 : 00000000000003e8
Dec 06 07:08:10 jackrune kernel: x5 : ffffff800591fe40 x4 :
0000000000000000 x3 : 000000000058e1e8
Dec 06 07:08:10 jackrune kernel: x2 : ffffff8001fd0000 x1 :
0000000000000000 x0 : 0000000000000000
Dec 06 07:08:10 jackrune kernel: Call trace:
Dec 06 07:08:10 jackrune kernel:  nl80211_send_chandef+0x188/0x1a0 [cfg8021=
1]
Dec 06 07:08:10 jackrune kernel:  nl80211_send_iface+0x72c/0x7c8 [cfg80211]
Dec 06 07:08:10 jackrune kernel:  nl80211_notify_iface+0x60/0xd8 [cfg80211]
Dec 06 07:08:10 jackrune kernel:  cfg80211_register_wdev+0x9c/0x118 [cfg802=
11]
Dec 06 07:08:10 jackrune kernel:
cfg80211_netdev_notifier_call+0xf4/0x558 [cfg80211]
Dec 06 07:08:10 jackrune kernel:  notifier_call_chain+0x78/0x148
Dec 06 07:08:10 jackrune kernel:  raw_notifier_call_chain+0x20/0x38
Dec 06 07:08:10 jackrune kernel:  call_netdevice_notifiers_info+0x60/0xb8
Dec 06 07:08:10 jackrune kernel:  register_netdevice+0x5ac/0x698
Dec 06 07:08:10 jackrune kernel:  register_netdev+0x2c/0x58
Dec 06 07:08:10 jackrune kernel:  brcmf_net_attach+0x134/0x178 [brcmfmac]
Dec 06 07:08:10 jackrune kernel:  brcmf_attach+0x238/0x4e8 [brcmfmac]
Dec 06 07:08:10 jackrune kernel:
brcmf_sdio_firmware_callback+0x7fc/0x960 [brcmfmac]
Dec 06 07:08:10 jackrune kernel:  brcmf_fw_request_done+0x150/0x198 [brcmfm=
ac]
Dec 06 07:08:10 jackrune kernel:
brcmf_fw_request_done_alt_path+0xa0/0xf8 [brcmfmac]
Dec 06 07:08:10 jackrune kernel:  request_firmware_work_func+0x58/0xb0
Dec 06 07:08:10 jackrune kernel:  process_one_work+0x148/0x3b8
Dec 06 07:08:10 jackrune kernel:  worker_thread+0x32c/0x450
Dec 06 07:08:10 jackrune kernel:  kthread+0x11c/0x128
Dec 06 07:08:10 jackrune kernel:  ret_from_fork+0x10/0x20
Dec 06 07:08:10 jackrune kernel: ---[ end trace 0000000000000000 ]---
and this:
Dec 06 07:19:17 jackrune kernel: ------------[ cut here ]------------
Dec 06 07:19:17 jackrune kernel: WARNING: CPU: 3 PID: 332 at
net/wireless/nl80211.c:3822 nl80211_send_chandef+0x188/0x1a0
[cfg80211]
Dec 06 07:19:17 jackrune kernel: Modules linked in: ghash_generic
ghash_ce gf128mul gcm ccm 8021q algif_aead crypto_null garp stp llc
ctr iptable_nat >
Dec 06 07:19:17 jackrune kernel: CPU: 3 PID: 332 Comm: iwd Tainted: G
      WC         6.6.63-v8+ #3
Dec 06 07:19:17 jackrune kernel: Hardware name: Raspberry Pi 3 Model B
Plus Rev 1.3 (DT)
Dec 06 07:19:17 jackrune kernel: pstate: 40000005 (nZcv daif -PAN -UAO
-TCO -DIT -SSBS BTYPE=3D--)
Dec 06 07:19:17 jackrune kernel: pc : nl80211_send_chandef+0x188/0x1a0
[cfg80211]
Dec 06 07:19:17 jackrune kernel: lr : nl80211_send_chandef+0x3c/0x1a0 [cfg8=
0211]
Dec 06 07:19:17 jackrune kernel: sp : ffffffc080a93650
Dec 06 07:19:17 jackrune kernel: x29: ffffffc080a93650 x28:
ffffff8005961ed4 x27: ffffff800ad3eb58
Dec 06 07:19:17 jackrune kernel: x26: ffffff8007b48810 x25:
ffffffec8b8ea838 x24: ffffffffffffffff
Dec 06 07:19:17 jackrune kernel: x23: ffffffc080a93718 x22:
ffffff8007b48000 x21: ffffff8004c8b000
Dec 06 07:19:17 jackrune kernel: x20: ffffff8008bae400 x19:
ffffffc080a93718 x18: 0000000000000000
Dec 06 07:19:17 jackrune kernel: x17: ffffff9345707000 x16:
ffffffecf2119150 x15: 0000000000000000
Dec 06 07:19:17 jackrune kernel: x14: 009009f090d000c6 x13:
0000000000636570 x12: 730000d022000000
Dec 06 07:19:17 jackrune kernel: x11: 000000000000013a x10:
0000000000001a60 x9 : ffffffec8b88656c
Dec 06 07:19:17 jackrune kernel: x8 : ffffff8007b48528 x7 :
ffffff8007b48528 x6 : 00000000000003e8
Dec 06 07:19:17 jackrune kernel: x5 : ffffff800591fe40 x4 :
0000000000000000 x3 : 000000000058e1e8
Dec 06 07:19:17 jackrune kernel: x2 : ffffff800643dc40 x1 :
0000000000000000 x0 : 0000000000000000
Dec 06 07:19:17 jackrune kernel: Call trace:
Dec 06 07:19:17 jackrune kernel:  nl80211_send_chandef+0x188/0x1a0 [cfg8021=
1]
Dec 06 07:19:17 jackrune kernel:  nl80211_send_iface+0x72c/0x7c8 [cfg80211]
Dec 06 07:19:17 jackrune kernel:  nl80211_dump_interface+0x10c/0x200 [cfg80=
211]
Dec 06 07:19:17 jackrune kernel:  genl_dumpit+0x48/0xd8
Dec 06 07:19:17 jackrune kernel:  netlink_dump+0x130/0x330
Dec 06 07:19:17 jackrune kernel:  __netlink_dump_start+0x258/0x348
Dec 06 07:19:17 jackrune kernel:  genl_family_rcv_msg_dumpit+0x90/0x120
Dec 06 07:19:17 jackrune kernel:  genl_rcv_msg+0x128/0x298
Dec 06 07:19:17 jackrune kernel:  netlink_rcv_skb+0x64/0x138
Dec 06 07:19:17 jackrune kernel:  genl_rcv+0x40/0x60
Dec 06 07:19:17 jackrune kernel:  netlink_unicast+0x2fc/0x370
Dec 06 07:19:17 jackrune kernel:  netlink_sendmsg+0x1c4/0x448
Dec 06 07:19:17 jackrune kernel:  __sock_sendmsg+0x64/0xc0
Dec 06 07:19:17 jackrune kernel:  __sys_sendto+0x114/0x178
Dec 06 07:19:17 jackrune kernel:  __arm64_sys_sendto+0x30/0x48
Dec 06 07:19:17 jackrune kernel:  invoke_syscall+0x50/0x128
Dec 06 07:19:17 jackrune kernel:  el0_svc_common.constprop.0+0xc8/0xf0
Dec 06 07:19:17 jackrune kernel:  do_el0_svc+0x24/0x38
Dec 06 07:19:17 jackrune kernel:  el0_svc+0x38/0xd0
Dec 06 07:19:17 jackrune kernel:  el0t_64_sync_handler+0x100/0x130
Dec 06 07:19:17 jackrune kernel:  el0t_64_sync+0x190/0x198
Dec 06 07:19:17 jackrune kernel: ---[ end trace 0000000000000000 ]---

I'll start over and try it again and see how far I get.

On Fri, Dec 6, 2024 at 1:36=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 6, 2024 7:53:28 AM Renjaya Raga Zenta
> <renjaya.zenta@formulatrix.com> wrote:
>
> > On Thu, 5 Dec 2024 14:10:51 +0100 Arend Van Spriel wrote:
> >> Can you try the patch attached?
> >
> > I've just tried this in 6.6, obviously the errors disappear. Tested wit=
h
> > DUMP_OBSS enabled.
>
> Thanks, Renjaya
>
> It was the pragmatic fix. There still seems a potential issue in how
> brcmfmac provides the channels to cfg80211.
>
> > Will this also land to stable?
>
> I have not formally submitted it to linux-wireless. I will add the
> appropriate tags for stable.
>
> Regards,
> Arend
>
>
>

