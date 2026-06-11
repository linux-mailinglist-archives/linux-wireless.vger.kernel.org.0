Return-Path: <linux-wireless+bounces-37652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id be/ZGSpSKmqInQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:14:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F666EEF6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:14:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IzmudD+B;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37652-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37652-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D77E4301FCAC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1ED34F497;
	Thu, 11 Jun 2026 06:13:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F82DC350;
	Thu, 11 Jun 2026 06:13:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158437; cv=none; b=UEd5b0mp6Xh+K2akJjOw74U7oc9RbGPeD7Fn8rIMsIogOb6YATSN6X4PYICk6ysoTkaRLCedYQowpd/ZtpGsecuflbScGn4h3QF9i6V5Gctfh/EFarRYzXdZrTgAPvoFn52tEZ62z6FMqTpyK4mcjrBGKpDsdRMc0LF3o5LlWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158437; c=relaxed/simple;
	bh=6zhvURZmlfW8zMTdnfRhUUFf36SCrAG+gzgidGoDtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHK+xprwHnnbMSjt+3NauLiGhxRITjDBVuVzDMc1+a7gSgoGO0PV4YYUUduNJxKitYo6fuPxxXhAkw5i9oNsPpphC0wwHW/5De7S8WnG7KhV4B0TmAYYpqJovRaKPCkvX9zNG2d8h29BC/Y5IjMaTjueZnDdrnZvX0Kvwc9aOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzmudD+B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5408B1F00893;
	Thu, 11 Jun 2026 06:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781158436;
	bh=M5WsnsZ4MAvmLf7nKfATl47R6VK/KMexUssZggzEOs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IzmudD+B7ZucXc0KDJnmsz9xM1FnRQBwm/PIXROQNKj6CCc+H+5SGsBTgwBzN7Wzu
	 k9177ZHMbKTJJPj+iXvlHum/tr130j9U5FJ2tdQdqpjH4fjvqcunNJ+a3vx03yeLiF
	 bOnwBjnGOrrRCEHODZsB98PWCyovwmc3Zi07b1YVQ6Ndggo8QnhXt2pu4kOLA17836
	 xgb0BlQcTQyI72kjrHIkuVSxKSSC5iDYlBefSbE5xmJpGLSy12blUQ3cMWt+TXAxq2
	 jTxIykVDfebvWpq/74rFGbk+CpQtJRDmyC4NmI2hxqZne9DkhurG6flVCUgew9n3/G
	 zkO5RXSENaZUg==
Date: Thu, 11 Jun 2026 08:13:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-bluetooth@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
Message-ID: <3qq4afo425imn25yb74ag62vpd5lhil4ctjbmknd3yrsvq3tw6@3hq23lknpm23>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
 <20260608-sm8350-wifi-v2-6-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-sm8350-wifi-v2-6-efb68f1ff04c@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37652-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE2F666EEF6

On Mon, Jun 08, 2026 at 09:59:24AM +0300, Dmitry Baryshkov wrote:
> The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
> port rather than RC device. The kernel recently started warning about
> the older style of DT. Modernize DT for SM8350 platform by moving the
> entries under the root port device node.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 18 +++++++++++-------
>  arch/arm64/boot/dts/qcom/sm8350.dtsi    | 12 ++++--------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 5f975d009465..4973a3eb11b5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -493,12 +493,14 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie0_default_state>;
>  
> -	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> -	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> -
>  	status = "okay";
>  };
>  
> +&pcie0_port0 {
> +	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &pcie0_phy {
>  	vdda-phy-supply = <&vreg_l5b_0p88>;
>  	vdda-pll-supply = <&vreg_l6b_1p2>;
> @@ -507,15 +509,17 @@ &pcie0_phy {
>  };
>  
>  &pcie1 {
> -	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> -	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> -
> -	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
>  
>  	status = "okay";
>  };
>  
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &pcie1_phy {
>  	status = "okay";
>  	vdda-phy-supply = <&vreg_l5b_0p88>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index eb2a795d8edb..136daa444865 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1583,12 +1583,9 @@ pcie0: pcie@1c00000 {
>  
>  			power-domains = <&gcc PCIE_0_GDSC>;
>  
> -			phys = <&pcie0_phy>;
> -			phy-names = "pciephy";
> -
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcie0_port0: pcie@0 {
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> @@ -1596,6 +1593,7 @@ pcie@0 {
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  				ranges;
> +				phys = <&pcie0_phy>;
>  			};
>  		};
>  
> @@ -1692,12 +1690,9 @@ pcie1: pcie@1c08000 {
>  
>  			power-domains = <&gcc PCIE_1_GDSC>;
>  
> -			phys = <&pcie1_phy>;
> -			phy-names = "pciephy";
> -
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcie1_port0: pcie@0 {
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> @@ -1705,6 +1700,7 @@ pcie@0 {
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  				ranges;
> +				phys = <&pcie1_phy>;
>  			};
>  		};
>  
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

