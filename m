Return-Path: <linux-wireless+bounces-34172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE0aKxMuymkA6AUAu9opvQ
	(envelope-from <linux-wireless+bounces-34172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:02:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6B356D3C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9260E3047409
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D73A6EE7;
	Mon, 30 Mar 2026 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7D0YxSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDD3A8737
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857334; cv=none; b=pKNhBr3eotMI4RUrcuwSpsh/Djdysc3ktcaAw4+0OZFC4ihiZOKR+T87qauL+BgugVtlzEIHv/bjNlXXPUDwUUiM7yMGkRBUiMKMlLfAhCMqFg3J/KDOKGAbuIizJG+USsrqd7MHmxmCpUNY0xo2fO3pk2H2atL4R14GS5S+sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857334; c=relaxed/simple;
	bh=MPDWBPm36fsWmva00EjlRjN2FTdNLYptQaxhTf+7Fg8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hx0vmA3IO+i1oyNoaynnBIB6Je43f+MEK8mz8m0G//ZTaVs90k88JjHetv/W6zarppg7POiInY6rcSAtX0bR+5aVuT91SqhmVPfE1uWOgM1fj3zwR0EcageiPw9NCp8wc4JeXe07CqCtBcaK3CbufrjYhYLTeD8Eo3pUmDbjLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7D0YxSi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso34976405e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774857330; x=1775462130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUItjZv34EZ10kX4LACTE3wjNz+JATlDo11i94BXg48=;
        b=D7D0YxSio7A4uSaBe30ZDn2zK9/eMSYJn+lo+a1N32wH0m0Tc3AG0xavE23lwL+sXo
         SktKSKq6PdxQz8dnJ2QZG7e9b4uZaMTvDtgk4dLzW3aJeHsWd7wVtEzKlyvHhOY8Alrc
         TZgJksYCX50uVaJ34GzXmi8+VHo+o9m8EI4hu/tD6ctmvsgpPCMo1JkHoZlhcYaC0WNO
         eWmHojJd8TMP+3+5+32WAMSHxHs1Ew3oLFdbaHg2Pz0vXxdgCv/j07oU08V9x+m9WbQh
         JSc7myNEoq3kPyKfp+TCGs49uNJYLYPPyHIANwryONs+d9RGqq+zKYMijnFWlgb1vPgH
         wx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857330; x=1775462130;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUItjZv34EZ10kX4LACTE3wjNz+JATlDo11i94BXg48=;
        b=bEVfpVJd9pZ/1pELYdn8bigToYl3G2uSfNojzbR9GG98KIwtf3v+HBrVTFrkAd7Jwc
         /4ljHIeITbIo4JZCv5jD9D1eZLZyPiq/X19Sbk8HorD5DerrG0r6rHsEz/QyT8NZLXTI
         Y5Py1iEVuXSdy79+tPmtPXm51V0EZUaX/vojnj81lUCi3cG+QfbJnV4nTvPYN6LI+hsW
         JhSNNrq2PN8kShO6BJ/SKtIZMwAWOSSKPGQk3OpAaCwDs55G7szK0UPtSQeN62ujAHBi
         e9aE/7BtdyQUbgSUQcnWHtOgufAdf0HSx4I8EabxJwkz5taC3xnGFTyVqOPyg841LjgM
         /3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9JBe51dY6QIk079oB1N6NZfx1Wqa+tqWPcnrOQfkwGKlr3ayFuiAOlzKXlkhnJ/3B6ByPP+YqbY8yGy60w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGo3MqIund2zSvEFhd1CxTMq09rSE4jrOHEOLgRu0xX4L1hCJI
	sJrhGNps6+hXZ2r/0cgWgHLNTXl7H1BWQ5AIbGun3nS4NCboTbAM3PJobM7a49SNGrQZA2RjPqV
	KRcj2sew=
X-Gm-Gg: ATEYQzwGbqXrqTI3Ys2HJz/looY3WeaP86crvfPG5r8IK2VrLG6B2falvFn0YFxD/B3
	n8Y/qlaxZsz6GCu/KnoaWSaKpEVOHd9cAhZcZ2YJCHYRxgMMequbJaEp7bMnA+WrKHE9C6nJY16
	9XOPmGIvLyhpgFXzrS9fDYD4eO+Sylv6Qnq6cx6oVHFnAQzIMlqo/Us81ifLQfO5fJ7H8y7xgbb
	KjMvOPD0ZKAaqNll0OKJs+aDT3Xei9MkqUrz0LS8+Qbio1v9oocZO8JDynZ7+kzHqN7ZLMRmjQn
	De9ROdVHgn/7VCvo1xdb0gUfT9sigFwiH5LO+wYC9mchthjV5uJi9AiiQMB33eOfA3voab/oHMT
	vLnSU/hLhIph9PU2bu7Pv/CrAvrUts0uvIiQOB90m3JtpzuLN2EnSSylFvNmrR1mcXp8m/gCrgY
	EwqR0s8I4U/D8h0dLrBk0ffrXM+IfcaLvq4jmwy5jd6/+Et3f1NtTaNaLrd5x69w1qF5TKPAcHr
	O0Kbu4=
X-Received: by 2002:a05:600c:4f91:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48727eda62emr178938295e9.20.1774857330208;
        Mon, 30 Mar 2026 00:55:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0? ([2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48735faac9dsm60393575e9.0.2026.03.30.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 00:55:29 -0700 (PDT)
Message-ID: <416d42a6-8d99-421c-91aa-e705f23576e2@linaro.org>
Date: Mon, 30 Mar 2026 09:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 6/9] arm64: dts: amlogic: t7: khadas-vim4: Add power
 regulators
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-6-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-6-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34172-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email,linaro.org:replyto,linaro.org:mid];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 76D6B356D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 10:59, Ronald Claveau wrote:
> Add voltage regulator nodes describing the VIM4 power tree,
> required by peripheral nodes such as the SD card controller.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 90 ++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index fffdab96b12eb..2450084d37642 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -6,6 +6,8 @@
>   /dts-v1/;
>   
>   #include "amlogic-t7.dtsi"
> +#include <dt-bindings/gpio/amlogic,t7-periphs-pinctrl.h>
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "Khadas vim4";
> @@ -45,6 +47,94 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	dc_in: regulator-dc-in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DC_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	sd_3v3: regulator-sdcard-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		gpio = <&gpio GPIOD_11 GPIO_ACTIVE_LOW>;
> +		regulator-boot-on;

> +		enable-active-low;

This properly is invalid, please send follow up patch removing this,

Thanks,
Neil

<snip>

