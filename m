Return-Path: <linux-wireless+bounces-16642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22639F8A5B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 04:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A894166B15
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545782943F;
	Fri, 20 Dec 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV/TTlCi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2781C6BE;
	Fri, 20 Dec 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663637; cv=none; b=axHbWx0gE8iof8raPRAVyot4LdkqjuVuaZDHJVDpjyAb9Bh0U8yDSKjutQWWZpQ8/9C9lUPNdsvLmDvZJ75e5FiU0+tlMXLNn+RF2Sq6+UUL1rzRCyB/xpoKMJ0TBcgA+Y6D9HOujMlUEvBIuj1jvppvhi6rNsGY3idFC6BnIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663637; c=relaxed/simple;
	bh=yKxVJm8zi4ZfAkD6NJEcwbiSgDzwZVJiHPkqyqebDq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NxjXtTaRl6XA4LeEMO+j0XxcdMZb2ZZnJym4QSzulFCJJaamTCVgjBoGFyoUvoQvtGbRJSULTXvTIBdyjpmcOvxg8hrNzGk7SguW/W1Kach25fO3AhfIKweq0ThprWA4gmZLuB3A3UePEQG3iExWi6ib1UODF+pXHt32sM0LsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV/TTlCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FEEC4CECE;
	Fri, 20 Dec 2024 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663637;
	bh=yKxVJm8zi4ZfAkD6NJEcwbiSgDzwZVJiHPkqyqebDq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BV/TTlCiXLWYVwdFpj8w7CGo53I5S0vGAYDCKAP97pxKR9HfoVIFJTiFlrPn3witf
	 wk60C53DGkwjQgJvadd4tGLJWCWicvvhTkfpP9ZG6yemrTotVugQfTy+Stp2hl8+Wg
	 JL+UtsaZQU5tdRqzIH4X/gjfVPAtxgqVJVrvxqbWz7X377sTcKmXcRz97y9LoBzPWC
	 vx6bVpfaxHZImw1OmAaeOUcpkAEpsB20Kj7dIjHYT180xkVr0ZAUOJEeytJ6Z+k06Q
	 uZzyzdczkyJr15ECtiTVYgwI3kkdaz0X86Smg0XgDYSIlpQLHmcvJWpsqO1COuLdEh
	 44ASmtkGvPacA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3873806656;
	Fri, 20 Dec 2024 03:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-12-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466365449.2457691.12871953420029941998.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:00:54 +0000
References: <20241219185709.774EDC4CECE@smtp.kernel.org>
In-Reply-To: <20241219185709.774EDC4CECE@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 18:57:09 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-12-19
    https://git.kernel.org/netdev/net-next/c/e8f33238052b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



