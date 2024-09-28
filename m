Return-Path: <linux-wireless+bounces-13273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F55988EC7
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DF1F21949
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB319DF69;
	Sat, 28 Sep 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2BoSkdh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE974BED;
	Sat, 28 Sep 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515325; cv=none; b=rwZ2lUjVlJ6p3oMxztiGVGsSfA3OYowWkmcOLoSlL9NYeOF2WUYPsZoMjoVSpTUypfeOjFMxmS2wblbZQkLLCU7BOC6Y1rJ8/wHERTt7Y75SmNY947rQfk+7udeX28S9paBg2j9b64p4PHgylYFWIoy0x8Ps953u5WzBaI481uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515325; c=relaxed/simple;
	bh=uCgtAKSgxvi3oFwpCxLapBxV0u9+nUh8QinzO5ofaro=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dvL+Gaes22hJo4xM0b7nKPHUZMIXWD3K/uEPYeP+KtVOZ088Farx5urai1e3lesRppAyJOLXpYIcp498H4cDOGmq9JqbAZpfgyPm15Yh04VSABbRoE6pFtiZTdFkjJwf/HdT9ES177w8SZfSrD/bkkrTJMwQNLM6OFR8qlcw4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2BoSkdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AFFC4CEC3;
	Sat, 28 Sep 2024 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727515324;
	bh=uCgtAKSgxvi3oFwpCxLapBxV0u9+nUh8QinzO5ofaro=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=E2BoSkdh7EcgYYncu4sHIzlPwyxK84ixHU61HX94xf4KZ9JD7nreUCTEsGbmO+lG2
	 HgMXEICrW1wWK412VPQxVkq/mGRiaKWq1VOeKoUxyMpcW8Xsh27MpECLeoeyfE+vtQ
	 uIkaFrRfka/77Z3/VCSkrTI4gVuaDjxWgUr6ntUk9gYe3e2WzBbVx3R3YGXE57oYTM
	 gKgO6xmhJYUy7DweOn8V0vSr2mv/0Wh8gWSKvNuKhsxsKO4oV4n25qeDguJw9clhwv
	 fl6NfrkVvzoSO+TJRx00tMBelSYI8PtP+iasBcJRCIOYaF8XdXnspNAB/lDCK7BJrj
	 8vybX7HEsILMQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of
 the ath11k on WCN6855
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240814082301.8091-1-brgl@bgdev.pl>
References: <20240814082301.8091-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751531994.2249584.3150490336155869162.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:22:01 +0000 (UTC)

Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Describe the inputs from the PMU of the ath11k module on WCN6855.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

02d697272cc6 dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240814082301.8091-1-brgl@bgdev.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


