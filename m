Return-Path: <linux-wireless+bounces-19431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8626A447C1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771421890047
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B120D4FF;
	Tue, 25 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhuyi1T7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F720D4F3;
	Tue, 25 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503585; cv=none; b=Tkxgy45CrsvAI5KHcHSOhIwGrBb5ltDpjdsXP504xjJD5knxpvOaAhzsHx9J1/1SGRlViBs4fF/3VPdC2zUNh08h1tQqtU51eLOevXbBCMVWDpy4b20yQF6eXw3Dpx2jTBf/Erop7ISRpZe3w+OIVJJ0+R3i15N98jvlzps+izE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503585; c=relaxed/simple;
	bh=BX69y1ANjPvnVIyBiB7P24k5Cj6FcQsBECZ68cv6mf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2UQQV+Y1EspX3y+nVhatlin23LK/PZ5w6KIwWyc9iR8GIpmGq71QJD2lyBkZYnCd4mGUoj9XddU92jeDN9n6v+2l3mo2as3LC1BCkDaXAwdlk0H0xuXViWdOP3xLgcoQZmumhWQpkaUJ5AItXEBKO/lcR0oGAPuDPBJTEnGRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhuyi1T7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFDAC4CEDD;
	Tue, 25 Feb 2025 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503585;
	bh=BX69y1ANjPvnVIyBiB7P24k5Cj6FcQsBECZ68cv6mf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vhuyi1T7ESRLApERLkzkFWy0Yz52Ys0tSw5GRFbkhaCcoGkKO5Pw/QHqC3myPk7Kj
	 1OLVtR2mPq+xUtimvS3VUCep+s4F112qgFo4tAesCPKI9OOxh2cyLLKxyrzUTxM/Qb
	 u5mmBFRWfu7Ui975CP7ERxb/aoZP54qLgp5caxj6hbxo4GOAFuak7cpnM8zD9XptaB
	 LX7OLarJMnWEqz5JepBsho0A+VRj3mYn9G8meozrgzkjQCU621aNVHIyARDmo4J437
	 bHKqaXgebTdiKwdSD0UKMQEv6EjJ0R87NpXTRDP9wselJkbdbpNjk/gbzQleQtESw7
	 ryBtdQ0YsMFyw==
Date: Tue, 25 Feb 2025 11:13:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	ath10k@lists.infradead.org, ath12k@lists.infradead.org,
	ath11k@lists.infradead.org, devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: wireless: ath10k: Strip ath10k prefix
 from calibration properties
Message-ID: <174050358243.2711030.9886778077090867092.robh@kernel.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
 <20250225-b-wifi-qcom-calibration-variant-v1-1-3b2aa3f89c53@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-1-3b2aa3f89c53@linaro.org>


On Tue, 25 Feb 2025 10:05:32 +0100, Krzysztof Kozlowski wrote:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath10k).
> 
> Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Why? Because people add qcom,ath12k-calibration-data and probably they
> will add qcom,ath13k-calibration-data, qcom,ath14k-calibration-data and
> so on.
> ---
>  .../bindings/net/wireless/qcom,ath10k.yaml         | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


