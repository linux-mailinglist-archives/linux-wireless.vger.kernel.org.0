Return-Path: <linux-wireless+bounces-19432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC684A447DE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48862163140
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A219DF53;
	Tue, 25 Feb 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/GPGZXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9ED155756;
	Tue, 25 Feb 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503723; cv=none; b=CnzIt+PmuNpWWsh0UYxJnkbW1l5kwBLrrlgencDWOySB+Nw9bCQL9bKe5Cg5LtI33vLJz2lhYYZn1cBsVA063LsWwafWIaW5XlwcUPdstF+fedQPqxdplEv1JSRILcK3awu7YZEKFLKNtS4WRFV/VmXl8MRSyyFkyIxoh03orKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503723; c=relaxed/simple;
	bh=7KeqBFol8pGLRVvFbeuC+puSXOYFlCJdGV7zPxksw7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRX0frL7jb/1dzuheoAwvhuFWOHZjJzskIQ5d3zvNbNOM8tBTdg/3tOj9ZZGBDa8jEEd0rJOARSjG9xylnl13429G8VaOUT9XMmaWPrZi29DCWCxG/w/RJfwyutjRut8D1Mkg79YSZgvo+ZmEZ9LXk/Q6Q5DxJmFccgoWSYclRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/GPGZXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00476C4CEDD;
	Tue, 25 Feb 2025 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503723;
	bh=7KeqBFol8pGLRVvFbeuC+puSXOYFlCJdGV7zPxksw7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/GPGZXeAlGWSiKVMN9ABMI1yaVWrR4V2oHRRwyBLXzcOuX9hCCjYJwcq1Fb0XZ9Y
	 MjqnURj4wK5tFnqZfYta9/djn513hXYNQm3d8f+2joPI/Z058C4v04Li2/eZOvbUSn
	 7A9v12Jj0k3zH68ZKxsZtTErDRqvJZ9vj/A7agSVQgu29nyuFNWaTeEuab747g7rCw
	 HKBbsgEZFQcEAXD7OWNS2yn2JyLpWwo6hp0EtVbQnad1lvWwVIHJ06jpU4KtDsIFZL
	 Tl9V1QFJiCsPLa52hVSQ0C79t3Pw2Nvsbyt6pPR81f2Lpns12SogMGwZ59znC/2T1X
	 3a3hjT1YO/H0w==
Date: Tue, 25 Feb 2025 11:15:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: wireless: ath11k: Strip ath11k prefix
 from calibration property
Message-ID: <174050372078.2716032.16014648484871048536.robh@kernel.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
 <20250225-b-wifi-qcom-calibration-variant-v1-2-3b2aa3f89c53@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-2-3b2aa3f89c53@linaro.org>


On Tue, 25 Feb 2025 10:05:33 +0100, Krzysztof Kozlowski wrote:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath11k).
> 
> Deprecate qcom,ath11k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 9 ++++++++-
>  Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml  | 7 +++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


