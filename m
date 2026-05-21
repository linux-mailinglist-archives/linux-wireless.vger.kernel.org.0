Return-Path: <linux-wireless+bounces-36767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOv2IHJGD2ptIgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:52:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5075AA9E4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A745F32C4A07
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DCE379C3F;
	Thu, 21 May 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egZmnsLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A03845D8;
	Thu, 21 May 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380376; cv=none; b=LV3EM4JzhRAoQPCeam/DuU/0mB5tAF6CQke9U/9D98GFEoJX9tzEJ0DUv75/NzxWEAZDw+WUjGx3svGC1LM/tE5IOyFV7J/C3Sq/DL2LKy3oUpfm02eKn+qRAGzyGbG9FMIaoQPOZYMuRu10Ujd3G/Ba85dr827Oxs1jsNXwx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380376; c=relaxed/simple;
	bh=PTiSiCkcQ7fIijyClE3NFIBeAytqfuOG1d58YEIfOf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rFY7qnQKuTZ30CWA1ZxUB+17xRvVo0ovTGEZZyAFMlzxkNMOlUehLGZDbQ3E5CZSpQ5NE2LKb9wonShKz/9RzFvX9Jx3SVHEG214DbNXdRFwZbiHWGBs/dpZl/S5GgEL6RjfGzMyAKrig3TsX4g2oRu69NeWTItgaHiN1llEXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egZmnsLW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 081B01F000E9;
	Thu, 21 May 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779380374;
	bh=dusw/CsGuS7cpPWYUs280n/HzgNhk1QSNG+bPDzIWTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=egZmnsLWSWZwHn8w+BTtoFNaLddpu3vEbk5S/NTfl3m3pIcUXpg1+JpkKr5jd5DYG
	 3JshXleLNNMdEn7mGBpUTRsbEqMr+UX9INQYkHmu8p9ATLeonR/D8mXJZXgwMw+782
	 mzJGQ7jgcfKeiWnydGCw6uafhp/RD0kdOWElX8T2n7Xnd1su9x9UH91LsIPL3lHpM1
	 djV9DFXeSVjTGRsF18VvuYCD0SwpuY5tT3WpYMGq0PXVoAt0UxjrT3N47hantIijUf
	 X1zB4N5+XgEqRHyHVpKdFOmYB5ullo99tOf0xo4MQqTWj3okcvcGz+D7kzdCEUwtQP
	 Q7E3PdJEkt5ag==
Date: Thu, 21 May 2026 11:19:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, nbd@nbd.name, lorenzo@kernel.org,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v3] PCI: Disable broken FLR on MediaTek MT7925
Message-ID: <20260521161932.GA167656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521061205.12727-1-jtornosm@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36767-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A5075AA9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[+cc Ryder]

On Thu, May 21, 2026 at 08:12:05AM +0200, Jose Ignacio Tornos Martinez wrote:
> The MediaTek MT7925 WiFi device (14c3:7925) advertises FLR capability
> but the implementation is broken - reset always fails, leaving the device
> in an undefined state.
> 
> This manifests in VFIO passthrough scenarios: Normal VM operation works
> fine, including clean shutdown/reboot. However, when the VM terminates
> uncleanly (crash, force-off), VFIO attempts to reset the device before
> it can be assigned to another VM. Because FLR is broken, the reset fails
> and the device remains in an undefined state, preventing reuse.

How do we know the device is an "undefined state"?  Does it just not
respond to config accesses?  Is there something in dmesg that shows
the problem?

I suppose it's similar to 81f64e925c29 ("PCI: Avoid FLR for Mediatek
MT7922 WiFi")?

I guess I'm just looking for some text more specific than "undefined
state".

Can we get any of the MediaTek folks to comment on this:
https://sashiko.dev/#/patchset/20260508145153.717641-1-jtornosm@redhat.com?part=1

Sashiko suggested that Device ID 0x0717 might have the same FLR
problem.

> Disable FLR for this device so the PCI core falls back to working reset
> methods (PM reset or bus reset).
> 
> This follows the existing pattern used for the MediaTek MT7922 WiFi
> (14c3:0616), which is the predecessor device and already uses this quirk.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v3: Resend with MediaTek wireless maintainers CC'd
> v2: https://lore.kernel.org/all/20260508145153.717641-1-jtornosm@redhat.com/
> 
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 000000000000..111111111111 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5607,6 +5607,7 @@
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> + * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> @@ -5617,6 +5618,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
> 
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> --
> 2.53.0
> 

