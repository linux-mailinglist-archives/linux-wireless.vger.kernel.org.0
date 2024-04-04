Return-Path: <linux-wireless+bounces-5854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E2897DDC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 04:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1051285A63
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 02:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F61CD20;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="limjUGjT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BA1CAA8;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199043; cv=none; b=iLcw4ZwrVgfklCinPDmhtiqo4FdSE/3N0y8czww6LWyx7EjYqSLK5iK4XfSyqy6+TAt6UxwF72RkvXSFFftu7V11w7pdaW4YefDNZSl7YMJcPNGRrNwP7NDAVRsVmLbSymMu0lJfY9hXRbWUwUPw7adClFsyIA3CfT3QzHGe+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199043; c=relaxed/simple;
	bh=fLLhdICbSbYMyMYPr4eJBTupZKW9tjY+NKcxxmVVcis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldljzk2iyLdipGxGBfa33/erAdzF1l5oYzQvIdJcaaxivF7bTHTS/HV5jAmXYo1JOiovioRt8JXt3bvNESvJWwMWOmFgpCULfKkdFqKe7X5JQ8aq8JvAm7rH2tc2oErqDXNAtrkOXR+fmIHnvktT/AjBlZeZIpafL0kiDZR6mbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=limjUGjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43B42C43394;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712199043;
	bh=fLLhdICbSbYMyMYPr4eJBTupZKW9tjY+NKcxxmVVcis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=limjUGjTRjNokn4OBBNQscQdSbKHr9GhFLPRk9rU8WDKLslldthVK0OnggBe/pI50
	 VZZup/2jyf6ekuN4xVnuWkZNB+vDKNSHs25KqTDghR5C/VSTM81Aam6FsODGVZ8DdD
	 aOWfUE/dBaNF7JP9D98sKPG1VUyTpx43i9K4oeHrGAMLp5eTo+ngNmbLszF3QQudh2
	 7LzJ99Y2n9wp9ORPEuHQ1WDSjFq7a3aOcJJ42kZz5GQTCHXyksBqBnW00DcP6XuD5w
	 PA3b60vxO8rZGNrQ57d8dhRIGNdQS8trGE6HVo8GBqWWx0X+Hr1GEUjNr+XKq6NPuH
	 jD4FAWa+xZ4ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C894D8BD16;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-04-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219904317.5496.10294522118952771698.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:50:43 +0000
References: <20240403093625.CF515C433C7@smtp.kernel.org>
In-Reply-To: <20240403093625.CF515C433C7@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 09:36:24 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-04-03
    https://git.kernel.org/netdev/net-next/c/8c73e8b59593

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



