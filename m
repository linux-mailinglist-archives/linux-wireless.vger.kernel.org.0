Return-Path: <linux-wireless+bounces-30315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6FCF04C0
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB8E3005BB6
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED442D46BD;
	Sat,  3 Jan 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDpztE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DB202997
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767467513; cv=none; b=oC/jER8mbORb1EAPFYYffGFHBOAxTC3kESnjO7FHbrg5mfnbR/NlByck9mDjU19pMCoeUIyrZAqb/XnuTVzHJTmjdeRKHkPm9FNSoKQ3wOh1zoQVU5hsi1xLke5u/VB+bf1WudagsrOq+3uJ233Gnd7FRUb10QasbksIAXsj+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767467513; c=relaxed/simple;
	bh=WQcwZxicd8tJeEZ8wwSKgGLrcryWZ+8gen//HqTDZy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5MD07waAN4rEtPDXUSH6oHqYJDCqppxFKMpavCLStjEFY8pDBsct09trtBVwj2g262k2F7FbK7iUYQ65b5HIbF/Etx4jHK1jgcbUDY+0aR+Cetz73sPpHXW5VcpCe3r+5x0hE93MicvmerOcJM+xvoT8UuT6VkNE/1HE/GFItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDpztE7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1470712a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 03 Jan 2026 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767467509; x=1768072309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbM6OEs6gWHNMToJKyj6Q6XC6FBG59lkOQg74xUYRMI=;
        b=iSDpztE7oo4lhHaOMVQiiDbtoiMxXfF8uLhMJIZ8qvP2EkV/sDEkFdPxRhiE99d5iA
         2JmU9eylI/im41j50xPPlMJN/5WyHQGTtzTOMH6l3wbKN0flmRTsMX2d5ai6AZ9G9K+J
         Rfg8XwyAXuLRNxtdb9QkohOC77FaowdIvyNjfRI/beK4wklgKGQplX0zDFdY7WWFPIZi
         LcR7DJ+sFIhYofhYVv6NaRYFBl+kWzqsD/Kut7n6eLBT0fTn5hHL4dZP8ptGg1upGiSP
         C+hFutlLz+F4Hr2kb+QhqhCCkZ/46q+uUix2kcrYwHSkMvaz5cc5+rto81+jqsHeklo4
         vndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767467509; x=1768072309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbM6OEs6gWHNMToJKyj6Q6XC6FBG59lkOQg74xUYRMI=;
        b=f+cJCLRnHCyEECCDM9sTsIgvQHvpai+i+4HDKjSCxwAPCnh5StkfCl/eeoTNNaPAQD
         GaLpZZyV2KLT6jhctVysHBBanIE9Z7Z5h190T2YQsWTgBMN98F9nQ+B4g7aNuTLgws5e
         ucKZEA6iO2Ei7EY0sTlLpleqGSqi5P9o92ro4epAzutxLHesYxRPwsO7dZddId9xk6Cu
         fqhcDVTllzXXrTuYg+VuHz1E/gimVnvL50LiDC6S8+aTshcQd8bCDE5nwm0GaOnHe4S5
         h9Fb8Qg1B4QOrdmviC0pVHMWKuUlslsQkAz3bElcODsv/KfxEKwZKLsljgjqm5GPTQaA
         W45w==
X-Forwarded-Encrypted: i=1; AJvYcCXcicVY5uLxM2+dLgFQoamoCZISeqw7NSiCIZQtaGRCJfMHqj+YWe65g0NHFZvyOTHsSjepl/vE2b1fncip0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMouwXWX0O5LaWZuC0tGZPww3qf3gUQTsFTrp2I4Lv9kNn0Lj
	7pqOK+zc5GpZL5KlCJnCqXOZ7G9BALHkSCw9OPJDWNuwZn7J/4yuz1UQVPB8cANQthAIGF6H/Dd
	KPLhDiHvXBE+Mnj+qwDkCvHY+zbn4dNw=
X-Gm-Gg: AY/fxX50W3YdEnIR+dueAOKfr/B8XrQiMiPT7+WeSklDwA35pv7K+olWKbFJUkwz7p4
	2Bwp1tiHECjvrMjY330u9rrunP+WrBrSSOtPH709d8Mjvgd8076d9rRupyV2BsF/6r04w8wJK/o
	AsvSiZg46IJaK69nX3fwrEYgl3BRThtyOEdoRW/eKzN0IznZZmaoem4UoidocTzwu++Tg4l/sEb
	qQ2qMlYB+5hD3YNjlSskGb3Fq6jgVlsZMZpremA7E3Pf7rc5ZqPRpmYP4igj3Vy70YuJVHkvk3u
	Ka2Cs3PMbdhu7DzmyY/lHbkVIXP/utoKKpm4XYcB11PDl0o6mA+fuXiF+MreCMHaUDsF
X-Google-Smtp-Source: AGHT+IGcSMOjY5H1/cN/FJpz1ZhVisyJEr9Phi+8YOtG5/u7q/YH06BnP/7PwX/39yA+rX4/zl5XbwbyJJEhckFh78o=
X-Received: by 2002:a50:bb04:0:b0:64b:5625:c519 with SMTP id
 4fb4d7f45d1cf-64fd4b5eefcmr2215684a12.10.1767467509244; Sat, 03 Jan 2026
 11:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102200315.290015-1-zbowling@gmail.com> <20260102200524.290779-1-zbowling@gmail.com>
 <CAGp9Lzozp3-hG9vJ85a5zmM13+VdSJvn3jqeU1L4mdTu3N2+7g@mail.gmail.com>
In-Reply-To: <CAGp9Lzozp3-hG9vJ85a5zmM13+VdSJvn3jqeU1L4mdTu3N2+7g@mail.gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Sat, 3 Jan 2026 11:11:37 -0800
X-Gm-Features: AQt7F2pEBR-ynOkimZUugh07CPcWvHVDziBKBmOjk-2u43S6ffHvjQkpV93rYNI
Message-ID: <CAOFcj8TjZ9T1E9ViM5=H43Dsh5BwOQrHp4_LkGELSvO9=VOnYA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: comprehensive stability fixes
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

1) I have some 17 smaller patches that got into more detail
but didn't want to spam. When sending here to LKMS I squashed that
down into about 7 initially that I have already sent in the last 3 days.
I wasn't sure if a fully squashed patch would make it easier to review,
since it's all related to a similar class of bug, which this patch is.

Most of this stemmed from null deref crash I ran into in a few places,
either during re-auth attempts that failed from a bad key or from other
races in state changes. When I was investigating searching google I
found a half a dozen other similar crashes posted on forums from folks
that hit similar things but no correct solution. Just folks doing hacks.

That's when I wrote a little stress test tool that if you have the right AP
environment like two APs with the same SSID with Wifi 7 and MLO
enabled you can trigger different races with some hammering and get a
consistent repro case. I'm using 3 Ubiquiti 7 Pro APs and it's been panic
city over here the last month which got me motivated enough to
investigate over my holiday break.

Some of these null and error return checks are purely defensive
additions to prevent future regressions.

2) I have a folder full of dumps after my stress tests to repro :)
They all look similar to this but the exact null defref is not always in
the same place. All from after ieee80211_iterate_interfaces so my patches
mostly work to check locks in or around that call. The deadlocks I have
some dmesg logs but that aren't too interesting.

[ 655.737302] [ T12] BUG: kernel NULL pointer dereference, address:
0000000000000000
[ 655.737320] [ T12] #PF: supervisor read access in kernel mode
[ 655.737324] [ T12] #PF: error_code(0x0000) - not-present page
[ 655.737328] [ T12] PGD 0 P4D 0
[ 655.737334] [ T12] Oops: Oops: 0000 [#1] SMP NOPTI
[ 655.737342] [ T12] CPU: 20 UID: 0 PID: 12 Comm: kworker/u128:0
Kdump: loaded Tainted: G OE 6.17.0-8-generic #8-Ubuntu
PREEMPT(voluntary)
[ 655.737350] [ T12] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[ 655.737351] [ T12] Hardware name: Framework Desktop (AMD Ryzen AI
Max 300 Series)/FRANMFCP06, BIOS 03.04 11/19/2025
[ 655.737354] [ T12] Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
[ 655.737370] [ T12] RIP: 0010:mt76_connac_mcu_uni_add_dev+0xba/0x1f0
[mt76_connac_lib]
[ 655.737385] [ T12] Code: cc 66 44 89 5d d2 44 88 45 d4 44 88 4d d5
88 65 d7 c6 45 dc 01 88 55 dd 0f b7 97 b8 00 00 00 88 4d ef 66 89 55
e4 66 89 55 ea <48> 8b 16 8b 12 83 fa 03 0f 84 0c 01 00 00 77 1b 83 fa
01 0f 84 f5
[ 655.737388] [ T12] RSP: 0018:ffffd07fc018fcb0 EFLAGS: 00010282
[ 655.737392] [ T12] RAX: 000000000000ff00 RBX: ffff8a4449442040 RCX:
0000000000000000
[ 655.737394] [ T12] RDX: 0000000000000013 RSI: 0000000000000000 RDI:
ffff8a44c7d7a4b0
[ 655.737396] [ T12] RBP: ffffd07fc018fcf8 R08: 0000000000000001 R09:
0000000000000000
[ 655.737397] [ T12] R10: 0000000000000000 R11: 0000000000000020 R12:
ffff8a4449442040
[ 655.737399] [ T12] R13: ffff8a44c7d79f08 R14: 0000000000000000 R15:
ffff8a44c7d78a80
[ 655.737401] [ T12] FS: 0000000000000000(0000)
GS:ffff8a53ca47f000(0000) knlGS:0000000000000000
[ 655.737403] [ T12] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 655.737404] [ T12] CR2: 0000000000000000 CR3: 00000009e2a40000 CR4:
0000000000f50ef0
[ 655.737406] [ T12] PKRU: 55555554
[ 655.737408] [ T12] Call Trace:
[ 655.737411] [ T12]
[ 655.737416] [ T12] mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
[ 655.737423] [ T12] __iterate_interfaces+0x92/0x130 [mac80211]
[ 655.737500] [ T12] ? __pfx_mt7925_vif_connect_iter+0x10/0x10 [mt7925_comm=
on]
[ 655.737506] [ T12] ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
[ 655.737549] [ T12] ? __pfx_mt7925_vif_connect_iter+0x10/0x10 [mt7925_comm=
on]
[ 655.737553] [ T12] mt7925_mac_reset_work+0x105/0x190 [mt7925_common]
[ 655.737559] [ T12] process_one_work+0x18b/0x370
[ 655.737567] [ T12] worker_thread+0x317/0x450
[ 655.737570] [ T12] ? __pfx_worker_thread+0x10/0x10
[ 655.737573] [ T12] kthread+0x108/0x220
[ 655.737577] [ T12] ? __pfx_kthread+0x10/0x10
[ 655.737579] [ T12] ret_from_fork+0x131/0x150
[ 655.737585] [ T12] ? __pfx_kthread+0x10/0x10
[ 655.737587] [ T12] ret_from_fork_asm+0x1a/0x30

3) Yeah, some of my later patches came from static analysis
(clang-tidy, etc) but
also AI, mostly looking for additional cases I missed since I'm new to
this code. Some
of the patches were actually porting over changes made for other MT chipset=
s
not applied to this one that seemed relevant. I'll try to include more
details. This is all
just an attempt to get my personal machine stable overnight so I don't
have to run
ethernet and just blacklist the driver :)

4) Sounds good! Will do!

Zac Bowling

On Fri, Jan 2, 2026 at 10:26=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> Hi Zac,
>
> Thanks for the extensive work digging into the MT7925 stability issues
> the problems you=E2=80=99re addressing are real and definitely worth fixi=
ng.
>
> For upstream review, it would help a lot to align with a few common pract=
ices:
>
> 1) One patch should handle one issue. Splitting this into smaller,
>    self-contained patches makes review easier and allows safe reverts.
>
> 2) For fixes of runtime failures (panic, NULL deref, hangs), please inclu=
de
>    the relevant dmesg or crash log in the commit message so reviewers and
>    downstream users can clearly see the failure being addressed and
>    determine whether they are hitting the same issue.
>
> 3) If a fix comes from static analysis (e.g. clang static analyzer), that=
=E2=80=99s
>    perfectly fine, just mention it in the commit message and briefly expl=
ain
>    why the state or pointer can be invalid at runtime.
>
> 4) For review, it would also be helpful to aggregate the fixes from v1, v=
2,
>    and this one into a clean v3 series based on the current wireless
>    tree (https://github.com/nbd168/wireless.git).
>
>                    Sean
>
> On Fri, Jan 2, 2026 at 2:05=E2=80=AFPM Zac Bowling <zbowling@gmail.com> w=
rote:
> >
> > From: Zac Bowling <zac@zacbowling.com>
> >
> > This unified patch combines all MT7925 driver fixes for kernel stabilit=
y:
> >
> > 1. NULL pointer dereference fixes in vif iteration, TX path, and MCU fu=
nctions
> > 2. Missing mutex protection in reset, ROC, PM, and resume paths
> > 3. Error handling for MCU commands (AMPDU, BSS info, key setup)
> > 4. lockdep assertions for debugging
> > 5. MLO (Multi-Link Operation) improvements for roaming and AP mode
> > 6. Firmware reload recovery after crashes
> >
> > These fixes address kernel panics and system hangs that occur during:
> > - WiFi network switching and BSSID roaming
> > - Suspend/resume cycles
> > - MLO link state transitions
> > - Firmware recovery after crashes
> >
> > Tested on Framework Desktop (AMD Ryzen AI Max 300) with MT7925 (RZ717).
> >
> > Individual patches and detailed analysis available at:
> > https://github.com/zbowling/mt7925
> >
> > Signed-off-by: Zac Bowling <zac@zacbowling.com>
> > ---
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7925/init.c
> > index d7d5afe365ed..f800112ccaf7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> > @@ -162,10 +162,17 @@ void mt7925_regd_update(struct mt792x_dev *dev)
> >         if (!dev->regd_change)
> >                 return;
> >
> > -       mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
> > +       if (mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env) =
< 0)
> > +               dev_warn(dev->mt76.dev, "Failed to set CLC\n");
> > +
> >         mt7925_regd_channel_update(wiphy, dev);
> > -       mt7925_mcu_set_channel_domain(hw->priv);
> > -       mt7925_set_tx_sar_pwr(hw, NULL);
> > +
> > +       if (mt7925_mcu_set_channel_domain(hw->priv) < 0)
> > +               dev_warn(dev->mt76.dev, "Failed to set channel domain\n=
");
> > +
> > +       if (mt7925_set_tx_sar_pwr(hw, NULL) < 0)
> > +               dev_warn(dev->mt76.dev, "Failed to set TX SAR power\n")=
;
> > +
> >         dev->regd_change =3D false;
> >  }
> >  EXPORT_SYMBOL_GPL(mt7925_regd_update);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/mac.c
> > index 1e44e96f034e..a4109dc72163 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> > @@ -1270,6 +1270,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
> >                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> >                 mconf =3D mt792x_vif_to_link(mvif, i);
> >
> > +               /* Skip links that don't have bss_conf set up yet in ma=
c80211.
> > +                * This can happen during HW reset when link state is i=
nconsistent.
> > +                */
> > +               if (!bss_conf)
> > +                       continue;
> > +
> >                 mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mcon=
f->mt76,
> >                                             &mvif->sta.deflink.wcid, tr=
ue);
> >                 mt7925_mcu_set_tx(dev, bss_conf);
> > @@ -1324,9 +1330,11 @@ void mt7925_mac_reset_work(struct work_struct *w=
ork)
> >         dev->hw_full_reset =3D false;
> >         pm->suspended =3D false;
> >         ieee80211_wake_queues(hw);
> > +       mt792x_mutex_acquire(dev);
> >         ieee80211_iterate_active_interfaces(hw,
> >                                             IEEE80211_IFACE_ITER_RESUME=
_ALL,
> >                                             mt7925_vif_connect_iter, NU=
LL);
> > +       mt792x_mutex_release(dev);
> >         mt76_connac_power_save_sched(&dev->mt76.phy, pm);
> >
> >         mt792x_mutex_acquire(dev);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7925/main.c
> > index ac3d485a2f78..b6e3002faf41 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > @@ -596,6 +596,17 @@ static int mt7925_set_link_key(struct ieee80211_hw=
 *hw, enum set_key_cmd cmd,
> >         link_sta =3D sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : =
NULL;
> >         mconf =3D mt792x_vif_to_link(mvif, link_id);
> >         mlink =3D mt792x_sta_to_link(msta, link_id);
> > +
> > +       if (!link_conf || !mconf || !mlink) {
> > +               /* During MLO roaming, link state may be torn down befo=
re
> > +                * mac80211 requests key removal. If removing a key and
> > +                * the link is already gone, consider it successfully r=
emoved.
> > +                */
> > +               if (cmd !=3D SET_KEY)
> > +                       return 0;
> > +               return -EINVAL;
> > +       }
> > +
> >         wcid =3D &mlink->wcid;
> >         wcid_keyidx =3D &wcid->hw_key_idx;
> >
> > @@ -625,8 +636,10 @@ static int mt7925_set_link_key(struct ieee80211_hw=
 *hw, enum set_key_cmd cmd,
> >                 struct mt792x_phy *phy =3D mt792x_hw_phy(hw);
> >
> >                 mconf->mt76.cipher =3D mt7925_mcu_get_cipher(key->ciphe=
r);
> > -               mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf=
,
> > -                                       link_sta, true);
> > +               err =3D mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, l=
ink_conf,
> > +                                             link_sta, true);
> > +               if (err)
> > +                       goto out;
> >         }
> >
> >         if (cmd =3D=3D SET_KEY)
> > @@ -743,9 +756,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
> >         bool monitor =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
> >
> >         pm->enable =3D pm->enable_user && !monitor;
> > +       mt792x_mutex_acquire(dev);
> >         ieee80211_iterate_active_interfaces(hw,
> >                                             IEEE80211_IFACE_ITER_RESUME=
_ALL,
> >                                             mt7925_pm_interface_iter, d=
ev);
> > +       mt792x_mutex_release(dev);
> >         pm->ds_enable =3D pm->ds_enable_user && !monitor;
> >         mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
> >  }
> > @@ -848,12 +863,17 @@ static int mt7925_mac_link_sta_add(struct mt76_de=
v *mdev,
> >
> >         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
> >         mlink =3D mt792x_sta_to_link(msta, link_id);
> > +       if (!mlink)
> > +               return -EINVAL;
> >
> >         idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - =
1);
> >         if (idx < 0)
> >                 return -ENOSPC;
> >
> >         mconf =3D mt792x_vif_to_link(mvif, link_id);
> > +       if (!mconf)
> > +               return -EINVAL;
> > +
> >         mt76_wcid_init(&mlink->wcid, 0);
> >         mlink->wcid.sta =3D 1;
> >         mlink->wcid.idx =3D idx;
> > @@ -879,15 +899,20 @@ static int mt7925_mac_link_sta_add(struct mt76_de=
v *mdev,
> >                                MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> > +       if (!link_conf)
> > +               return -EINVAL;
> >
> >         /* should update bss info before STA add */
> >         if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->=
tdls) {
> >                 if (ieee80211_vif_is_mld(vif))
> > -                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.=
ctx,
> > -                                               link_conf, link_sta, li=
nk_sta !=3D mlink->pri_link);
> > +                       ret =3D mt7925_mcu_add_bss_info(&dev->phy, mcon=
f->mt76.ctx,
> > +                                                     link_conf, link_s=
ta,
> > +                                                     link_sta !=3D mli=
nk->pri_link);
> >                 else
> > -                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.=
ctx,
> > -                                               link_conf, link_sta, fa=
lse);
> > +                       ret =3D mt7925_mcu_add_bss_info(&dev->phy, mcon=
f->mt76.ctx,
> > +                                                     link_conf, link_s=
ta, false);
> > +               if (ret)
> > +                       return ret;
> >         }
> >
> >         if (ieee80211_vif_is_mld(vif) &&
> > @@ -985,18 +1010,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, stru=
ct ieee80211_vif *vif)
> >  {
> >         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev=
, mt76);
> >         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> > -       struct ieee80211_bss_conf *link_conf =3D
> > -               mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
> > -       struct cfg80211_chan_def *chandef =3D &link_conf->chanreq.oper;
> > -       enum nl80211_band band =3D chandef->chan->band, secondary_band;
> > +       struct ieee80211_bss_conf *link_conf;
> > +       struct cfg80211_chan_def *chandef;
> > +       enum nl80211_band band, secondary_band;
> > +       u16 sel_links;
> > +       u8 secondary_link_id;
> > +
> > +       link_conf =3D mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
> > +       if (!link_conf)
> > +               return;
> > +
> > +       chandef =3D &link_conf->chanreq.oper;
> > +       band =3D chandef->chan->band;
> >
> > -       u16 sel_links =3D mt76_select_links(vif, 2);
> > -       u8 secondary_link_id =3D __ffs(~BIT(mvif->deflink_id) & sel_lin=
ks);
> > +       sel_links =3D mt76_select_links(vif, 2);
> > +       secondary_link_id =3D __ffs(~BIT(mvif->deflink_id) & sel_links)=
;
> >
> >         if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
> >                 return;
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, secondary_link_id);
> > +       if (!link_conf)
> > +               return;
> > +
> >         secondary_band =3D link_conf->chanreq.oper.chan->band;
> >
> >         if (band =3D=3D NL80211_BAND_2GHZ ||
> > @@ -1024,6 +1060,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76=
_dev *mdev,
> >
> >         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
> >         mlink =3D mt792x_sta_to_link(msta, link_sta->link_id);
> > +       if (!mlink)
> > +               return;
> >
> >         mt792x_mutex_acquire(dev);
> >
> > @@ -1033,12 +1071,13 @@ static void mt7925_mac_link_sta_assoc(struct mt=
76_dev *mdev,
> >                 link_conf =3D mt792x_vif_to_bss_conf(vif, vif->bss_conf=
.link_id);
> >         }
> >
> > -       if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->=
tdls) {
> > +       if (link_conf && vif->type =3D=3D NL80211_IFTYPE_STATION && !li=
nk_sta->sta->tdls) {
> >                 struct mt792x_bss_conf *mconf;
> >
> >                 mconf =3D mt792x_link_conf_to_mconf(link_conf);
> > -               mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
> > -                                       link_conf, link_sta, true);
> > +               if (mconf)
> > +                       mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.=
ctx,
> > +                                               link_conf, link_sta, tr=
ue);
> >         }
> >
> >         ewma_avg_signal_init(&mlink->avg_ack_signal);
> > @@ -1085,6 +1124,8 @@ static void mt7925_mac_link_sta_remove(struct mt7=
6_dev *mdev,
> >
> >         msta =3D (struct mt792x_sta *)link_sta->sta->drv_priv;
> >         mlink =3D mt792x_sta_to_link(msta, link_id);
> > +       if (!mlink)
> > +               return;
> >
> >         mt7925_roc_abort_sync(dev);
> >
> > @@ -1098,10 +1139,12 @@ static void mt7925_mac_link_sta_remove(struct m=
t76_dev *mdev,
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> >
> > -       if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->=
tdls) {
> > +       if (link_conf && vif->type =3D=3D NL80211_IFTYPE_STATION && !li=
nk_sta->sta->tdls) {
> >                 struct mt792x_bss_conf *mconf;
> >
> >                 mconf =3D mt792x_link_conf_to_mconf(link_conf);
> > +               if (!mconf)
> > +                       goto out;
> >
> >                 if (ieee80211_vif_is_mld(vif))
> >                         mt792x_mac_link_bss_remove(dev, mconf, mlink);
> > @@ -1109,6 +1152,7 @@ static void mt7925_mac_link_sta_remove(struct mt7=
6_dev *mdev,
> >                         mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.=
ctx, link_conf,
> >                                                 link_sta, false);
> >         }
> > +out:
> >
> >         spin_lock_bh(&mdev->sta_poll_lock);
> >         if (!list_empty(&mlink->wcid.poll_list))
> > @@ -1247,22 +1291,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif,
> >         case IEEE80211_AMPDU_RX_START:
> >                 mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid=
, ssn,
> >                                    params->buf_size);
> > -               mt7925_mcu_uni_rx_ba(dev, params, true);
> > +               ret =3D mt7925_mcu_uni_rx_ba(dev, params, true);
> >                 break;
> >         case IEEE80211_AMPDU_RX_STOP:
> >                 mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid)=
;
> > -               mt7925_mcu_uni_rx_ba(dev, params, false);
> > +               ret =3D mt7925_mcu_uni_rx_ba(dev, params, false);
> >                 break;
> >         case IEEE80211_AMPDU_TX_OPERATIONAL:
> >                 mtxq->aggr =3D true;
> >                 mtxq->send_bar =3D false;
> > -               mt7925_mcu_uni_tx_ba(dev, params, true);
> > +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, true);
> >                 break;
> >         case IEEE80211_AMPDU_TX_STOP_FLUSH:
> >         case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
> >                 mtxq->aggr =3D false;
> >                 clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> > -               mt7925_mcu_uni_tx_ba(dev, params, false);
> > +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, false);
> >                 break;
> >         case IEEE80211_AMPDU_TX_START:
> >                 set_bit(tid, &msta->deflink.wcid.ampdu_state);
> > @@ -1271,8 +1315,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, stru=
ct ieee80211_vif *vif,
> >         case IEEE80211_AMPDU_TX_STOP_CONT:
> >                 mtxq->aggr =3D false;
> >                 clear_bit(tid, &msta->deflink.wcid.ampdu_state);
> > -               mt7925_mcu_uni_tx_ba(dev, params, false);
> > -               ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
> > +               ret =3D mt7925_mcu_uni_tx_ba(dev, params, false);
> > +               if (!ret)
> > +                       ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr,=
 tid);
> >                 break;
> >         }
> >         mt792x_mutex_release(dev);
> > @@ -1293,12 +1338,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct =
ieee80211_vif *vif)
> >         if (mvif->mlo_pm_state !=3D MT792x_MLO_CHANGED_PS)
> >                 return;
> >
> > -       mt792x_mutex_acquire(dev);
> >         for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
> >                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> > +               if (!bss_conf)
> > +                       continue;
> >                 mt7925_mcu_uni_bss_ps(dev, bss_conf);
> >         }
> > -       mt792x_mutex_release(dev);
> >  }
> >
> >  void mt7925_mlo_pm_work(struct work_struct *work)
> > @@ -1307,9 +1352,11 @@ void mt7925_mlo_pm_work(struct work_struct *work=
)
> >                                               mlo_pm_work.work);
> >         struct ieee80211_hw *hw =3D mt76_hw(dev);
> >
> > +       mt792x_mutex_acquire(dev);
> >         ieee80211_iterate_active_interfaces(hw,
> >                                             IEEE80211_IFACE_ITER_RESUME=
_ALL,
> >                                             mt7925_mlo_pm_iter, dev);
> > +       mt792x_mutex_release(dev);
> >  }
> >
> >  static bool is_valid_alpha2(const char *alpha2)
> > @@ -1645,6 +1692,8 @@ static void mt7925_ipv6_addr_change(struct ieee80=
211_hw *hw,
> >
> >         for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
> >                 bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> > +               if (!bss_conf)
> > +                       continue;
> >                 __mt7925_ipv6_addr_change(hw, bss_conf, idev);
> >         }
> >  }
> > @@ -1706,6 +1755,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ie=
ee80211_vif *vif,
> >                     [IEEE80211_AC_BK] =3D 1,
> >         };
> >
> > +       if (!mconf)
> > +               return -EINVAL;
> > +
> >         /* firmware uses access class index */
> >         mconf->queue_params[mq_to_aci[queue]] =3D *params;
> >
> > @@ -1876,6 +1928,8 @@ static void mt7925_vif_cfg_changed(struct ieee802=
11_hw *hw,
> >         if (changed & BSS_CHANGED_ARP_FILTER) {
> >                 for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS=
) {
> >                         bss_conf =3D mt792x_vif_to_bss_conf(vif, i);
> > +                       if (!bss_conf)
> > +                               continue;
> >                         mt7925_mcu_update_arp_filter(&dev->mt76, bss_co=
nf);
> >                 }
> >         }
> > @@ -1891,6 +1945,8 @@ static void mt7925_vif_cfg_changed(struct ieee802=
11_hw *hw,
> >                         } else if (mvif->mlo_pm_state =3D=3D MT792x_MLO=
_CHANGED_PS) {
> >                                 for_each_set_bit(i, &valid, IEEE80211_M=
LD_MAX_NUM_LINKS) {
> >                                         bss_conf =3D mt792x_vif_to_bss_=
conf(vif, i);
> > +                                       if (!bss_conf)
> > +                                               continue;
> >                                         mt7925_mcu_uni_bss_ps(dev, bss_=
conf);
> >                                 }
> >                         }
> > @@ -1912,7 +1968,12 @@ static void mt7925_link_info_changed(struct ieee=
80211_hw *hw,
> >         struct ieee80211_bss_conf *link_conf;
> >
> >         mconf =3D mt792x_vif_to_link(mvif, info->link_id);
> > +       if (!mconf)
> > +               return;
> > +
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, mconf->link_id);
> > +       if (!link_conf)
> > +               return;
> >
> >         mt792x_mutex_acquire(dev);
> >
> > @@ -2033,6 +2094,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw,=
 struct ieee80211_vif *vif,
> >                 mlink =3D mlinks[link_id];
> >                 link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> >
> > +               if (!link_conf) {
> > +                       err =3D -EINVAL;
> > +                       goto free;
> > +               }
> > +
> >                 rcu_assign_pointer(mvif->link_conf[link_id], mconf);
> >                 rcu_assign_pointer(mvif->sta.link[link_id], mlink);
> >
> > @@ -2113,9 +2179,14 @@ static int mt7925_assign_vif_chanctx(struct ieee=
80211_hw *hw,
> >
> >         if (ieee80211_vif_is_mld(vif)) {
> >                 mconf =3D mt792x_vif_to_link(mvif, link_conf->link_id);
> > +               if (!mconf) {
> > +                       mutex_unlock(&dev->mt76.mutex);
> > +                       return -EINVAL;
> > +               }
> > +
> >                 pri_link_conf =3D mt792x_vif_to_bss_conf(vif, mvif->def=
link_id);
> >
> > -               if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
> > +               if (pri_link_conf && vif->type =3D=3D NL80211_IFTYPE_ST=
ATION &&
> >                     mconf =3D=3D &mvif->bss_conf)
> >                         mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_li=
nk_conf,
> >                                                 NULL, true);
> > @@ -2144,6 +2215,10 @@ static void mt7925_unassign_vif_chanctx(struct i=
eee80211_hw *hw,
> >
> >         if (ieee80211_vif_is_mld(vif)) {
> >                 mconf =3D mt792x_vif_to_link(mvif, link_conf->link_id);
> > +               if (!mconf) {
> > +                       mutex_unlock(&dev->mt76.mutex);
> > +                       return;
> > +               }
> >
> >                 if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
> >                     mconf =3D=3D &mvif->bss_conf)
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/mcu.c
> > index 8eda407e4135..cf38e36790e7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> > @@ -1722,6 +1722,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, link_sta->link_id);
> >         mconf =3D mt792x_vif_to_link(mvif, link_sta->link_id);
> > +
> > +       if (!link_conf || !mconf)
> > +               return;
> > +
> >         chandef =3D mconf->mt76.ctx ? &mconf->mt76.ctx->def :
> >                                     &link_conf->chanreq.oper;
> >
> > @@ -1800,6 +1804,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb=
,
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, link_sta->link_id);
> >         mconf =3D mt792x_vif_to_link(mvif, link_sta->link_id);
> > +
> > +       if (!link_conf || !mconf)
> > +               return;
> > +
> >         chandef =3D mconf->mt76.ctx ? &mconf->mt76.ctx->def :
> >                                     &link_conf->chanreq.oper;
> >         band =3D chandef->chan->band;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/pci.c
> > index 8eb1fe1082d1..b6c90c5f7e91 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> > @@ -454,7 +454,9 @@ static int mt7925_pci_suspend(struct device *device=
)
> >         cancel_delayed_work_sync(&pm->ps_work);
> >         cancel_work_sync(&pm->wake_work);
> >
> > +       mt792x_mutex_acquire(dev);
> >         mt7925_roc_abort_sync(dev);
> > +       mt792x_mutex_release(dev);
> >
> >         err =3D mt792x_mcu_drv_pmctrl(dev);
> >         if (err < 0)
> > @@ -581,10 +583,12 @@ static int _mt7925_pci_resume(struct device *devi=
ce, bool restore)
> >         }
> >
> >         /* restore previous ds setting */
> > +       mt792x_mutex_acquire(dev);
> >         if (!pm->ds_enable)
> >                 mt7925_mcu_set_deep_sleep(dev, false);
> >
> >         mt7925_regd_update(dev);
> > +       mt792x_mutex_release(dev);
> >  failed:
> >         pm->suspended =3D false;
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers=
/net/wireless/mediatek/mt76/mt792x_core.c
> > index 9cad572c34a3..0170a23b0529 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> > @@ -95,6 +95,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80=
211_tx_control *control,
> >                                        IEEE80211_TX_CTRL_MLO_LINK);
> >                 sta =3D (struct mt792x_sta *)control->sta->drv_priv;
> >                 mlink =3D mt792x_sta_to_link(sta, link_id);
> > +               if (!mlink)
> > +                       goto free_skb;
> >                 wcid =3D &mlink->wcid;
> >         }
> >
> > @@ -113,9 +115,12 @@ void mt792x_tx(struct ieee80211_hw *hw, struct iee=
e80211_tx_control *control,
> >                 link_id =3D wcid->link_id;
> >                 rcu_read_lock();
> >                 conf =3D rcu_dereference(vif->link_conf[link_id]);
> > -               memcpy(hdr->addr2, conf->addr, ETH_ALEN);
> > -
> >                 link_sta =3D rcu_dereference(control->sta->link[link_id=
]);
> > +               if (!conf || !link_sta) {
> > +                       rcu_read_unlock();
> > +                       goto free_skb;
> > +               }
> > +               memcpy(hdr->addr2, conf->addr, ETH_ALEN);
> >                 memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
> >
> >                 if (vif->type =3D=3D NL80211_IFTYPE_STATION)
> > @@ -136,6 +141,10 @@ void mt792x_tx(struct ieee80211_hw *hw, struct iee=
e80211_tx_control *control,
> >         }
> >
> >         mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
> > +       return;
> > +
> > +free_skb:
> > +       ieee80211_free_txskb(hw, skb);
> >  }
> >  EXPORT_SYMBOL_GPL(mt792x_tx);
> >
> >

