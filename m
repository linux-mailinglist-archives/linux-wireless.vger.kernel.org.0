Return-Path: <linux-wireless+bounces-1493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E28242D4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D7E1C23E94
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F62134F;
	Thu,  4 Jan 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opbxd8AE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934F22335
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e54d40cca2so4382357b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jan 2024 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704375868; x=1704980668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PaHFfcOelAjR2MGyweZQdTrdxlz7oJntZOkTBcCfI/8=;
        b=opbxd8AE34sHMyezy1o5VQjDdK8T42j+qoBaOn7eNu/G0jf4lGpoo+USBc8Ogu3S3H
         6DGy5kTD2Bo9z68+RvDeZGvXFymh1YeiTDg8t5xfFWJQnFLAPA8MjADeIxjhHomoU3E+
         5pmK+IxAr/4eAZcSl8eFk03QBwSSjwFbMx1MQ4W/z1hlVFj60K2XzesKjXIFwzKk0CwC
         nne24IqoJuu4m9Cxdy5vqcEsna3q+/RuN5FQ6JAz1sBEWm+rjo6zOF5/Ddw0S/Kf5EWP
         Ylxk4d9VR6dZ+5e3fq5624qBtz92Rg7CnJTSeUibgX5KazQZ8SmgWZN7FaqJBpmggdom
         dqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704375868; x=1704980668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaHFfcOelAjR2MGyweZQdTrdxlz7oJntZOkTBcCfI/8=;
        b=v+Glr02AGyCZL+jI7jHj79+idJLUEWGsJOgBh2OfJ+q+4Ut8jcT7QwOUdk2faMrcPm
         pGUz+O89xsvhUyYFGLT/UXmMe1y+78RrRdSdvvzbH4/5I6gY3LlvD0tP+tpJpSLsmPIg
         B+kNF/lHYObR3TFUTkpzxthEORiIb+rK1i+NqFK5zne5EF+/UENQVZqyuatUYQliZ0eC
         fhDvGLrWRgf43m5+NE0/J8uFTiQAOwBLjkuwCYzusXfyM/Ajmb1wdIWIO8aWE1U3/OYw
         +UtpuJ+jGfcuORXbfKC8PvHa1Jd84uz4hojstmi7qwF+rcUoD2MzToBYLfTMtd3CdC8P
         KO4Q==
X-Gm-Message-State: AOJu0YymKBud595osWFetxlmp5W6dcLhCDjWFPiA/d6GyDVlgmo0coal
	yJSl+bfdON0vh2NpvwcO2RLCjyTnbGF1LtUZtvPcXyfa4vkdcg==
X-Google-Smtp-Source: AGHT+IEZCkEXOIdEM0j+8NIK0uK6YCf75WCjyHpwydLwlV5/P5Xet8pHKf/9cbHSR3VeVJohCL4uPwgEzC0vSgDbJM8=
X-Received: by 2002:a0d:cb85:0:b0:5d7:1940:8dea with SMTP id
 n127-20020a0dcb85000000b005d719408deamr463700ywd.81.1704375868283; Thu, 04
 Jan 2024 05:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-3-brgl@bgdev.pl>
In-Reply-To: <20240104130123.37115-3-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jan 2024 15:44:16 +0200
Message-ID: <CAA8EJpqZ8zbNcK1BsJaaoK3Fje9KhrvFvJpgdBa-US3eMhOmOw@mail.gmail.com>
Subject: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: describe the WLAN module
 of QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 15:03, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Describe the ath11k WLAN on-board the QCA6390 module. Include the
> relevant regulators and the enable GPIO.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index cd0db4f31d4a..721f86af952b 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -734,6 +734,22 @@ &pcie0_phy {
>         vdda-pll-supply = <&vreg_l9a_1p2>;
>  };
>
> +&pcieport0 {
> +       wifi@0 {
> +               compatible = "pci17cb,1101";
> +               reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wlan_en_state>;
> +
> +               enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +
> +               vddpmu-supply = <&vreg_s2f_0p95>;
> +               vddpcie1-supply = <&vreg_s8c_1p3>;
> +               vddpcie2-supply = <&vreg_s5a_1p9>;

If I remember correctly, qca6390 has at least 8 power supplies AON,
PMU, 3xRFA, 2xPCIe and VDDIO.

Moreover, these bindings do not solve another problem: the PMU is
shared between WiFi and BT parts. For the next gen (WCN6855) this
becomes even more important, see the code in msm-5.10 which makes sure
that there is a proper time between one of the units going down and
another one being powered on.

> +       };
> +};
> +
>  &pcie1 {
>         status = "okay";
>  };
> @@ -1303,6 +1319,14 @@ sdc2_card_det_n: sd-card-det-n-state {
>                 function = "gpio";
>                 bias-pull-up;
>         };
> +
> +       wlan_en_state: wlan-default-state {
> +               pins = "gpio20";
> +               function = "gpio";
> +               drive-strength = <16>;
> +               output-low;
> +               bias-pull-up;
> +       };
>  };
>
>  &uart6 {
> --
> 2.40.1
>
>


-- 
With best wishes
Dmitry

