Return-Path: <linux-wireless+bounces-2122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CA830C8C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D90B20DD8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70022F05;
	Wed, 17 Jan 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNQUQPyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856422EFD
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515420; cv=none; b=cWiMJNsXKa6v2majJ/VSiJATJVQqwfH7g5lXJypgl8MmDggmm75cS7xoAuY7/44HDEiqrJSY9whUo78SQlsrgcyDz5jlq3OdyVPnleKEBgzmERpRt7jTjMBpQNjl86Hv/Wk3VPj1nDgUdjOw4oSqwy/gob0qWC6h+yz8PqWo3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515420; c=relaxed/simple;
	bh=PGA5XF8apgvFZl5vCFekKzJo49ntitv3Oa87Rh9Ojwc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=poaM4mNRNkRF0PKpE9TRAFztE6PoBaIozfuoWAK3DvBlOt6oqnP5u5TIFrrE49aoaovAQKYZugdGmT+ur/zhqRpqFY4h4BSdg6+21LDVz/jpjuaUVIj8tmpB5ISHT3G526c2x7dtGsuIpZ2GUfz8NMHlYHF1uRVFZts14ttgZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNQUQPyK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso116100697b3.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705515417; x=1706120217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYLeQC5slfCvWFFzPxrebDUGGj/LueNwDEYL/EBPrAo=;
        b=dNQUQPyK+W6ldPQveER0dtG/y4QgWv/W5nHYMKVIRW4PjU4JL4MR4andbSP2PrkEpe
         0ZGYkzaVJWRRWu+O39ArH+4NIPEIFBpnZIENsKBBgTI01EVjDu442++OubPRG3u6xOkZ
         3GQRGzo1AdYiUuaaCv8ive2F68LzA/NgIY0ONN4/TsHT5waVyABGQ50sfE8z3DXunpXd
         tPN49YpdALI8rPMk3RkiRU4QfaMy4JhyBM3vV/5qcca4LU7ECG46ypfatrRJwjQK/0Np
         VcRn4ML1fxEvSTBHL/7CZK/oGumOTpzQMy0G2CIVwnpR3SmBm4wzOukz4yWmV9qGlEfo
         VLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515417; x=1706120217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYLeQC5slfCvWFFzPxrebDUGGj/LueNwDEYL/EBPrAo=;
        b=hosIeGOR+tBq54oHPPnIaLHIVmuQ9stUrY0Zqoucm4no8t2u2JOO6GvWEuAFyuIlev
         F9n016BOsiRwfowt/aXsqkltOiNZk4CYYIYP+PvT2VvlIGTR1RJVzjjqywYFh2qNUxU6
         4tvHvsB2sbR4uXSrb3gd2rxQ1vDfjRVDaZem5Q1iiua6sC9tUTVfApSErEs3RXTx2E7p
         dApqbM+Wvqa2P2E7mMHsFPuSvjGGh84ojKmemMepzRnEFVpfObZ2fl41uBVTlrKC3sNo
         dAmwuewG9f96aE4sinSdMaexnoNxkrdSjaWuU73fu/D1M3l53TeQqSdlmm9V2FRXPp2s
         iISQ==
X-Gm-Message-State: AOJu0Ywomy6gOLwaobjm4PYOcslO9RKgEnt/Zj1ivYQrLSGsXyfpa+sa
	XT6Ch2ZvRoPgptdJWBp8NRGzds4qa1tiERp1ZIYgZP//6GlUwA==
X-Google-Smtp-Source: AGHT+IEiU4sgOHiDuc04/q9jECuMRdLjA17jYKeAeJ4piEglYPHw18T3b/PpQlqA7gfF1SOpcxOh16zWc3G/Lxu8Esg=
X-Received: by 2002:a0d:cc4e:0:b0:5ff:5d7e:54af with SMTP id
 o75-20020a0dcc4e000000b005ff5d7e54afmr1969991ywd.105.1705515417633; Wed, 17
 Jan 2024 10:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl>
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jan 2024 20:16:46 +0200
Message-ID: <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
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
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 18:08, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The responses to the RFC were rather positive so here's a proper series.
>
> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
>
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
>
> After some additional brain-storming with Manivannan and the realization
> that DT maintainers won't like adding any "fake" nodes not representing
> actual devices, we decided to reuse existing PCI infrastructure.
>
> The general idea is to instantiate platform devices for child nodes of
> the PCIe port DT node. For those nodes for which a power-sequencing
> driver exists, we bind it and let it probe. The driver then triggers a
> rescan of the PCI bus with the aim of detecting the now powered-on
> device. The device will consume the same DT node as the platform,
> power-sequencing device. We use device links to make the latter become
> the parent of the former.
>
> The main advantage of this approach is not modifying the existing DT in
> any way and especially not adding any "fake" platform devices.

I'd still like to see how this can be extended to handle BT power up,
having a single entity driving both of the BT and WiFI.

The device tree changes behave in exactly the opposite way: they
define regulators for the WiFi device, while the WiFi is not being
powered by these regulators. Both WiFi and BT are powered by the PMU,
which in turn consumes all specified regulators.

>
> Changes since RFC:
> - move the pwrseq functionality out of the port driver and into PCI core
> - add support for WCN7850 to the first pwrseq driver (and update bindings)
> - describe the WLAN modules in sm8550-qrd and sm8650-qrd
> - rework Kconfig options, drop the defconfig changes from the series as
>   they are no longer needed
> - drop the dt-binding changes for PCI vendor codes
> - extend the DT bindings for ath11k_pci with strict property checking
> - various minor tweaks and fixes
>
> Bartosz Golaszewski (7):
>   arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
>   PCI: create platform devices for child OF nodes of the port node
>   PCI: hold the rescan mutex when scanning for the first time
>   PCI/pwrseq: add pwrseq core code
>   dt-bindings: wireless: ath11k: describe QCA6390
>   dt-bindings: wireless: ath11k: describe WCN7850
>   PCI/pwrseq: add a pwrseq driver for QCA6390
>
> Neil Armstrong (2):
>   arm64: dts: qcom: sm8550-qrd: add Wifi nodes
>   arm64: dts: qcom: sm8650-qrd: add Wifi nodes
>
>  .../net/wireless/qcom,ath11k-pci.yaml         |  89 ++++++
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  29 ++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  37 +++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  29 ++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi          |  10 +
>  drivers/pci/Kconfig                           |   1 +
>  drivers/pci/Makefile                          |   1 +
>  drivers/pci/bus.c                             |   9 +-
>  drivers/pci/probe.c                           |   2 +
>  drivers/pci/pwrseq/Kconfig                    |  16 ++
>  drivers/pci/pwrseq/Makefile                   |   4 +
>  drivers/pci/pwrseq/pci-pwrseq-qca6390.c       | 267 ++++++++++++++++++
>  drivers/pci/pwrseq/pwrseq.c                   |  82 ++++++
>  drivers/pci/remove.c                          |   3 +-
>  include/linux/pci-pwrseq.h                    |  24 ++
>  17 files changed, 621 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/pwrseq/Kconfig
>  create mode 100644 drivers/pci/pwrseq/Makefile
>  create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c
>  create mode 100644 drivers/pci/pwrseq/pwrseq.c
>  create mode 100644 include/linux/pci-pwrseq.h
>
> --
> 2.40.1
>
>


-- 
With best wishes
Dmitry

