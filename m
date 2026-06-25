Return-Path: <linux-wireless+bounces-38092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9uGhDmYxPWoQywgAu9opvQ
	(envelope-from <linux-wireless+bounces-38092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 15:47:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 592EC6C63DB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 15:47:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="K/H+kk7M";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38092-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38092-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 624C2300FF83
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA22FFDCC;
	Thu, 25 Jun 2026 13:47:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB22192F9;
	Thu, 25 Jun 2026 13:47:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395233; cv=none; b=SI7In7HyGZCTO8706QCqCX4cA30HSWwkclspGVhzF1lmt70gdvj6pBj3CVEzwjqguvpq5tG0Xn2mdmO415evO6PGgILvW+prrmebAFd0AMxuYO3mT/dIDQedjUeWLzQcSFw+OqpaQ+pAv2HBAg+iJXCK40+EZAR+M/ueqX53Xrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395233; c=relaxed/simple;
	bh=sUrOudAXU9Br8QRIcbTjpO5nSiOe9O7QbWrp03EBHQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2nKhp3NhTN3VTHvGKm4o+IgcyR00G5n4pIfijHm2CDWFk7hIWbFupBa1T9ybmQOB99pjhNPmBtB/d8yRuDQq0mIQXIeWWQ+3zLLKZXqGaQF+LBl9qJeCS4QJA/kiExFE75cBpetdMlDPl66Q02b89vlt5ZYq3pzICdXdLsU4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/H+kk7M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B801F00A3A;
	Thu, 25 Jun 2026 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782395231;
	bh=9NPVPzLEscImUoRdY5p2atD0bm47zYNmsCtx2fosl9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/H+kk7MthuGsNEfqZX+0NpLwSxSB2ve+MSOzeYm1/fz1UksvGAbxJ83Zjz3ns77X
	 6HX/4N7e1UuuitUfBmgSFd8xbuJhqew2TzB3EZfWbR0XlKVal/F69vk17OTflQNavQ
	 RBIz8Q2dlR+5hDkj6Aun86vywlcpbqI4IazraZMHLbrKfhzujWUHBM7V8OGtqF7oHy
	 nT18jckB2HY6skJLxkkl2o4fAYPjo25oQs0xG5lnK2Gdgl1c8+kuaGF5cvGx2+hRbq
	 Cm17eH8lDLCzDpJWHzoVJeNWYqdwRLTFn13c3A+F6lQjZwSlyPp2P/9kqYCgK06FFA
	 1Qjqa+J9IPUXA==
Date: Thu, 25 Jun 2026 15:46:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
Message-ID: <mxarrodtocadpq3yu4nkbs6g7u5tzpk3vg5ot2tmlw442eg2hg@nlcdcinamlah>
References: <20260623183115.1585273-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623183115.1585273-1-jtornosm@redhat.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38092-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nlcdcinamlah:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 592EC6C63DB

On Tue, Jun 23, 2026 at 08:31:15PM +0200, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
>   Normal VM operation works fine, including clean shutdown/reboot.
>   However, when the VM terminates uncleanly (crash, force-off), VFIO
>   attempts to reset the device before it can be assigned to another VM.
>   Without a working reset method, the device remains in an undefined state,
>   preventing reuse.
> 
> - SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
>   on first VM assignment without proper reset capability.
> 
> Add device-specific reset methods using BAR-space hardware reset registers
> that exist in these devices:
> 
> - WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
>   ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
>   ath11k_mhi_set_mhictrl_reset()):
>   - Write/clear reset bit at offset 0x3008
>   - Wait for PCIe link recovery (up to 5 seconds)
>   - Clear MHI controller SYSERR status at offset 0x38
> 
> - SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
>   driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
>   - Write reset request to offset 0xb0
>   - Wait 2 seconds for reset completion
> 
> These are true hardware reset mechanisms (not power management or firmware
> error recovery), providing proper device reset for VFIO scenarios.
> 
> Testing was performed on desktop platforms with M.2 WiFi and modem cards
> using M.2-to-PCIe adapters, including extensive force-reset cycling to
> verify stability.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v10:
>   - Complete redesign based on maintainer feedback (Manivannan Sadhasivam,
>     Alex Williamson): use actual hardware reset registers from
>     device drivers instead of D3hot power cycling
> v9: https://lore.kernel.org/all/20260612142638.1243895-1-jtornosm@redhat.com/
> 
>  drivers/pci/quirks.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 431c021d7414..8ad3f214e520 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4240,6 +4240,121 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
> +#define QUALCOMM_WIFI_MHISTATUS			0x48

This macro is unused.

> +#define QUALCOMM_WIFI_MHICTRL			0x38
> +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
> +
> +/*
> + * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
> + * registers.
> + */
> +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
> +{
> +	bool link_recovered = false;
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u32 val;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	val |= QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	val &= ~QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	timeout = jiffies + msecs_to_jiffies(5000);
> +	while (time_before(jiffies, timeout)) {
> +		val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +		if (val != 0xffffffff) {

s/0xffffffff/PCI_ERROR_RESPONSE

> +			link_recovered = true;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +
> +	if (!link_recovered) {
> +		pci_err(pdev, "PCIe link failed to recover after reset\n");
> +		goto out_restore;
> +	}
> +
> +	/* After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set
> +	 * and thus need to set MHICTRL_RESET to clear SYSERR.
> +	 */
> +	iowrite32(QUALCOMM_WIFI_MHICTRL_RESET_MASK, bar + QUALCOMM_WIFI_MHICTRL);
> +	ioread32(bar + QUALCOMM_WIFI_MHICTRL);
> +
> +	msleep(10);
> +
> +out_restore:
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	return link_recovered ? 0 : -ETIMEDOUT;
> +}
> +
> +#define MHI_SOC_RESET_REQ_OFFSET		0xb0
> +#define MHI_SOC_RESET_REQ			BIT(0)
> +
> +/*
> + * Qualcomm modem device-specific reset using MHI SoC reset via BAR0
> + * register.
> + */
> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
> +
> +	/* Be sure device reset has been executed */
> +	msleep(2000);
> +
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4255,6 +4370,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_qualcomm_wifi },  /* WCN6855 WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_qualcomm_wifi },  /* WCN7850 WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_qualcomm_modem }, /* SDX62/SDX65 modems */

Not an issue and the existing entries are not sorted, but can you atleast keep
these IDs sorted in ascending order?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

