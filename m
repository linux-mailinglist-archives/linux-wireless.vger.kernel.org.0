Return-Path: <linux-wireless+bounces-8259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736168D3289
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E22B235CD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12506169AD3;
	Wed, 29 May 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHgFWB+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD41E888;
	Wed, 29 May 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973519; cv=none; b=FpzoMsFNr5YQEKcXRbHXGMZbFqIV6aHyB6bem81TfkwVSYlsZLV1T1jlxp3E6C2aqiHn1pIg+j3m0nA9jgWT4YP9kGhY0yKXOT0u+7NhTb0qA83rxlaR6F6yofWrxjeDIBR4C7EbUgpE9P/OlcsCyyDF5DDGOvkALsrilbbY1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973519; c=relaxed/simple;
	bh=MF0KhYNWSAZG1I9Dmuy4u1xpG22i7yS/OTYbcgXjtUc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mLLaA0RN8MPCu3UvZAyUlUVenNm9eYV7R8gXWO/mVmrN2abgpEgPslQM5+wYWVN4/Gxw/RuJ4BkLnc+gr3DX0k1Xqa4rfkJz2TqGJFoIZKU8kKl7BtYLCcQw+3QmYBRPM9BuhGyUG63aLmvrYHffBBjdwihm7wDQaE0ZfUsZR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHgFWB+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC59C32781;
	Wed, 29 May 2024 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716973519;
	bh=MF0KhYNWSAZG1I9Dmuy4u1xpG22i7yS/OTYbcgXjtUc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sHgFWB+jK6Mvf5fBRRP2YexDHRG46SwFx/WaZZC8meVL8vEQ7zFnK+0esw1SdHEIU
	 KXJtATpUGyx6irx5acjwsE/117kpgCJw8eXTAqbR/SKLcvgiKcS5PapqOKVtzFOEKs
	 vE+8uy1U+c4Zl0PI9/mRgcPaLRp2jTIKPEfOQWfE16Y0TdK6WfgYAnA2/Amk8+GSUS
	 osYolyNlMo1X8SzQE26TZpLuJCyKN6TUI9wF+A1fbvwBb87eu1wzfQHSKm2jZpUDWU
	 dGtMv0pBblc396LJgPEYmp9EaXg/qUmk5yNXtzw0Udggvma+xH1CXwRbZnP3t/Qxi/
	 NVmVVIAWeXJsg==
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
Message-ID: <171697351470.2158278.1110328163301153386.kvalo@kernel.org>
Date: Wed, 29 May 2024 09:05:16 +0000 (UTC)

"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convention for examples is to only show what's covered by the binding,
> so drop the provider "qcom,ipq8074-wcss-pil". It is also not documented
> by a schema which caused a warning.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'll take this to our ath.git tree, ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240528134610.4075204-1-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


