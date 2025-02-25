Return-Path: <linux-wireless+bounces-19433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599BA44815
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 18:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B897880BA8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985319D88B;
	Tue, 25 Feb 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i28EhJ52"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C819258C;
	Tue, 25 Feb 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503740; cv=none; b=fkp6mMR62vcCF0Rbmk7q3V9Al9fZ48A8ZHRvaIjp63e+fjlbmuMFHJQM7Q76gIzc5d/I75q5AMBab1unxTJlXmJvxhptJYjDthqspKxVJQGRDTfQZ8PLiZw3qaNKUTbuRdNkT4jC/vOfmesm5mK8EmXsT9carOVCTSS2SiCqxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503740; c=relaxed/simple;
	bh=ZF1rAhCMbOrvp76SA+oTUJgptcVWQVsV/ij4xenjie0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDHKUCG3dv0PmOBnLFcd3rJND3HLL7hQfPVC9qLnaqIv/SrhRnO4sbdYVxjHnk50HzDtC5zCzb7KJgj1yUOVf+WdQPkQHQVhR2AFBHeho5VOo+xBmhL3bSIro+iKdAFf3jhbH9XUMIRCB6dtMxKffod3klAcYlMX7mQ0jeE+VZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i28EhJ52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F6C4CEDD;
	Tue, 25 Feb 2025 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503740;
	bh=ZF1rAhCMbOrvp76SA+oTUJgptcVWQVsV/ij4xenjie0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i28EhJ52IXq3mC5Lc3lOt22PkbrYUq4RV8yoxln8w81ZgPuc5yn9Zgwp1FTKe90XS
	 z3crKCBTuHWP1++96ZxuvzXgk9a3+/U3/mqAlhPyenGj2Rzt6wJjqTHWsgRGyJTVN9
	 G169Klzw/0lOhbX1lGAiyaFePgWfur1/vrJKhkRlBm6i+E+Lwh4oTtWDvG8t4jomR7
	 /J2BMB8mZH7jVmxyN5HHYWFKUOpSJay7b/MwGzDNJYJ4quuMjNfRsGCcyJEiKuEQUU
	 2wBv/glI9bXLWBmmtBII410ZzTgf3V2E0fF1AWbirgL7qjiVhpqyt8QBfVhDrx9MXd
	 wNqNChMAHvvYw==
Date: Tue, 25 Feb 2025 11:15:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Conor Dooley <conor+dt@kernel.org>, ath12k@lists.infradead.org
Subject: Re: [PATCH 3/5] dt-bindings: wireless: ath12k: Strip ath12k prefix
 from calibration property
Message-ID: <174050373800.2716505.16558517329137280278.robh@kernel.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
 <20250225-b-wifi-qcom-calibration-variant-v1-3-3b2aa3f89c53@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-3-3b2aa3f89c53@linaro.org>


On Tue, 25 Feb 2025 10:05:34 +0100, Krzysztof Kozlowski wrote:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath12k).
> 
> Deprecate qcom,ath12k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml   | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


