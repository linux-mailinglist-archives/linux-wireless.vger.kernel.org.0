Return-Path: <linux-wireless+bounces-1970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9194482ECD6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789A51C23033
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECC13AC0;
	Tue, 16 Jan 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bQpMM2UV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B73134B3;
	Tue, 16 Jan 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7hPyXMbU0CD1CuULzjBrBJfzCqxSAxyW0J1gzY7L4k=; b=bQpMM2UV8hhxHvlIsXc1VdCyy4
	AbdqYgIG3sHS5Hp7Q8iaMlCg5gW7xFi/+aBFSos3T5Pn7NqepsMiIgLmUy6mbn9jzMlYYI5vsQuom
	7HwCXvcq2/D9jKrEDazSryO/boUMlRUXFe4guB+rlh53aeKqrd83Qidz4FUEimelchz4iVHPv4Ydm
	g+uJ5QgIYL+XNYUF+WeOYoBeH1J+EGGDhZ0FONytZQ3EAvuPMFFUHfm3JPaKO/zwzNz0ZxmaOCsDo
	hgi2VMFCwGe9llUAgHMY0jt2SOEr64SjXBbsAWnFFccGZ+Q6KEpMpIySOx+VnLwNSDSGN7VfY9RzP
	CzRQ1v7Q==;
Received: from [54.239.6.184] (helo=daas-dns-lhr50-9.e-lhr50.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPgsj-00CiQK-OI; Tue, 16 Jan 2024 10:41:22 +0000
Message-ID: <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
Subject: Re: ath11k and vfio-pci support
From: David Woodhouse <dwmw2@infradead.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>, Alex Williamson
	 <alex.williamson@redhat.com>, Kalle Valo <kvalo@kernel.org>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, iommu@lists.linux.dev
Date: Tue, 16 Jan 2024 11:41:19 +0100
In-Reply-To: <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
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
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-/4xJATSpIQSxoZ9/1nnU"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-/4xJATSpIQSxoZ9/1nnU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-01-16 at 18:08 +0800, Baochen Qiang wrote:
>=20
>=20
> On 1/16/2024 1:46 AM, Alex Williamson wrote:
> > On Sun, 14 Jan 2024 16:36:02 +0200
> > Kalle Valo <kvalo@kernel.org> wrote:
> >=20
> > > Baochen Qiang <quic_bqiang@quicinc.com> writes:
> > >=20
> > > > > > Strange that still fails. Are you now seeing this error in your
> > > > > > host or your Qemu? or both?
> > > > > > Could you share your test steps? And if you can share please be=
 as
> > > > > > detailed as possible since I'm not familiar with passing WLAN
> > > > > > hardware to a VM using vfio-pci.
> > > > >=20
> > > > > Just in Qemu, the hardware works fine on my host machine.
> > > > > I basically follow this guide to set it up, its written in the
> > > > > context of GPUs/libvirt but the host setup is exactly the same. B=
y
> > > > > no means do you need to read it all, once you set the vfio-pci.id=
s
> > > > > and see your unclaimed adapter you can stop:
> > > > > https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
> > > > > In short you should be able to set the following host kernel opti=
ons
> > > > > and reboot (assuming your motherboard/hardware is compatible):
> > > > > intel_iommu=3Don iommu=3Dpt vfio-pci.ids=3D17cb:1103
> > > > > Obviously change the device/vendor IDs to whatever ath11k hw you
> > > > > have. Once the host is rebooted you should see your wlan adapter =
as
> > > > > UNCLAIMED, showing the driver in use as vfio-pci. If not, its lik=
ely
> > > > > your motherboard just isn't compatible, the device has to be in i=
ts
> > > > > own IOMMU group (you could try switching PCI ports if this is the
> > > > > case).
> > > > > I then build a "kvm_guest.config" kernel with the driver/firmware
> > > > > for ath11k and boot into that with the following Qemu options:
> > > > > -enable-kvm -device -vfio-pci,host=3D<PCI address>
> > > > > If it seems easier you could also utilize IWD's test-runner which
> > > > > handles launching the Qemu kernel automatically, detecting any
> > > > > vfio-devices and passes them through and mounts some useful host
> > > > > folders into the VM. Its actually a very good general purpose too=
l
> > > > > for kernel testing, not just for IWD:
> > > > > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/=
test-runner.txt
> > > > > Once set up you can just run test-runner with a few flags and you=
'll
> > > > > boot into a shell:
> > > > > ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
> > > > > Please reach out if you have questions, thanks for looking into
> > > > > this.
> > > >=20
> > > > Thanks for these details. I reproduced this issue by following your=
 guide.
> > > >=20
> > > > Seems the root cause is that the MSI vector assigned to WCN6855 in
> > > > qemu is different with that in host. In my case the MSI vector in q=
emu
> > > > is [Address: fee00000=C2=A0 Data: 0020] while in host it is [Addres=
s:
> > > > fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
> > > > [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
> > > > firmware uses that vector to fire interrupts to host/qemu. However
> > > > host IOMMU doesn't know that vector because the real vector is
> > > > [Address: fee00578=C2=A0 Data: 0000], as a result host blocks that
> > > > interrupt and reports an error, see below log:
> > > >=20
> > > > [ 1414.206069] DMAR: DRHD: handling fault status reg 2
> > > > [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault in=
dex
> > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > request
> > > > [ 1414.210334] DMAR: DRHD: handling fault status reg 2
> > > > [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault in=
dex
> > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > request
> > > > [ 1414.212496] DMAR: DRHD: handling fault status reg 2
> > > > [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault in=
dex
> > > > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > > > request
> > > > [ 1414.214600] DMAR: DRHD: handling fault status reg 2
> > > >=20
> > > > While I don't think there is a way for qemu/ath11k to get the real =
MSI
> > > > vector from host, I will try to read the vfio code to check further=
.
> > > > Before that, to unblock you, a possible hack is to hard code the MS=
I
> > > > vector in qemu to the same as in host, on condition that the MSI
> > > > vector doesn't change.
> > >=20
> > > Baochen, awesome that you were able to debug this further. Now we at
> > > least know what's the problem.
> >=20
> > It's an interesting problem, I don't think we've seen another device
> > where the driver reads the MSI register in order to program another
> > hardware entity to match the MSI address and data configuration.
> >=20
> > When assigning a device, the host and guest use entirely separate
> > address spaces for MSI interrupts.=C2=A0 When the guest enables MSI, th=
e
> > operation is trapped by the VMM and triggers an ioctl to the host to
> > perform an equivalent configuration.=C2=A0 Generally the physical devic=
e
> > will interrupt within the host where it may be directly attached to KVM
> > to signal the interrupt, trigger through the VMM, or where
> > virtualization hardware supports it, the interrupt can directly trigger
> > the vCPU.=C2=A0=C2=A0 From the VM perspective, the guest address/data p=
air is used
> > to signal the interrupt, which is why it makes sense to virtualize the
> > MSI registers.
>
> Hi Alex, could you help elaborate more? why from the VM perspective MSI=
=20
> virtualization is necessary?

An MSI is just a write to physical memory space. You can even use it
like that; configure the device to just write 4 bytes to some address
in a struct in memory to show that it needs attention, and you then
poll that memory.

But mostly we don't (ab)use it like that, of course. We tell the device
to write to a special range of the physical address space where the
interrupt controller lives =E2=80=94 the range from 0xfee00000 to 0xfeeffff=
f.
The low 20 bits of the address, and the 32 bits of data written to that
address, tell the interrupt controller which CPU to interrupt, and
which vector to raise on the CPU (as well as some other details and
weird interrupt modes which are theoretically encodable).

So in your example, the guest writes [Address: fee00000  Data: 0020]
which means it wants vector 0x20 on CPU#0 (well, the CPU with APICID
0). But that's what the *guest* wants. If we just blindly programmed
that into the hardware, the hardware would deliver vector 0x20 to the
host's CPU0... which would be very confused by it.

The host has a driver for that device, probably the VFIO driver. The
host registers its own interrupt handlers for the real hardware,
decides which *host* CPU (and vector) should be notified when something
happens. And when that happens, the VFIO driver will raise an event on
an eventfd, which will notify QEMU to inject the appropriate interrupt
into the guest.

So... when the guest enables the MSI, that's trapped by QEMU which
remembers which *guest* CPU/vector the interrupt should go to. QEMU
tells VFIO to enable the corresponding interrupt, and what gets
programmed into the actual hardware is up to the *host* operating
system; nothing to do with the guest's information at all.

Then when the actual hardware raises the interrupt, the VFIO interrupt
handler runs in the guest, signals an event on the eventfd, and QEMU
receives that and injects the event into the appropriate guest vCPU.

(In practice QEMU doesn't do it these days; there's actually a shortcut
which improves latency by allowing the kernel to deliver the event to
the guest directly, connecting the eventfd directly to the KVM irq
routing table.)


Interrupt remapping is probably not important here, but I'll explain it
briefly anyway. With interrupt remapping, the IOMMU handles the
'memory' write from the device, just as it handles all other memory
transactions. One of the reasons for interrupt remapping is that the
original definitions of the bits in the MSI (the low 20 bits of the
address and the 32 bits of what's written) only had 8 bits for the
target CPU APICID. And we have bigger systems than that now.

So by using one of the spare bits in the MSI message, we can indicate
that this isn't just a directly-encoded cpu/vector in "Compatibility
Format", but is a "Remappable Format" interrupt. Instead of the
cpu/vector it just contains an index in to the IOMMU's Interrupt
Redirection Table. Which *does* have a full 32-bits for the target APIC
ID. That's why x2apic support (which gives us support for >254 CPUs)
depends on interrupt remapping.=20

The other thing that the IOMMU can do in modern systems is *posted*
interrupts. Where the entry in the IOMMU's IRT doesn't just specify the
host's CPU/vector, but actually specifies a *vCPU* to deliver the
interrupt to.=20

All of which is mostly irrelevant as it's just another bypass
optimisation to improve latency. The key here is that what the guest
writes to its emulated MSI table and what the host writes to the real
hardware are not at all related.

If we had had this posted interrupt support from the beginning, perhaps
we could have have a much simpler model =E2=80=94 we just let the guest wri=
te
its intended (v)CPU#/vector *directly* to the MSI table in the device,
and let the IOMMU fix it up by having a table pointing to the
appropriate set of vCPUs. But that isn't how it happened. The model we
have is that the VMM has to *emulate* the config space and handle the
interrupts as described above.

This means that whenever a device has a non-standard way of configuring
MSIs, the VMM has to understand and intercept that. I believe we've
even seen some Atheros devices with the MSI target in some weird MMIO
registers instead of the standard location, so we've had to hack QEMU
to handle those too?

> And, maybe a stupid question, is that possible VM/KVM or vfio only=20
> virtualize write operation to MSI register but leave read operation=20
> un-virtualized? I am asking this because in that way ath11k may get a
> chance to run in VM after getting the real vector.

That might confuse a number of operating systems. Especially if they
mask/unmask by reading the register, flipping the mask bit and writing
back again.

How exactly is the content of this register then given back to the
firmware? Is that communication snoopable by the VMM?


> >=20
> > Off hand I don't have a good solution for this, the hardware is
> > essentially imposing a unique requirement for MSI programming that the
> > driver needs visibility of the physical MSI address and data.
> >=20

Strictly, the driver doesn't need visibility to the actual values used
by the hardware. Another way of it looking at it would be to say that
the driver programs the MSI through this non-standard method, it just
needs the VMM to trap and handle that, just as the VMM does for the
standard MSI table.=20

Which is what I thought we'd already seen on some Atheros devices.

> > =C2=A0 It's
> > conceivable that device specific code could either make the physical
> > address/data pair visible to the VM or trap the firmware programming to
> > inject the correct physical values.=C2=A0 Is there somewhere other than=
 the
> > standard MSI capability in config space that the driver could learn the
> > physical values, ie. somewhere that isn't virtualized?=C2=A0 Thanks,
>
> I don't think we have such capability in configuration space.

Configuration space is a complete fiction though; it's all emulated. We
can do anything we like. Or we can have a PV hypercall which will
report it. I don't know that we'd *want* to, but all things are
possible.


--=-/4xJATSpIQSxoZ9/1nnU
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMTE2MTA0MTE5WjAvBgkqhkiG9w0BCQQxIgQgIDnWV9gR
m1MSiH1O8zMiAat6/lKTTBThZHwLsyQEyQEwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBhkDm30KoN2R5HnhK8Y81OlPe24+JjKGCd
dkKtMyWJqDBfSiEv6Iuvj66/mUTbtmOOUQuB3uVO1dtqNgWjfwdHYomltKqlE4kax4t7egyf/tk4
rvPSoQvHHffWH7PFocFbSKOWy2gBoJ2URHc/GmPtdByJ8lGo93HShDSPXH/wQmWBynm0Ik894oHh
M+MbaJObm+XdknsqYt/ybkPIey3KATvqYnyY/UF+kA9B+Rjc/2BkE+SlSy5ls21zirZ3XC7BFYlD
iKLapzIJSCI2RR9TftbyCvq4qaNZ8opXSYis7qtHd6nim709ULZKf1r70R+7Xzvada9HnS8EcDM2
WiukSRmc4Jiy/yUjm8HQ4nGchEvsMynbZwjoHrKmWmC+DlHlAJlnb/3Vm0FIODlqw70M9kcGHzxi
A5l4YXy6pkp+wtIrWaPTPAzklakuG2qyffvxbCHeYxbRz0tvlo4PN2TKI3SDb6huZBUwYrqnqg8l
WeeMsPFMDS/jWvCxSXiHNVpkPm2nWH9O6BNAcN2kk5WpzmClW5Fa1XTnsMUvOrfi3Mx5YL64iOxg
RLr4xdp4RAmlYWns8Io1eqzTCOj7F9G72yp4i/HGe+xyPv4/0JfdWW17OOfOadMsD82KgqsVkyPq
IKphReANUgk8a5Muf86kf+7++dnJqs1IAOetPoRnYQAAAAAAAA==


--=-/4xJATSpIQSxoZ9/1nnU--

