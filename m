Return-Path: <linux-wireless+bounces-14455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42D9AE14A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB8F1F230DF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0B1B0F17;
	Thu, 24 Oct 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULBwzZbm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB80170826;
	Thu, 24 Oct 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763101; cv=none; b=EZfQBecW/JOpNiniy9lo/k9jqyoW7G/QRYIU0sMXadTs5h8fvvPA0MjYX1XSnIwmWZc1DHsKBND9X1TdK9+0KmYlLMThas11fbP3mGh47f6y6EIqMklNuFaaCOH/6uoCJaNQ+GAvK0PMG08UE7lgpWCx4uJQb83P5/NR3PURfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763101; c=relaxed/simple;
	bh=7kngg9pdtYpQtza0UYmezUYqLMx3hxlD2ZRjOunfoJQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=B8Z+rxh2uG2AAZBb2zj2PtLd1XXYPuLA8lqfLX7snOUPrNAWSTZxYtLpFPTscFA4UKMIy3z5NjCNquiJ8epY1aGlCQFh8z3fBHqbxy5t5t3ihcVUJEF3iQkJo5EkZRHr/qv5NlkvvHNUq0yiTfQ4aW/NAjmXJgMQvCmRWlG0LmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULBwzZbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383A3C4CEC7;
	Thu, 24 Oct 2024 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729763100;
	bh=7kngg9pdtYpQtza0UYmezUYqLMx3hxlD2ZRjOunfoJQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ULBwzZbmzRqEiKMBg+X47y/WZVApeTALq+fPUp0CgDq00Mh+9w9V2ocx6l9qjRzad
	 OEXHKio+E/V2kJX26fUDK+CAP8p3ORql12Q7rQynmue1Maye50WFNfH36vREdRG2EE
	 08XkbOdmfPq+jmfNwapFhBspZxLg188Gnc9rwymRVZBEKEVijjRktE9Y1f47FqvMCZ
	 VPfWg7bnEkcFk3LHVR4bh5sN58ufNf/a6YKf2+MVhC0jJzSYEyQP7Qy4E1sKW0PRFv
	 arCwJY09rMZ0pED8kmfTv0IOPj596D7keiN7DSjfDO4MuCs+/XsSQ7LIs4g4b4fkZA
	 Dpse0VaaF7jng==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Adham Abozaeid <adham.abozaeid@microchip.com>,
  Ajay Singh <ajay.kathat@microchip.com>,  Alexis =?utf-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Conor Dooley <conor+dt@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  devicetree@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wilc1000: Rework bus locking
References: <20241023144125.80296-1-marex@denx.de>
Date: Thu, 24 Oct 2024 12:44:52 +0300
In-Reply-To: <20241023144125.80296-1-marex@denx.de> (Marek Vasut's message of
	"Wed, 23 Oct 2024 16:41:21 +0200")
Message-ID: <87r085n8bv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> The bus locking in this driver is broken and produces subtle race
> condition with ksdioirqd and its mmc_claim_host()/mmc_release_host()
> usage in case of SDIO bus. Rework the locking to avoid this race
> condition.

[...]

> NOTE: I only tested the SDIO part

BTW if the patch is not yet ready to be applied to our trees it's a good
idea to mark it as RFC. That way the maintainers know that they should
skip it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

