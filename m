Return-Path: <linux-wireless+bounces-8156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C388D13D3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 07:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729581C20D87
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB394BA94;
	Tue, 28 May 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="II3O24pd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34994AEDF;
	Tue, 28 May 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873757; cv=none; b=JndqCVbtOW2nv+8cZZCCxCqjiS9GFLSPV6szJUgIxZ5zVLsqt0RGbZpEIxy1IN3W+DNffaWKErkgxqqonFriAgBOP0MulVMeDo4bPDiXL30PX/+8EXn7Ugp65RDFj11FAZe01cOdw0GeJdW9/RN2jJOa8Au2Ay/t/Q9MD7nTePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873757; c=relaxed/simple;
	bh=7ERKas/OkCdasWCLOQ9A0s9OZOng3YFWI1DUXAB5Hwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8BIXB76jLN+YonrhqWRVDXEKcargclZb5RWYOBMIGqFeV60rIaX3DVc3fZj3KdUC610c2qxYgDC8OypNGfNJ4ZUy1UlaXyz78+Gzep1fuBBhmsWN7xvzi5T9pSUs3vQV/db+qy+xV2Y1zg8XWw62oAY7uwCzAj2Bo3alakhjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=II3O24pd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=h2WKMvgwAaogvoHjA4LWCMWXhYlg8Zv23ou9ksyPtbo=;
	t=1716873755; x=1717305755; b=II3O24pdoi42K512Ax6StNNB6pZGKvZIbv7GmjYvOljd2RZ
	xbW6KqFv9nnVQDauERtJei5qNpX+X5fw1PncMtmu0vfmdoLbmIg0AgjEYyx8cvxNmjTtiAnAs89dk
	O6P5vApgA21pcmLyTmi0IJPJE7pCp82Bi5PxI5xjXrWcxOHcrgf2moKKf9L3O7iWWUnVqnRQuQPaw
	TwVakVnmKmuLHEh9T6wpkT/mSKcFJkkiQe+Deo/RjAivjGeQj8Y3s8lfDzGGOqDwu2nI+xARF9gjj
	5+h7PqwDLnOHPWD7E9/XGtO6JVzr3qIZjIBBVCdDWWSkXiHqfpWNB8FOxjP56fZQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sBpI7-00087e-MZ; Tue, 28 May 2024 07:22:31 +0200
Message-ID: <b3d8a378-346d-4dd8-9af8-1529a4484184@leemhuis.info>
Date: Tue, 28 May 2024 07:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
To: Christian Heusel <christian@heusel.eu>,
 Johannes Berg <johannes.berg@intel.com>, regressions@lists.linux.dev
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Savyasaachi Vanga <savyasaachiv@gmail.com>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716873755;2b659210;
X-HE-SMSGID: 1sBpI7-00087e-MZ

On 28.05.24 00:01, Christian Heusel wrote:
> 
> Savyasaachi reports that scanning for other stations in monitor mode
> does not work anymore with his RTL8821CE wireless network card for linux
> kernels after 6.8.9.

Thx for the report. A few remarks:

Please be more specific in cases like this, as "kernels after 6.8.9" can
mean "6.8.10+", "6.10-rc", or "6.9.y" (apparently it is the latter).
Yes, this is nitpicking, which is why I normally would not have said
anything -- but because you frequently report bugs it's likely in
everybody's interest to bring this up.

In a case like this it would also be good if the reporter could give
latest mainline a try, as (1) a fix might already be in there and (2)
some developers do not care at all about bugs in stable kernels (and
they are free to do so!). See
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
for details.

And sorry, there is something else: from the dmesg it looks a lot like
this report is from a patched vendor kernel that among others seems to
enable features like "forced interrupt request threading"
(https://github.com/zen-kernel/zen-kernel/wiki/Detailed-Feature-List ).
Such changes even if small and done carefully can lead to bugs like this
(yes, that particular feature I mentioned can be enabled through a
kernel parameter as well, but some developers would consider this to be
an unsupported configuration). The absolut minimum you should have done
is to mention that; but normally you never want to use such kernels for
reporting bugs upstream, as the problem might not be present in the
upstream code.

Ciao, Thorsten

> His workflow was putting the adapter in monitor mode by running
> "airmon-ng start wlan0" and then capture the surrounding stations with
> "airodump-ng wlan0".
> 
> We have bisected the issue together in the issue in the Arch Linux
> bugtracker[0] down to the following commit:
> 
>     0a44dfc070749 ("wifi: mac80211: simplify non-chanctx drivers")
> 
> Savyasaachi (in CC) offered to be available for questions and further
> debugging in this thread and some general debugging outputs are
> attached/below.
> 
> Reported-by: Savyasaachi Vanga <savyasaachiv@gmail.com>
> Bisected-by: Christian Heusel <christian@heusel.eu>
> 
> Cheers,
> Chris
> 
> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/54
> 
> ---
> 
> #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/54
> #regzbot introduced: 0a44dfc070749
> #regzbot title: wifi: RTL8821CE does not work in monitor mode
> 
> ---
> 
> lsusb:
> 
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 003 Device 002: ID 0bda:c829 Realtek Semiconductor Corp. Bluetooth Radio
> Bus 003 Device 003: ID 0c45:6739 Microdia Integrated_Webcam_FHD
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> 
> lspci:
> 
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
> 00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
> 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 5
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 6
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 7
> 01:00.0 Non-Volatile memory controller: Micron Technology Inc 2210 NVMe SSD [Cobain] (rev 03)
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Barcelo (rev c2)
> 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
> 04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
> 04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
> 04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
> 04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
> 04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
> 05:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)
> 05:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)

