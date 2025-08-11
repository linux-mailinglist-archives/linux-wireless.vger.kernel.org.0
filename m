Return-Path: <linux-wireless+bounces-26244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED9B202C4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AE318C131E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FF2DCF6D;
	Mon, 11 Aug 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="0JuNZ6zz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F181213248
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903381; cv=none; b=Dt1dIxqhn1QTZ+ssOgggnSZGFqiyVKcIwHDtb8T3IFcNkTcuxA3DJ+KNr+lyCMv8AASwUUhAFS9AlLhVa7hfHNUSrmHf62a5IzFXySGgK8yetXwDi49AbDBv1dzKYUF5ARkYpCy2UtDyvrGLPLgan3DDaMcqKi/HpS4ljSGPt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903381; c=relaxed/simple;
	bh=D/EBweKiWSM1Qxts2mX+N3ewBUrWvbqgEntX+pcinKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fof6+9JGNZYXBwZh0LxXHReULxe9gZdjfj44Adn8v0DfQg1G0qx/EQDWnY5tsVFkkzCdKPk84+QyrL1k+KoaUZ7eihsCrtl0/tJNTqKh4UoJVQAWdRmKKqPv8DOmLQ8JHLQ2rj1UZCWArgjE8FOqhz8cm4lhZ1a/WwCZuzkrT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=0JuNZ6zz; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-88bc87958d3so2015181241.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1754903376; x=1755508176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc1j0g+sS3ET9hSghi71HrzdGP44q2m0atbgQRqxQc4=;
        b=0JuNZ6zzAPZoSYDJ69oVvdoWgCgfoLi4mIwoq3QuoYNZPu6pDz4dhgG332ADPKQ+i2
         dghj4V+H4YSuIsdjtReVmj5104uXs1Mll9ZerIKeVRjMWY1exFsiNHSWanS5ieULzCjL
         Oix+eu5Yyf/bxcUHBnktYr5reHbgBqYHxoIMoUreYUPFJN+k4vkO7JSqHB+szvqJpx4i
         UJ1EvynXtLx8Y3UbImasMCyMCaVXf0nCbaVpih86ngd3wlU4xF4WZiXA9jTsc73SxnnH
         CTnagBRfdwjjSGdLzLRxM0xxobnDG9m1JAeIo3pvRfkuXn72xSpx83bMq3wmnKG7myUV
         Mngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903376; x=1755508176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc1j0g+sS3ET9hSghi71HrzdGP44q2m0atbgQRqxQc4=;
        b=ETgVwPQcdCwN+8S9ZR+arCxg+ZN4heRnUfG0UfVVCXmUDTiM7OSilWjl7fZ2iY0SXW
         Wl3oPOd08FjGe0rd6R++L0IXk5yIu5OYyWc5SuIEXDB8EnmIhiwLa5CenOF3Q2vHbOlp
         XlceP97pOwKcjET4BtaQwqxXQZTqbfNoRhhfV+qHtToQo60QCzgl3Dy42r6Of8s16OJc
         vp3KQdCA+Cs3keT7JeH/DoPWrU3ad9ik08PvNRGSdxLS6P+o9oSRY9+7ROGwIGXNvxcs
         WWdojlQq5r8EpYcHo13hF5DutyNGI4tDW7ave0zs7G9VdJeAvZVtLuUHLoYg3PgSoS5p
         IfIg==
X-Gm-Message-State: AOJu0YynYgY+6ZrgUFYT6LOXUbu7BpYnz0GVEowktIycmMTbaktqy0dt
	APA0hndAEQQQ/UnYSOYZKYnVMCtprlcgG3WByHgsBZJtZ1s/iXMMoEg+jESQC2shGMDHUD5XRWE
	3g+KFqAEE8Wt7GAJVtmcYyMcXg9QuNYnjkNtD0W8Ihg==
X-Gm-Gg: ASbGncuODspeTaU3bSl16GC4jJplkH8jtZ9D/1ZplxbOzP/3inc+F8pq4PgF8KFzVJI
	wXzgOk3Hw/hV63l/uitQLMEn0mHQVPd4AdtNBckwlifeNXpeRcG4fsVDyUzlt9iiCXFhOv93xgA
	DfDaOb4izX7co7I+isxyZA0g4iPX1dOc4NOWx7591Lz/jdT8DGRxAHLMzBd0HtT59QDOY+WPUfh
	01N6UoiaA==
X-Google-Smtp-Source: AGHT+IFQgak8B/i94a+5/tbjXnIwCpnB4h6aOXcgY+IDVVxCk8cfgS0uOuyT8W7BCpfjOIILnAyTfuPY6UG63QgkkqM=
X-Received: by 2002:a05:6102:4a95:b0:4e4:5ed0:19b2 with SMTP id
 ada2fe7eead31-5060d6a66f4mr4553961137.9.1754903376243; Mon, 11 Aug 2025
 02:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech> <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
In-Reply-To: <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Mon, 11 Aug 2025 11:08:53 +0200
X-Gm-Features: Ac12FXwSxuo-bHRaus5KmWu1qrTQOh3m2ZczARj2_k3P9ErkLfczw-KP-36POdc
Message-ID: <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:25=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 6/12/2025 12:40 AM, balsam.chihi@moment.tech wrote:
> > From: Balsam CHIHI <balsam.chihi@moment.tech>
> >

Hello, sorry for the delay. I was OoO.

> > During system reboot or module removal (rmmod), a crash was observed
> > due to a synchronous external abort caused by invalid register access
> > in ath11k_pci_clear_dbg_registers(). This happens when the device is
> > already powered off and the driver attempts to read debug registers.
>
> What does 'powered off' mean exactly here? is WLAN powered by an internal=
/external supply
> that will be removed during rmmod/reboot?

The "powered off" means that the wlan card is rmmod or reboot.
It is not powered by external supply.

>
> >
> > The crash log shows:
> > root@OpenWrt:~# reboot
> > [  343.663492] Internal error: synchronous external abort:
> > 0000000096000210 [#1] SMP
> > [  343.670992] Modules linked in: [...]
> > [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
> > [  343.849746] Hardware name: LS1088A
> > [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
>
> I don't see any relationship between ath11k_pci_clear_dbg_registers() and=
 this PC pointer.
> So how did you locate the problematic register access then?

I tyied to look for the problem based the PC pointer but I was not
abled to find it.
So, I added prints in ath11k driver to find out where it stucks,
classical debug method.
Then I found out that any "ath11k_pcic_read32()" call fails on rmmod
ath11k_pci or reboot,
but they work fine when insmod/boot ath11k_pci.

>
> > [  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> > [...]
> > [  343.950800] Call trace:
> > [  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> > [  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> > [  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
> > [  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
> > [  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
> > [  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
> > [  343.986906]  pci_device_shutdown+0x34/0x44
> > [  343.991004]  device_shutdown+0x160/0x268
> > [  343.994928]  kernel_restart+0x40/0xc0
> > [  343.998594]  __do_sys_reboot+0x104/0x23c
> > [  344.002518]  __arm64_sys_reboot+0x24/0x30
> > [  344.006529]  do_el0_svc+0x6c/0x100
> > [  344.009931]  el0_svc+0x28/0x9c
> > [  344.012986]  el0t_64_sync_handler+0x120/0x12c
> > [  344.017344]  el0t_64_sync+0x178/0x17c
> > [  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
> > [  344.027102] ---[ end trace 0000000000000000 ]---
> >
> > This patch adds a `power_on` flag to conditionally skip debug register
> > reads when the device is not powered, preventing invalid memory access.
>
> why is only 'read' concerned here?

Good question, I can't explain why only the reading fails but not the writi=
ng.

>
> You are skipping several 'read' in this change, could you help narrow dow=
n which
> individual read instance causes this?
>

All read calls fail on rmmod/reboot, when
ath11k_pci_clear_dbg_registers() is called.
But they all succeed when insmod/boot ath11k_pci.

> >
> > With this change, the system no longer crashes on reboot or rmmod,
> > and the driver continues to function correctly when reloaded.
> >
> > Tested-on: QCN9074 hw2.0 PCIe on LS1088A
> > Tested-on: OpenWrt 24.10.1
> > Fixes: crash on reboot/rmmod due to invalid register access
> > Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
> > ---
> >  drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wirele=
ss/ath/ath11k/pci.c
> > index 78444f8ea153..0c1b55957557 100644
> > --- a/drivers/net/wireless/ath/ath11k/pci.c
> > +++ b/drivers/net/wireless/ath/ath11k/pci.c
> > @@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struct at=
h11k_base *ab)
> >               ath11k_warn(ab, "link down error during global reset\n");
> >  }
> >
> > -static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
> > +static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab, boo=
l power_on)
> >  {
> > -     u32 val;
> > +     if (power_on) {
> > +             u32 val;
> >
> > -     /* read cookie */
> > -     val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> > -     ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val)=
;
> > +             /* read cookie */
> > +             val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> > +             ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\=
n", val);
> >
> > -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> > -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val)=
;
> > +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> > +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\=
n", val);
> > +     }
> >
> >       /* TODO: exact time to sleep is uncertain */
> >       mdelay(10);
> > @@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(struct=
 ath11k_base *ab)
> >       ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
> >       mdelay(10);
> >
> > -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> > -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val)=
;
> > +     if (power_on) {
> > +             u32 val;
> >
> > -     /* A read clear register. clear the register to prevent
> > -      * Q6 from entering wrong code path.
> > -      */
> > -     val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
> > -     ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
> > +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> > +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\=
n", val);
> > +
> > +             /* A read clear register. clear the register to prevent
> > +             * Q6 from entering wrong code path.
> > +             */
> > +             val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG)=
;
> > +             ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", va=
l);
> > +     }
> >  }
> >
> >  static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
> > @@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base =
*ab, bool power_on)
> >       }
> >
> >       ath11k_mhi_clear_vector(ab);
> > -     ath11k_pci_clear_dbg_registers(ab);
> > +     ath11k_pci_clear_dbg_registers(ab, power_on);
> >       ath11k_pci_soc_global_reset(ab);
> >       ath11k_mhi_set_mhictrl_reset(ab);
> >  }
>

