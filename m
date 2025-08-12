Return-Path: <linux-wireless+bounces-26345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E196B23A91
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6326F1B6626A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23302D877B;
	Tue, 12 Aug 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgytJMWm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43322D7808;
	Tue, 12 Aug 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033618; cv=none; b=sDTuny6l96re955Um4k0bkOiIzNQJj4ScYZ01IdWDOJYVLqkzXpSMiw2gVpKWi4Ble0vdooWl/dHd7VKj/NA5h6b2aRocy5xO9UG4k+IBgbAp46rAnr+8lAOu2bcYC+sEvlkLCMSi64HTtxuw72Z+6UnLDYpsxZUi8lhw8+ziBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033618; c=relaxed/simple;
	bh=C+KttgTZ2avh2OL713FKvz8YyKV99KKUUR2nqlakuUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fLAf4q4R9gyqGEjQEOIyI7nkb4byTVdEdbHHtrQNmmtdgyG/Tw3/bTS4ptDm2RjmS+naniyV90ExiqI1VXbeiACltm/7fvWpqWPnFXwP+/6Yr/cZzThvKmBk+bIm4ejxmF4/seChtdfRa0ROYTSr2um2Xbe7BVveUWDRyLQF1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgytJMWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827F7C4CEF5;
	Tue, 12 Aug 2025 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033618;
	bh=C+KttgTZ2avh2OL713FKvz8YyKV99KKUUR2nqlakuUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgytJMWm3/0qZvHyGUr8HrkftmMw+XIFpSUcajD9c4i/h6Kkenko833K4exGhIWRt
	 Pd7XhSi3/0QE5XuEOTxh6Tqk2DfTJ6T8NbNILb6jxXsXO9yVGKEZ9O9+5gClL98HGr
	 gon02Q9tkV86mrE3nLuwT6R8RbdT+0lmBryxAU/0+4jLgn+jbcJ6TgOB8xcRA5YvYG
	 n8YDP+356eRCt2bTXboU41O208hTV4/zw/+pEp/Gn69+ggOJgE85vKn7XzvppjNe2O
	 P3CJqhaHribQXaMuCpYfIh9iyn4vXU1GiiNw2iY0ovZzFG9Y0MEHYAs/omi8CecA/K
	 nscMaczaZIqsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDE9383BF51;
	Tue, 12 Aug 2025 21:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: nfc: ti,trf7970a: Drop 'db' suffix
 duplicating dtschema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503363024.2827924.6313629408379264166.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 21:20:30 +0000
References: <20250811142235.170407-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250811142235.170407-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mgreer@animalcreek.com, krzk@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, conor+dt@kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 16:22:36 +0200 you wrote:
> A common property unit suffix '-db' was added to dtschema, thus
> in-kernel bindings should not reference the type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: nfc: ti,trf7970a: Drop 'db' suffix duplicating dtschema
    https://git.kernel.org/netdev/net-next/c/f8262b8dadfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



