Return-Path: <linux-wireless+bounces-30392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AFCF72D4
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 09:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1532C3017E7F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083330ACEB;
	Tue,  6 Jan 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQQ0gBPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8681D5CC6;
	Tue,  6 Jan 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686421; cv=none; b=NSuKiYh14v/C65WPkkuE+NV1olN/gd3AS66mdOrUvlsHLLxmNOl8zSNOvnK/CAcZMFi5MjEdujeArbiCMiSqEPowxVrm1+aSugxy0QUDNNfZzfH1+u1mmZvSiLNRldasvBr5yylo6dTj4uwdApL7zg9utSP/jZRSkWdZN5kQcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686421; c=relaxed/simple;
	bh=dkGrJ+HNkmvmZTpBr46Pq3Us3nvf8mhGcZF8C0/MzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzTwaGi9e3qqYxLbZDcM8hxWAyoqEp6QGXoKOuDkWJCaYJAOGXF6+bXjMnwm1XZLXclzXN4QA8m5G6Y+jBa/PkuKKeYbnfi14h6CJTLQX1d7S3AWRWqXHSABod6CP6H89MJpyMvZHH+hS8H+m1TKe12+xHfySG9C4tE7iaDEpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQQ0gBPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9012C116C6;
	Tue,  6 Jan 2026 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767686420;
	bh=dkGrJ+HNkmvmZTpBr46Pq3Us3nvf8mhGcZF8C0/MzzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQQ0gBPICFv2Mhig5gItFjq+6d62Zn7GYDi4hGisgG54sbx1sgsEtz5/vFHvZEeQa
	 KVKEZyE6wQXD9BTKrQmDB8+/PhWyAR5ZnqXqgzqlXGkoanlksDCKrIzVwpNbL0HMtU
	 dR7y451KqxpHu0ySjoNP6rfE5urNIbAMBrO/QFKtdh1+HT/wgHh5/ZuU256HPkfutC
	 zbMicu03Tv5lAInAc4BX/mjKq7VWuFuJpHUTAFRTr4LtpTkS2Ge+YjU4TPFm/FYwzA
	 178W6grtUapZI8I9OdewbzF3lIcQfW19Y/is6EYEIu3mc1I409ROTXi7z4/DJ82s08
	 3azdQeGnkeMqQ==
Date: Tue, 6 Jan 2026 09:00:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/14] regulator: dt-bindings: qcom,wcn3990-pmu:
 describe PMUs on WCN39xx
Message-ID: <20260106-excellent-pygmy-puffin-97f7d5@quoll>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>

On Tue, Jan 06, 2026 at 03:01:11AM +0200, Dmitry Baryshkov wrote:
> WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PMU
> (clearly described as such in the documentation). Provide DT schema
> covering other Qualcomm WiFi/BT chips to cover these devices too.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/regulator/qcom,wcn3990-pmu.yaml       | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


