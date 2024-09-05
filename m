Return-Path: <linux-wireless+bounces-12511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98696CBC1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A4FB2335E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6A38C;
	Thu,  5 Sep 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa+4ulVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0D440C;
	Thu,  5 Sep 2024 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496248; cv=none; b=GnmYKeyAjieelWXMOphGd7YgSAaL0UJa6WMLPmmQXZ4gWV+aUTMttOc4mnHdbC+PPrDYRm9TWnW943IJlaWsUr7JT5kCek72QelWYVlyoikWArAZgp/wcrHJnl6vV7bhe0gYGawSEKOr1t/q26IY7Vy2BoW2aYrVA1d14NrV1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496248; c=relaxed/simple;
	bh=ZOxA0tc80ws3/h9RZ4QUKMunHgtR11CqrVzZL3CAeBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i/teduMtap3dsdU1n/+Y15GSng6gc2OVChv844+IAq2f0ZSZyxjE0khgvSHEDBaLWFLbtQfsCt7NhzkDgBJqioVeMdnEFpbvh+Mc+BhEf8yYKXxaPaYwjb6/Rft3IwQV96mF8JXjKdQURR+lBTjK8O6poQgBstzSmnXzAIccjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa+4ulVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B32C4CEC2;
	Thu,  5 Sep 2024 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725496247;
	bh=ZOxA0tc80ws3/h9RZ4QUKMunHgtR11CqrVzZL3CAeBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sa+4ulVNa6OL5LP1Q+8/e+Docgmvqbvk+y8xkp6FxQX4SuqTfFWEtGFAYmCAe5kLg
	 6sC0sSIBf03xmhFD36tJDLegSZi0GuINyELcJjcgxCChWNgZT3577Arei8but3dvNb
	 e+yx6oc0hDonYIcFlRjyUCU+Y6gyISSFA2AD8be7kG3j/ZzVG/4TJq04xdspU8k8Qr
	 l4thIKge80DTGDs0q8RiwgD3Kn4aG2P5qpIWIx0dXAeMnMmT24iM3yCjZ6HDUmmgDb
	 cfRjLVvtUiYV/oiJtnPru7KMHOHp3WoQd+bWU2l1XTk5BNY99avS1hbY92alx9CnT8
	 mXEi3YeuesTUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC13822D30;
	Thu,  5 Sep 2024 00:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-09-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549624823.1210487.11680541007570530680.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:30:48 +0000
References: <20240904153205.64C11C4CEC2@smtp.kernel.org>
In-Reply-To: <20240904153205.64C11C4CEC2@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 15:32:05 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-09-04
    https://git.kernel.org/netdev/net-next/c/43b772448710

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



