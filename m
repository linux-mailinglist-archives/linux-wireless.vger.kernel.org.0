Return-Path: <linux-wireless+bounces-30848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB62D2897B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 22:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94508303211A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6931AAA8;
	Thu, 15 Jan 2026 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujGiB/MH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE22286409;
	Thu, 15 Jan 2026 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511020; cv=none; b=s3tPssqz4u3YzI7aj0muGJvVsfgoHnl16sSGsv6UkHrdc/KCbDQJFsG/mXC/bjmenYsyjP+cIsW1GAzoVxReAT3O1t6mnPu5+Psi4ehWcCNEGsJ06Pn/hWgRBhwobDQAgGJQv+HWHGkTzslDEQ/KnOPG9Sr9S0bHM1qiYf2VjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511020; c=relaxed/simple;
	bh=Bfdh1ihpqGHMGuPqW6c73mjv5JMezBBfg7OgdT7IM0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdMneXmlOqXdNo2sdx35kulHVSOG9UhIvqj2zGS+MEQZdmLpVrbmWSRoutjzlUHjsiKSja7V20TF+Up/3RaauVN1zqZj5joM0mFc3z/ytyw0fK2DwEoX6EcjOMtMglS2kIqHoINyn+ZL4/imR1GEfgXJSlzQuPScKVsU3QpgEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujGiB/MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FEC116D0;
	Thu, 15 Jan 2026 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768511019;
	bh=Bfdh1ihpqGHMGuPqW6c73mjv5JMezBBfg7OgdT7IM0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujGiB/MHcXEUMMquCTYeVW1Z0CuGRIv8DgW6mCFGMHRcB2vuIrvLfZJh02ZJImnP7
	 sRldwyf6qDQ36d/NVnzw9Y3qJiUwLaovnG97wG3tEfcaosNqi8/5xgiIRgpZN5fDzO
	 kZ/gYoJnNEAGxCkhoNa3mcOqzXug70iUJ9atlHWOGjMdeuJE1KJw/ycWeBN6CNC6Qb
	 4/VszlIprBQjAkI8f5itv8U7Mf4kNyB/TXU+j457T9HVkXIqtiyW2VnLcTzhuDmwtw
	 Ak2yhw7DPo+RcLpVn9IzKWk3MCBD84J46JX+pNSEVPhz8eJ32eI+k88IZn6xnNDEYB
	 BhMmx45rwOP5w==
From: Bjorn Andersson <andersson@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/14] power: sequencing: extend WCN driver to support WCN399x device
Date: Thu, 15 Jan 2026 15:03:34 -0600
Message-ID: <176851101091.263753.12255000072756523298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Jan 2026 03:01:10 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Applied, thanks!

[06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
        commit: c5dc4812f6bf397b82290c540085e9ec98b47b30
[07/14] arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
        commit: 8bfb696ccdc5bcfad7a45b84c2c8a36757070e19
[08/14] arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
        commit: c303e89f7f17c29981d09f8beaaf60937ae8b1f2
[09/14] arm64: dts: qcom: sm8150: add uart13
        commit: 0404b98c6bbca7a3b1e59a20d173fa149ac20194

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

