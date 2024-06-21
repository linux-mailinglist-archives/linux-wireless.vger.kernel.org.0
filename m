Return-Path: <linux-wireless+bounces-9344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1A911907
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C20DB219AA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E1129E93;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfB8uDXm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443D127B62;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718940629; cv=none; b=nJr37RRj4tRj+4w+uX424VE4SQiLnL0FrpwNxSkM0yTYtt5UbyI756OQ4vrpt/ajXLReeMBTfUYykR0wrDGuc1fQqeE5U+JKsELVHTOQwpKe8apB43jr10RM/xoLnF0TfqrPBJVJ8unyPd0scGUECwy+B/PwjS1jRFLSUxBMeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718940629; c=relaxed/simple;
	bh=otEn1cv7oa8TtZVWWFCQE/YHru0IofZ41yc8h8GL4mQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9H3dUk21rTnCwDn6lFYWYGz+Yp6DnwkLby80fIEqjuKlHR+WL/zW8TdFy90fH2nyYVtAVEKdRYj3eMfbOArznlzapwR4MopaBq+eyKhoeN61YsrWtX49zYjVQAdcMEVwLNRV+rwOn/RDlLZwzp5E6HKKIRUJ3DyQ3d+3NNErKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfB8uDXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C499BC4AF0A;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718940628;
	bh=otEn1cv7oa8TtZVWWFCQE/YHru0IofZ41yc8h8GL4mQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qfB8uDXmmaMZSrnXfm2us2Mtlis0cZ1CNVVkbLPmY5Krk+KW/CdZx892kH8GE+lfu
	 /ZBrlKbOvfnlvmbtimZ7CbsW/h6TlfJ8kI4Uym0TjhdUFE7omZbvp3aWLKEfT7tbR+
	 Ut1AhsKBD0j/6IDfYgctWNF8eBfOGUr/ohEV9WhSyz4cyetrAZNpbs3IV84BUhS7v2
	 2BOM/2JYraHhYHGb0U4nokQ2w+uYvqfBgiEJag26MGDdGnJ6e9pb7HolZGC9UztGu7
	 1SEYllkjzHerb3fH7abSrmp5Hd59cDTFLvS1kukgJCzMzZSKLxPdVxNcXuU+ai/xiD
	 ipilL4iHdvJGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9A01CF3B9B;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] wifi: mt76: un-embedd netdev from mt76_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171894062869.32761.11202988972119969537.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:30:28 +0000
References: <20240619105311.3144908-1-leitao@debian.org>
In-Reply-To: <20240619105311.3144908-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, horms@kernel.org, kees@kernel.org,
 Bo.Jiao@mediatek.com, lynxis@fe80.eu, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, leon.yen@mediatek.com, quan.zhou@mediatek.com,
 lundril@gmx.de, sujuan.chen@mediatek.com, chui-hao.chiu@mediatek.com,
 StanleyYP.Wang@mediatek.com, benjamin-jw.lin@mediatek.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 03:52:36 -0700 you wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_devices from struct mt76_dev by converting them
> into pointers, and allocating them dynamically. Use the leverage
> alloc_netdev_dummy() to allocate the net_device object at
> mt76_dma_init().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] wifi: mt76: un-embedd netdev from mt76_dev
    https://git.kernel.org/netdev/net-next/c/08f116c9ea6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



