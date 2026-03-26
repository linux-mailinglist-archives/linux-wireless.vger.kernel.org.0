Return-Path: <linux-wireless+bounces-33926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFMALar1xGld5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:00:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFAC331CA5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D08E3040FA1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A163B9DA4;
	Thu, 26 Mar 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axs6ryHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB73B8D58
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515188; cv=none; b=ShZdwuI5hkxoTPqQ2hs26XEhfF7cWgX+Y90QofzTanWQbwlAl40qN8oRl95TtrVVGKuAIHTMPt3bwHmUdE94cA4G9Gx8+KCXcO4ibxoTnUQh1lxqrVfSnRc3BWp8zdqy5mup/3ZwExVtOipCYeZszxlIo4HXqQdEuTOVdYg86L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515188; c=relaxed/simple;
	bh=O1jN7BD1GGh6tS7iK1iKMQNeemAgg7gH0h2lUJMtyzU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iBRftU9sgby/tIHPD3EAKtw1H8w6vSaLh4hSS3pQVDRU3WTzX7nahvDyffbovb0jMQNkqjq0TCdIC8CpaxgJUopiNIEbDFTGDzu/yqks6Zdlw/Tk2aGzeS/HFbCezp70r7ZOnqNTc72xx9Jvtxhp1BWfSTkDjcAFfE7ORC7Ux5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axs6ryHJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso6159065e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515186; x=1775119986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDXG9M4VD8sbt4ubZpnvKniIhpg/LpwkxR7DgYK7GD0=;
        b=axs6ryHJXk5TQYWk7R/Kyg7ny8VkbnGVt2IMpuKP+V1GgNsSGWpN+ue/l9Nyj+51y0
         wjAb4BG/0bf+/7K9LZoKW4RX8Sd9AZKp0p/zQT/2J1RwB0v8WaChdzz6xdmDnNHB8NFb
         XflIkk+12f6sjmwKEEBieidkOqqOq0zP1SqYURMQZapvHnGBQGmoR6jRehd+bsoWuko7
         aEgVfP8DHKZIFPkkwz3C2lMfeLQkU2yGu+jXBqRumu79AlpzHTfWvHHocRu0ANszj/rC
         3EmmuDlsxwF6Ast3ADIWIF+GTMWbP+IWfSlQr27xmSSrGqUOBizGgKp62iJDdQbrrt45
         yhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515186; x=1775119986;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDXG9M4VD8sbt4ubZpnvKniIhpg/LpwkxR7DgYK7GD0=;
        b=rW5Cbp8f3moLDqGcXMRE6laIc/p3KAecZc6W3DT5XoE4Xcc7Ute2fq51BpypJuvc67
         +t+C7/siYoz4RdVl8AypqOcTay+V2gBkRyvNM9r39+Vw15yPIj2aaehPO8jEQdwqVtyp
         uAwgZn3QAtK6+Ag9r5PZfsrGb/8mVlElFAvHCLuJ350Xsy5utZkzLToZmiL+hGys7KFb
         ZS+nqHO5njtMX7H67GDOg2CLUkrxrqxibLXgtlU/yJi5mpwSQOS1MbuIpnFFlEbGCu8O
         pd5Sezvivd9O71IFPgiAMcPfxaqiX6fbIo1R0jiSbRaP+gNAIkVTZQOsQ2fcbsD5MPKp
         FAoA==
X-Forwarded-Encrypted: i=1; AJvYcCW19M5LCHuD/RQ0iWSSw+t9p4g29l0wHLFG8myBF+uDMnXnq0Xa+3HPV5WDfW3cMK+y7OPUsFZ/0Q7K/EIjAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpcyejZPiHd655ZXTkLCIdhgB3rXfdgvgz6gLBp1vZGhysM1B
	38pKGIAloj+bD01RbajzRk9ItWs/y6PkcTaGoNJEnIqpn+Al9eGWeCjrGcWVle7amUE=
X-Gm-Gg: ATEYQzyqs1CZcH7S1kEltm2LJOxmfCmftaWqrbcO8AmdLoJ7uErqzPMIxECkaX0f4Wl
	R8VFSunz0jOKFF8Hoq5aaUNgQ+e64OhKCKb8lrojT0/34kWE57gf2hw0k9b5HmYmqQEzqlrltBr
	T9Z90bXT40LSND/VPZp5OwFIqtzM5O6dP9QpXnjTLegTo9nvLNKjeVl6/jBohy/GEHyYJSAqBlx
	720A1BPBBEjwh7HUQsDDDorYGmj3duKnHZePzZ7Hq6S0szw2jxhjWI3UUSAbNikR8bH0zvkea+F
	6tAW/vG4GQZP3xUMumqXFkwIUAV/NR3BP+Texr/YhbOqSU/UJeWsOBZHxggyDKQHhFD29Cxnnb5
	rpC5oALqGD9J6w+NAJLGUuMZbNK2VcuvTI8L2wY8GMUx8B8K/K/qRDnOamjkXPkAWl368ghBAUN
	50TQKFhHQkQcldTBNKgmG6ljywSyQghuFvv/uapUhdiFO/ZdQt5pTyr3TPRQf/+D8sx4AzlwTpA
	9oOgdw=
X-Received: by 2002:a05:600c:c490:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48715fc7437mr97262695e9.1.1774515185800;
        Thu, 26 Mar 2026 01:53:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e708asm5819184f8f.36.2026.03.26.01.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:53:05 -0700 (PDT)
Message-ID: <d39c0e43-8c62-4a41-895a-5384dc365c2a@linaro.org>
Date: Thu, 26 Mar 2026 09:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/9] arm64: dts: amlogic: t7: Add PWM controller nodes
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Nick Xie <nick@khadas.com>
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-5-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-5-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33926-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RSPAMD_URIBL_FAIL(0.00)[0.0.117.48:query timed out,5a000:query timed out,5e000:query timed out,0.0.226.144:query timed out];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[pwm.0.0.125.0:query timed out];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6AFAC331CA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:15, Ronald Claveau wrote:
> Add device tree nodes for the seven PWM controllers available
> on the Amlogic T7 SoC, using amlogic,meson-s4-pwm as fallback compatible.
> All nodes are disabled by default and should be
> enabled in the board-specific DTS file.
> 
> Co-developed-by: Nick Xie <nick@khadas.com>
> Signed-off-by: Nick Xie <nick@khadas.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 63 +++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index eb09a26bcd0e0..581cdaebfe637 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -511,6 +511,69 @@ sec_ao: ao-secure@10220 {
>   				amlogic,has-chip-id;
>   			};
>   
> +			pwm_ao_ef: pwm@30000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x30000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_E>,
> +					 <&clkc_periphs CLKID_PWM_AO_F>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_gh: pwm@32000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x32000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_G>,
> +					 <&clkc_periphs CLKID_PWM_AO_H>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ab: pwm@58000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x58000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_A>,
> +					 <&clkc_periphs CLKID_PWM_B>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_cd: pwm@5a000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5a000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_C>,
> +					 <&clkc_periphs CLKID_PWM_D>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ef: pwm@5c000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5c000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_E>,
> +					 <&clkc_periphs CLKID_PWM_F>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_ab: pwm@5e000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5e000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_A>,
> +					 <&clkc_periphs CLKID_PWM_AO_B>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_cd: pwm@60000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x60000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_C>,
> +					 <&clkc_periphs CLKID_PWM_AO_D>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
>   			sd_emmc_a: mmc@88000 {
>   				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>   				reg = <0x0 0x88000 0x0 0x800>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

