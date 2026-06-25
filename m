Return-Path: <linux-wireless+bounces-38091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z2XzH9cnPWpAyAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 15:06:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990DD6C5E56
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 15:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gqj3yzK4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38091-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38091-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 525EF300B9FB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0332857EE;
	Thu, 25 Jun 2026 13:03:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF5283FFB;
	Thu, 25 Jun 2026 13:03:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392608; cv=none; b=Bba9GxEiJK1pkiZMZu63JGCPGenjl29uv3c072Z0ZaEdPQGiS6R3GDho4YVItzj9kNv8a1OK7QQvdEyxhptHXYFxlxZuyeeRtw0TwuCI4s1NhOSU35vHzV6k5/lreaqwE1TbJdhTlLLD0e0BARgIIfU026VzOvT24oHVVv6WyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392608; c=relaxed/simple;
	bh=Hetg/C11SaAz5YiY4sxHM3Mfj0r2rKP8fYNOe5jaR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3NI9kMbC4SRjBNnNsKgvdVYWtwG5KsK5h78dV1B5dxg8bZW8xvKTfryigzWRiMOo/wSroV4BgkHEJNG1XyVGyHUg7ign1pE1BBomiw5jxM2DSYd/IW2qdUpeUp1c8eKpve5KtfdYCcPmdnukYSKyFIVZFELpULbeUZsZBZtnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqj3yzK4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2484C1F00A3A;
	Thu, 25 Jun 2026 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782392607;
	bh=SybMIkwobe3FEtfhKnM3aPAHyhkZL+tIP9Fxj1kdDsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gqj3yzK4p4I20bQEslq4B9XPtyWmj/LBb8p9OCRJqluJlsVlvwV+GSFoRutXaT0tn
	 v0gI4mb/+S/oFwnRNP9rWqAxJgxz3HPYKsl5oH1aXWYme74K8vFyeVKUja/46Su8nf
	 LzYEGoAhrfntFe7RUvUlu5EQoCB968Mn6iJsP/5w/0cvsDruqSNjvSO1sexEqpK2AP
	 LqIYyvbxMQqG/6671hgFh2kYb1Z6Wh7h9hKcf0A5vexTvXYJ3sp/+vRNBQWV39VBx/
	 uV6HbPahnHGAVgqjgR9ovlbTpC4Sw4F/yVyQyZembfV3XbvAkbIFvx92XyjRVJ8oDO
	 vvPYYPqlyx4aw==
Date: Thu, 25 Jun 2026 15:03:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, 
	bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org, linux-pci@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
Message-ID: <l3pcelhxn46p4smkkg5yob5enf4d4garp2p6macopnq5h2gwyf@zbbn65k4tz2q>
References: <20260623183115.1585273-1-jtornosm@redhat.com>
 <4cdfb71b-2ef8-4985-8294-c4a29e37faa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cdfb71b-2ef8-4985-8294-c4a29e37faa3@oss.qualcomm.com>
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
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38091-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 990DD6C5E56

On Wed, Jun 24, 2026 at 03:47:12PM +0800, Baochen Qiang wrote:
> 
> 
> On 6/24/2026 2:31 AM, Jose Ignacio Tornos Martinez wrote:
> > Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> > lack working reset methods for VFIO passthrough scenarios. These devices
> > have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> > broken bus reset.
> > 
> > The problem manifests in VFIO passthrough scenarios:
> > 
> > - WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
> >   Normal VM operation works fine, including clean shutdown/reboot.
> >   However, when the VM terminates uncleanly (crash, force-off), VFIO
> >   attempts to reset the device before it can be assigned to another VM.
> >   Without a working reset method, the device remains in an undefined state,
> >   preventing reuse.
> > 
> > - SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
> >   on first VM assignment without proper reset capability.
> > 
> > Add device-specific reset methods using BAR-space hardware reset registers
> > that exist in these devices:
> > 
> > - WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
> >   ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
> >   ath11k_mhi_set_mhictrl_reset()):
> >   - Write/clear reset bit at offset 0x3008
> >   - Wait for PCIe link recovery (up to 5 seconds)
> >   - Clear MHI controller SYSERR status at offset 0x38
> > 
> > - SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
> >   driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
> >   - Write reset request to offset 0xb0
> >   - Wait 2 seconds for reset completion
> > 
> > These are true hardware reset mechanisms (not power management or firmware
> > error recovery), providing proper device reset for VFIO scenarios.
> > 
> > Testing was performed on desktop platforms with M.2 WiFi and modem cards
> > using M.2-to-PCIe adapters, including extensive force-reset cycling to
> > verify stability.
> > 
> > Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> > ---
> > v10:
> >   - Complete redesign based on maintainer feedback (Manivannan Sadhasivam,
> >     Alex Williamson): use actual hardware reset registers from
> >     device drivers instead of D3hot power cycling
> > v9: https://lore.kernel.org/all/20260612142638.1243895-1-jtornosm@redhat.com/
> > 
> >  drivers/pci/quirks.c | 118 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 431c021d7414..8ad3f214e520 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4240,6 +4240,121 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
> >  	return 0;
> >  }
> >  
> > +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
> > +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
> > +#define QUALCOMM_WIFI_MHISTATUS			0x48
> > +#define QUALCOMM_WIFI_MHICTRL			0x38
> > +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
> > +
> > +/*
> > + * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
> > + * registers.
> > + */
> > +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
> > +{
> > +	bool link_recovered = false;
> > +	unsigned long timeout;
> > +	void __iomem *bar;
> > +	u32 val;
> > +	u16 cmd;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	if (pdev->current_state != PCI_D0)
> > +		return -EINVAL;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> > +
> > +	bar = pci_iomap(pdev, 0, 0);
> > +	if (!bar) {
> > +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +		return -ENODEV;
> > +	}
> > +
> > +	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> 
> QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET is beyond the first 4K bar area hence requires MHI
> wakeup before accessing, see [1]. the wakeup callback for WCN6855 is
> ath11k_pci_bus_wake_up() which calls mhi_device_get_sync(). Not sure how this can be done
> here. Maybe Mani can provide some hints?
> 

I don't think the device needs to be waken up before
QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET. ath11k driver wakes up the device for
accessing the MHI interface I believe. Since this callback is not touching MHI,
there is no need to wakeup the device, AFAIK.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

