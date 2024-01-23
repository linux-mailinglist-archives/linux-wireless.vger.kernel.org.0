Return-Path: <linux-wireless+bounces-2390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D77839585
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E6E28D858
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE965F552;
	Tue, 23 Jan 2024 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQI6L1Mf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244415FF0C;
	Tue, 23 Jan 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028626; cv=none; b=HtRq2UCFj7rMfxIbF9Hg+tAq+856qsvJ98CsqL27kt2SUWPi+2II2fB1EDDBa6BGx/yu7GqLBAbEKb6fW3aM6cCafaFw2VVlcogKSVC6ucpHrpyaBzfsJH38XIQXrivebgasUem4r6A3IdTFwAglcGSp01C1uPNH97gPVeeinBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028626; c=relaxed/simple;
	bh=jj3VqLmXB00PzuYsjo8Uwh//2+mNSoukP9msIcVGdLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KkPveWcbBQDiJFaZg9hi6fVdODbtD45fcYle02D3bYG8DU3nCm4ZPYkEO6uoaPQKGcJwiciJjZ6ejYxKyKoVY9DvZjOK0WjzThUJvNydWvKRiqdBZJrqAaCILTbeQUKadxtAq3tmaOYIe49NDyMFN0+pRJD0ZeUA4GiCSnIlOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQI6L1Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A634C43390;
	Tue, 23 Jan 2024 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028624;
	bh=jj3VqLmXB00PzuYsjo8Uwh//2+mNSoukP9msIcVGdLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HQI6L1MfvB1XEpopkMyS5uvL9m2xZ5tGj66Jtg0Oce99Ik1OSIWr9oz005U5ub3hH
	 HvQR/T+TCgBrAaFT4KhXi466DPr2s5+68Czo7/xWtaTuLA+DNUFfRjGJpCciCO3e4G
	 0k9BLFuBaGbkuZuFS+Ad1RfegC2kEwkpWbI5A6GLIAfGdU3EzyCdGEdIbLkrwRhqIs
	 UzOq4MfPpsFs9ksBW7CqrY7w5hBmpskNfmyhA4HnqrAv6P3gGHvgnOW3Z1LlgO0YdY
	 VMbt6TK8jkdcEvdQwHQJM46O+n3kbn6Fw1Xewc0RJ7ecqafu/zF6MZHQykkY6vKddC
	 Dsw5AQNCO6gtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CE59DC99E0;
	Tue, 23 Jan 2024 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-01-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170602862444.26209.8351727968153583754.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 16:50:24 +0000
References: <20240122153434.E0254C433C7@smtp.kernel.org>
In-Reply-To: <20240122153434.E0254C433C7@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 15:34:34 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-01-22
    https://git.kernel.org/netdev/net/c/1347775dea7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



