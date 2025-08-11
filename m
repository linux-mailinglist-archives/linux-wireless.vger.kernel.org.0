Return-Path: <linux-wireless+bounces-26252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB14B208C6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E474E1976
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F92D2398;
	Mon, 11 Aug 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="kxeMJlA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0026AE4
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915245; cv=none; b=LMCSHAcMfdpDs+5xrYRS9fP9dN4XF5eGSt3woUnzl8c0sMUxUCeA/UJF6Eq5PIcWBgKz7VjDlacsiK/lIbnlE9MHqfguNAO0xTBDgh0PZ3zTxsDMalfGuaieKirPR6N0sH5BJe6Gm1FGyleBav/gJbwER0Mlqq3WyA1akOenQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915245; c=relaxed/simple;
	bh=9YjcbmyxSB9ix7azQPodVUJVBl+7gQqjynx1u9PkiBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niK7O0UEPooEYyapMsc5YW0QP682auaD7Ba11QmdOebvMXyS9Inn1JQTTCHCcLxu577BfoJkRgOhMCfPkHbPOfKggHDRj7197Ag+tkjn0M6lRFGQia4axSvHcgHJ99Q/dHhAd6iamwYGyAJqPG+qVtHU8SG0iUiimB4OVaSuvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=kxeMJlA6; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5392ba07940so3010548e0c.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1754915240; x=1755520040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYdkcTWbUlS5e0ai1u6zNM9VGBZaPTEbSzeTgy3Ag4o=;
        b=kxeMJlA6wT0bG19O9zzJ/0PO2xlT7/WUneMLJL4DEufyQ3OC5LMamOfPhbfV+YsVl5
         JYtHJXiDYmFBGSvpRmyBlLDxp24ORL80r5NZI2Gp6k8O5WRPPzy/8g1pqJdMs0yJGGTo
         /Drj/WtK4zxctG7EixMesDTjb/2xnoNX0k6FuC8Li1xY2q/EiCZZebsW2I2IlfMrONDa
         grwUfh8dkPZjmGEVczxHFeHdHWuEkIi+lDLGMGwv8lPOcusULI1e3NNN/d/93daCWF5M
         X6DzeC1Q7Pfe1XJC26BPitrMrPVE24K79gtEqJ+waSxeZjSUQo5FThVxo2N7eKvQraMs
         qfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915240; x=1755520040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYdkcTWbUlS5e0ai1u6zNM9VGBZaPTEbSzeTgy3Ag4o=;
        b=p6MR8bZZQ9Adbd96BXkFAts22pbi6e+SYrgzlNwSpVib8PZ5aQ/xu7tdx6oluEk/Lc
         s/hX3d5EHKInvAUTfXX2Hd3eqE1JfnyMBwjtYKLyyJJeLuOoam4k9mZwoqxzFdELHsKu
         l6iExkMeW9fMrbFjzVVfaipuNWUveMPNeARMx+rRWDZ564Jdhxl3oUw3RBkmH2QB89uE
         fyzaa1t6AjQ25ojGxc/SBrLksAo6nWRxNnN5nXqkXfqzMvJa2IUxWVGFQC//atnRekjZ
         ATe0yf2JBBPKx29eGQEsJmB95C3EoWDEz6NzGmfFSvUFUIqFKAvXlfgQHmKyz14VYs+T
         cEww==
X-Gm-Message-State: AOJu0YzEuJKtVAJeZ01Svu4msf+4+spRKphwTT2RJqMA2Hq6OWysAb24
	BEXPMEXtyQe0udmJT/SBCwjNz6nYCkvqDDIFIhrmHW5RPMHT8Iipah/oewWNysadePwgKHznJp+
	9LN4wIatQuhVxOPsUhX8QpKMjRkYeE3uazKgLR4Bh6Qrp6K6PELZJnFE=
X-Gm-Gg: ASbGncsQ7mx9xd0rGRGne7XGxeB9mBlGjDoSJvndJnbMIC4uY8KwhRz+0deXbyfQGha
	QvoieS+4nbt6TfTxaEsK2SODMtZv20oTNHZccLvOCxVKN9J3c/G7lpYA5ojq4/vuTpyilUi48pU
	Xq5RaypPHdwv/uO5mhqwRnWMypFDs1LhlSWSWqMy6ikRanF+dl/t2aCJLbv6TUqaprhnhhEY/mt
	TM/KZZaCQ==
X-Google-Smtp-Source: AGHT+IGtUSrENkQ194ELDBv806l0BAdJnjsN3630pPKssfifeVkFRi4vYZkrUKQ9gqEQB0V2wCZ4cx9QV5b/pC4i+2o=
X-Received: by 2002:a05:6122:1da2:b0:539:58c2:1e0a with SMTP id
 71dfb90a1353d-53a52d9e73bmr4740534e0c.4.1754915239717; Mon, 11 Aug 2025
 05:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
In-Reply-To: <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Mon, 11 Aug 2025 14:26:43 +0200
X-Gm-Features: Ac12FXw1P5XX-AczedanlW-0plGUXiJmPaZUga9P5lPjxeYcpWrMRPbb3YofUmg
Message-ID: <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:00=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 8/11/2025 5:08 PM, Balsam Chihi wrote:
> > On Fri, Jul 25, 2025 at 5:25=E2=80=AFAM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 6/12/2025 12:40 AM, balsam.chihi@moment.tech wrote:
> >>> From: Balsam CHIHI <balsam.chihi@moment.tech>
> >>>
> >
> > Hello, sorry for the delay. I was OoO.
> >
> >>> During system reboot or module removal (rmmod), a crash was observed
> >>> due to a synchronous external abort caused by invalid register access
> >>> in ath11k_pci_clear_dbg_registers(). This happens when the device is
> >>> already powered off and the driver attempts to read debug registers.
> >>
> >> What does 'powered off' mean exactly here? is WLAN powered by an inter=
nal/external supply
> >> that will be removed during rmmod/reboot?
> >
> > The "powered off" means that the wlan card is rmmod or reboot.
> > It is not powered by external supply.
>
> OK.
>
> >
> >>
> >>>
> >>> The crash log shows:
> >>> root@OpenWrt:~# reboot
> >>> [  343.663492] Internal error: synchronous external abort:
> >>> 0000000096000210 [#1] SMP
> >>> [  343.670992] Modules linked in: [...]
> >>> [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
> >>> [  343.849746] Hardware name: LS1088A
> >>> [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> >>> [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> >>
> >> I don't see any relationship between ath11k_pci_clear_dbg_registers() =
and this PC pointer.
> >> So how did you locate the problematic register access then?
> >
> > I tyied to look for the problem based the PC pointer but I was not
> > abled to find it.
> > So, I added prints in ath11k driver to find out where it stucks,
> > classical debug method.
>
> Yeah, classical and always work.
>
> > Then I found out that any "ath11k_pcic_read32()" call fails on rmmod
> > ath11k_pci or reboot,
>
> I worry PCIe link is not stable on your platform when rmmod/reboot. Can y=
ou try with ASPM
> disabled?

ASPM is indeed disabled in the Kernel config.
I will also try with your patch and get back to you with the results.
And in the meanwhile, I would like to let you know the following informatio=
n :
Other PCIe devices are working well even with ASPM enabled in the same slot=
,
and the issue is present in all PCIe slots.
I have many board variants of the same platform that showed the same output=
.
Maybe it is only related to the Qualcomm QCN9074 WiFi6E chipset?
I tried 2 wifi cards from two manufacturers of the same wifi chip and
the issue is the same.
Is it related to the SoC Freescale Layerscape LS1088A?
It seems like the kernel is accessing a freed resource or no longer
existing memory address because the wifi card is turned off.


>
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -605,11 +605,13 @@ static void ath11k_pci_aspm_disable(struct ath11k_p=
ci *ab_pci)
>
>  static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
>  {
> +#if 0
>         if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
>                 pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_=
LNKCTL,
>                                                    PCI_EXP_LNKCTL_ASPMC,
>                                                    ab_pci->link_ctl &
>                                                    PCI_EXP_LNKCTL_ASPMC);
> +#endif
>  }
>
>  #ifdef CONFIG_DEV_COREDUMP
>
>
> > but they work fine when insmod/boot ath11k_pci.
> >
> >>
> >>> [  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> >>> [...]
> >>> [  343.950800] Call trace:
> >>> [  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> >>> [  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> >>> [  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
> >>> [  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
> >>> [  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
> >>> [  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
> >>> [  343.986906]  pci_device_shutdown+0x34/0x44
> >>> [  343.991004]  device_shutdown+0x160/0x268
> >>> [  343.994928]  kernel_restart+0x40/0xc0
> >>> [  343.998594]  __do_sys_reboot+0x104/0x23c
> >>> [  344.002518]  __arm64_sys_reboot+0x24/0x30
> >>> [  344.006529]  do_el0_svc+0x6c/0x100
> >>> [  344.009931]  el0_svc+0x28/0x9c
> >>> [  344.012986]  el0t_64_sync_handler+0x120/0x12c
> >>> [  344.017344]  el0t_64_sync+0x178/0x17c
> >>> [  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
> >>> [  344.027102] ---[ end trace 0000000000000000 ]---
> >>>
> >>> This patch adds a `power_on` flag to conditionally skip debug registe=
r
> >>> reads when the device is not powered, preventing invalid memory acces=
s.
> >>
> >> why is only 'read' concerned here?
> >
> > Good question, I can't explain why only the reading fails but not the w=
riting.
> >
> >>
> >> You are skipping several 'read' in this change, could you help narrow =
down which
> >> individual read instance causes this?
> >>
> >
> > All read calls fail on rmmod/reboot, when
> > ath11k_pci_clear_dbg_registers() is called.
> > But they all succeed when insmod/boot ath11k_pci.
> >
> >>>
> >>> With this change, the system no longer crashes on reboot or rmmod,
> >>> and the driver continues to function correctly when reloaded.
> >>>
> >>> Tested-on: QCN9074 hw2.0 PCIe on LS1088A
> >>> Tested-on: OpenWrt 24.10.1
> >>> Fixes: crash on reboot/rmmod due to invalid register access
> >>> Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
> >>> ---
> >>>  drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++---------=
--
> >>>  1 file changed, 21 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wire=
less/ath/ath11k/pci.c
> >>> index 78444f8ea153..0c1b55957557 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/pci.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> >>> @@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struct =
ath11k_base *ab)
> >>>               ath11k_warn(ab, "link down error during global reset\n"=
);
> >>>  }
> >>>
> >>> -static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
> >>> +static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab, b=
ool power_on)
> >>>  {
> >>> -     u32 val;
> >>> +     if (power_on) {
> >>> +             u32 val;
> >>>
> >>> -     /* read cookie */
> >>> -     val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> >>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", va=
l);
> >>> +             /* read cookie */
> >>> +             val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> >>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%=
x\n", val);
> >>>
> >>> -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", va=
l);
> >>> +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%=
x\n", val);
> >>> +     }
> >>>
> >>>       /* TODO: exact time to sleep is uncertain */
> >>>       mdelay(10);
> >>> @@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(stru=
ct ath11k_base *ab)
> >>>       ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
> >>>       mdelay(10);
> >>>
> >>> -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", va=
l);
> >>> +     if (power_on) {
> >>> +             u32 val;
> >>>
> >>> -     /* A read clear register. clear the register to prevent
> >>> -      * Q6 from entering wrong code path.
> >>> -      */
> >>> -     val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
> >>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
> >>> +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%=
x\n", val);
> >>> +
> >>> +             /* A read clear register. clear the register to prevent
> >>> +             * Q6 from entering wrong code path.
> >>> +             */
> >>> +             val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_RE=
G);
> >>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", =
val);
> >>> +     }
> >>>  }
> >>>
> >>>  static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
> >>> @@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_bas=
e *ab, bool power_on)
> >>>       }
> >>>
> >>>       ath11k_mhi_clear_vector(ab);
> >>> -     ath11k_pci_clear_dbg_registers(ab);
> >>> +     ath11k_pci_clear_dbg_registers(ab, power_on);
> >>>       ath11k_pci_soc_global_reset(ab);
> >>>       ath11k_mhi_set_mhictrl_reset(ab);
> >>>  }
> >>
> >
>

