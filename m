Return-Path: <linux-wireless+bounces-38860-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ld8gCKBVUWqRCgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38860-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 22:27:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 241CA73E410
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 22:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Sd7sj++5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38860-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38860-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59DE63017CB6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500239F174;
	Fri, 10 Jul 2026 20:25:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B039EF32;
	Fri, 10 Jul 2026 20:25:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715149; cv=none; b=cj+78/VAwO1AHiSBKMB6hUQwNGtM7Vya7YwaZDax1l6LrB/z2LGgGvg5lPCIf6/wlLQVHMHGfc2ADwZCRXe8Yc1gD0rSdhu+Y0n8IL4mXjeMhMtAVUWU4xV/P8+FpSgxLlnWT5dleILt71BPuX8O0EnLp4mMW9WAXhy8784fYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715149; c=relaxed/simple;
	bh=MYkhLJjFzu/0shKCRegPVVOR3/cURK0eqPqvT6VmZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tp3AXTv5EcrAUDrG2wZWQG246NyalAQfupWunhCBojb4K3xbQEISrZKnRqkWnRKOPyyzkmuzlzdZWcHI9LYgo+5Ks6/giImNBiIS4E6tgU2iMkYA+vEE7e5tYPwhg2nIfL5Gdj6vL0LGEyzWRxrUjxHdRmD4OpOpSuVes3Cw3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd7sj++5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0831F00A3A;
	Fri, 10 Jul 2026 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783715147;
	bh=xkkm/ay4UwW+LKTRMQXsXHe7l4TsIKcsEKX51F7sGr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Sd7sj++52Pz2Pz2wGW3mFCJs7y5zatPJ6wjFHodxWDPYb9ZC+NX15p0Uny3xfhysj
	 wElnyMhbIk3ZUUOA5+t10GaPqjbbPsyfgHALPKW6KnJtDLUAyYaKU1fwOkEBJmolO7
	 0ePWxShhOkhgF2fBtCCjMwYKKC/CunYss+mySjVw3PW+rxJBWmsEXZyIZ3w2KvOSp6
	 a+wBIBpHFugDxxDB71+jUyYifB+wywDqnLXJE3CGR+A/MkdE1aESXoj8Lz8C+GBLyj
	 naz9D8aUs4b4ooSPfrhUV/DJVq9hOpsig9yUtQzeTvdZ6tfLFPgzxALqrTBDe3In7h
	 qzCiOIDuy6RgQ==
Date: Fri, 10 Jul 2026 15:25:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v3 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
Message-ID: <20260710202546.GA989860@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-pci-aspm-fix-v3-6-6bd72451746e@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:bhelgaas@google.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:nirmal.patel@linux.intel.com,m:jonathan.derrick@linux.dev,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:krishna.chundru@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:ilpo.jarvinen@linux.intel.com,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38860-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 241CA73E410

On Wed, Jul 08, 2026 at 04:30:20PM +0200, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> It is not recommended to enable/disable the ASPM states on the back of the
> PCI core directly using the LNKCTL register. It will break the PCI core's
> knowledge about the device ASPM states. So use the APIs exposed by the PCI
> core to enable/disable ASPM states.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/pci.c   | 19 +++----------------
>  drivers/net/wireless/ath/ath12k/pci.h   |  4 +++-
>  3 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 4a2b240f967a..7852ede3eaea 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>  config ATH12K
>  	tristate "Qualcomm Wi-Fi 7 support (ath12k)"
> -	depends on MAC80211 && HAS_DMA && PCI
> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM

As Sashiko pointed out [1], I think adding the PCIEASPM dependency is
an issue.  The PCI core should provide stubs or whatever is necessary
to make ath12k work even if PCIEASPM isn't selected.

I'm guessing this hardware depends on the ability to disable ASPM even
without PCIEASPM so we probably would need more than just empty stubs.
We do build aspm.c unconditionally now and we provide LTR and L1SS
save/restore regardless of PCIEASPM.  Maybe we need something similar
here.

[1] https://lore.kernel.org/all/20260708144904.0CC4F1F000E9@smtp.kernel.org

>  	select QCOM_QMI_HELPERS
>  	select MHI_BUS
>  	select QRTR
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index d9a22d6afbb0..6d48fb25690d 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -884,19 +884,9 @@ static void ath12k_pci_free_region(struct ath12k_pci *ab_pci)
>  
>  static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>  {
> -	struct ath12k_base *ab = ab_pci->ab;
> -
> -	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				  &ab_pci->link_ctl);
> -
> -	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
> -		   ab_pci->link_ctl,
> -		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
> -		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> +	ab_pci->aspm_states = pcie_aspm_enabled(ab_pci->pdev);
>  
> -	/* disable L0s and L1 */
> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ASPM_ALL);
>  
>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>  }
> @@ -925,10 +915,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>  {
>  	if (ab_pci->ab->hw_params->supports_aspm &&
>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPMC,
> -						   ab_pci->link_ctl &
> -						   PCI_EXP_LNKCTL_ASPMC);
> +		pci_force_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);
>  }
>  
>  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
> index 0e0e2020c6ae..409ef063cd69 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.h
> +++ b/drivers/net/wireless/ath/ath12k/pci.h
> @@ -128,7 +128,9 @@ struct ath12k_pci {
>  
>  	/* enum ath12k_pci_flags */
>  	unsigned long flags;
> -	u16 link_ctl;
> +
> +	/* Cached PCIe ASPM states */
> +	u32 aspm_states;
>  	unsigned long irq_flags;
>  	const struct ath12k_pci_ops *pci_ops;
>  	u32 qmi_instance;
> 
> -- 
> 2.43.0
> 
> 

