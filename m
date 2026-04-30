Return-Path: <linux-wireless+bounces-35703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iChoNwQq82mwxgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:08:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA44A0839
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 397D6303A085
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA853ACA42;
	Thu, 30 Apr 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bplODJU/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4183A5E81;
	Thu, 30 Apr 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542241; cv=none; b=CQQJNRzQ9svU4Dvm5jbkyuZAFwrbzfsNVU/fSMzYc9oYukMcXb/lusnz5RcxDM6ymPK5EQtNQXNr5YltnJPN3rp0E/R6ZUmhHq185q8W3Nee5vzUYpVmN9I5EqIsXbVh0LbjmuhWXtapMdt8C7aTsXCuOoCoJXnsjIdE6umtmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542241; c=relaxed/simple;
	bh=pjD4a8rJ5wy6WIWFMXc/dMRwPE2lWwOkl+wfhS2cIxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6jLjC0mAFIS8/tGx5TlxlOnPGlb7yNv15qXboiAs9kMiuBWR5Lm1gZ4ohD1mAh52Es+k8/ZknJ42TECzDMrEphGTOrC6okF6qmbCYfGTJcoNBMpHKjCKr6XPehmyAoPEi795qjCFxE/je4A57IAZycbXgTVbqLpTfSFZpXE5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bplODJU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F83C2BCB3;
	Thu, 30 Apr 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777542241;
	bh=pjD4a8rJ5wy6WIWFMXc/dMRwPE2lWwOkl+wfhS2cIxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bplODJU/7ooHDNPIO3jofxmXUudXii8FNNlM4cLlKsg2xa1rzkJtzGIaCQEE5PtlT
	 k2X2s+mFd8BHQrw+yditg9/oAb2mOFnydZHwRjIeFD0D5um8JnTMBeGiyY0lIqzu8A
	 1dkEpe7x9CySs76qPyfav4wXZJZ33CEYe0VOX2WxMb4kdeR5izyJ4N7QuOfKzD+DYH
	 OdTB2zDSzpq/JKsvbnZADUyziLCEVZsv4jiGSpL+Rn0Cub486PPITbtdu63OuNPubA
	 cOL0/bXqyVZSeTcBqQGrpC11wIezKJWt6LrGGRX7T3O57Xmkl/hs+yrorqRVZFkcrf
	 jmBwyEe1LL1xQ==
Date: Thu, 30 Apr 2026 11:43:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@makrotopia.org
Subject: Re: [PATCH 2/9] arm64: dts: qcom: arduino-imola: Describe boot1
 NVMEM layout
Message-ID: <20260430-famous-meek-dinosaur-edacc6@quoll>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
X-Rspamd-Queue-Id: 74FA44A0839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35703-lists,linux-wireless=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.591];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.17.48:email,0.0.0.0:email,qualcomm.com:email,0.0.21.24:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 04:23:07PM +0200, Loic Poulain wrote:
> On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
> with device-specific information such as the WiFi MAC address
> and the Bluetooth BD address. This partition can serve as an
> alternative to additional non-volatile memory, such as a
> dedicated EEPROM.
> 
> The eMMC boot partitions are typically good candidates, as they
> are realively small, read-only by default (and can be enforced
> as hardware read-only), and are not affected by board reflashing
> procedures, which generally target the eMMC user or GP partitions.
> 
> Describe the corresponding nvmem-layout for the WiFi and
> Bluetooth addresses.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> index bf088fa9807f040f0c8f405f9111b01790b09377..dc85cf94f71cac8666cab30ccf37cc2d2f8fd941 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
> @@ -409,7 +409,31 @@ &sdhc_1 {
>  	no-sdio;
>  	no-sd;
>  
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
>  	status = "okay";
> +
> +	card@0 {
> +		compatible = "mmc-card";
> +		reg = <0>;

> +
> +		partitions-boot1 {
> +			nvmem-layout {

This should not be a separate patch. You add the layout AND you use it.

> +				compatible = "fixed-layout";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				wifi_mac_addr: mac-addr@4400 {
> +					reg = <0x4400 0x6>;
> +				};
> +
> +				bd_addr: bd-addr@5400 {
> +					reg = <0x5400 0x6>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &spi5 {
> 
> -- 
> 2.34.1
> 

