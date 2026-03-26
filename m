Return-Path: <linux-wireless+bounces-33925-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIycOsD2xGmC5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33925-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:05:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC6331E5F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E60130347AC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9C3B960F;
	Thu, 26 Mar 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Se+QCkHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF7238C0D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515177; cv=none; b=SN0XOibxPNweVfQCgn4IinLZRtsdrIuV66PRS13SE1DcwtLHQR072zdu8SBfFeQKbUYmoCrNFnzH63tU7KtMdZ/3YXLsLv/5b9Q5vYybuaJy5nckhB/ZLgSxB25HNCaO7UTSDNi2vQPoLnO/ODTy9EKCMeppFCpJMroILDWkF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515177; c=relaxed/simple;
	bh=1TFlh6vX9rIf+AI3Yi6Yz4mnrOkBXxXUYpjspg6Jam4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kTEHVILjj4QN1RHhi2Ix0gFDQMGrTO7iMoTO6Q9/28+XBNpIJIRlFWLVEuhlxPxS7BgKICIb7JVLL3EEALRVhKtqBTtzUKm10q80RyURf8SfXDCl0lCdp8AVwkSsiP2W6g2xPWDd1nFBp09RETVyI4B9sq4EzhmfAfbMi/2AcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Se+QCkHp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-487012ce896so4112685e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515174; x=1775119974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alkbuVKROditw0aGu/OnnUsWfxL3CtIz8SG2uW8L1eU=;
        b=Se+QCkHpvRTw1iYGVrCu2wDTR8CVJHWaaflMNuMgVvu9uc/HzMRfz7is2tAbcRGBS5
         IgeUCKCGcBT2mv7mU+/3UXh4unqw+9KGg5nrCSl0IZl8l6Tp0qhXCuHgfO3b310n5SbI
         rmOT8FJWELPRuyF8S0909JVSFf/I7o050/xmoVDoGtl8bER7cvxYwkJJVmb+wfxAG79C
         3AhCH3SI1sqxNQrosTH+eWGj9xnJaIa1wgZf1oMgIPsbl94Qg078Q52oHUcN24dc0wkF
         OTqGxfWu+ZmgidGWSH3NOaf+/ctPPWY6s7r5WCbTHf1PUBeVdiZc97p4EGh1azw3ZjP8
         V9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515174; x=1775119974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alkbuVKROditw0aGu/OnnUsWfxL3CtIz8SG2uW8L1eU=;
        b=sojzDHtz/v2f15R56/22OzK80QUeyq8wMMczQePiUImm8VziiAxWKVHter8KGZnGd2
         3OWzVETjfi6cG7n3uWe7ATekizng5i3T17gwNu9UP/ezalUSK4X3nD3Pat/rZFq9ztai
         ZwuggLUoXGgamaFUq0ejeh8aOObUXdbxPpYrydYWW1PvrnhJOu+asw4uAbglV/+4ZkEb
         UT/HtWLpz7lnhpCjNBLw0jNYADcZv5V0CqboZ/ucFzYpEIZeqo9abO1FIXSPwtdEnC9h
         +h5G3HD5iQthFf+X5+dHwGYUIhgATPo/8tWjcGSuQHsHcN/JvIgUxr/hdqmuYGaYa129
         Qk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUanvV44NETlXl1oOrlV6l2gtIsTQ2vpns/Um3DlYQsf77+qZp1scfkXYsHTSaS02o15eecrEm053DptrGqOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe23D1umIjjtygcwOIU4IZ5U4STvNRLvGh/Abk8r63rsxrBSmD
	fkVmmPh/W5wYgUiDCGTHW6sUKtHDfg7vqrM1p4Z61Vp38SiCrhoBKOIPEC4S4xKWYbY=
X-Gm-Gg: ATEYQzynASh8s1cgUHOFsalc7soDGHT0FVJHhyfn98/QKtuyp0ji2sS3/6iDoK+xe8R
	7VtRJ0KsW+dEHaEWFu02FQRGVkAfVdc9uTXNi3HSmfhgJUc3ri//206zBwc+rG5HroXZ2CfZQyR
	q/FIfkkfziTunBAGTr8Qlh+Clky8twOR+N6vqypl709OKl1tY39QQI7IWprjonQmPTl1DWLNdMn
	rbnPkCZPOEUyhk+ULwfyuhkSfINnKulF/vqSz2gloO4rPknJ4CV/93CobeeUwDBx5EVTw1+u2KQ
	7IRlkVJBjxsOxk4ZyRp8N0W24ADSuLjGEvayszCjZUOa1wXgSDMqACOizjuGyYogruGoi0A+8jk
	sB+5mL+3cRHKpUpyXTrE+s1JrDMUPbDcjro3dfFsdHo5SiFNw6R7VdNNL8xIu3hP/88hBlKsZ8K
	swL1h8o0NkkvLqVk1QBG0VIDyIch7UGTveaEy0+dchpalcAKn1gChp9PCkMteALNyFClnnGESdh
	2BnfNI=
X-Received: by 2002:a05:600c:4ed4:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-487160083f4mr106443395e9.15.1774515174254;
        Thu, 26 Mar 2026 01:52:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9179b212sm6621276f8f.0.2026.03.26.01.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:52:53 -0700 (PDT)
Message-ID: <7c207f00-fff3-4506-858e-db7dfdc32ccd@linaro.org>
Date: Thu, 26 Mar 2026 09:52:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/9] arm64: dts: amlogic: t7: Add PWM pinctrl nodes
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
 <20260325-add-emmc-t7-vim4-v4-4-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-4-44c7b4a5e459@aliel.fr>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33925-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:replyto,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliel.fr:email];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 58BC6331E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:15, Ronald Claveau wrote:
> These pinctrl nodes are required by the PWM drivers to configure
> pin muxing at runtime.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 136 ++++++++++++++++++++++++++++
>   1 file changed, 136 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 62c87d0ef7065..eb09a26bcd0e0 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -307,6 +307,142 @@ mux {
>   					};
>   				};
>   
> +				pwm_a_pins: pwm-a {
> +					mux {
> +						groups = "pwm_a";
> +						function = "pwm_a";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_a_pins: pwm-ao-a {
> +					mux {
> +						groups = "pwm_ao_a";
> +						function = "pwm_ao_a";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_b_pins: pwm-ao-b {
> +					mux {
> +						groups = "pwm_ao_b";
> +						function = "pwm_ao_b";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_c_pins: pwm-ao-c {
> +					mux {
> +						groups = "pwm_ao_c";
> +						function = "pwm_ao_c";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_c_hiz_pins: pwm-ao-c-hiz {
> +					mux {
> +						groups = "pwm_ao_c_hiz";
> +						function = "pwm_ao_c_hiz";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_d_pins: pwm-ao-d {
> +					mux {
> +						groups = "pwm_ao_d";
> +						function = "pwm_ao_d";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_e_pins: pwm-ao-e {
> +					mux {
> +						groups = "pwm_ao_e";
> +						function = "pwm_ao_e";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_f_pins: pwm-ao-f {
> +					mux {
> +						groups = "pwm_ao_f";
> +						function = "pwm_ao_f";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_g_pins: pwm-ao-g {
> +					mux {
> +						groups = "pwm_ao_g";
> +						function = "pwm_ao_g";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_g_hiz_pins: pwm-ao-g-hiz {
> +					mux {
> +						groups = "pwm_ao_g_hiz";
> +						function = "pwm_ao_g_hiz";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_ao_h_pins: pwm-ao-h {
> +					mux {
> +						groups = "pwm_ao_h";
> +						function = "pwm_ao_h";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_b_pins: pwm-b {
> +					mux {
> +						groups = "pwm_b";
> +						function = "pwm_b";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_c_pins: pwm-c {
> +					mux {
> +						groups = "pwm_c";
> +						function = "pwm_c";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_d_pins: pwm-d {
> +					mux {
> +						groups = "pwm_d";
> +						function = "pwm_d";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_e_pins: pwm-e {
> +					mux {
> +						groups = "pwm_e";
> +						function = "pwm_e";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_f_pins: pwm-f {
> +					mux {
> +						groups = "pwm_f";
> +						function = "pwm_f";
> +						bias-disable;
> +					};
> +				};
> +
> +				pwm_vs_pins: pwm-vs {
> +					mux {
> +						groups = "pwm_vs";
> +						function = "pwm_vs";
> +						bias-disable;
> +					};
> +				};
> +
>   				sdcard_pins: sdcard {
>   					mux {
>   						groups = "sdcard_d0",
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

