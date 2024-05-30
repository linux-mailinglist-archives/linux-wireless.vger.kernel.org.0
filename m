Return-Path: <linux-wireless+bounces-8320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AFF8D4F6D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582091C2313F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B711EA8D;
	Thu, 30 May 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1+zf4fy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA201CD2C;
	Thu, 30 May 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084242; cv=none; b=LjKe9+zz4YqNttxP1Qv08bO4mVSaXzu2cplFfVha78wJRKHKqAiVIebJhycfWiNicJUSTxhIUR0ldUS4bQqUG3DWtjwCM5196Ic4aEt5SQO38tWsRf7jQ0Rptnl16CuUO/Vz/zIjzqN7mpyeVbZo5zxFNv5bs5QII+MP5dIH3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084242; c=relaxed/simple;
	bh=xygDBTFplFvzRM5DN63ShuFxOVfO34VSI62/KLcs6/s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=T7VlBatC6kf7sNU2cIXxvQetIaa+z7Ja3K9Qlt9Dxl7NSibjS+cmjDUxe/yx3Sq72QOyyp9tkuYAbNSFvh1ZRms64V6NAzmAlR5RD70S3GADDSfgulz/Fn3fQAg2KqmYfQjBvAPFGyeZibGgeQF4WNgFj2/xIWFPS/Rs3XkSoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1+zf4fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF31C32781;
	Thu, 30 May 2024 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717084241;
	bh=xygDBTFplFvzRM5DN63ShuFxOVfO34VSI62/KLcs6/s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b1+zf4fyZE72cIxWjUctp5CRzeVz6Yl9GpuyUPX96s6q4z3GYoPvqC5zZuB9kz32X
	 Bpqgy1wgUJWUAbFy/PeDuP9ahs9xyzXiTva3+SPp/nMgCZPRKr3bETli2cmKuCjzhN
	 Mf+4lLHUXh/Ivz09NJKqDE66yxVak8yiC24hLT3+VTIiK+oJ97CZPYAMxR/uOfEl7g
	 2+bCXcSgfRyWoYAtjI+/aKxzEfkkbCJMhx7L+8O60uhjc9kInU2r6ZHHZfvQrxHwNG
	 NMiKbpbujXSWOSa0tAP3YmNspTKZ78c0xSit4QNxHdKbIt3JiR2CZRZ+nE/LozBEH6
	 DCokCQareq2mA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] dt-bindings: net: wireless: ath11k: Drop
 "qcom,ipq8074-wcss-pil" from example
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240528134610.4075204-1-robh@kernel.org>
References: <20240528134610.4075204-1-robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171708423701.182911.6673955018823846122.kvalo@kernel.org>
Date: Thu, 30 May 2024 15:50:38 +0000 (UTC)

"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convention for examples is to only show what's covered by the binding,
> so drop the provider "qcom,ipq8074-wcss-pil". It is also not documented
> by a schema which caused a warning.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

43e934360d1d dt-bindings: net: wireless: ath11k: Drop "qcom,ipq8074-wcss-pil" from example

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240528134610.4075204-1-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


