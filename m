Return-Path: <linux-wireless+bounces-33929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 54pCKGr0xGld5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:55:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EE331B02
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C3783032E67
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181B346E57;
	Thu, 26 Mar 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0z1S6+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A634C140
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515299; cv=none; b=ZBuf891dLPShL/XPnl/56vN5TgUi5BiJ/lTh8olyI6pBXAET1DZTTRJXDRssbth4jnb6B3eqbVwshtWIRtqgdhN84paaRy/XoZAfSAUOw0ZIF2cUzCLi9qUdQwNpNsd6LrHN9063qd3i1JcdyoaXOKix7zVEGTVk8eZQDuoprv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515299; c=relaxed/simple;
	bh=sDMEuZ5NbvWpRTjfdc6QeJE8QGjyvgn4ez8QF19VQ0I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mzZN+7zGHFp1EyYJxmeKRmJO9V9xw8jB5yU0a8DMG9cO+oOvklRgOjE6fRwwFnJyrtrk1PP/c78CreLryT7M9b0bHdfTFDGVAyGe5HdTlfZCmyutPvO6WBWRv+EtSePZv1JDHiKQBnXJFUfbqdDO5qAP5RCDjDJ2K1GeZudDk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0z1S6+a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so5428275e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515295; x=1775120095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPOq+t0BPIjTXIy85z0pLZNyx1Sqnvxn5kHxjGZM2Uw=;
        b=o0z1S6+aU93OlkOzo7sM3NMZSGxiJPty9c6uVfGVerbwntDWAYebxSBkmpLFLWMiw0
         mwCcud2XkX0Qg6vp6ndNzPT/P+wcUe/jxNZsnxRXIpd7Siezh6TxU7oEwh9VaueEFh0H
         2D1hIXgW1V3YfrEbS4zcmb5uD3VxENuhFD2aEhv9lti8iN3RkVV+OHhdyzkKwip3sB7b
         uQFQCd1a6Ujgd4biVNtE7BHKkqu8ElvOtbcNHEDGFALH8cDv//LYTyu+g187TVw91qHg
         Yn88dudTl3SOOJS2tAyXI+6qKuUz75zsgQO+9f7ua2x7hS/WflKKMKcWysJXqLy/l4Ph
         JqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515295; x=1775120095;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPOq+t0BPIjTXIy85z0pLZNyx1Sqnvxn5kHxjGZM2Uw=;
        b=TQspcagmHG8EqNZQ30wtsuwOyuwGrnOcFwVLaVNDtesFaA6jkfpDr5+feVYLxrARaF
         vwftIo6snbfx5aZdPIpO6/Ljij3g9GC0C+71ydMUf+vV/v1xMY9AglGpLTxBJ2s4JUsf
         trb5ycXUI+u8JTG5vSW4M67rhWRCsvWd2G3JLAAANTpyNySabKkKWmI9wV0JrFLsRPxK
         c20ea1v0CTMljTfPWw1b4nuwM5YefSo6esdHPCUcuc5SuT8a1bNCIjHRKNP8xoO4m999
         MRz5Fh5XIZlCdKSHV7E48m3aPue/giOLbMyuLEuoTkjuo8BAoGIePO/sS+N1gsMl4Uyn
         x+vA==
X-Forwarded-Encrypted: i=1; AJvYcCU4QHGgukWT0jtSzmWbZCVg3jaD8lihVrZll+zxexENSSjsjnf2Eg3XOBFO2m8Z4lG84F4Zt9CnKhsgVShGXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsgE8T8+aRF7PUA7TuWfycOviX2x4Xinozw++SIjIclEgQT4h
	wXZb1mZ1sogeqnUDt2XCHu2q1OQF68c5eVvEXBoEJE7f78Q3n5ENt3ESEGKx5n9rE3Gq78Lg84U
	URUQw
X-Gm-Gg: ATEYQzzboK4MG9YJJd1SeQbZhGA50nt3NRkeaxXWM6yGGyWVnl950mvvvsG6Y4BuUwA
	2fFOPwkD632ufx0uQ1asmELPoHs4uuvEiuB3OgKtgpsnn6K0xEzImNr/aTMsKM2y6Ut8oaHxBs6
	RF+d7bAlTO/vhMDGS5+Qz/1DGIDR5ZdqLv10GkKQBbd8f1UGjHQD5VjlfuBopQ2dNJyilpYnTF2
	NN1LM5CGb6QUqCrl53L4MHWbyvYcy7rzs0kGSpl6ppwNFwgtYI++8Wm992+reqTFTDcJSx54U7n
	Hc8jQK2i4UPOgCVWob5sRsARBCO18ISZfZqHD462GPyizbTaCo1w7dhyu+KYnSdJSYsY1+DVtBq
	gCDXUPbvemva26A3U0svIC3cXAvmipYWgQp20p+qLWuwLs0etGxCUCtkfBXhvlxxUiKY5UhYLRh
	XsH8J7e+DMGWp9KzRI4cA4mC8mqSJuaz0IAFqQBEQdX60u49SQ2c+4qq2Y1vYAp8gMFZEDKvkVR
	sO1Tm8=
X-Received: by 2002:a05:600c:3e1a:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-48715fbabedmr88067005e9.7.1774515295443;
        Thu, 26 Mar 2026 01:54:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901b90sm10376515e9.17.2026.03.26.01.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:54:55 -0700 (PDT)
Message-ID: <512d95b5-5348-4c7c-961c-b6ca1431cee4@linaro.org>
Date: Thu, 26 Mar 2026 09:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 9/9] arm64: dts: amlogic: t7: khadas-vim4: Add MMC
 nodes
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-9-44c7b4a5e459@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-9-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33929-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email,linaro.org:replyto,linaro.org:mid];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5E0EE331B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:15, Ronald Claveau wrote:
> Enable and configure the three MMC controllers for the Khadas VIM4 board:
> - sd_emmc_a: SDIO interface for the BCM43752 Wi-Fi module
> - sd_emmc_b: SD card slot
> - sd_emmc_c: eMMC storage
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 90 +++++++++++++++++++++-
>   1 file changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index 770f06b0b16c7..5a73ae081036c 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -14,7 +14,10 @@ / {
>   	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>   
>   	aliases {
> -		serial0 = &uart_a;
> +		serial0	= &uart_a;

Spurious change

> +		mmc0	= &sd_emmc_c;
> +		mmc1	= &sd_emmc_b;
> +		mmc2	= &sd_emmc_a;
>   	};
>   
>   	memory@0 {
> @@ -159,6 +162,91 @@ &pwm_ab {
>   	pinctrl-names = "default";
>   };
>   
> +/* SDIO */
> +&sd_emmc_a {
> +	status = "okay";
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	cap-sdio-irq;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +	no-mmc;
> +	no-sd;
> +
> +	power-domains = <&pwrc PWRC_T7_SDIO_A_ID>;
> +
> +	keep-power-in-suspend;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddao_1v8>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm43752-fmac", "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +	no-sdio;
> +	no-mmc;
> +
> +	power-domains = <&pwrc PWRC_T7_SDIO_B_ID>;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&sd_3v3>;
> +	vqmmc-supply = <&vddio_c>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +
> +	power-domains = <&pwrc PWRC_T7_EMMC_ID>;
> +
> +	vmmc-supply = <&vddio_3v3>;
> +	vqmmc-supply = <&vddio_1v8>;
> +};
> +
>   &uart_a {
>   	status = "okay";
>   	clocks = <&xtal>, <&xtal>, <&xtal>;
> 

With that:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

