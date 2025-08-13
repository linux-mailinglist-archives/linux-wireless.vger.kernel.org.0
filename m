Return-Path: <linux-wireless+bounces-26364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83BB24B94
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BF57B6D99
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E82ECE86;
	Wed, 13 Aug 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="eDwzpYJT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FFF1494D9
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094068; cv=none; b=TxsdpQCEQFDQRUV1w72bxaAItXxw73Hgf1Ion0a4l1u/zCu6CzV4NtfMGoY0MPXBMrTst8m5p2kkaUgpcRevs/z/PwudZVWu1EFNqSSPGhMEbnRNpAVJXuaetNF6Lg6ZHy2H2iViEB6gaFo5hqO9suGHDQMw78AcQg0fUBRhhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094068; c=relaxed/simple;
	bh=39Jc5ZW0+nmgXaURdCtX9mfS84orXU6awXbmGoVDkUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcERJ4znkX/wI02mrrmNhr8NDeJlDQq8/2ZF/pe8v0my5CPXwlsLk0FFRkWwRHr+4jDhllSx4/4bbNOfaN/4y87aJk7g0uqA9MSrJ38dzEnd20SeGuNmyqOO1nRcVChq+LhmtHyk8yeum78cgNRnmHEuEjpbbFK2syeC6E3G2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=eDwzpYJT; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4fc1094c24eso4250541137.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1755094064; x=1755698864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2NDgDNL6t4O5RlzryUd2FYHevQUJKZTBPmSxd+p0w=;
        b=eDwzpYJTNoSg6B29g4fT+BI/HfE2Buc6RiJctC0zPeXs/7rL7lr8yMWDfVXHvtIU90
         WUCW2iOX5bUFwxP4hjxSqHnhNqVbhe+2gEzfYTEU3kaEBusULCBbIK9YYJwnl4TuBCRn
         8fkTkatKyPPZl9lmgylFUsfdYlFWnBmtpjqdIY3NJ1vIp8LaeSnxJw9ZgLHcVao803S+
         gY/G4kyyoIIXmFk5WEsXWVGA6ByVvXX+1+GPB4lVkSq8H2bHyJ8HVEf9LBu/TJKevX/M
         UGxZ/x54ANV37mHmdJXUBoYlZpyqi6YixTEzGKLywLa7R/9xZ3iIqVg2A92+rseMrlz8
         CCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094064; x=1755698864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m2NDgDNL6t4O5RlzryUd2FYHevQUJKZTBPmSxd+p0w=;
        b=afk4ilLrHbRdIDrJo2HWFgrGxhevVOT5yCQeQnucEjAMn1+7ThpIGk2+0WFvO7qSK7
         EjGK5QBimDr7vyfTVpq11WU/RTY69Hy2Pe32CHmDXax2f4M4WIw2lJMzeFL+b9LMECux
         xxmMxd+Lsjwy9vfHk2aaSHSRRdE0aQ2ANmmbooPr+61xzF0u/kiUyt+m021/9wkc3F3q
         JDAXiT53RAcdowxVzABdZo7M4gJRS14OaZgeKS1c9GluQUJdRPbjbUDacA1Lyvccnf8r
         h6nFjhu7TaIaw9F3uNmTh7roOcCCaLRetuUSAVgmIdQWasehMnvBNTnFvcqMPuA0i6kx
         E5NA==
X-Gm-Message-State: AOJu0Yzu81dLtCF1+jJjgO2Xbg8Ij3BmdF9oi4loXLJznEyeUF6W0gXA
	U710FLgqQfwts5hP9aLhnCb2pX31xWSoqRByWNwmaX2vFIcOa+7thSqr3dYB63BBOepsSxwOjgo
	yP/OCZ7VUi5mgwKGhIaqxQvEfHlAd6kg5/SmHZYMYcmpDcbWfO/P40VA=
X-Gm-Gg: ASbGnctmg2VObMi+bN6MI3L0PRrNMWJhTWQzJX7mp30Pv2XCwteEs09gXNFsUD+Zh8J
	pMy/tWTF9Iy8myc+hZ2OIVDHZRO4nRsavOou9MObQiGnx0PLYtBvOq+mS+3lpw0riVkjan7P4yk
	pe0OEAbeVWwPfAMpdTy7rBIy87AEfUq9RlVqufcXBCMhvvNahq83Aw1UjhkZ8eN+YbGzUqglfod
	QXcot+6ug==
X-Google-Smtp-Source: AGHT+IG6uR+AZxtNP8mgFC60bHH2gIdH5wwHFy/dMxp7AYBrNZ8GGkyY4jehlKBBDZdA1aHXe3J7+YE2eCEwiaAahhg=
X-Received: by 2002:a05:6102:8028:b0:4fb:142:1ff5 with SMTP id
 ada2fe7eead31-50e50e9e168mr1546694137.26.1755094063603; Wed, 13 Aug 2025
 07:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
In-Reply-To: <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Wed, 13 Aug 2025 16:07:07 +0200
X-Gm-Features: Ac12FXxcavLOTfpHf_I7AL2yjngQ8RoPpQdtvXryXWHdMpcGbvwCmDXj2Z52uVI
Message-ID: <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:21=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 8/11/2025 8:26 PM, Balsam Chihi wrote:
> > On Mon, Aug 11, 2025 at 1:00=E2=80=AFPM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 8/11/2025 5:08 PM, Balsam Chihi wrote:
> >>> On Fri, Jul 25, 2025 at 5:25=E2=80=AFAM Baochen Qiang
> >>> <baochen.qiang@oss.qualcomm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 6/12/2025 12:40 AM, balsam.chihi@moment.tech wrote:
> >>>>> From: Balsam CHIHI <balsam.chihi@moment.tech>
> >>>>>
> >>>
> >>> Hello, sorry for the delay. I was OoO.
> >>>
> >>>>> During system reboot or module removal (rmmod), a crash was observe=
d
> >>>>> due to a synchronous external abort caused by invalid register acce=
ss
> >>>>> in ath11k_pci_clear_dbg_registers(). This happens when the device i=
s
> >>>>> already powered off and the driver attempts to read debug registers=
.
> >>>>
> >>>> What does 'powered off' mean exactly here? is WLAN powered by an int=
ernal/external supply
> >>>> that will be removed during rmmod/reboot?
> >>>
> >>> The "powered off" means that the wlan card is rmmod or reboot.
> >>> It is not powered by external supply.
> >>
> >> OK.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> The crash log shows:
> >>>>> root@OpenWrt:~# reboot
> >>>>> [  343.663492] Internal error: synchronous external abort:
> >>>>> 0000000096000210 [#1] SMP
> >>>>> [  343.670992] Modules linked in: [...]
> >>>>> [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
> >>>>> [  343.849746] Hardware name: LS1088A
> >>>>> [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> >>>>> [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pc=
i]
> >>>>
> >>>> I don't see any relationship between ath11k_pci_clear_dbg_registers(=
) and this PC pointer.
> >>>> So how did you locate the problematic register access then?
> >>>
> >>> I tyied to look for the problem based the PC pointer but I was not
> >>> abled to find it.
> >>> So, I added prints in ath11k driver to find out where it stucks,
> >>> classical debug method.
> >>
> >> Yeah, classical and always work.
> >>
> >>> Then I found out that any "ath11k_pcic_read32()" call fails on rmmod
> >>> ath11k_pci or reboot,
> >>
> >> I worry PCIe link is not stable on your platform when rmmod/reboot. Ca=
n you try with ASPM
> >> disabled?
> >
> > ASPM is indeed disabled in the Kernel config.
> > I will also try with your patch and get back to you with the results.
> > And in the meanwhile, I would like to let you know the following inform=
ation :
> > Other PCIe devices are working well even with ASPM enabled in the same =
slot,
> > and the issue is present in all PCIe slots.
>
> Thanks, the info helps.
>
> > I have many board variants of the same platform that showed the same ou=
tput.
> > Maybe it is only related to the Qualcomm QCN9074 WiFi6E chipset?
>
> I think so.
>
> > I tried 2 wifi cards from two manufacturers of the same wifi chip and
> > the issue is the same.
>
> Do you have a WCN6855 WiFi chip to try?

I don't have any other WiFi card right now.
Only QCN9074 from different manufacturers behaved identically.

>
> > Is it related to the SoC Freescale Layerscape LS1088A?
>
> I never heard of such issues before. For now I am suspecting that your So=
C PCIe RC behaves
> differently from other platforms, like X86.
>  > It seems like the kernel is accessing a freed resource or no longer
> > existing memory address because the wifi card is turned off.
>
> WiFi chip might enter a state where access to some specific registers cou=
ld not be
> completed, hence the 'abort' error.
>
> >
> >
> >>
> >> --- a/drivers/net/wireless/ath/ath11k/pci.c
> >> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> >> @@ -605,11 +605,13 @@ static void ath11k_pci_aspm_disable(struct ath11=
k_pci *ab_pci)
> >>
> >>  static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
> >>  {
> >> +#if 0
> >>         if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags=
))
> >>                 pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_E=
XP_LNKCTL,
> >>                                                    PCI_EXP_LNKCTL_ASPM=
C,
> >>                                                    ab_pci->link_ctl &
> >>                                                    PCI_EXP_LNKCTL_ASPM=
C);
> >> +#endif
> >>  }
> >>
> >>  #ifdef CONFIG_DEV_COREDUMP
> >>
>
> Anyway, please try with above change. In addition you can manually confir=
m ASPM status in
> LinkCtrl register with lspci tool, on my machine it is like:
>
> $ sudo lspci -s 02:00.0 -vv
> 02:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>         [...]
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 [...]
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 [...]
>

# lspci -s 0000:01:00.0 -vv
0000:01:00.0 Network controller: Qualcomm Technologies, Inc
QCN6024/9024/9074 Wireless Network Adapter (rev 01)
Subsystem: Qualcomm Technologies, Inc QCN6024/9024/9074 Wireless Network Ad=
apter
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

I removed my patch, applied yours, and the issue came back.

According to dmesg logs, ath11k_pci_aspm_disable() is called on probe
and on remove.
The crash happens after the ath11k_pci_aspm_disable() call when rmmod or re=
boot.

>
> >>
> >>> but they work fine when insmod/boot ath11k_pci.
> >>>
> >>>>
> >>>>> [  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> >>>>> [...]
> >>>>> [  343.950800] Call trace:
> >>>>> [  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> >>>>> [  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> >>>>> [  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
> >>>>> [  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
> >>>>> [  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
> >>>>> [  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
> >>>>> [  343.986906]  pci_device_shutdown+0x34/0x44
> >>>>> [  343.991004]  device_shutdown+0x160/0x268
> >>>>> [  343.994928]  kernel_restart+0x40/0xc0
> >>>>> [  343.998594]  __do_sys_reboot+0x104/0x23c
> >>>>> [  344.002518]  __arm64_sys_reboot+0x24/0x30
> >>>>> [  344.006529]  do_el0_svc+0x6c/0x100
> >>>>> [  344.009931]  el0_svc+0x28/0x9c
> >>>>> [  344.012986]  el0t_64_sync_handler+0x120/0x12c
> >>>>> [  344.017344]  el0t_64_sync+0x178/0x17c
> >>>>> [  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
> >>>>> [  344.027102] ---[ end trace 0000000000000000 ]---
> >>>>>
> >>>>> This patch adds a `power_on` flag to conditionally skip debug regis=
ter
> >>>>> reads when the device is not powered, preventing invalid memory acc=
ess.
> >>>>
> >>>> why is only 'read' concerned here?
> >>>
> >>> Good question, I can't explain why only the reading fails but not the=
 writing.
> >>>
> >>>>
> >>>> You are skipping several 'read' in this change, could you help narro=
w down which
> >>>> individual read instance causes this?
> >>>>
> >>>
> >>> All read calls fail on rmmod/reboot, when
> >>> ath11k_pci_clear_dbg_registers() is called.
> >>> But they all succeed when insmod/boot ath11k_pci.
> >>>
> >>>>>
> >>>>> With this change, the system no longer crashes on reboot or rmmod,
> >>>>> and the driver continues to function correctly when reloaded.
> >>>>>
> >>>>> Tested-on: QCN9074 hw2.0 PCIe on LS1088A
> >>>>> Tested-on: OpenWrt 24.10.1
> >>>>> Fixes: crash on reboot/rmmod due to invalid register access
> >>>>> Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
> >>>>> ---
> >>>>>  drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++-------=
----
> >>>>>  1 file changed, 21 insertions(+), 15 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wi=
reless/ath/ath11k/pci.c
> >>>>> index 78444f8ea153..0c1b55957557 100644
> >>>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
> >>>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> >>>>> @@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struc=
t ath11k_base *ab)
> >>>>>               ath11k_warn(ab, "link down error during global reset\=
n");
> >>>>>  }
> >>>>>
> >>>>> -static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
> >>>>> +static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab,=
 bool power_on)
> >>>>>  {
> >>>>> -     u32 val;
> >>>>> +     if (power_on) {
> >>>>> +             u32 val;
> >>>>>
> >>>>> -     /* read cookie */
> >>>>> -     val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> >>>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", =
val);
> >>>>> +             /* read cookie */
> >>>>> +             val =3D ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> >>>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0=
x%x\n", val);
> >>>>>
> >>>>> -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", =
val);
> >>>>> +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0=
x%x\n", val);
> >>>>> +     }
> >>>>>
> >>>>>       /* TODO: exact time to sleep is uncertain */
> >>>>>       mdelay(10);
> >>>>> @@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(st=
ruct ath11k_base *ab)
> >>>>>       ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
> >>>>>       mdelay(10);
> >>>>>
> >>>>> -     val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", =
val);
> >>>>> +     if (power_on) {
> >>>>> +             u32 val;
> >>>>>
> >>>>> -     /* A read clear register. clear the register to prevent
> >>>>> -      * Q6 from entering wrong code path.
> >>>>> -      */
> >>>>> -     val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
> >>>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
> >>>>> +             val =3D ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> >>>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0=
x%x\n", val);
> >>>>> +
> >>>>> +             /* A read clear register. clear the register to preve=
nt
> >>>>> +             * Q6 from entering wrong code path.
> >>>>> +             */
> >>>>> +             val =3D ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_=
REG);
> >>>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n"=
, val);
> >>>>> +     }
> >>>>>  }
> >>>>>
> >>>>>  static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
> >>>>> @@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_b=
ase *ab, bool power_on)
> >>>>>       }
> >>>>>
> >>>>>       ath11k_mhi_clear_vector(ab);
> >>>>> -     ath11k_pci_clear_dbg_registers(ab);
> >>>>> +     ath11k_pci_clear_dbg_registers(ab, power_on);
> >>>>>       ath11k_pci_soc_global_reset(ab);
> >>>>>       ath11k_mhi_set_mhictrl_reset(ab);
> >>>>>  }
> >>>>
> >>>
> >>
>

