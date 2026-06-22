Return-Path: <linux-wireless+bounces-37981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TQyvNAJiOWp3rQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 18:25:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3466B11BE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 18:25:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ku1f72fK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37981-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37981-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19EF302AC23
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4685E2EBB8D;
	Mon, 22 Jun 2026 16:22:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3B238C1A;
	Mon, 22 Jun 2026 16:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145369; cv=none; b=U3MPP0Qha0pQWcW3U9wqzl4lRhOXZX2zVhwYEwZNV8eQWszjIWaiVDTeX+rQFxF7lhlj2Gff2uKkOxbJItHVhNEUNAIaIsNDxDgEJ1GWY7umkxzc4FMcejtT2kqLZW60DzOJ8qKWFAVQ/XpmIeqbMyZGQdrOAme0p4OzxnPpuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145369; c=relaxed/simple;
	bh=ZxB0HLrfwlmT9jfHFx31X73Y0V37Fo02zElWchtig6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Kf8bnoilK1imj35aDyxQsOLnclLQEnc7iNeaYixAZpPXD47A8VLn6ezhCEGRRpag/IBDkRFPNX9JlL/JQowvkvbDHsdiwvIpDeo9fyvTLJIYDDAvymX4YZAt/T8qGWiaQp8FkjCgxQKmCLcf1SrMrWkJCqvVUSuzutrydkV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku1f72fK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B481F000E9;
	Mon, 22 Jun 2026 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145367;
	bh=ih+I5LnVu91b8pUW2V5GEe/78uVOQ3kGU5E/0iuy70k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ku1f72fKgdOM39icewQMIy5DxQcwfR3BAg894AtUwaqWJ6n9ma5vCgEAMSvjx8Eh/
	 rHdHjET/Ccg2I+FAvobyUTONrsxsIBhzVos8fy17w/P4/Su+F42/NH+ypA9WewiUU4
	 EgRHCS3Zad8Yz3Lwgm1Hx9FHLkEIWdLghmUZQ3QpS/xezkQoSDLclvYSSFnruZfW5Z
	 dRc3q4FwJ7i19lOXshPoidh6SwArl5dRNTYmGo6HiazmRGGxffnPN3uThvLj0c7c0g
	 7MBbS0hnVAOlC9sfWdQGVVmuxe6f4Y/bY4cLVYCBnxZ0pwpulEEISm3Vqy8EeBJ9iJ
	 OUzo0J0fKd9bw==
Date: Mon, 22 Jun 2026 18:22:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, bhelgaas@google.com, jjohnson@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <4wmbans3ae5ayxqvs3wwn4hg3r3dcjuugmw2akoihvry35bq6k@k5lm6zjrp44l>
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
 <20260618063309.9536-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618063309.9536-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37981-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D3466B11BE

On Thu, Jun 18, 2026 at 08:33:08AM +0200, Jose Ignacio Tornos Martinez wrote:
> Hi Mani,
> 
> Let me clarify the exact scenario and where the reset is necessary:
> 
> * For the commented WiFi devices (WCN6855/WCN7850):
> 
> Standard VFIO passthrough flow (this works fine):
>   1. Unbind native driver (ath11k/ath12k/MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver → device works perfectly
>   5. VM shuts down cleanly → device can be reassigned → works fine
> 
> The problem occurs with unclean VM termination:
>   1. VM crashes or is force-terminated
>   2. VFIO tries to reset the device before reassignment
>   3. Without a working PCI reset method, reset fails
>   4. Device stuck in undefined state → cannot be reassigned to another VM
>   
>      Unbinding the driver again doesn't help because the device hardware
>      itself is in a bad state. From hypervisor:
>      $ lspci -vvv -s 0000:03:00.0
>         03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
>             !!! Unknown header type 7f
>      And a full host power-cycle is necessary to recover.
>      

Can you try the global reset available in the WLAN device BAR space?

WCN6855: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/net/wireless/ath/ath11k/pci.c#n193
WCN7850: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n182

> * For the commented modem devices (SDX62/SDX65): 
> 
> Even worse because it fails during the first VM boot without proper reset
> capability, standard VFIO passthrough flow:
>   1. Unbind native driver (MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver and crashes:
>      [   24.024165] mhi mhi0: Device failed to enter MHI Ready
>      [   24.024168] mhi mhi0: MHI did not enter READY state
>      
>      Unbind/rebind attempts fail:
>      [  352.643601] mhi mhi0: Requested to power ON
>      [  352.643611] mhi mhi0: Power on setup success
>      [  373.442954] mhi mhi0: Device failed to clear MHI Reset
>      [  373.442970] mhi mhi0: MHI did not enter READY state
>      And requires a full host power cycle to recover,
>      even outside of VFIO scenarios.
> 
> * MHI Host driver's remove callback may handle clean software state
> teardown, but it doesn't provide a PCI reset capability that VFIO can
> invoke. VFIO needs a reset method registered in the PCI reset hierarchy
> (device_specific, pm, flr, bus, etc.). VFIO invokes this reset both during
> initial device binding (before the VM starts) and when reassigning the
> device between VMs - without a working reset method, the device cannot
> reach a clean state for initialization.
> 

Likewise, there is a SoC reset available in the modem BAR space. You can try it:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/bus/mhi/host/main.c#n178

If these works, then you can hook these in the device_specific reset callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

