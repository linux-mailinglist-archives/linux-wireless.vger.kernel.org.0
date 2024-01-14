Return-Path: <linux-wireless+bounces-1887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F261582D0EC
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8488E281E2B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C21C14;
	Sun, 14 Jan 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFZabdzF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487B23BD;
	Sun, 14 Jan 2024 14:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAB7C433C7;
	Sun, 14 Jan 2024 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705242966;
	bh=2PtpfqJ1Dl46SH4Umiey2RyYGOKuTs63MJB/h3a4M90=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qFZabdzF5pOjQs656gKVK0gH+mgP3pEf+4EeaIwow7aSlieh5afrXBG1eX3Uumz5k
	 1onuNWe2M3kKUT2hexzcOiDFUslI4eY+tOdszeL3Nk/5WwKAbZKCaJK+i7k5jYXYSX
	 JZGwJ3tzaACb7BgdKoY49gVTrvo4u+kaPFjuhiXWdUshnJjAyBETSRZWVC394EGdJ+
	 u2/5kyNEchoXCUKcLt8mMKgrnYpu7AOJhoqlOMtrvoI6P2bzoXBFZkDNz3MpLpdclx
	 XQQEUWeX6Gx69nGH18ADbUIY9fzZryD05CVtinNaisoE7G0rPjdSrxrEz+zm4sAbKM
	 0Sb7NlSrBz/3A==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: James Prestwood <prestwoj@gmail.com>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,
    David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Subject: Re: ath11k and vfio-pci support
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
Date: Sun, 14 Jan 2024 16:36:02 +0200
In-Reply-To: <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com> (Baochen
	Qiang's message of "Sun, 14 Jan 2024 20:37:03 +0800")
Message-ID: <87il3w7zjh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>> Strange that still fails. Are you now seeing this error in your
>>> host or your Qemu? or both?
>>> Could you share your test steps? And if you can share please be as
>>> detailed as possible since I'm not familiar with passing WLAN
>>> hardware to a VM using vfio-pci.
>>
>> Just in Qemu, the hardware works fine on my host machine.
>> I basically follow this guide to set it up, its written in the
>> context of GPUs/libvirt but the host setup is exactly the same. By
>> no means do you need to read it all, once you set the vfio-pci.ids
>> and see your unclaimed adapter you can stop:
>> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
>> In short you should be able to set the following host kernel options
>> and reboot (assuming your motherboard/hardware is compatible):
>> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
>> Obviously change the device/vendor IDs to whatever ath11k hw you
>> have. Once the host is rebooted you should see your wlan adapter as
>> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely
>> your motherboard just isn't compatible, the device has to be in its
>> own IOMMU group (you could try switching PCI ports if this is the
>> case).
>> I then build a "kvm_guest.config" kernel with the driver/firmware
>> for ath11k and boot into that with the following Qemu options:
>> -enable-kvm -device -vfio-pci,host=<PCI address>
>> If it seems easier you could also utilize IWD's test-runner which
>> handles launching the Qemu kernel automatically, detecting any
>> vfio-devices and passes them through and mounts some useful host
>> folders into the VM. Its actually a very good general purpose tool
>> for kernel testing, not just for IWD:
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
>> Once set up you can just run test-runner with a few flags and you'll
>> boot into a shell:
>> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
>> Please reach out if you have questions, thanks for looking into
>> this.
>
> Thanks for these details. I reproduced this issue by following your guide.
>
> Seems the root cause is that the MSI vector assigned to WCN6855 in
> qemu is different with that in host. In my case the MSI vector in qemu
> is [Address: fee00000  Data: 0020] while in host it is [Address:
> fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
> [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
> firmware uses that vector to fire interrupts to host/qemu. However
> host IOMMU doesn't know that vector because the real vector is
> [Address: fee00578  Data: 0000], as a result host blocks that
> interrupt and reports an error, see below log:
>
> [ 1414.206069] DMAR: DRHD: handling fault status reg 2
> [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> request
> [ 1414.210334] DMAR: DRHD: handling fault status reg 2
> [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> request
> [ 1414.212496] DMAR: DRHD: handling fault status reg 2
> [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> request
> [ 1414.214600] DMAR: DRHD: handling fault status reg 2
>
> While I don't think there is a way for qemu/ath11k to get the real MSI
> vector from host, I will try to read the vfio code to check further.
> Before that, to unblock you, a possible hack is to hard code the MSI
> vector in qemu to the same as in host, on condition that the MSI
> vector doesn't change.

Baochen, awesome that you were able to debug this further. Now we at
least know what's the problem.

I'll add David Woodhouse and the iommu list in hopes that they could
give us ideas how to solve this. Full thread here:

https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

