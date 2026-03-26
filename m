Return-Path: <linux-wireless+bounces-33923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F3HOZb2xGmC5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:04:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52490331E0D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B48363136BB1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15F375F8E;
	Thu, 26 Mar 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrVh5olG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CA3B7749
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515127; cv=none; b=ed689nMlHCF/cj6awfJyNdbYq1MigciBRBFTuCUpgOtUmrmHoDRrNJ8twryYh7aDvsRoDYDywPIfpu9WAHcA3x4OvmNaSykBTheUQ+ivW8vb+GWmRpFO8rsbKWTLeKePZyzmi/Hl1vPS14qL/VHbKCzWGTtDMkQw9YdRyQZlgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515127; c=relaxed/simple;
	bh=VSiA801w/9hEVKBasLtS7uUMFQfqf1PgJgxXUEq+J6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eRMkAUMwCZl76+mPjhlJopZ3Z+SzFZ6LpEfhoUlZ5f9K1Tx+CuUK2eZl+nb3pJyFgj3Mqut1zdeKEE1p/pQOZmx7nvwfTgohOUGpqRwtvr78k64yi4cPIBEEy4cXHqcsX/7AY5yn4XUnrib9JC+DJ3s9pkrv6kWRLB991+XOgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vrVh5olG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7c2788dso393171f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515125; x=1775119925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smOP6x0To5MeFMWDp/WtjMB68J+cu7J59H9CXktE27U=;
        b=vrVh5olGaClsjbxGeMpKdU2ESV1IjeoQNayXHC6EFuCxgiKS7u3d/6FuwiOEIoa7xu
         9Ni0K4NLlmhhbHxdF9OU+ad31iIkDaCS9EQR3Jtlt3vcz6Bx7ixsfYsTXTQUEmTi8VG6
         DxhhQmccoZSQeRY+jD5UwqA1w8K/+IgUYP1Phvi023BRkjAcROD0NwBcBbyz72eJ3+xz
         qt9nFWpLKGiPRpeimJ8Jx4lJPiYRTUHaX3lqdhqWjs2uPtidYBK3MLXGo5LPzmcJ5/NQ
         DkPAcKBcxN4HJ+GbfH3ktU0qhbpOxKsfxf7kqhPujeFr/QmKJyKq7oZI7or4QlPI2cLI
         FuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515125; x=1775119925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smOP6x0To5MeFMWDp/WtjMB68J+cu7J59H9CXktE27U=;
        b=jc40t7Hi6zAqhEJzZlsTshRdjjLpR67Jwb9yEXFHAAVMIWI7O9iou7qWcHeCM/3495
         EZQQYTwmx82+eOVhyWP9PaAwlil0TmphXUrRD0my04ZtS60rT/oZa81dsVZWn5miX2sI
         cdl7dOm+McURbxKqeuueSguQp6/ksn3Ye8sby1UELxzjjfnYU/MQbeHsTgKFUa28xTZj
         IaSGwT2WexjvGIIoI9jL2xw/JtJuwh/5OVXZt4S6JLuXNKBgSDQQmge4OdM3zTnJ+J7Z
         iN59xVUKH2VC5vewDlCFrixI/6VBGiGUbRW5rRqAGB+egxWL8/h7XEVtWN4legXK9o1l
         fKCw==
X-Forwarded-Encrypted: i=1; AJvYcCWGHTP7VsplHOBss+9pAAaWU5mjqQ+h/E4GwMc0P+HUyKfhbelMVCM3P7DD3QowVZ0j76mXPpBIa2+EKsJ0LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrhzsB+Wb8w/I2m7WMc7vB0XHsRmbE6y5tpd83uzK6w97ZThQ
	19VydI04zaWjWneZDYBxfe0Ayb0KNOV0dUM+Tv5B4kRiGlQOVFIT1LtbsqtlvBqoFUo=
X-Gm-Gg: ATEYQzxtwrDogtA2W4ZwJ8aBDpDOft6P+3vvhOSipbYdJC4gb957XUG7ESBIXzBSfEw
	Ifdl0v+IT33aBsy7DQcEJEEkODV/GKU92cYMdNrGb1C3XVi3fp9Sr5W/evVAUCvUOypq8hyqxeZ
	z47M+WcFvubJ9iJI3hnlJsYz2G3AG5zpraiGR48nyXo5Z1UPdowNxPyFTIOTC5TNV4Fl9ZAwtFu
	11KEzzl82/AmxyCRsh1YLJmsX7C0JRWTiyZZ8aAJmdJ1sjXZgVgMMt/oKLStxEWXF5UwfOou4z9
	C66HFtl2OVO0oeP/oCVZhfs3hdvDC9hv3+JhY6pi5nTpNbnVdyU+2R/IVZm6K+0FRYNOMYTVBkk
	10DuUip223ih+Z3+CchaYXZCSgrNEmmYyNCXlRjZhUlVLvjq6u9KAuEMTT7YsxG+eBO/gZRaSZa
	oV9+mr9asCzDEV5W6FhRz1yWomLhTuL0PYeOMEIkNYzTfSTzvX/ze1eiZ7FhFaN+05kRPTDhPor
	z1fx0Y=
X-Received: by 2002:a05:6000:400b:b0:43b:4ef0:e13 with SMTP id ffacd0b85a97d-43b889a49eemr10222108f8f.12.1774515124429;
        Thu, 26 Mar 2026 01:52:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2c8sm6326074f8f.20.2026.03.26.01.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:52:03 -0700 (PDT)
Message-ID: <5298e691-99ba-48fc-874b-c9af308664ee@linaro.org>
Date: Thu, 26 Mar 2026 09:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and
 SDIO pinctrl nodes
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
 <20260325-add-emmc-t7-vim4-v4-1-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-1-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33923-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:email,linaro.org:dkim,linaro.org:replyto,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_PROHIBIT(0.00)[0.0.15.240:email,0.0.15.160:email];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 52490331E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:15, Ronald Claveau wrote:
> These pinctrl nodes are required by the eMMC, SD card and SDIO drivers
> to configure pin muxing at runtime.
> 
> - eMMC: control, 4-bit/8-bit data, data strobe and clock gate pins
> - SD card: data, clock, command and clock gate pins
> - SDIO: data, clock, command and clock gate pins
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 98 +++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 6510068bcff92..016b5429c8d1b 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -250,6 +250,104 @@ gpio: bank@4000 {
>   					#gpio-cells = <2>;
>   					gpio-ranges = <&periphs_pinctrl 0 0 157>;
>   				};
> +
> +				emmc_ctrl_pins: emmc-ctrl {
> +					mux-0 {
> +						groups = "emmc_cmd";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +
> +					mux-1 {
> +						groups = "emmc_clk";
> +						function = "emmc";
> +						bias-disable;
> +					};
> +				};
> +
> +				emmc_data_4b_pins: emmc-data-4b {
> +					mux-0 {

No need for "-0"

> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				emmc_data_8b_pins: emmc-data-8b {
> +					mux-0 {

No need for "-0"

> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				emmc_ds_pins: emmc-ds {
> +					mux {
> +						groups = "emmc_nand_ds";
> +						function = "emmc";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				emmc_clk_gate_pins: emmc-clk-gate {
> +					mux {
> +						groups = "GPIOB_8";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				sdcard_pins: sdcard {
> +					mux {
> +						groups = "sdcard_d0",
> +							 "sdcard_d1",
> +							 "sdcard_d2",
> +							 "sdcard_d3",
> +							 "sdcard_clk",
> +							 "sdcard_cmd";
> +						function = "sdcard";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				sdcard_clk_gate_pins: sdcard-clk-gate {
> +					mux {
> +						groups = "GPIOC_4";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				sdio_pins: sdio {
> +					mux-0 {

No need for "-0"

> +						groups = "sdio_d0",
> +							 "sdio_d1",
> +							 "sdio_d2",
> +							 "sdio_d3",
> +							 "sdio_clk",
> +							 "sdio_cmd";
> +						function = "sdio";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				sdio_clk_gate_pins: sdio-clk-gate {
> +					mux {
> +						groups = "GPIOX_4";
> +						function = "gpio_periphs";
> +						bias-pull-up;
> +					};
> +				};
>   			};
>   
>   			gpio_intc: interrupt-controller@4080 {
> 


