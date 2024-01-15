Return-Path: <linux-wireless+bounces-1942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BFD82DE9B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4C01C21DDC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81241803D;
	Mon, 15 Jan 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJBcw1+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148618040
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705340822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tj95X6Cb7bhoneZp66ZNJxrjevei8xxSJ8nqqi86PvE=;
	b=UJBcw1+WL3hm0hyTRbXR5eds5CVWtwaN9HiBQYSp1y4KFEeAoAJf4k+elZrehraaNOxU2K
	+Q4Z/xgsSiCwUXwCcUxAaSpKlKbXD8cvryOrtuucZNFwis6ZJ8sDK2UaRBSb3FF7Q0NOlK
	HiE1inbYvyQ8qWcByqW5/hdnMK/xtn4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-X57VTXl3P6G_ZbTf_q_JjA-1; Mon, 15 Jan 2024 12:47:01 -0500
X-MC-Unique: X57VTXl3P6G_ZbTf_q_JjA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so845420539f.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 09:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705340820; x=1705945620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj95X6Cb7bhoneZp66ZNJxrjevei8xxSJ8nqqi86PvE=;
        b=fNiLgwmPBj0CNalO0osqZy9klkxKAtk59mR+tsQtJTlQp4pEJnYAjP33TiyImdiGOI
         tBhDnG5Dv4edFwaaB/eCKvq1QOO6n4fJg8TD/0fembQJnBoDCtffueDRyQYf79Cf5U+A
         x0YPUIIsvUci2LgLlDIEyymXs46dFgshbblk03pGm1tfj4WFxtQbT1PlkN2ZPcB/Mkd3
         k++qdvXIZ8qNhlukXFnqHdoOpVX4lmiZU4iq7byV9n4Idn3CYNa+OEAkF7S2tU3TPbNH
         18nbWQjt8PUhOrh5iCgJNT1I682CK/mKGG3qtx6IcrrRArDzjcEt99Lx34I8EuJ5qAqG
         FLSA==
X-Gm-Message-State: AOJu0Yw5L270dVnwximMBhPlU2yRof8cawtYERoR+ctaAtmw0Hb7a08q
	KvC8wd4k9WDmYTIXyrVXxIdZrKIYyud7cQP6trbsiV7XU4caDrxVbtUP4xMghhJTWKnR9G69x2t
	m103VPvY8HunybycziSfc2bmmEdQuhrC7Mb0=
X-Received: by 2002:a6b:f017:0:b0:7bf:3b15:a4b8 with SMTP id w23-20020a6bf017000000b007bf3b15a4b8mr2592075ioc.37.1705340820572;
        Mon, 15 Jan 2024 09:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsk5tH1OmNXvCvtcX6HYKQW/5RrTQyTMoRwHQR84713RSt0MxE+/PyZzU6KANDdoWAD43sQA==
X-Received: by 2002:a6b:f017:0:b0:7bf:3b15:a4b8 with SMTP id w23-20020a6bf017000000b007bf3b15a4b8mr2592064ioc.37.1705340820242;
        Mon, 15 Jan 2024 09:47:00 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id a1-20020a0566380b0100b0046d9e290a74sm2445951jab.7.2024.01.15.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:46:59 -0800 (PST)
Date: Mon, 15 Jan 2024 10:46:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, James Prestwood
 <prestwoj@gmail.com>, <linux-wireless@vger.kernel.org>,
 <ath11k@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev
Subject: Re: ath11k and vfio-pci support
Message-ID: <20240115104658.0b56bd35.alex.williamson@redhat.com>
In-Reply-To: <87il3w7zjh.fsf@kernel.org>
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
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jan 2024 16:36:02 +0200
Kalle Valo <kvalo@kernel.org> wrote:

> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
> >>> Strange that still fails. Are you now seeing this error in your
> >>> host or your Qemu? or both?
> >>> Could you share your test steps? And if you can share please be as
> >>> detailed as possible since I'm not familiar with passing WLAN
> >>> hardware to a VM using vfio-pci.  
> >>
> >> Just in Qemu, the hardware works fine on my host machine.
> >> I basically follow this guide to set it up, its written in the
> >> context of GPUs/libvirt but the host setup is exactly the same. By
> >> no means do you need to read it all, once you set the vfio-pci.ids
> >> and see your unclaimed adapter you can stop:
> >> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
> >> In short you should be able to set the following host kernel options
> >> and reboot (assuming your motherboard/hardware is compatible):
> >> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
> >> Obviously change the device/vendor IDs to whatever ath11k hw you
> >> have. Once the host is rebooted you should see your wlan adapter as
> >> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely
> >> your motherboard just isn't compatible, the device has to be in its
> >> own IOMMU group (you could try switching PCI ports if this is the
> >> case).
> >> I then build a "kvm_guest.config" kernel with the driver/firmware
> >> for ath11k and boot into that with the following Qemu options:
> >> -enable-kvm -device -vfio-pci,host=<PCI address>
> >> If it seems easier you could also utilize IWD's test-runner which
> >> handles launching the Qemu kernel automatically, detecting any
> >> vfio-devices and passes them through and mounts some useful host
> >> folders into the VM. Its actually a very good general purpose tool
> >> for kernel testing, not just for IWD:
> >> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
> >> Once set up you can just run test-runner with a few flags and you'll
> >> boot into a shell:
> >> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
> >> Please reach out if you have questions, thanks for looking into
> >> this.  
> >
> > Thanks for these details. I reproduced this issue by following your guide.
> >
> > Seems the root cause is that the MSI vector assigned to WCN6855 in
> > qemu is different with that in host. In my case the MSI vector in qemu
> > is [Address: fee00000  Data: 0020] while in host it is [Address:
> > fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
> > [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
> > firmware uses that vector to fire interrupts to host/qemu. However
> > host IOMMU doesn't know that vector because the real vector is
> > [Address: fee00578  Data: 0000], as a result host blocks that
> > interrupt and reports an error, see below log:
> >
> > [ 1414.206069] DMAR: DRHD: handling fault status reg 2
> > [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > request
> > [ 1414.210334] DMAR: DRHD: handling fault status reg 2
> > [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > request
> > [ 1414.212496] DMAR: DRHD: handling fault status reg 2
> > [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> > 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > request
> > [ 1414.214600] DMAR: DRHD: handling fault status reg 2
> >
> > While I don't think there is a way for qemu/ath11k to get the real MSI
> > vector from host, I will try to read the vfio code to check further.
> > Before that, to unblock you, a possible hack is to hard code the MSI
> > vector in qemu to the same as in host, on condition that the MSI
> > vector doesn't change.  
> 
> Baochen, awesome that you were able to debug this further. Now we at
> least know what's the problem.

It's an interesting problem, I don't think we've seen another device
where the driver reads the MSI register in order to program another
hardware entity to match the MSI address and data configuration.

When assigning a device, the host and guest use entirely separate
address spaces for MSI interrupts.  When the guest enables MSI, the
operation is trapped by the VMM and triggers an ioctl to the host to
perform an equivalent configuration.  Generally the physical device
will interrupt within the host where it may be directly attached to KVM
to signal the interrupt, trigger through the VMM, or where
virtualization hardware supports it, the interrupt can directly trigger
the vCPU.   From the VM perspective, the guest address/data pair is used
to signal the interrupt, which is why it makes sense to virtualize the
MSI registers.

Off hand I don't have a good solution for this, the hardware is
essentially imposing a unique requirement for MSI programming that the
driver needs visibility of the physical MSI address and data.  It's
conceivable that device specific code could either make the physical
address/data pair visible to the VM or trap the firmware programming to
inject the correct physical values.  Is there somewhere other than the
standard MSI capability in config space that the driver could learn the
physical values, ie. somewhere that isn't virtualized?  Thanks,

Alex


