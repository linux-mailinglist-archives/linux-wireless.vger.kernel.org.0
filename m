Return-Path: <linux-wireless+bounces-17086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A3A01A2B
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741991619BE
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE501537CE;
	Sun,  5 Jan 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b="pXAgMQsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB901547D5;
	Sun,  5 Jan 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736092678; cv=none; b=R9tgfiAiEX8smgxm1N0ZC1LilIcrOsvtzBHQPpjMlBLBjz2MN80hYPIaDexnGZOdF2MNfMv1I/pGsYNBAS89YnVZ61ezXS5/Ww3baP7mTRdWBwsDWq/0rLK1vGNGnmGqqptdBZXvWTRTY+G1IohO0sR2if1X1z3Oikvs9bGpZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736092678; c=relaxed/simple;
	bh=glECVpijGwA38pQyr2puxTIpItvr3Fwj0JiLUxyydYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciaABD8/0FXHlp2nlpP7O0dvAPxiQvEheNo/SXP+cutOWBnHoZIAfjx/baitsdS4703C6f4Ydr48rw6L8UkC6Wjbv71duhMdWR8zU1nY9Te2DH//vO+Vh2Po5Or858lLsVWOAXvpLRakNmvoImXzA8SeTj1Fbi9MG2nqVqn9xRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu; spf=pass smtp.mailfrom=lucaweiss.eu; dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b=pXAgMQsY; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucaweiss.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
	t=1736092148; bh=glECVpijGwA38pQyr2puxTIpItvr3Fwj0JiLUxyydYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pXAgMQsYJHghdfEqLYfQzq01nogpYuPbPPGioHwTr3x0FlIujGpb2AYjTnKJncPQ3
	 UiBi8X9gzbOPkIQlNzBnqW/dqpdyt0FEOaGW0s3zsa/fyDlM2KPC4qb9Kqg39VAcW5
	 O6lrwJz7UZONazHGmL2AvNHDI14YXR7NiCMHMxAs=
From: Luca Weiss <luca@lucaweiss.eu>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, Alex Bee <knaerzche@gmail.com>
Cc: Alex Bee <knaerzche@gmail.com>, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] wifi: brcmfmac: of: Support interrupts-extended
Date: Sun, 05 Jan 2025 16:49:07 +0100
Message-ID: <4660783.LvFx2qVVIh@g550jk>
In-Reply-To: <20240622215416.659208-1-knaerzche@gmail.com>
References: <20240622215416.659208-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Alex,

On zaterdag 22 juni 2024 23:54:16 Midden-Europese standaardtijd Alex Bee wrote:
> The currently existing of_property_present check for interrupts does not
> cover all ways interrupts can be defined in a device tree, e.g.
> "interrupts-extended".
> 
> In order to support all current and future ways that can be done, drop that
> check and call of_irq_parse_one to figure out if an interrupt is defined
> and irq_create_of_mapping for the actual mapping and let it be handled by
> the interrupt subsystem.

This commit seems to break WiFi on qcom/apq8026-asus-sparrow on 6.11.11
release, and I'm guessing also other apq8026 devices that I have.

dmesg looks like the following on this board:

[   33.699503] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
[   33.811445] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
[   36.565674] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[   36.565725] ieee80211 phy0: brcmf_bus_started: failed: -110
[   36.565777] ieee80211 phy0: brcmf_attach: dongle is not responding: err=-110
[   36.575930] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

After reverting this commit it works well again:

[  141.299739] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  141.355040] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  141.364695] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[  141.469042] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
[  141.612365] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
[  141.730597] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[  141.730661] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob available (err=-2)
[  141.731778] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Jun 23 2016 21:14:35 version 7.10.324.google.security.test (TOB) (r640416) FWID 01-495ddd98

Would you have a different solution apart from just reverting this commit?

Regards
Luca

> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> Link to v1:
> https://lore.kernel.org/all/20240621225558.280462-1-knaerzche@gmail.com/
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index e406e11481a6..fe4f65756105 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -70,6 +70,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  {
>  	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>  	struct device_node *root, *np = dev->of_node;
> +	struct of_phandle_args oirq;
>  	const char *prop;
>  	int irq;
>  	int err;
> @@ -129,10 +130,10 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  		sdio->drive_strength = val;
>  
>  	/* make sure there are interrupts defined in the node */
> -	if (!of_property_present(np, "interrupts"))
> +	if (of_irq_parse_one(np, 0, &oirq))
>  		return;
>  
> -	irq = irq_of_parse_and_map(np, 0);
> +	irq = irq_create_of_mapping(&oirq);
>  	if (!irq) {
>  		brcmf_err("interrupt could not be mapped\n");
>  		return;
> 





