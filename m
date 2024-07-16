Return-Path: <linux-wireless+bounces-10252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F69323A6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56CF1C22922
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D21990A7;
	Tue, 16 Jul 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTEDsi9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F5198A20
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124829; cv=none; b=usxuSLeM9k57Q8krmjY+Xhls/jOvx2W7OffaVLxeE4wp1xLZYQf+NrH8h6gK79sT7e6rSjRL1TiAyUgUeiHpQ2OBKl+acLQJ4RAyGpETMDsshzb4VCMufcxAJ4YudqVs1V55hVQqHOHA44gjw8Yyp3sXXEioGXKTLSxOgQ5xvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124829; c=relaxed/simple;
	bh=f8Gky9YqWDCmNh8MKNY9H8sRB+mkfPsGLsY2vGiP7+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI3c7OTnTj+UnvYV3IqEqfH7yRtWFYFC+8Wdm/IIj39lxUICxsUiqQsgbz3LrE59xNIZ+KGzggykE4yr6Xy98la8UZYYShdsJ4jVBSAyo5CCmLDeeccLCuizobXtcl1rY4AdAohVVhbR9gv/uMNWKs8SV3fFovq+3if1JdKkK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTEDsi9k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so3239172b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721124827; x=1721729627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6gMwbuavCbnycNTjRaKx9Abv3DoqBPYUEzkdAtOD14=;
        b=NTEDsi9kYF9duQPxqkOq3Bkr6Vol49BNRWzhV2wsTBiR7MJtBd+1IRNl4jzjrxoUAv
         Ykd5vKc7d+ndCODB7vfiibVcjhTZ6DkOt98lfgDBgb0QTKO1LfpaUmfF/TuD8x7oS9XD
         C+sd80RtqFIrVMON04BADFTBcEywMkjURVrCO4sQf4Sd56oPOTrjirsk+VgyNUI0JvkR
         IjzBRi0FEk4DLGimAtE/KdozIezmWTU0VYTR6nGHDPgafu6qtCrWU8PFPoLIEB6KUqyP
         kLYXTr3nvppS6V/MQ1Simq77QoMT5FvSVNHjjH9E33TIgzc4bmPdoTayW/ZGytsTvTDb
         ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721124827; x=1721729627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6gMwbuavCbnycNTjRaKx9Abv3DoqBPYUEzkdAtOD14=;
        b=AywD7jlpnUgZ2RXqA6cMGbPRQmlULV8zqSFdK0uufIdxMFkw7mwnFhaw6CBExp2PcO
         8lXjGrPaJy1BGIEFFH85RvgfAnJR03kW4Dfdx+YDtVdNlr4du4sEQDLwwtA1h9ItQFzi
         AzRAgS5hh2uxvZvDG2VxYAy9w8DWKdg0vc+/PmaPiZn8ro7t9wxthiSUc6j1YHJR4C2A
         P8W7hRP6Fj6/KsGUk6GbZxR2NXk9VE5eM1zenw2PeqJAHmzs7EeGJi2nRAqFvNNyjYCU
         5YFToZclBc7q6HXOI+mflbDDSNsVYhikmrDVqIjcn71Mldl3loSnOIecAQNvrp7xDpHG
         SkUA==
X-Forwarded-Encrypted: i=1; AJvYcCUedzknarBequ9GGoRFoKtqGR6J/b3ozHJxkZkEB6QMc1rnu/Fti0DcZZZohbHqgw7/fDJtNkV6sA0ZlI4FpZnBR5Y0tKdcbXglSs4CgDE=
X-Gm-Message-State: AOJu0Yyo0y8VeBxqYHcJPrvkP13SXh3w0UbsoP20kyuWiXXUob8QlyS4
	e/IjFpm2FTm7sNiZI/W9rBVYwPVNgsn/ySt/1z1ghYJazZ3HHQzRR3AA/uYvWQ==
X-Google-Smtp-Source: AGHT+IEDJskFirz6paZGF1HW14iR2GuRPxyEKCS91A1U9kJEn0J3pLh5f3w2w9WhXlu21KxqWnu3BQ==
X-Received: by 2002:a05:6a00:170d:b0:706:6272:417 with SMTP id d2e1a72fcca58-70c1fbd50acmr2120187b3a.10.1721124827058;
        Tue, 16 Jul 2024 03:13:47 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e285sm5915488b3a.8.2024.07.16.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:13:46 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:43:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20240716101335.GK3446@thinkpad>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7OeGNIGGpqNC0@windev.fritz.box>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpV7OeGNIGGpqNC0@windev.fritz.box>

On Mon, Jul 15, 2024 at 09:40:41PM +0200, Patrick Wildt wrote:
> Describe the bus topology for PCIe domain 4 and add the ath12k
> calibration variant so that the board file (calibration data) can be
> loaded.
> 
> Signed-off-by: Patrick Wildt <patrick@blueri.se>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts      |  9 +++++++++
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi                 | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index fbff558f5b07..f569f0fbd1fc 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -635,6 +635,15 @@ &pcie4_phy {
>  	status = "okay";
>  };
>  
> +&pcie4_port0 {
> +	wifi@0 {
> +		compatible = "pci17cb,1107";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +		qcom,ath12k-calibration-variant = "LES790";
> +	};
> +};
> +
>  &pcie6a {
>  	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 7bca5fcd7d52..70eeacd4f9ad 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
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
> +
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
> 

-- 
மணிவண்ணன் சதாசிவம்

