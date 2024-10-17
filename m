Return-Path: <linux-wireless+bounces-14160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04C9A297C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B23D1C27CE7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EA1DF243;
	Thu, 17 Oct 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmrPRy/B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F61DED5B;
	Thu, 17 Oct 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183685; cv=none; b=VulxWPzMPDSOiKtqMMR9/z33Ka4ZC5jmTLo+f1yf4Al+WpkoZVxR2KhwRWpNaLLrji6Rvb2S0QzTcfXahQevCCayomh8NoSYW9UZkcuHgsJ7RF93Qsd2ht9F4F8Rqtezf/F1ojhN90tFA2pD0Ds21aeNUf8CXJ7TZ2+0yPtFC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183685; c=relaxed/simple;
	bh=1lxOlYEcYOR8eSfFluOEN1NiPrjmOzuMGs0H0pgeIuI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=tsSIFCh+0zkUDC7FFjpOWk6fmpN5Xy8rhATA70ZhcqhrI/M2FxTm9tVntETvao3MMNHEQv4cI8R6nkTzKOB2FPLPVch/5Vjo/s4E1KrLKZoWYkCp/6Hu7DFQTNlzZv94r3LMKzCNKc3QZ+01s54pBjhpPtVBQT+Y9p/0Rom+Vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmrPRy/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB28C4CEC3;
	Thu, 17 Oct 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183684;
	bh=1lxOlYEcYOR8eSfFluOEN1NiPrjmOzuMGs0H0pgeIuI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SmrPRy/B7ogdyZ6IDnLACoZecv9uC4jXbGQuxsDdhe9mG+sGQptUjaxEs9MSKkvn7
	 zLUPyzThXEyMNbwpUJr89T4LEd5JbWD/jQeWkQF+OqJRaiwt+ICUWsbDeAP/ptzFso
	 IjyE+Wbu0EvHEhR8LwXXc8Od7HLbPhj2A8ObNrp8j6ZnrSRp6HeKVEdlBqMnQ67wjw
	 5C+ndzVSfUDzegddcBcFL5HZE3i80nmsmdr3zXyofwWnUsPp1cBJ/KUi+6peHzYuIA
	 h939D1L35OmMxasGtkLYwRnldFkU3AmtjDhsBiGNLmCVs6+IerXQ3OsKFvNQbl5Swl
	 GSwAiBrvsFkiQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 1/7] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241004114551.40236-1-marex@denx.de>
References: <20241004114551.40236-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918367985.970100.15233672330515513203.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:48:01 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> Document compatible string for the WILC3000 chip. The chip is similar
> to WILC1000, except that the register layout is slightly different and
> it does not support WPA3/SAE.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>

7 patches applied to wireless-next.git, thanks.

1b292a161cfb dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
719e469eb9a2 wifi: wilc1000: Clean up usage of wilc_get_chipid()
0a6ea2e235ef wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
1241c5650ff7 wifi: wilc1000: Fill in missing error handling
577c04fc3b8e wifi: wilc1000: Fold wilc_create_wiphy() into cfg80211.c
fbdf0c5248dc wifi: wilc1000: Register wiphy after reading out chipid
e1408c115ef9 wifi: wilc1000: Add WILC3000 support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241004114551.40236-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


