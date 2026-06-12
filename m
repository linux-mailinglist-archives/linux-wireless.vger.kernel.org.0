Return-Path: <linux-wireless+bounces-37749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UjKXCGQjLGpdMAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:19:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0567A7B0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:18:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fRS8UoxT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37749-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37749-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE70031DD182
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617B2DEA61;
	Fri, 12 Jun 2026 15:17:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DF2D238A;
	Fri, 12 Jun 2026 15:17:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277472; cv=none; b=WCpWW/RBUCUgsav267q73Naub0Ly48YhF5TEZlNv0Cf/34yY8RGmd77+cX6vooVXPy6BiPu+Ml7dBsBq/JSaawW0TLrDRETmgVqsFOtegmFcko3WSVKu/hSFdy1VpRLAAWkxo4EFzynwi0glKaNYo50g/v5HDmizygIHz5trs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277472; c=relaxed/simple;
	bh=U4O+P7MXQot0uopxFWZ0QHzHbnym462DP/joRZT0bv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kGr0MqoB4PtwVczDeMYH3g/feZNJbCP/JLERq9kkGQR7CqPxeImbwVXqvXtvKwP4FBBrE4pj22yCPqcPo0NWH5AM8kOfzmG69pw0vrPjZ/MDC6UdSHkQj59c3gAb0v03TcZel4wqTV8IZlJI5jDyXmN3bZgJXXNjFYXLY7QL448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRS8UoxT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F791F000E9;
	Fri, 12 Jun 2026 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277471;
	bh=6XpxeIXcm0bcntaNBOITL3pX8sOGQ/dSwg/AQ/P7ms4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fRS8UoxTBVb4rjGnYIwpI1u8mm+LKqLs/UKIe2+xv44fYHk8PoTevfj9MV/O1HD+H
	 OLVwNhdiVr/PDit8ZkqapCQ4Kd3HwfDtPOq7ldw4enMG9cH25buCz/2Fff5FHTdQQw
	 MeJRzZv4oKxo6RKAyS7nMh1vxIBPA8Ucxwv+Flv3qYlOYDd+Q1/fGxcovQKFqArt2T
	 WeuEJUALKmD7dJzVnz5ifVEnIIfmbTwxiCZyPwlt8v1CVvGgVy4tZL4k/7bd3sKNWD
	 tmwDmp62wqcZ6VKiLv4HGRhnGesNFX5jt5lm6HYOs60imYuOy3mRBvAKjmsuWzN+xU
	 tOR09zOWG5emw==
Date: Fri, 12 Jun 2026 10:17:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Alex Williamson <alex@shazbot.org>
Cc: bhelgaas@google.com, jjohnson@kernel.org, mani@kernel.org,
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <20260612151749.GA603817@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612142638.1243895-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37749-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bhelgaas:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4D0567A7B0

[+to: Alex, VFIO resets]

On Fri, Jun 12, 2026 at 04:26:38PM +0200, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.

I guess "bus reset" here refers to Secondary Bus Reset being asserted
by the bridge upstream from these devices?  Seems a bit surprising if
that doesn't work.  Or is it just that we can't use SBR because there
are multiple devices below that bridge?

> The problem manifests in VFIO passthrough scenarios:
> 
> - WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.

I don't know enough about VFIO, but I sort of expected that VFIO would
reset devices between reassignment regardless of how a VM terminates.
I guess that's not true?

> - WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.
> 
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
> 
> Add device-specific reset entries for these Qualcomm devices using D3hot
> power cycling. Testing shows that despite advertising NoSoftRst+, D3hot
> transition provides sufficient reset for VFIO reuse, particularly after
> unexpected VM termination. While not a complete reset (BARs preserved),
> it provides the only viable reset mechanism for these devices.

Since the device claims to preserve internal state across D3hot->D0
(and it sounds like at least BARs *are* preserved), is this a
potential leak of state between VMs?  To play devil's advocate, how do
we convince a customer that none of their data is ever leaked to a
subsequent tenant using this device?

> Testing was performed on desktop platforms with M.2 WiFi and modem cards
> using M.2-to-PCIe adapters, including extensive force-reset cycling to
> verify stability.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v9:
>   - Complete redesign based on maintainer feedback (Alex Williamson, Bjorn
>     Helgaas, Rafael Wysocki): dropped general d3cold infrastructure entirely
>     and now just a single patch: the proven D3hot reset for specific
>     Qualcomm devices (device-specific reset)
>   - Previous v8 patch 1/3 (general d3cold) dropped: concerns about ACPI
>     portability, bridge issues, runtime PM, and lack of _PR3 hardware for
>     testing.
>   - Previous v8 patch 3/3 (quirk_no_bus_reset) already merged for v7.2
> v8: https://lore.kernel.org/all/20260609163649.319755-1-jtornosm@redhat.com/
> 
>  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 431c021d7414..bac1edb6c2dc 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4240,6 +4240,41 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +/*
> + * Device-specific reset method for certain Qualcomm devices via D3hot power
> + * cycle.
> + *
> + * These specific Qualcomm devices lack FLR capability, advertise NoSoftRst+
> + * (blocking PM reset), and have broken bus reset. Despite advertising
> + * NoSoftRst+, testing shows that D3hot transition provides sufficient reset
> + * for VFIO reuse, particularly after unexpected VM termination where the
> + * device would otherwise remain in an undefined state. While not a complete
> + * reset (BARs are preserved), it provides the only viable reset mechanism for
> + * these devices in the commented situations.
> + */
> +static int reset_qualcomm_d3hot(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	ret = pci_set_power_state(dev, PCI_D3hot);
> +	if (ret)
> +		return ret;
> +	msleep(200);
> +
> +	ret = pci_set_power_state(dev, PCI_D0);
> +	if (ret)
> +		return ret;
> +	msleep(200);
> +
> +	return 0;

If we think this is a viable method, it seems like we should use
pci_pm_reset(), which takes care of IOMMU and device readiness issues.

We would have to change pci_pm_reset() to deal with the fact that
PCI_PM_CTRL_NO_SOFT_RESET seems wrong on these devices.  Maybe we
could cache PCI_PM_CTRL_NO_SOFT_RESET in pci_pm_init(), then override
it with quirks for these devices?

> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4255,6 +4290,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_qualcomm_d3hot },  /* WCN6855 */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_qualcomm_d3hot },  /* WCN7850 */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_qualcomm_d3hot },  /* SDX62/SDX65 */
>  	{ 0 }
>  };
>  
> -- 
> 2.54.0
> 

