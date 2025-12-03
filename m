Return-Path: <linux-wireless+bounces-29479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C9CA1B8E
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 22:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1498D306B528
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028332DC339;
	Wed,  3 Dec 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O2Z8ZpuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169332DC795
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798453; cv=none; b=mKncGiOwubPmrDUkJHZGdPWccTY4awaOS2a/gWqngUPooyxhbXmoF3nV/D6Hmyd/398SNLdEITJb8q655L3hMJpZxNrbXiiIkCENVwTBkPgXz70BuB2hzxAj6HJ9G7x6ZexbrZByz8EWgBNL//Mas2SqL3Kl5qEzu9IXg6nLGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798453; c=relaxed/simple;
	bh=VZVdZ44lA0brLQX2RzHeYexOKxCAhiFjKkt9kwiarbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpNNVWcXOx4vbWvDD0IIcA2ymTKMtTBYr85eBjfXlQ33z2+Za1ifKhbQqUp/frQtQCkZtnQZ5S7AQqu3mhn92tK6pnumBUWrWDwy9wNOT37swJ4cVZ9632RVm9lh1bGix4vso2dqqLdzd5HVCEDjHL2srrMxQd7d6yw+f1mTnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O2Z8ZpuV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so205140b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764798451; x=1765403251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qKeGTsD/DT+TUGUNxy2VzIns/N4h+6YktbT6beUiGo=;
        b=O2Z8ZpuV8ycxjwkA+pLMJWenMdQAb+JyRRa6UxvQmtSp6ROtIaJ6plkjItzBou7rjJ
         MN/Z/vt63WKG6WLo8sXOssSFEn6LOtzH8LAj4mD0dMTG1CBvpwhBRgq7KlIlSdvxbS61
         CIyzdJRXWPjHAbknQsTe4JAFiPvS3+EBYP9Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798451; x=1765403251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qKeGTsD/DT+TUGUNxy2VzIns/N4h+6YktbT6beUiGo=;
        b=pxAA3pgqQreCnt4oeUVuTCB5jBL4Cvhl6hlW6hMeqjEO9wAe3OKUVJGkZHRww9uakV
         KGOMhGke6wsUB4MwugCF/DVWwYBanTR8x49R0oQMb854Sk8qhhnBqTO8j0wuCkMvGdZY
         G0ECbvJMGxgNsWCIvxgQwLfI4en+5bACOqHYGsiOczQInHeFT9gvnrwE9G+7+F4QhHed
         Z8fa6iGfoAasZFhH7y6KVLtWUsx0ONw4JTPmFqCJw33z/T5UG5dYn5SH7QNzCN6Ms8Dz
         REZmb1BrXNwe4U0lOra/WuoomuFOBQFFGORAP/V8kFVZ47sgckKGs9x6ihlVWSRZ/02I
         LCfA==
X-Forwarded-Encrypted: i=1; AJvYcCU4hs4mfm9IolcjLedlw3U65P5qnzLWgFo0mrWe8CWkWg+vW/z7Oz7ahsM/nUzqeI5rGc6LDjP1mXuKEnsraw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4m9TbZCSWo+I/rpgdvC4dVS5xG9MN86w3Q/Vm5lAZ7Cp6h8gY
	exvaLIk/SrjEsfY4/4+ERYInw6PSSjO4OkoV/SgUfjXcewVE4vFKrrnGKklDDvsfuw==
X-Gm-Gg: ASbGncu4Q0H6v1R/VjbsYQIud554KaBDMKdDr8frN5+Tsoh8dKl2dra58TuTeLfM9tN
	8Ju8D7EXLJXI2PXhNP8SBQE1cAKI7E4aQrfoNbT+mWWA+N4SCC/yA4ezNRiMhP/ZjFnRVUeBE3E
	K4eILDQrMJ92EvTqml/otjL8ziqpr8aCzDLefglSTyc+YppXvY72/KJb5SY+nihhngyFgzZnSpC
	q1lBk3QXMYKhC0M6Bj0gDarV5SkBW/G9b5nOias/zuL37lMlSZ6lRmItqPSyaEAQij8Msba01Sf
	xw2c2UulODi7p1AoFJp4Y72M2vyKFTmBjZrkTFqsXRBN4PBMgeQgkP50IslsrNPxmwQjppkngNq
	L1pPZt6w/fw7N4SeeMXgCWJ7KP9zhJU7Uf61OV5vII2/Gk2i/Sp1rX3SVL5nYRJwUfIBBIoKXuu
	xpniblTI3AqV18Q2YooaY9KkTy8StK4QG0R9xEZT9kT1UCGUOaqQ==
X-Google-Smtp-Source: AGHT+IHYOL+UBYAVNBaexNp51zLW4j5ZRWtvPK/36fgfBgTEcmZyfDLkwf8DPOCYg9Guqcci0ODQoA==
X-Received: by 2002:a05:7022:63aa:b0:11d:f464:38b3 with SMTP id a92af1059eb24-11df4643926mr1543335c88.2.1764798449474;
        Wed, 03 Dec 2025 13:47:29 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcb04a07bsm88741033c88.7.2025.12.03.13.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:47:28 -0800 (PST)
Date: Wed, 3 Dec 2025 13:47:27 -0800
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts:
 samsung,coreprimevelte: add wifi node
Message-ID: <aTCv75hjdX5XvgCh@google.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-5-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026182602.26464-5-balejk@matfyz.cz>

On Sun, Oct 26, 2025 at 07:20:41PM +0100, Karel Balej wrote:
> Add a node for the phone's WiFi serviced by the Marvell SD8777 chip a
> communication with which happens over the SDIO. Also enable a regulator
> without which it is not possible to connect to networks although they
> are discovered properly.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../mmp/pxa1908-samsung-coreprimevelte.dts        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> index b2ce5edd9c6a..36d6ae4e902e 100644
> --- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> +++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
> @@ -475,6 +475,14 @@ ldo14: ldo14 {
>  				regulator-min-microvolt = <1200000>;
>  				regulator-max-microvolt = <3300000>;
>  			};
> +
> +			/*
> +			 * Needs to be enabled in order for the WiFi to be able
> +			 * to connect to networks.
> +			 */
> +			ldo15 {
> +				regulator-always-on;

Do we have a min/max voltage for this regulator?

> +			};
>  		};
>  	};
>  };
> @@ -523,6 +531,13 @@ &sdh1 {
>  	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
>  	bus-width = <4>;
>  	non-removable;
> +	#address-cells = <1>;
> +	#size-cells = <0>;

I wonder if this should have:

	vmmc-supply = <&ldo16>;

rather than regulator-always-on above.

Brian

> +
> +	wifi@1 {
> +		compatible = "marvell,sd8777";
> +		reg = <1>;
> +	};
>  };
>  
>  &pwm3 {
> -- 
> 2.51.1
> 

