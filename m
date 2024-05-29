Return-Path: <linux-wireless+bounces-8241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F978D2A63
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5FE1F278A5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058515CD53;
	Wed, 29 May 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwFVivYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B515CD4C;
	Wed, 29 May 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948137; cv=none; b=M7QHd73AxPsFJtg9Ya5KRclgYtJs4hnnRPQb/yzjo8B48AH1x8jKegeo2fRaR/zJoLSGe6nYaNI53YC+EoTde5QvQqqY3TBRas2vylUsb3Wgbqt93E0WVS5n+dUE72MngfHElkxnZd4IV4IUhoirk+I6vnogzBivDtPCvo4X1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948137; c=relaxed/simple;
	bh=kBuQ9fcA+VN6pPO3SFipaZrl1mBckkhQxMcU1vdmrT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNKCuIkWwJUxBTeoZUGdnrj/Aamw85Yg6p+APyD3K9mb9OZ9hRg+M0SBY0qaIETlU7gSm3u9BIByubu0c+FO7UKc0gHIluOY1ZknJn8kfPv7/lzOSbQ++MtskN3vhdzFVmT4RJ8uzv/UwYBO6EODKCafK1XJ8gMOA7L52yw2Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwFVivYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB112C4AF08;
	Wed, 29 May 2024 02:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716948136;
	bh=kBuQ9fcA+VN6pPO3SFipaZrl1mBckkhQxMcU1vdmrT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwFVivYOgH6ldsdLchXHx8VvhvKvJ2HOJXTIpYoe1syCLelhlDuql/2rPzZcCvm3w
	 BwuBUY1hRH3dZr2/8875yzsE+sHEY2GLSzzfbMoqaJpsjpQO8IPtFOvO8lU4VPoSLQ
	 X7Uxtp+B8ZABJb+ZWLVcO82zeHX2HSIj0EcbVfQwsaTihNVNvHXE0LbEknveDL7rpH
	 WcsA3Mm23OfE/f8dWEXBajFO/lNQMmobJofNmst2lMBGuVgdfFv0vgAb/qJzMuTATQ
	 uf0ia4VvpVsndQxmSY69Ta6/bTkNjTJahLInrlzTwsuDe7APARcC+NxGyW07Z57CkA
	 4Ed6S8oh2mnSQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k <ath10k@lists.infradead.org>,
	Marc Gonzalez <mgonzalez@freebox.fr>
Cc: wireless <linux-wireless@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>,
	MSM <linux-arm-msm@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Arnaud Vrac <avrac@freebox.fr>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jami Kettunen <jamipkettunen@gmail.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: (subset) [PATCH v3 0/3] Work around missing MSA_READY indicator for msm8998 devices
Date: Tue, 28 May 2024 21:01:54 -0500
Message-ID: <171694812078.574781.940205504715408568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 29 Apr 2024 16:01:41 +0200, Marc Gonzalez wrote:
> Work around missing MSA_READY indicator in ath10k driver
> (apply work-around for all msm8998 devices)
> 
> CHANGELOG v3
> - Add a paragraph in binding commit to explain why we use
>   a DT property instead of a firmware feature bit.
> - Warn if the "no_msa_ready_indicator" property is true,
>   but we actually receive the indicator.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator for wifi
      commit: 737abcabe97bb37e38be2504acd28ad779dbaf3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

