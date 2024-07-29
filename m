Return-Path: <linux-wireless+bounces-10591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36C93EC3A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 06:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A311F2324A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FF13AD0F;
	Mon, 29 Jul 2024 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGjnkw/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505513AA42;
	Mon, 29 Jul 2024 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225534; cv=none; b=mI663+mDfqfe3j9NCHach8qt8/tvxpuJn8Wb3Yeth81Bn7jqezNlqKKdWQpsYzl9nccwAY6C45YdzPJBA28fHijYMDnTZwZv3wYTej42k+7fLR2Hn3YZKfgvswP/L4mN59NE4v6M4We7ZhZKLndJN+Cy7+kpLofMVKWVIQPFp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225534; c=relaxed/simple;
	bh=OTJPkGkpde1iTM4/DKCFCr5P3BMKKGLJcgjquoJy3ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/grXCca8+RgtRC4ugJpInYUoq39ZemKkw/0QihL9EfBAo1G9uZF8qmRDoGw0JU9kt5hEtlm64eD17pqzGxrH2TlOIYUm8ps6/F+9g5KhRQJCDiVMtYZAJ15umQVHiuUBDNPcqkF8Ii9GArV/W0WvEb/ItH3Sgj/S70yyxSQWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGjnkw/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26BC32786;
	Mon, 29 Jul 2024 03:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722225533;
	bh=OTJPkGkpde1iTM4/DKCFCr5P3BMKKGLJcgjquoJy3ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGjnkw/SwHaYz0anxSPQI6esforJZ3DJG9/e43+VFjeVFqPuJ0jwZwEW/5NgftaaJ
	 mv+U+j2swUOjuFm841UpghBsM63o0Hq9WgI09OGEVLLDqlECKBPjFvvyoZ6EsrW64y
	 K/CvzJEX3sczcOVjzrj4N1ucGlO1wWRuyp5GkcAYHnjqOEDWu/5IuY8HAjB3/A8QhY
	 Gn0kXhVxS8qBINLGEkM6xzzdKeO/j7pRNfUZOP2tLJVKIOiD+uDeS41NS1I5bGdZio
	 VRjPTN7gNbk/8Yx8TFMvnk4s9C+W1ZjrmNyeyGrrKtjfapQtg43SOzYNNSi3R8cA3N
	 yIS86o3s4wVBw==
From: Bjorn Andersson <andersson@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Patrick Wildt <patrick@blueri.se>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
Date: Sun, 28 Jul 2024 22:58:19 -0500
Message-ID: <172222551311.175430.13568156026564706830.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 15 Jul 2024 21:38:11 +0200, Patrick Wildt wrote:
> This series adds the missing calibration variant devicetree property
> which is needed to load the calibration data and use the ath12k wifi
> on the Lenovo Yoga Slim 7x.
> 
> Patrick Wildt (2):
>   dt-bindings: net: wireless: add ath12k pcie bindings
>   arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
      commit: 8bc7cb73df8644423758c79d4504d501c8ef3854

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

