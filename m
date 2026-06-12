Return-Path: <linux-wireless+bounces-37748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n0/iEeshLGrkLwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:12:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF267A6EA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 17:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=IfyvRcoU;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Q +QS1wj";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37748-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37748-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F1430E93D4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F3385D86;
	Fri, 12 Jun 2026 15:12:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550D36EA82;
	Fri, 12 Jun 2026 15:12:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277139; cv=none; b=Qx0+xRp+EccslXxViLorQxwVtCcr1I6ODCx4/FVeSyv5tL3Wmg5lKeCjZcXgOIL9OsxDPVVtKfyUsbAB1QKDJZCsxmgN4OoMqNN0UTLpiwzwaBZpzj28KYG0XWDLJhjGGRdxwjZ2dTcSTWaR2p6Pz6/iZxuCbkSsOKX2QNW0Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277139; c=relaxed/simple;
	bh=txyrxT8yboQMDQ5xaGacmeJbEnSicxk+P9F60nr2898=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt2HyBzJmF3dR5U7oZB9edBefuLwlizJOSBQoD5i3URiS01Q3/6yT0aE3i5PxzTahmKp2FxjiclVyKPyRvnY4skU+oe8RgskEUmMew/uXhogLIMXZWg0aHBNYpP2IUO9kbdaQquvf+jsSIEkrGIVXC4MExqWYMZLdrEwkiME1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=IfyvRcoU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+QS1wjE; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B470EC01FA;
	Fri, 12 Jun 2026 11:12:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 11:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781277136;
	 x=1781363536; bh=kCZGhFktK5I+Rd85vY1rnYGowRfHuOl4vJ+wXdl1bFk=; b=
	IfyvRcoUnzGp1tOUTqkNLcO3Wcc8D8dm0UNFS2E2nVyl/GDtW9v3gdpGNjRfIfF0
	ulWQFmmIia0uVlKpdpN86jxiYBjyfckuiBtOn0HQPmswkm2HhtlRQwX/dJ57yWMD
	m3JGaBnEGUB4Bq8l+e2zik/3mSG4uofkGz2p0S65zJZlx2auFw8xC+l/wmmejtak
	fL00hnW4hKoTCv7HP7zIwzE9j1YvrduNVmebOyG/r7UqwWXXysf2PuSem3OvMWME
	v23M78lEEuesHz1gvyDTVetZQPimp0IDerAuLPNffsUu0WMvOp/A921TJe/lsrqA
	Iyo7cQtGdG/FcXEVJx2WAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781277136; x=
	1781363536; bh=kCZGhFktK5I+Rd85vY1rnYGowRfHuOl4vJ+wXdl1bFk=; b=Q
	+QS1wjEEttGbj4DTZNzem3+nTtifIQQqK9DFTHSWSKp4iccaKs9OfXQr0wETFin0
	9Uit7BUNDbtqG+qrblUSYAQFTNKdW+zhCSpOSxGIj/0D+EgAhUEMhb/uMFa0F0Dx
	jGEQAXvwd5Wof7eAaygP3AfY1ueF52Ae7sVwSAKroQErrP/cjlFzTWpxzO4euw71
	zWMvN4VVnMb7V7hzbeLFYKztHT6CmXNZqzzqhOg34b94FK00Ytbbk/L5hzrQUBi3
	huvvdiX5WM/YORhySL4CNJNhk+O2YHK07HW3hVQsCov+N6ryILKi+qf2FA3CIigr
	F+OdIsNYgGATsqd7o8l6Q==
X-ME-Sender: <xms:zyEsauS7o0p0XsvnBltMVZSTFd3UapsTS4K6J3tTdErr-R63wshkCQ>
    <xme:zyEsar6ptPtlg7hdk8cZGIZfT9yS1pV2Vo13BLRqCxdpLlfHIiCtFAw_G9PDmX3_X
    7Dcf8pTHbBibGeSngz9N93v0XE2QduLx1BkO8pRX5pzl_nZnp3qAQ>
X-ME-Received: <xmr:zyEsarUHLoVgmMt75ciFQXohSG0EKZL6hnBhFgn_pJZ7Ck2sPdvOqaHJXG8>
X-ME-Proxy-Cause: dmFkZTEhPZaTC5WJocVUz5p5x0OW7AO+PJl65exHIc4Skl9u7+pCIASypwnZ2mEtrsFjVd
    nAfGYOfgwVEG7Zck9yOtoDUwnm3G0j/e0qgulx3823I9tWTC/B/GDf3mRot4aYYObkOqax
    Wn484U1gesW3V20fygsVoDQ2FgRl6KKkCUBHDXDUfYJIboONNnLbM0J/4de0z9gBp2Sor4
    oXI57Wy1cuV5E2BkFQMI7FmRf2kQp0wHEtzSsXEUWDPo1EPVbOz3OLD2gDAW8V7So8zC5j
    yZCiv0IRwN5Q7xB8h/b3oS4idkhxxZKhVjo1aKWDiIgbfCbaefLLuazkONhY4t5LiB2RPT
    sDXgC091zSfc/Aa4/vRolhXA7u9HOFswKXvU0crPiGqsHevBawOuXIgivjl++1GvYBvh7h
    sy0RAMDpQd5le+cGaXVqFHIUVKFgYM5l6A8FRtwdmURbZZqmU5k6IT+MlcgFJzSRvTa8LP
    hErtaApFyLC1Dewo6rLv9g/EHrMOgHZcSUPq+HUFRAswPxDaO5+VC2XC1/l8u96zlIsU7+
    NGTAk8lYTPzWEcY/cxNS8X5lIJQIDfVVSdSWls2jJ2LzHlmct5J+zGROScUvJc6pu6tSv7
    XPVghDqVNSLLVxiPQ2PrutL4Zc1Kx6AhCtEUwSAeUa0ZpZJTV5onbaL6Of3Q
X-ME-Proxy: <xmx:zyEsap9kzHKg_LrhUXmOrDBPM5oo_86flSWGUSA_ihQGmEktc9z26g>
    <xmx:zyEsajrT8aQdWUZXjlvWGviCXlde0e1mh0lRHc96ZAdRyugRRogk4A>
    <xmx:zyEsakKroulvIZeTvpN4JhHSKPxFEVEKqgvOsNeUBo4XkcG8RigiOg>
    <xmx:zyEsauNB4lU9fXK8hyd6TL3ny-TBiPddrekpS_WnfSv7WZd7P7zJ0w>
    <xmx:0CEsav_yNxm_0aJmrBPDTiAhBvUfsHE43ZEvwMvNzWAy7dNExeuNxlH6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:12:13 -0400 (EDT)
Date: Fri, 12 Jun 2026 09:12:11 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, jjohnson@kernel.org, mani@kernel.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 mhi@lists.linux.dev, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <20260612091211.53856fbe@shazbot.org>
In-Reply-To: <20260612142638.1243895-1-jtornosm@redhat.com>
References: <20260612142638.1243895-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37748-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0CF267A6EA

On Fri, 12 Jun 2026 16:26:38 +0200
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
> Add device-specific reset entries for these Qualcomm devices using D3hot
> power cycling. Testing shows that despite advertising NoSoftRst+, D3hot
> transition provides sufficient reset for VFIO reuse, particularly after
> unexpected VM termination. While not a complete reset (BARs preserved),
> it provides the only viable reset mechanism for these devices.
> 
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

Comment and scope is better, but this is duplicating the body of
pci_pm_reset() using a different mechanism with different timeouts. It
would be better to extract the core of pci_pm_reset() to a
pci_do_pm_reset() function that's used both here and by the
pci_pm_reset() function. Thanks,

Alex

