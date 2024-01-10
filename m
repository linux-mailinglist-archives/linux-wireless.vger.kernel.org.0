Return-Path: <linux-wireless+bounces-1620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E746A8282F0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F823284896
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AE36B1B;
	Tue,  9 Jan 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgUePAhV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FF35890;
	Tue,  9 Jan 2024 09:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CBBC433F1;
	Tue,  9 Jan 2024 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704791893;
	bh=HPNvwBlDoURqcR228aqjUvaE1RRrnKS4myuXXAyaAog=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QgUePAhVgYTKdCDir8lW5xgFglt6GgowMR6umaf1kI3jYuBEyAmb3yDBh9xym6xHX
	 LYtGNIHNc69u/mOhR53YaK9NOoKsPWFj+jU3O2j3Np73y601KPh5DUUOqnWcRj4Lhj
	 XpMCreey5P1dYUlyEXvoFoTiUDnlH7/pyH//6WxJS9X9AhfbmWaWjhZhCXMSxaHivi
	 1BTV9Sbg1gUGII3VJS46zGejC9vFQtb3DF3whKvRqSF7hHkWlR8y9B8X7CXGLMMaKx
	 Ev1vbmAKdBil9IiXRIqBic3d7NkU5RMgjwhZnuy35LAFMQ2jJUBDhkqGH49yuoq/Ph
	 F1d1/82OwuaTA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Heiko Stuebner <heiko@sntech.de>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Chris Morgan <macromorgan@hotmail.com>,
  Linus Walleij <linus.walleij@linaro.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  =?utf-8?Q?N=C3=ADcolas?= F . R . A . Prado
 <nfraprado@collabora.com>,  Marek Szyprowski <m.szyprowski@samsung.com>,
  Peng Fan <peng.fan@nxp.com>,  Robert Richter <rrichter@amd.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Terry Bowman <terry.bowman@amd.com>,
  Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Huacai
 Chen
 <chenhuacai@kernel.org>,  Alex Elder <elder@linaro.org>,  Srini Kandagatla
 <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  <linux-wireless@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-pci@vger.kernel.org>,
  Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
References: <20240104130123.37115-1-brgl@bgdev.pl>
	<20240104130123.37115-9-brgl@bgdev.pl>
	<15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
Date: Tue, 09 Jan 2024 11:18:04 +0200
In-Reply-To: <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com> (Jeff
	Johnson's message of "Fri, 5 Jan 2024 17:31:47 -0800")
Message-ID: <87jzoizwz7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
>> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq/Kconfig
>> index 010e31f432c9..f9fe555b8506 100644
>> --- a/drivers/pci/pcie/pwrseq/Kconfig
>> +++ b/drivers/pci/pcie/pwrseq/Kconfig
>> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
>>  	help
>>  	  Say yes here to enable support for PCIe power sequencing
>>  	  drivers.
>> +
>> +if PCIE_PWRSEQ
>> +
>> +config PCIE_PWRSEQ_QCA6390
>> +	tristate "PCIe Power Sequencing driver for QCA6390"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  Enable support for the PCIe power sequencing driver for the
>> +	  ath11k module of the QCA6390 WLAN/BT chip.
>> +
>> +endif
>
> As I mentioned in the 5/9 patch I'm concerned that the current
> definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively hide
> the fact that QCA6390 may need additional configuration since the menu
> item will only show up if you have already enabled PCIE_PWRSEQ.
> Yes I see that these are set in the defconfig in 9/9 but I'm concerned
> about the more generic case.
>
> I'm wondering if there should be a separate config QCA6390 within ath11k
> which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390

Or is it possible to provide an optional dependency in Kconfig (I guess
not)? Or what about mentioning about PCIE_PWRSEQ_QCA6390 in ATH11K_PCI
help text?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

