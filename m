Return-Path: <linux-wireless+bounces-37638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L3LHLSOwKWoOcAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 20:42:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A3866C57E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 20:42:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gpyZegFr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37638-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37638-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78ACB30BFDB8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5394356766;
	Wed, 10 Jun 2026 18:42:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0799349CCD;
	Wed, 10 Jun 2026 18:42:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116959; cv=none; b=NhLTnDyiK5A5jI1rJ4NkWALlpKpf4ZQ0hro1GvCXFdco8/u/OZ+DnUwIL75ncdOkp35JD8B8UgDXPvem9T0gjk4pDrexEBuiz1c77yAoX5Y+1gqJOFhD96bNlgn0J6JyekZ5Sqb3ewbhikKX/Mq3O1EmknObZN8hXYodTwEj7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116959; c=relaxed/simple;
	bh=bncw1kp2XmKdNd9PZSqbZND3nV3QuAke+Or/JDyh2x8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X4rF3xbIfLD+ScSOzpfX2PaE8Qlcdwp2MeqQd4amiHGbOTTm3Ln4aisLPUkkd6LV/H4VWkOo46Aekdogk8FmaGjEC7+awHQEn7u1Q5pejtBzQIdvsz7p0nnfj25nNiD3fH75iWR+AZFjdI3Nj94cqF0DdatG6TIvr/B+2DeIWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpyZegFr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2812E1F00893;
	Wed, 10 Jun 2026 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116958;
	bh=xnrO31LLlSXPRgDvDd03PEdMDaXIr+aCbScw5GFqWuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gpyZegFrsmlQCERexafvFL8huHGeATz3YXutJXCy3MFp08VXEsP/Tx8O3Hp3qUhlp
	 HNY4ULM+9Sx/MlKcfrKbjfVKXQNpZs5FX5JNUbwrvgyPjDRXjHryZKNDe76hI0JVIE
	 jUYTffFgdsfo8plKCaZPsVlldj2JtoqJHMO5ecLfUs5gZvlZ0U/GMBLuv/MUY1F4X4
	 xFkQbfBYV1bDTRz54GDZxSuOFTlGMPIGRmHEaBUVUHB9/U8hg6djZB95N7AKe0FvqM
	 0DB/0stigbLyXUHWSulkgaf03pnMZjUnOpieehIb6JBD3KpCyHqF6DPyjw5msHmrIq
	 YgDuFmUZxz2SA==
Date: Wed, 10 Jun 2026 13:42:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org,
	mani@kernel.org, linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: Add d3cold as general reset method
Message-ID: <20260610184236.GA236984@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603105853.326290-2-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37638-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bhelgaas:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A3866C57E

[+cc linux-pm]

On Wed, Jun 03, 2026 at 12:58:51PM +0200, Jose Ignacio Tornos Martinez wrote:
> Add D3cold power cycle as a general PCI reset method for single-function
> devices on platforms with ACPI _PR3 power resources. This provides true
> power cycle reset capability when the platform can physically cut power
> to the device.
> 
> The implementation strictly requires _PR3 to be present - the platform
> must be able to control device power. This ensures d3cold only attempts
> true power cycling, not falling back to D3hot transitions.
> 
> D3cold reset is placed at the end of the reset hierarchy since it requires
> specific platform support and should be tried after standard methods.
> 
> Reset hierarchy with this change:
> 1. device_specific
> 2. acpi
> 3. flr
> 4. af_flr
> 5. pm (D3hot via config space, checks NoSoftRst)
> 6. bus (SBR)
> 7. cxl_bus
> 8. d3cold (NEW - true power cycle, requires _PR3)
> 
> This benefits:
> - Platforms with _PR3 support
> - Single-function devices needing true power cycle
> - VFIO passthrough scenarios where FLR/PM unavailable

I assume you have some specific device(s) in mind here; can we mention
any examples so this is more than just theoretically useful?

> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v7: code unchanged from v6
> v6: https://lore.kernel.org/all/20260602160024.1171949-2-jtornosm@redhat.com/
> 
>  drivers/pci/pci.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  2 +-
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..096868f80cd4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4491,6 +4491,55 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	return ret;
>  }
>  
> +/**
> + * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
> + * @dev: PCI device to reset
> + * @probe: if true, check if D3cold reset is supported; if false, perform reset
> + *
> + * Reset the device by transitioning through D3cold (actual power removal via
> + * platform power control) and back to D0. This requires ACPI _PR3 power
> + * resources to be present - the platform must be able to physically cut power
> + * to the device.
> + *
> + * Only available for single-function devices to avoid affecting other
> + * functions in multi-function devices.
> + *
> + * Returns 0 if device can be/was reset this way, -ENOTTY if not supported,
> + * or other negative error code on failure.
> + */
> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +
> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;

platform_pci_set_power_state() is currently only implemented for MID
and ACPI, but we're starting to see DT systems with power control for
devices, so I assume it may someday be extended to support them.

Checking pci_pr3_present() seems wrong to me because it assumes ACPI.  

On ACPI systems, it seems like pci_set_power_state(PCI_D3cold) should
return an error if the necessary ACPI methods are not present, and we
wouldn't need this check.  Is that not the case?

Or is this _PR3 check here just to support the "probe"?  I don't know
if there's a generic interface to tell us whether we can control the
power to a device.

> +	if (probe)
> +		return 0;
> +
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	ret = pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		goto done;
> +
> +	ret = pci_set_power_state(dev, PCI_D0);
> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}
> +
>  /**
>   * pcie_wait_for_link_status - Wait for link status change
>   * @pdev: Device whose link to wait for.
> @@ -5065,6 +5114,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> +	{ pci_d3cold_reset, .name = "d3cold" },
>  };
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..1ca7b880ead7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> -- 
> 2.54.0
> 

