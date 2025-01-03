Return-Path: <linux-wireless+bounces-17063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E719CA00FCC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 22:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1951885487
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB071C232B;
	Fri,  3 Jan 2025 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWNE9reb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB41C07EA;
	Fri,  3 Jan 2025 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939119; cv=none; b=Z255Z2p0D/qHgLQ/h/Wwsngql96P8a6+NGrpjduNkKwSMIz2IynQBk/Z6+6WCSxnmNmZgwYx3j7mOTjh6BYbtkTtSSLn+0Ay3TmORJi9M58O5KgVxco6sqHpcrXicfU5KKRlPkpkxETQSOeR23vBodRHYPwXIbFB1sMB5Krto90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939119; c=relaxed/simple;
	bh=Yrk/YsSXzP/Nte+IkBreXUjv1UblDRgdvIS1lIKOFlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lYDVZor/s29Hxe5OLFLOuTVkT5mGJGzbp8BkMpAQNlRHYyHE1+ji3t3zebAnGV5ekrZvUvLUkdIDHw7YoTqy45WGpowWlGWe+9riXBFgA6kAVJnGsl14QYKCjGHKiFf/y1HVeEhAOo4Vncw+LZh66q7JvURp8h2VPZZEZl/H8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWNE9reb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB28EC4CECE;
	Fri,  3 Jan 2025 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735939119;
	bh=Yrk/YsSXzP/Nte+IkBreXUjv1UblDRgdvIS1lIKOFlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RWNE9rebV2LC7ARtdr8jkr7nAmAorBFtJDVOiISUnTZqAv6n8qGXKayukW9c/uZS1
	 Nqnt5ea2nvL8batQ8UXS4A4AZRiEU7Dt5MWBCd8azQ0H72IMwbb5uXpkdSCjhyYQ8M
	 zk85osVZaCMDBa+2qY5v7M6aaReOy8lzjgpk7zBLznq0PyxVHo3FCUhfmQnrvv0L9m
	 usddZB7kENa8J09L+kIW0kcF3dt1/EKL7dQgrnOy4QSTVi24+1bvM5tRz3plBk/rPp
	 Yv3kq3+etWSFIBRGk+9kp+HdOYEO7Pet5c6dUS6JvkAW9qJOoEGjri2iRe+FH6Njk5
	 i065sT9FBLPGQ==
Date: Fri, 3 Jan 2025 15:18:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Patrick Wildt <patrick@blueri.se>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-yoga: add wifi
 calibration variant
Message-ID: <20250103211837.GA4406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpV7OeGNIGGpqNC0@windev.fritz.box>

On Mon, Jul 15, 2024 at 09:40:41PM +0200, Patrick Wildt wrote:
> Describe the bus topology for PCIe domain 4 and add the ath12k
> calibration variant so that the board file (calibration data) can be
> loaded.

> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3085,6 +3085,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phy-names = "pciephy";
>  
>  			status = "disabled";
> +
> +			pcie4_port0: pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;

Hi Patrick, what's the purpose of this bus-range?  IIUC this describes
a Root Port, where we can read and configure the secondary/subordinate
bus numbers from the RP config space, so it seems like we don't need
to describe them here.

> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>  		};
>  
>  		pcie4_phy: phy@1c0e000 {
> -- 
> 2.45.2
> 

