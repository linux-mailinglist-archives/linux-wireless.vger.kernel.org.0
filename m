Return-Path: <linux-wireless+bounces-1990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914482F43D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 19:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB81C2380F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E51CD2A;
	Tue, 16 Jan 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uuo9fg9e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BF1CD27
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429737; cv=none; b=SAdZTGXZviY0TpBEURGuCeOYQbTTkA6KD9jZyjx2lquDcWv0JbqqwQJ03xS9EQc6EHyROigxyscByjJTosMSIkikSf9ut1lIWtpvv+uglO2fXjL2WrKiZpdLs6zGHU7RVCXp56L0YG84CbhtOEFfQ5I0kUZeaNHeAjz7cwweZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429737; c=relaxed/simple;
	bh=gRBv+83R7xtY4IadOQb/R3l9cez8C//XEu5+h57hoHo=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=U3ilZlBciDUiKg7dGIJUnZ/gXDTu7fzenUH/4I1zfn2jXG5i4oHT6g5S5mEuAj3dmDX0NMJC6EW585f6eAnhFNKrTRk/HCvzGNswdn+q0ODA8oyhzeEtPvI7+n+C8SHTaWBaVa5fA3T1mWvzi8vsrbnBreqUiMboxk3SuEpkt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uuo9fg9e; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705429730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFpSKNfj2ZpHpE+OI1l4tUBJbby+Xma9IN8r4rqgVsQ=;
	b=Uuo9fg9ex1FfZxbb4mp6DpZ4hVLyLpdWyQlf5vc7ut3xhLoMG6Yri9lKJKe/0+GD1hnoBD
	9oJWOdjn+xNcjkkbgcZkPt6aiMAYBEoLC/W4FNPMRIKp3gZzNL3KKrLSvadVvKyIinvifl
	yfmqwjF0qg1RFG23EwYCItsq5Xfp9xA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-ArXd6TOtNlacfsP5vDaRBw-1; Tue, 16 Jan 2024 13:28:49 -0500
X-MC-Unique: ArXd6TOtNlacfsP5vDaRBw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso714446239f.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 10:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429728; x=1706034528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFpSKNfj2ZpHpE+OI1l4tUBJbby+Xma9IN8r4rqgVsQ=;
        b=UGsxOasZbWzSEnXcbGuSJ2JCoh18YJjOjjEmQX8/eAPqZgRoADZtjjS4Dz7j2rlWgr
         KcafW0rDEKAWVgAmAxHHl87DO+8ZbvkD0XBSo8IqkCyH1wHZ85gRUMWGj1DOmA6TpNMz
         OXszHTWqAs8CyhFySAzUKYlMlck/8dUOeymHCpoyfXh/MYmThFMTswCFcf3EvOvR9YPT
         nW7oq+BifLaXAx4qZr1tUVYZcwbihYByj1rsGtUuwWWHrS84nzHDKDt/z/4DHduniC4+
         zoxiOHvvXWjPHgiDMT/5x3TSHglQzagw8U4hAFOM4DV3zbrjWUM0S0GyU0bNJuHvN8bO
         9Xug==
X-Gm-Message-State: AOJu0Yx0CtPC8bBPlgwW7GgBXnlKh0oIh7e1pGxTbSO+7uZ8IFYt/tR/
	HK6eKP/HxodCGIEo2d7wBFdrcicTZp0v8ie4oFRde4xtEAwEQ8uhdeh6WFQ6RaeQ9boV5ClB64z
	sCLszzoqF2TL2w9er7N3rkcFPk2K65v9eTzjhC1SJwzA=
X-Received: by 2002:a05:6602:2e8a:b0:7bf:36f2:54cd with SMTP id m10-20020a0566022e8a00b007bf36f254cdmr6625259iow.22.1705429728110;
        Tue, 16 Jan 2024 10:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB6m6BKxv+sHQEq6Nv6/xYIXHdArVIn/PO6CHdPSFBZMKnrHzZ1Cvx3EiK7jVa2CyreQVlqg==
X-Received: by 2002:a05:6602:2e8a:b0:7bf:36f2:54cd with SMTP id m10-20020a0566022e8a00b007bf36f254cdmr6625245iow.22.1705429727695;
        Tue, 16 Jan 2024 10:28:47 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id cb12-20020a0566381b0c00b0046e1ebd94b3sm3119068jab.24.2024.01.16.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:28:47 -0800 (PST)
Date: Tue, 16 Jan 2024 11:28:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: ath11k and vfio-pci support
Message-ID: <20240116112845.55ebfcf7.alex.williamson@redhat.com>
In-Reply-To: <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	<87r0ipcn7j.fsf@kernel.org>
	<356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	<26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
	<87mstccmk6.fsf@kernel.org>
	<df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
	<8734v4auc4.fsf@kernel.org>
	<e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
	<285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
	<4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
	<3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
	<87il3w7zjh.fsf@kernel.org>
	<20240115104658.0b56bd35.alex.williamson@redhat.com>
	<543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
	<57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 11:41:19 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2024-01-16 at 18:08 +0800, Baochen Qiang wrote:
> >=20
> >=20
> > On 1/16/2024 1:46 AM, Alex Williamson wrote: =20
> > > On Sun, 14 Jan 2024 16:36:02 +0200
> > > Kalle Valo <kvalo@kernel.org> wrote:
> > >  =20
> > > > Baochen Qiang <quic_bqiang@quicinc.com> writes:
> > > >  =20
> > > > > > > Strange that still fails. Are you now seeing this error in yo=
ur
> > > > > > > host or your Qemu? or both?
> > > > > > > Could you share your test steps? And if you can share please =
be as
> > > > > > > detailed as possible since I'm not familiar with passing WLAN
> > > > > > > hardware to a VM using vfio-pci. =20
> > > > > >=20
> > > > > > Just in Qemu, the hardware works fine on my host machine.
> > > > > > I basically follow this guide to set it up, its written in the
> > > > > > context of GPUs/libvirt but the host setup is exactly the same.=
 By
> > > > > > no means do you need to read it all, once you set the vfio-pci.=
ids
> > > > > > and see your unclaimed adapter you can stop:
> > > > > > https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
> > > > > > In short you should be able to set the following host kernel op=
tions
> > > > > > and reboot (assuming your motherboard/hardware is compatible):
> > > > > > intel_iommu=3Don iommu=3Dpt vfio-pci.ids=3D17cb:1103
> > > > > > Obviously change the device/vendor IDs to whatever ath11k hw you
> > > > > > have. Once the host is rebooted you should see your wlan adapte=
r as
> > > > > > UNCLAIMED, showing the driver in use as vfio-pci. If not, its l=
ikely
> > > > > > your motherboard just isn't compatible, the device has to be in=
 its
> > > > > > own IOMMU group (you could try switching PCI ports if this is t=
he
> > > > > > case).
> > > > > > I then build a "kvm_guest.config" kernel with the driver/firmwa=
re
> > > > > > for ath11k and boot into that with the following Qemu options:
> > > > > > -enable-kvm -device -vfio-pci,host=3D<PCI address>
> > > > > > If it seems easier you could also utilize IWD's test-runner whi=
ch
> > > > > > handles launching the Qemu kernel automatically, detecting any
> > > > > > vfio-devices and passes them through and mounts some useful host
> > > > > > folders into the VM. Its actually a very good general purpose t=
ool
> > > > > > for kernel testing, not just for IWD:
> > > > > > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/do=
c/test-runner.txt
> > > > > > Once set up you can just run test-runner with a few flags and y=
ou'll
> > > > > > boot into a shell:
> > > > > > ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
> > > > > > Please reach out if you have questions, thanks for looking into
> > > > > > this. =20
> > > > >=20
> > > > > Thanks for these details. I reproduced this issue by following yo=
ur guide.
> > > > >=20
> > > > > Seems the root cause is that the MSI vector assigned to WCN6855 in
> > > > > qemu is different with that in host. In my case the MSI vector in=
 qemu
> > > > > is [Address: fee00000=C2=A0 Data: 0020] while in host it is [Addr=
ess:
> > > > > fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
> > > > > [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
> > > > > firmware uses that vector to fire interrupts to host/qemu. However
> > > > > host IOMMU doesn't know that vector because the real vector is
> > > > > [Address: fee00578=C2=A0 Data: 0000], as a result host blocks that
> > > > > interrupt and reports an error, see below log:
> > > > >=20
> > > > > [ 1414.206069] DMAR: DRHD: handling fault status reg 2
> > > > > [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault =
index
> > > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > > request
> > > > > [ 1414.210334] DMAR: DRHD: handling fault status reg 2
> > > > > [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault =
index
> > > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > > request
> > > > > [ 1414.212496] DMAR: DRHD: handling fault status reg 2
> > > > > [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault =
index
> > > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > > request
> > > > > [ 1414.214600] DMAR: DRHD: handling fault status reg 2
> > > > >=20
> > > > > While I don't think there is a way for qemu/ath11k to get the rea=
l MSI
> > > > > vector from host, I will try to read the vfio code to check furth=
er.
> > > > > Before that, to unblock you, a possible hack is to hard code the =
MSI
> > > > > vector in qemu to the same as in host, on condition that the MSI
> > > > > vector doesn't change. =20
> > > >=20
> > > > Baochen, awesome that you were able to debug this further. Now we at
> > > > least know what's the problem. =20
> > >=20
> > > It's an interesting problem, I don't think we've seen another device
> > > where the driver reads the MSI register in order to program another
> > > hardware entity to match the MSI address and data configuration.
> > >=20
> > > When assigning a device, the host and guest use entirely separate
> > > address spaces for MSI interrupts.=C2=A0 When the guest enables MSI, =
the
> > > operation is trapped by the VMM and triggers an ioctl to the host to
> > > perform an equivalent configuration.=C2=A0 Generally the physical dev=
ice
> > > will interrupt within the host where it may be directly attached to K=
VM
> > > to signal the interrupt, trigger through the VMM, or where
> > > virtualization hardware supports it, the interrupt can directly trigg=
er
> > > the vCPU.=C2=A0=C2=A0 From the VM perspective, the guest address/data=
 pair is used
> > > to signal the interrupt, which is why it makes sense to virtualize the
> > > MSI registers. =20
> >
> > Hi Alex, could you help elaborate more? why from the VM perspective MSI=
=20
> > virtualization is necessary? =20
>=20
> An MSI is just a write to physical memory space. You can even use it
> like that; configure the device to just write 4 bytes to some address
> in a struct in memory to show that it needs attention, and you then
> poll that memory.
>=20
> But mostly we don't (ab)use it like that, of course. We tell the device
> to write to a special range of the physical address space where the
> interrupt controller lives =E2=80=94 the range from 0xfee00000 to 0xfeeff=
fff.
> The low 20 bits of the address, and the 32 bits of data written to that
> address, tell the interrupt controller which CPU to interrupt, and
> which vector to raise on the CPU (as well as some other details and
> weird interrupt modes which are theoretically encodable).
>=20
> So in your example, the guest writes [Address: fee00000  Data: 0020]
> which means it wants vector 0x20 on CPU#0 (well, the CPU with APICID
> 0). But that's what the *guest* wants. If we just blindly programmed
> that into the hardware, the hardware would deliver vector 0x20 to the
> host's CPU0... which would be very confused by it.
>=20
> The host has a driver for that device, probably the VFIO driver. The
> host registers its own interrupt handlers for the real hardware,
> decides which *host* CPU (and vector) should be notified when something
> happens. And when that happens, the VFIO driver will raise an event on
> an eventfd, which will notify QEMU to inject the appropriate interrupt
> into the guest.
>=20
> So... when the guest enables the MSI, that's trapped by QEMU which
> remembers which *guest* CPU/vector the interrupt should go to. QEMU
> tells VFIO to enable the corresponding interrupt, and what gets
> programmed into the actual hardware is up to the *host* operating
> system; nothing to do with the guest's information at all.
>=20
> Then when the actual hardware raises the interrupt, the VFIO interrupt
> handler runs in the guest, signals an event on the eventfd, and QEMU

s/guest/host/

> receives that and injects the event into the appropriate guest vCPU.
>=20
> (In practice QEMU doesn't do it these days; there's actually a shortcut
> which improves latency by allowing the kernel to deliver the event to
> the guest directly, connecting the eventfd directly to the KVM irq
> routing table.)
>=20
>=20
> Interrupt remapping is probably not important here, but I'll explain it
> briefly anyway. With interrupt remapping, the IOMMU handles the
> 'memory' write from the device, just as it handles all other memory
> transactions. One of the reasons for interrupt remapping is that the
> original definitions of the bits in the MSI (the low 20 bits of the
> address and the 32 bits of what's written) only had 8 bits for the
> target CPU APICID. And we have bigger systems than that now.
>=20
> So by using one of the spare bits in the MSI message, we can indicate
> that this isn't just a directly-encoded cpu/vector in "Compatibility
> Format", but is a "Remappable Format" interrupt. Instead of the
> cpu/vector it just contains an index in to the IOMMU's Interrupt
> Redirection Table. Which *does* have a full 32-bits for the target APIC
> ID. That's why x2apic support (which gives us support for >254 CPUs)
> depends on interrupt remapping.=20
>=20
> The other thing that the IOMMU can do in modern systems is *posted*
> interrupts. Where the entry in the IOMMU's IRT doesn't just specify the
> host's CPU/vector, but actually specifies a *vCPU* to deliver the
> interrupt to.=20
>=20
> All of which is mostly irrelevant as it's just another bypass
> optimisation to improve latency. The key here is that what the guest
> writes to its emulated MSI table and what the host writes to the real
> hardware are not at all related.
>=20
> If we had had this posted interrupt support from the beginning, perhaps
> we could have have a much simpler model =E2=80=94 we just let the guest w=
rite
> its intended (v)CPU#/vector *directly* to the MSI table in the device,
> and let the IOMMU fix it up by having a table pointing to the
> appropriate set of vCPUs. But that isn't how it happened. The model we
> have is that the VMM has to *emulate* the config space and handle the
> interrupts as described above.
>=20
> This means that whenever a device has a non-standard way of configuring
> MSIs, the VMM has to understand and intercept that. I believe we've
> even seen some Atheros devices with the MSI target in some weird MMIO
> registers instead of the standard location, so we've had to hack QEMU
> to handle those too?
>=20
> > And, maybe a stupid question, is that possible VM/KVM or vfio only=20
> > virtualize write operation to MSI register but leave read operation=20
> > un-virtualized? I am asking this because in that way ath11k may get a
> > chance to run in VM after getting the real vector. =20
>=20
> That might confuse a number of operating systems. Especially if they
> mask/unmask by reading the register, flipping the mask bit and writing
> back again.
>=20
> How exactly is the content of this register then given back to the
> firmware? Is that communication snoopable by the VMM?
>=20
>=20
> > >=20
> > > Off hand I don't have a good solution for this, the hardware is
> > > essentially imposing a unique requirement for MSI programming that the
> > > driver needs visibility of the physical MSI address and data.
> > >  =20
>=20
> Strictly, the driver doesn't need visibility to the actual values used
> by the hardware. Another way of it looking at it would be to say that
> the driver programs the MSI through this non-standard method, it just
> needs the VMM to trap and handle that, just as the VMM does for the
> standard MSI table.=20
>=20
> Which is what I thought we'd already seen on some Atheros devices.
>=20
> > > =C2=A0 It's
> > > conceivable that device specific code could either make the physical
> > > address/data pair visible to the VM or trap the firmware programming =
to
> > > inject the correct physical values.=C2=A0 Is there somewhere other th=
an the
> > > standard MSI capability in config space that the driver could learn t=
he
> > > physical values, ie. somewhere that isn't virtualized?=C2=A0 Thanks, =
=20
> >
> > I don't think we have such capability in configuration space. =20
>=20
> Configuration space is a complete fiction though; it's all emulated. We
> can do anything we like. Or we can have a PV hypercall which will
> report it. I don't know that we'd *want* to, but all things are
> possible.

RTL8169 has a back door to the MSI-X vector table, maybe that's the one
you're thinking of.  Alternate methods for the driver to access config
space is common on GPUs, presumably because they require extensive
vBIOS support and IO port and MMIO windows through which pre-boot code
can interact with config space is faster and easier than standard
config accesses.  Much of the work of assigning a GPU to a VM is to
wrap those alternate methods in virtualization to keep the driver
working within the guest address space.

The fictitious config space was my thought too, an ath11k vfio-pci
variant driver could insert a vendor defined capability into config
space to expose the physical MSI address/data.  The driver would know
by the presence of the capability that it's running in a VM and to
prefer that mechanism to retrieve MSI address and data.

Alternatively as also suggested here, if programming of the firmware
with the MSI address/data is something that a hypervisor could trap,
then we might be able to make it transparent to the guest.  For example
if it were programmed via MMIO, the guest address/data values could be
auto-magically replaced with physical values.  Since QEMU doesn't know
the physical values, this would also likely be through a device
specific extension to vfio-pci through a variant driver, or maybe some
combination of variant driver and QEMU if we need to make trapping
conditional in order to avoid a performance penalty.

This is essentially device specific interrupt programming, which either
needs to be virtualized (performed by the VMM) or paravirtualized
(performed in cooperation with the guest).  This is also something to
keep in mind relative to the initial source of this issue, ie. testing
device drivers and hardware under device assignment.  There can be
subtle differences.  Thanks,

Alex


