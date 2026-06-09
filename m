Return-Path: <linux-wireless+bounces-37602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eOSvHe1VKGqCCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 20:05:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7C6632A0
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 20:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=XvipgDIu;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="E XmrpHy";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37602-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37602-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906D730432C1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700E331EB0;
	Tue,  9 Jun 2026 17:53:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86673EB0E1;
	Tue,  9 Jun 2026 17:53:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027639; cv=none; b=XHHW5UhDWmYJZ5hxndNQHoXeIUFbd4ZINgiPC2mMjrbpUB1XtYwG3Zp168f5EaSG58n0wjFeFEEGd1s0oar4AuBy0+Wuct9kw+cFhiiEUOov1MHClE74DvnsOPNPdhHGGs/iF8GG65WI1I/zlFF0YC5t+7zim52OudpPNUIYis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027639; c=relaxed/simple;
	bh=G3dDSYxZITI4JoM1P6ag+zLEWWXbjY1AHlcB74bNZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6ntwIHIKz8z7pnEgcNcoOUQRnKRd+QyOal3/BfNHSFBTX0leV4KVhutNlpbAl+TOLo9Zl0aivQbILkhPPDgBofViXgPtHJq+s6SeTzU3CrBESkytqJu5D1FR6ZLoVsJgiDX1acWe7gO7fYj2+9L+4V+T8Fv+tJxCahzUbKxa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=XvipgDIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXmrpHyP; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BA30140016C;
	Tue,  9 Jun 2026 13:53:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781027635;
	 x=1781114035; bh=a7CVtmzOovR3wl8r9g3dFUCizxylV+cMA1xI3GoLUqo=; b=
	XvipgDIuwM1znBDepE6HRKdzLIxZJ0zJ/bfnn/Wv+VMRHTp3ETT9qSQOri23PifY
	6rUTJRutHeQSjmFr3RuKh8OMNAi0YtLxqBRDnC5Ti+/KJuxPoCdnYvVXDvQot4ts
	7yOVgwH56chjAPAo04dFS45diFORy6zvGXExgHx2+qba9QlNpD0zH243FvnYGCs0
	AIE+NeUopYCqA6uSWhyaat65xGZOT9eJhpgpV8Op9Jz1rvlKwLdfpoY4pQXxIDjH
	csndRfRXVhrhgRgvnd8tzRm9HEQJv1658AQBfzc25ZDBxLktubup180VzxKLO5nm
	p+56NCVMyp9YKQmgycuL7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781027635; x=
	1781114035; bh=a7CVtmzOovR3wl8r9g3dFUCizxylV+cMA1xI3GoLUqo=; b=E
	XmrpHyPPpv1jn9UwJI2c19C/FFhNsdwd8+gqIcqZft7n5LaEKyXE2/hDKB3rBp0r
	W0TvuPESkaA+AmAITl36DbHXpk20YyzBTeZker7hvkKkbe8ma/tarH46cJzWPo2e
	cZ442aOBHfUMPRo5xIp1l/HniiHK5o1hQ8LlNEdDD0dPHyFNqJbC76wN4vHA3Nl1
	X3zt5JzuhALoA5DdL2zTAZKq7fhtslc1EaqCcuqSEuDrcVb0iWF3c/Lrz8entMBY
	PBp8V4sabfTFxryjNWay+8RAG3bTprizHpryOjrCrYC8N3FAFtj+1FFoFDJjxD9A
	E1YjVIL+n8NzZK4UUMu1w==
X-ME-Sender: <xms:MlMoalUGd6o3p476meUrAdF--kAe2V3_SvCox1-W8Q-1cNXP5_olGA>
    <xme:MlMoatvhuDvGZP4Ce7lq9mRc5BbrOuJoly2KD4rpe9EQ-IEF2dxc6yPpLBzwK8oj-
    nNwpufop2y95xM6gmEgvaoGZNsqwpwL_6yhPRTibFjmwfBzWa0V5Q>
X-ME-Received: <xmr:MlMoag76H3JSuZ0cyE5-5Qlo9JA_SnWJ_uq_h3mxK2moL2U-jzLjDQi2IQ4>
X-ME-Proxy-Cause: dmFkZTE1if/jpE/lTR6fAEmuWN1lAZ4H/eJ2GCBC95FwGXdoQnSuqhxsu9rTyd4IuvRvq1
    h+9MlrfADCxGehVryUb0S3FUd+LOp7PSSdA81J97Qmq0R52mtdiqACZJKNlUB61wTLjSft
    MQ7HYNGaavv+kTNwH65iFJ08RGkQkma0iHltFQVIFMiTHpSYLibEnmPdsH3EINMc5oOwcT
    B8gLqhx3gkSaRMjaBCC+tBSu/Wagoidj2BbOPHxB3vBQvxz9GFun2Wu67vZry7++Gg8i9v
    VnzqApG2p8Fv0Ezkf2ftLgAjqai175lues2XJWoyl4Ovw4SMDANoC/N4g+S1+eR6sjQmQS
    V7kcbY/6+T7Bni9TcCszuG7OuzPjTIEd/9Q7bkk36JYcuiPLut69GwtC0KD/rKossoQhst
    EgeVxJZT77At7qcEc5PGyCH1qOM4VsrBSw+rN9fb7ShRlQlGO+lsJvZfC8Ca8jRX6L37zi
    33SUOVubNnYfqtiv0Kq5E8yFCYR+5chLBvpftihecsHy3td42ysQwAm7ZMV3cdnyI+n9Dr
    j4yQPfUkVXtH7GaSRTk0zSjbvA7pAHDH2ZnUa4qQiFHZNrgUDECSw95pnzFvyvMQXmifod
    OUV1uOSyk8aHvz8gbt06jglSGG+eMI3tYDqJUk9WsOtadbJpNtWnB1NuPZ6w
X-ME-Proxy: <xmx:MlMoaoSKmE3FZMXcIca2shHXVwmnsshYN7LySb157tS3QzJnaQxvRA>
    <xmx:MlMoaruzBb0D1lye9NGSFGrFWk1Ze_b39KoYSf8bHUULrphh_xZWvA>
    <xmx:MlMoai8oudoO-PuPjUck68Vo0MW6izxGOUi1kcVKw_FoR5-BryZD4Q>
    <xmx:MlMoasxgLuEzSU7M6mW2WLaF99SJz0kPsbn9z_ah15LEVdVLxDhVDQ>
    <xmx:M1MoavAiZQk3APqYazZle3AHyxOsJ06XmoW3HjZVDH1I_K-AKsgSayH1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 13:53:53 -0400 (EDT)
Date: Tue, 9 Jun 2026 11:53:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, jjohnson@kernel.org, mani@kernel.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 mhi@lists.linux.dev, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm
 devices
Message-ID: <20260609115352.32acb6fe@shazbot.org>
In-Reply-To: <20260609163649.319755-3-jtornosm@redhat.com>
References: <20260609163649.319755-1-jtornosm@redhat.com>
	<20260609163649.319755-3-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37602-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C7C6632A0

On Tue,  9 Jun 2026 18:36:48 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.
> 
> - WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.
> 
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
> 
> Add device-specific reset entries for these Qualcomm devices using D3cold
> power cycling with automatic D3hot fallback. The implementation uses
> pci_set_power_state(D3cold) which automatically falls back to D3hot on
> platforms without ACPI _PR3 power resources. While not a complete reset
> (BARs preserved), testing shows D3hot transition provides sufficient reset
> for VFIO reuse.
> 
> Extract a shared pci_dev_d3cold_d0_cycle() helper function to avoid code
> duplication between pci_d3cold_reset() (strict _PR3 requirement) and the
> new reset_d3cold_d3hot() device-specific reset (automatic fallback).
> The helper performs only the power cycle; IOMMU handling is done by the
> caller (pci_d3cold_reset() for general method, __pci_dev_specific_reset()
> wrapper for device-specific methods).
> 
> Device-specific reset is position #1 in the reset hierarchy, so these
> Qualcomm devices will use power cycling as their primary reset method,
> with the general d3cold method (position #8) available as a fallback on
> _PR3-capable platforms if users override via sysfs.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v8: Fix commit message: correct IOMMU handling description. The helper
>     performs only the power cycle; IOMMU is handled by callers (this was
>     v6 fix)
> v7: https://lore.kernel.org/all/20260603105853.326290-3-jtornosm@redhat.com/
> 
>  drivers/pci/pci.c    | 37 +++++++++++++++++++++++++++----------
>  drivers/pci/pci.h    |  1 +
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  3 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 096868f80cd4..f7a7443287fd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4491,6 +4491,32 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	return ret;
>  }
>  
> +/**
> + * pci_dev_d3cold_d0_cycle - Perform D3cold->D0 power cycle
> + * @dev: Device to power cycle
> + *
> + * Common helper to perform D3cold->D0 power cycle for reset methods.
> + * Attempts D3cold transition with automatic fallback to D3hot on platforms
> + * without ACPI _PR3 power resources.
> + *
> + * Caller must handle IOMMU preparation/cleanup if needed.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int pci_dev_d3cold_d0_cycle(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	ret = pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		return ret;
> +
> +	return pci_set_power_state(dev, PCI_D0);
> +}
> +
>  /**
>   * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
>   * @dev: PCI device to reset
> @@ -4520,22 +4546,13 @@ static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	if (dev->current_state != PCI_D0)
> -		return -EINVAL;
> -
>  	ret = pci_dev_reset_iommu_prepare(dev);
>  	if (ret) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = pci_set_power_state(dev, PCI_D3cold);
> -	if (ret)
> -		goto done;
> -
> -	ret = pci_set_power_state(dev, PCI_D0);
> -
> -done:
> +	ret = pci_dev_d3cold_d0_cycle(dev);
>  	pci_dev_reset_iommu_done(dev);
>  	return ret;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a..a9942787de9e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -234,6 +234,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  int pci_try_reset_bridge(struct pci_dev *bridge);
> +int pci_dev_d3cold_d0_cycle(struct pci_dev *dev);
>  
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e49136ac5dbf..70f3b0f26799 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4237,6 +4237,22 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +/*
> + * Device-specific reset method via D3cold/D3hot power cycle.
> + *
> + * Some devices lack working FLR, advertise NoSoftRst+ (blocking PM reset),
> + * and have broken bus reset. This function provides device-specific reset via
> + * power cycling, attempting D3cold with automatic fallback to D3hot on platforms
> + * without ACPI _PR3 power resources.
> + */

My only complaint is that this is positioned a bit generically.  If the
reset only achieves D3hot on a device that reports NoSoftRst+, then
this appears as a no-op reset method.  The claim here is instead that
despite reporting NoSoftRst+, the devices using this reset have notably
improved behavior, especially across unexpected resets in device
assignment scenarios.  This leads us to believe that some degree of
reset is achieved, for devices that otherwise have no viable
alternative reset method.

Also, I know from previous discussions that much of the testing was
done with M.2 adapters in slots without _PR3 support, which exercises
the D3hot fallback rather than an actual D3cold power cycle.  Has each
of these devices been tested on a platform where D3cold is actually
achieved through this method?  Thanks,

Alex

> +static int reset_d3cold_d3hot(struct pci_dev *dev, bool probe)
> +{
> +	if (probe)
> +		return 0;
> +
> +	return pci_dev_d3cold_d0_cycle(dev);
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4252,6 +4268,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_d3cold_d3hot },  /* WCN6855 */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_d3cold_d3hot },  /* WCN7850 */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_d3cold_d3hot },  /* SDX62/SDX65 */
>  	{ 0 }
>  };
>  


