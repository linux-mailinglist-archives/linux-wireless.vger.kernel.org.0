Return-Path: <linux-wireless+bounces-38305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O3mfJv6ZQmrh+QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 18:14:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB176DD345
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 18:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NmwCUn9f;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38305-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38305-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2EC30E048A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74243DA38;
	Mon, 29 Jun 2026 16:01:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356A3E5EF9;
	Mon, 29 Jun 2026 16:01:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748906; cv=none; b=EKunJKIqE1ulq/GZEkQWnAtYrcoCT49HGdB10LdIzvxfYyov6Iy22gTrVzGHpRE8XLVaH1SNXK42F7DJQQZXIp+IcCAZuURID6A4ZgVlIgX63IZ7Z72nIoCikYrwy6uAWS0RK1ikPucuFIp2wxSlB1V6PsBzl5Hslr47z4jdnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748906; c=relaxed/simple;
	bh=gNf3+xtGsHZcEPpHO8DbFh36xC7Xv23kzYATNbWno/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq4+fkx2spsuGoAjXAa53V3NlWxog6NxWyuhiNSxBgnUq616dytqHD/fldOayO9T0ny+pvhz46VvPZqadl8sh3sOcw5TaWtCu8IYmu295xz9KDBorSbtLZB+nIrEfCkyeg+tB+PNFX51pgsFxuAs2X5JiEdvJ3bLGZVC6/XwdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmwCUn9f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780AD1F000E9;
	Mon, 29 Jun 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748905;
	bh=ZMagSuV/KEPQnZY+XS5s3kJW3BcH6iR0+wLbzdgK2X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmwCUn9fNzlLN6RHJFD4f7AaI7M+siGWgaA6KKEP8+YaHgbCT8Eo8ua71Hrl3tsBb
	 EpcinpRLb8K5+ZYGfFCrfm7EX5pUXhwd2BSqPwDcPUh64Nk5R6nFyv7fw9tmx/PWoa
	 s69IS3QurF0gsSQrR2oF5sNahDh46sdOzkV2qJUBVdWI9wGP4VGkAi+UmP5kFjb/Ds
	 meVJPowgZXAb7UJobfEJ81GhUUY0N+OGFRk5wNRqM/PZgIS0yfCIQVKPoMH597Gonz
	 PY9ic9oKw/XQW/PxJLHU+q6JjPJcYIjAlGlPO+EzOkAuHa1iOiwDQAOk+nrX2N1xLA
	 JmMc0obmWEe7w==
Date: Mon, 29 Jun 2026 18:01:37 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <5mrwcurlf6xnqla5x5idpt7ug34nv2eqpijnjmccgdwazrmwyv@64tixxe4aa57>
References: <20260626055023.197470-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626055023.197470-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38305-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECB176DD345

On Fri, Jun 26, 2026 at 07:50:23AM +0200, Jose Ignacio Tornos Martinez wrote:
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

Couple of comments below, including one bug due to my previous suggestion. Once
those are addressed, feel free to add:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
> v11: Address Manivannan Sadhasivam feedback:
>   - Remove unused QUALCOMM_WIFI_MHISTATUS define
>   - Use PCI_ERROR_RESPONSE instead of 0xffffffff
>   - Sort device IDs in ascending order (0x0308, 0x1103, 0x1107)
> v10: https://lore.kernel.org/all/20260623183115.1585273-1-jtornosm@redhat.com/
> 
>  drivers/pci/quirks.c | 117 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 431c021d7414..0de606366200 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4240,6 +4240,120 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
> +#define QUALCOMM_WIFI_MHICTRL			0x38
> +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2

Qcom calls these WiFi devices as WLAN devices. So I'd prefer to use this term
all around even for function names.

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
> +		if (val != PCI_ERROR_RESPONSE) {

As Sashiko also pointed out, this will always evaluate to true due to
PCI_ERROR_RESPONSE being ~0ULL. Please use:

	if (!PCI_POSSIBLE_ERROR(val))

Sorry for the wrong suggestion earlier.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

