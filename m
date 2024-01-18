Return-Path: <linux-wireless+bounces-2210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47206831EC3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D2F28780D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679592D628;
	Thu, 18 Jan 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbJgbhEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB62D605
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600250; cv=none; b=XHqZ4saKrrtsCy+UxdvzUOPsgIJ7y47GwIZXuuTu4uhaDz+rNqC0YEPYKecD20nMZyPB5IMnKsuCQ0UUyJgp4PBXC0FhOmwyoIQncGsc23ZUCeOW92dDKTmqaHatuzp5q9LPObcAJk83ZNonKd8r1o44yI2lOgCWE4I9desJJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600250; c=relaxed/simple;
	bh=R83s/PyF4fXUdK67JiE75Dz9JrojGyAfOWEwxObSVV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPeNGteVZ5Exq0Y/rYwNRkNcRAxy6K8qjVAMEVXAGH+1Shy/iKm31FPa84aoqudA//i2SzSgJAD19TTmHiXlzQXoszZv/9+n5ivfeEDeffRFODr3W/x5ZGeHx39TQCe+p5DY8B+uO/ZIpfWM6Y62iDDfBuAo8J/3TSz5tLt4fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbJgbhEn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e759ece35so14780981e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600246; x=1706205046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeOfVhu/YQjuPaBL7HLOFJxylUSZb5ghXwEj0tH+VbM=;
        b=LbJgbhEneDdeNqOEmRiGt3riWuUBUuVlABZyUdAdZ8O0LkDxG+pAu7QNo5YAWMjpL3
         eY6u86tWGvrLmk19X0D60CGMwpgspuFzxDdL+RbFND0sd11IavHXilYeBR1n/BWmS7QA
         0obftDJl+9tRy7H2hcPydoykwQqlWTulXDus5CGoG3164YX20SfYCCS8VGrVFKeRega8
         t4pXISDeLwMhi63Etq20aBuLQx+muYiJLWGJtutwJKIjANPa6R/YcMBqZ8PSCKs2nK8s
         hc/mnuhYw9ADWkRf9LojrWc9shl2HeeJfJ+HaJY5D7AEri+CrT1SdGVGusGEMv+o/LY6
         oxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600246; x=1706205046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeOfVhu/YQjuPaBL7HLOFJxylUSZb5ghXwEj0tH+VbM=;
        b=BaKFbfOKNt01LOxLtYoI4q1L/kT1n+e2KkIN9pUuNBTWkElpDZk0/CHHcmi01G9V3d
         EjbMpLhYTyWmXCIAkjqKShxnr2fKXe5neGodN5EfHd1p5THlvCT3WUmiwIxXnTU9Xrt+
         aciUrmoBj1GSzNASjOyikmDiTtQR44bAmn8XIekVWpQzGBfzKlc1C3l2zEQNW4eypGsT
         7J/JObg7hFcQR2nGxbIlM/7/TPAj23Fzf7ibwc7Sdj9mj62M/CJaG+oz3BRZuGmsNDo9
         mKVIBsrQn2OXro8fCExGgSl6strqWPATptzWJUjnQgEyff4LJa+x8BiOL4DrnrGnze+m
         UhcA==
X-Gm-Message-State: AOJu0YxvXSp2DBf7YkmpW9BM/pGM9dK/EZBo+nDeZ0NhYzuUEwNGYWR7
	46D/+rKaFb0RoGfuyeXhRgtJoiQUq6PVU2jIuySHArTeNUKIcLmq/84UUpx8Jto=
X-Google-Smtp-Source: AGHT+IHqhtxBqUtdwqkS5/LYHeL/ekXGtb2Jn3Eqr4OlemBLU7YUpfw9MOxkxxvtVnMVoEQW1MZhFA==
X-Received: by 2002:a05:6512:31ca:b0:50e:6c1d:5dee with SMTP id j10-20020a05651231ca00b0050e6c1d5deemr7487lfe.33.1705600245837;
        Thu, 18 Jan 2024 09:50:45 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm718900lfj.65.2024.01.18.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:50:45 -0800 (PST)
Message-ID: <ed2dddc6-6461-4a2b-8491-13955cbd80fd@linaro.org>
Date: Thu, 18 Jan 2024 18:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] PCI/pwrseq: add a pwrseq driver for QCA6390
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-10-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240117160748.37682-10-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 17:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power sequencing driver that's capable of correctly powering
> up the ath11k module on QCA6390 and WCN7850 using the PCI pwrseq
> functionality.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [Neil: add support for WCN7850]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +static struct pci_pwrseq_qca6390_vreg pci_pwrseq_wcn7850_vregs[] = {
> +	{
> +		.name = "vdd",
> +	},

Weird there's no .load here.. On Qualcomm they're used for asking
the regluators to enter the high power mode, so it'd be useful.

Konrad

