Return-Path: <linux-wireless+bounces-33924-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKGXG4j2xGld5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33924-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:04:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DD331DDD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14E6F30CD5EF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769503385B2;
	Thu, 26 Mar 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8aoUrOv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9619346E57
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515167; cv=none; b=vA8XBwhNKuUmNRwetYrBzr7lSyz66Ti1h3pp5QkMIXzWviJkC86uLx6zTeqnLZ5a2Usb8+TK9ARsio1+dTFOxTe4cXbzjVrX818OF9yi7ASYdY0+s62kDcXiQ/WacdY9bVHXVRKSkzMLliCgKAxclkDsaLguBpn2x1kKRyX/ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515167; c=relaxed/simple;
	bh=mR3j7kj7vROwQ5ag8Pn7MdYIgcgh1ubte3V78Ak4zlc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YQXzOvmzjnP1JFV2Ys8Jnw1Xap2n1SZ/sFlmVqCJq9cX1q1x1aTd7KpD6E9wgCrM8e/5DekHHdRZVgtPzBg6zrs3wueojiDvyIS2XgHEhBZFAiUYzq7oC3EgytZ6oLpN/1S4mOI9TNxZqa1sXA6bp2G/6ptGAoHOQ+HtP9JZs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8aoUrOv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1333847f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515164; x=1775119964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmPvkIy3tf1J6J+2oDH92ejHRFaN+YHsg5wdlsi6hv4=;
        b=o8aoUrOvy7H1Zpb/oLeuPGFh86XcySAajaA70S3i8O7JWQVtQwyviaXTrf0OgggFlA
         DgatDn4/e7wL/JXUZbEKULev0QX5WCJi2XOjoFPzhEPwsFJvyIHaLBXzIcdcSiOZxwpQ
         QWOByI0zjQilZyxS/5o0oL91VItMALz9w1rYyNZnEUurPrBoUDezXBH6M2UQ/MEvVBK5
         h+MIkRptd3cfuqIfTeK6V/Mj3JfXAC2PgVdrH1fyPPNB7jLldtbG4Uz8cSQRqdV+s9T4
         FSCoMqgUTK7myv58P4+pcMAChx7XMLOsp4TyH9T1jgxbbfS3ob68KFgp2XloRQnLva0Y
         hQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515164; x=1775119964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmPvkIy3tf1J6J+2oDH92ejHRFaN+YHsg5wdlsi6hv4=;
        b=FsM8xmSWGiUwI1YANkxDR5vX788q6699khdWvCaHhglfnOx8imlbAGwauSEftsAiFn
         rKZxnAZ5Q1/d+NWPOzXHrYxereujJx+bpR1pXwN4Baj3uT3hepF/BRwo2sZu8KmotGl5
         dRO0YzPzShHI2aZ0A8RR+syF+SqoCjsHdiwDSUrhc8GAjV8D/ypryxyEMDBRoqYCFy2D
         EbnhOlDL+Aj5Fcu4pO3Cx4tN3LjrLgCeE+zesid4Ka/w0K58Ck4TNlb85qrrDBLyIL2+
         /zYBzvgKTgGePAaHPYrjMsePkEB/wTmJREYhnsn8UOa6pvCJr3vlKKwrv87QtsuNZCWx
         mOdg==
X-Forwarded-Encrypted: i=1; AJvYcCXZwifAYyBn5jenimmkeKaSyycCdrxXz+7D2Wta7gEVRDsRD5SB5vfLAdG/C0HVbb1uqhiSi5DNGM+us3gnrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIvUcgzCmtxInOOxDMSxsbWTP4xDrBmMJdCSUG0oIbnC9LrgH
	i3bSsEV+zEB2E+ILH6cgRycXd01N4YPwrJXuYOzu3u7zTLQ8ytr+e6AXy2OUl/OU3tQ=
X-Gm-Gg: ATEYQzxltu7mjw5OnwMsVlDhGrtTOBF0TSgwm0GRnGcdyNM+r+nZ0jR33m+D7Fyug1A
	fAwjYNjHhbAMiBBuWm+6YcZODqcLFxya43Lv2XYVOKF6mR9aAjekufZgiRr5Yyd2b7w84L+9frt
	aI9TNiMMf3WSNKDdSeQhNuhkX2Hc3tceuJd1tiqVXVTtZp0hBtWKYVyIszu9YYOoucweQDdwrEV
	fngTYUpgz4jdj2+YKFnd2/uAyQf6UXZKqX5b41ss2nAUXQsT3J1OPWT3ifFNEe/+63/LbaDB+FE
	KC9Utl6duWRgx7h9r+XCuQ803yfLri2NqEUKP1bLEqyEs+0tm1qT3RWbVNkLN8tjnWfKSmXjgBN
	XTz67xQEeIXJ39vnAlX8HHgUy9Q/+vpE6VMjbvmqci2/quOL7kBEW3GtigLrmUZleJbvt8yhE+N
	dTLSh5uejRch9iaUvb9erPEwcH2WKJyYMjxokhAjr9YwNkBT+gKcrxrqWRwo9RUmSelP5iz/ze9
	FxFWI8=
X-Received: by 2002:a05:600c:4e93:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48722bd529fmr12331585e9.10.1774515164267;
        Thu, 26 Mar 2026 01:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm36907265e9.11.2026.03.26.01.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:52:43 -0700 (PDT)
Message-ID: <4b2ba22d-7d0b-4c71-ad83-46d198718fec@linaro.org>
Date: Thu, 26 Mar 2026 09:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
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
 <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33924-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:replyto,linaro.org:mid,aliel.fr:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,8a000:email,8c000:email,0.1.87.192:email];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.0.39.236:email];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: A77DD331DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:15, Ronald Claveau wrote:
> Add device tree nodes for the three MMC controllers available
> on the Amlogic T7 SoC, using amlogic,meson-axg-mmc as fallback compatible.
> All nodes are disabled by default and should be
> enabled in the board-specific DTS file.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 39 +++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 016b5429c8d1b..62c87d0ef7065 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -374,6 +374,45 @@ sec_ao: ao-secure@10220 {
>   				reg = <0x0 0x10220 0x0 0x140>;
>   				amlogic,has-chip-id;
>   			};
> +
> +			sd_emmc_a: mmc@88000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x88000 0x0 0x800>;
> +				interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";

move disabled at the end of the properties

> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
> +					 <&clkc_periphs CLKID_SD_EMMC_A>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
> +
> +			sd_emmc_b: mmc@8a000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8a000 0x0 0x800>;
> +				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
Ditto

> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
> +					 <&clkc_periphs CLKID_SD_EMMC_B>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
> +
> +			sd_emmc_c: mmc@8c000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8c000 0x0 0x800>;
> +				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
Ditto
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
> +					 <&clkc_periphs CLKID_SD_EMMC_C>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
>   		};
>   
>   	};
> 


