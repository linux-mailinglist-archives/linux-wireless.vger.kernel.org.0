Return-Path: <linux-wireless+bounces-30293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BCCEEC93
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768873011A43
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50E221554;
	Fri,  2 Jan 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7OcxuCp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74319D89E;
	Fri,  2 Jan 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365013; cv=none; b=BvgYRsdvcF+R4QY/4E33F4oDGypDBnan4hVkbyt3LXsi69/aWL/xA8xwKjUS5HxyabWly5k4f/sHbB9PDM1tMBMzPxrfi7LgTVPHvms/IEvjL+2LQWitHG1qkFUrrdITibGqPlUFwiDKpmByvIkmrwonXHFR2zfUwTVXty80afo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365013; c=relaxed/simple;
	bh=nyHtgP68erpLvHWm6764+JEIXGn81OZrAUsIOLo6/ys=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=e3cUgnDCGDppQBhTWj6KOpHKC0Gn62/6jTFxB1egVWnIBvu9dUwYXtUfELn9AgYyId8Ij6PVVe08MHvFVncoEd82Wh6eRHfPuAhYKXhpQgZHNFVNePtrMBjviwhcJKI8Dn2FjS9ErXCMyR5b1595T7wIjiVs15c/781GlKgcCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7OcxuCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09075C116D0;
	Fri,  2 Jan 2026 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767365013;
	bh=nyHtgP68erpLvHWm6764+JEIXGn81OZrAUsIOLo6/ys=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=u7OcxuCpmb29cSRLpISqyRHup8TEYMOWAkIYs40lRyNkKBia3n7iZ6NSmpQOktwnA
	 xxoXi0cW+kTUVzBo9bEAlsbuq5mX4OP/eDUJeHRIo4ObHeMQXQMXBOuaaeTBBLjWHh
	 dYk/0iIQbZdrpMUb0wm929Id2xZbgu2JaAfsN5EuQ8qJa/7sADkJTJu8eSS/2J58G4
	 UNrVr6CLDoeZWCtUBC2XuoIQv1PPqJKPYuehEPv2ALLopOE737dHbbppIPSeO/k/11
	 M5sgXa50iyFjfBo9+cN3kr7P8RUkT0zDEN+LywgewS7S6aFIvT5jO3BU6kMNUwjqjv
	 q9HEY3+hg+8Xg==
From: Rob Herring <robh@kernel.org>
Date: Fri, 02 Jan 2026 08:43:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Bartosz Golaszewski <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 ath10k@lists.infradead.org
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
Message-Id: <176736452702.3671432.8334984298495582439.robh@kernel.org>
Subject: Re: [PATCH 00/14] power: sequencing: extend WCN driver to support
 WCN399x device


On Wed, 31 Dec 2025 01:35:50 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> Backwards compatibility with the existing DTs is retained by keeping the
> regulator&clock code in the drivers as a fallback.
> 
> As a part of the series I've converted only several boards, verifying
> that all known instances of WCN39xx family works (fixing the issues
> meanwhile). The rest of devices might follow the pattern later.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (14):
>       regulator: dt-bindings: qcom,qca6390-pmu: describe PMUs on WCN39xx
>       Bluetooth: qca: enable pwrseq support for WCN39xx devices
>       Bluetooth: qca: fix ROM version reading on WCN3998 chips
>       wifi: ath10k: snoc: support powering on the device via pwrseq
>       power: sequencing: qcom-wcn: add support for WCN39xx
>       arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
>       arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
>       arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
>       arm64: dts: qcom: sm8150: add uart13
>       arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
>       arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
>       arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
>       arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
>       arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly
> 
>  .../bindings/regulator/qcom,qca6390-pmu.yaml       |  36 ++++++
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  60 +++++++--
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |  62 +++++++--
>  .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |  66 ++++++++--
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  75 +++++++++--
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 141 ++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               |   9 ++
>  drivers/bluetooth/btqca.c                          |   2 +
>  drivers/bluetooth/hci_qca.c                        |  26 ++--
>  drivers/net/wireless/ath/ath10k/snoc.c             |  43 ++++++-
>  drivers/net/wireless/ath/ath10k/snoc.h             |   2 +
>  drivers/power/sequencing/pwrseq-qcom-wcn.c         | 130 ++++++++++++++++++-
>  12 files changed, 596 insertions(+), 56 deletions(-)
> ---
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
> change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167
> 
> Best regards,
> --
> With best wishes
> Dmitry
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com:

arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb: wcn3950-pmu (qcom,wcn3950-pmu): 'vddch1-supply' is a required property
	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml
arch/arm64/boot/dts/qcom/qrb4210-rb2.dtb: wcn3988-pmu (qcom,wcn3988-pmu): 'vddch1-supply' is a required property
	from schema $id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml






