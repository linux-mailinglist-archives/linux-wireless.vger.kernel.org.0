Return-Path: <linux-wireless+bounces-38012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nVEUKVGPOmoqAAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 15:51:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75F6B7999
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 15:51:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gtW8ybMC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38012-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38012-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEC4930013B7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8655C37DE9D;
	Tue, 23 Jun 2026 13:50:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00D3672A9;
	Tue, 23 Jun 2026 13:50:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222625; cv=none; b=DgjGyccBcQZ4mcUqhxypfO6kj9bbvw+iaMBwGkVbKjXiJCnRg6VjD/Y6aq4XGSA7W87C2f3MQh7JcTiea9sn9jHx7ImVSLbez8FGOtl09bw1ehj9DXWS32r4Y87v1nmxfmtIDyR41SeVUq0HpimLhbYxv7NNP0tbEAd3RHgNne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222625; c=relaxed/simple;
	bh=zQDu23l59318ZbjiwU+/DgdA4l2AgopdPdTn1W2TIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgDYSA338ZNvnLxRcyMMAiuwBrNJoC3GVizzkm5BiuUIr/84hrI5lHi/BCYoUbGE1PpgbrWTk2qu52kvJWk8/0ZApt9mrD2WU6hUXV9tRPw7sDCh4ZkpPcq4IaAPpBFsORa8B4F/albHU4Pwcj5tSQueZ+A82gi602eGaG+/BiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtW8ybMC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A441F000E9;
	Tue, 23 Jun 2026 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782222623;
	bh=07uoq0PIndTVBv8tgnHeAEJeFAtrzEKE7E1mnPuM/Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gtW8ybMCR3A8frppplBqKA6GR+ojYF+zzFnO8rMTDlzZXqh81kXWWIfEbS1bV+0ex
	 Pq1th8wk6FIFljyGQDEbPGKOeQaQFpBrhZqrcnoIgJdy0m6Fj0NCg1m/ifnlkD1dVb
	 fN9yLXJXV5rBTTfVwBDadrOrF49Tkpbf806Gy7XEQjQzI6wXMtZS21S1R3rjnyo34E
	 2oo7Cm5zFUH3NHHTfONxIriOOXGLStnIz2sTBgMmv6isAfxQyCGM2ixoAt+M2/ffLT
	 YnK2VTDwt1wRaxUln/ozWqe4nooDXt4Fc+q3/d7/eAUTXDjzD7jQntvBI2kwPO5b13
	 DR5xGFXyr+cMg==
Date: Tue, 23 Jun 2026 15:50:15 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, bhelgaas@google.com, 
	jjohnson@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <nlbqw3h2m6cux2cbpq2ka4kq7fl7qlizkndw5zltsqd3qf346n@xmxssbpalqih>
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
 <20260618063309.9536-1-jtornosm@redhat.com>
 <4wmbans3ae5ayxqvs3wwn4hg3r3dcjuugmw2akoihvry35bq6k@k5lm6zjrp44l>
 <20260622160822.09350246@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622160822.09350246@shazbot.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:jtornosm@redhat.com,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38012-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,xmxssbpalqih:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F75F6B7999

On Mon, Jun 22, 2026 at 04:08:22PM -0600, Alex Williamson wrote:
> On Mon, 22 Jun 2026 18:22:39 +0200
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> 
> > On Thu, Jun 18, 2026 at 08:33:08AM +0200, Jose Ignacio Tornos Martinez wrote:
> > > Hi Mani,
> > > 
> > > Let me clarify the exact scenario and where the reset is necessary:
> > > 
> > > * For the commented WiFi devices (WCN6855/WCN7850):
> > > 
> > > Standard VFIO passthrough flow (this works fine):
> > >   1. Unbind native driver (ath11k/ath12k/MHI)
> > >   2. Bind vfio-pci driver
> > >   3. Assign device to VM
> > >   4. VM boots, loads its own driver → device works perfectly
> > >   5. VM shuts down cleanly → device can be reassigned → works fine
> > > 
> > > The problem occurs with unclean VM termination:
> > >   1. VM crashes or is force-terminated
> > >   2. VFIO tries to reset the device before reassignment
> > >   3. Without a working PCI reset method, reset fails
> > >   4. Device stuck in undefined state → cannot be reassigned to another VM
> > >   
> > >      Unbinding the driver again doesn't help because the device hardware
> > >      itself is in a bad state. From hypervisor:
> > >      $ lspci -vvv -s 0000:03:00.0
> > >         03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
> > >             !!! Unknown header type 7f
> > >      And a full host power-cycle is necessary to recover.
> > >        
> > 
> > Can you try the global reset available in the WLAN device BAR space?
> > 
> > WCN6855: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/net/wireless/ath/ath11k/pci.c#n193
> > WCN7850: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n182
> > 
> > > * For the commented modem devices (SDX62/SDX65): 
> > > 
> > > Even worse because it fails during the first VM boot without proper reset
> > > capability, standard VFIO passthrough flow:
> > >   1. Unbind native driver (MHI)
> > >   2. Bind vfio-pci driver
> > >   3. Assign device to VM
> > >   4. VM boots, loads its own driver and crashes:
> > >      [   24.024165] mhi mhi0: Device failed to enter MHI Ready
> > >      [   24.024168] mhi mhi0: MHI did not enter READY state
> > >      
> > >      Unbind/rebind attempts fail:
> > >      [  352.643601] mhi mhi0: Requested to power ON
> > >      [  352.643611] mhi mhi0: Power on setup success
> > >      [  373.442954] mhi mhi0: Device failed to clear MHI Reset
> > >      [  373.442970] mhi mhi0: MHI did not enter READY state
> > >      And requires a full host power cycle to recover,
> > >      even outside of VFIO scenarios.
> > > 
> > > * MHI Host driver's remove callback may handle clean software state
> > > teardown, but it doesn't provide a PCI reset capability that VFIO can
> > > invoke. VFIO needs a reset method registered in the PCI reset hierarchy
> > > (device_specific, pm, flr, bus, etc.). VFIO invokes this reset both during
> > > initial device binding (before the VM starts) and when reassigning the
> > > device between VMs - without a working reset method, the device cannot
> > > reach a clean state for initialization.
> > >   
> > 
> > Likewise, there is a SoC reset available in the modem BAR space. You can try it:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/bus/mhi/host/main.c#n178
> > 
> > If these works, then you can hook these in the device_specific reset callback.
> 
> 
> These look promising as simple flows to implement in a device specific
> reset: save command register, set memory enable, ioremap BAR space,
> match read/write/delay sequences of reset function and caller, iounmap,
> restore command.
> 
> Note the delay in this latter reset is in the caller.  It's also
> surprising that none of these implement a read to flush the posted
> write that initiates the reset.  I wonder if that contributes to the 2s
> delay in the latter example.
> 

While I agree that the absence of read-back after the posted write is a problem,
especially with a delay afterwards, the delay itself is required to let the
device reset itself and do a warm boot.

I'll submit fixes to do a read-back after triggering the reset to ensure that
the write gets flushed to the device before the delay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

