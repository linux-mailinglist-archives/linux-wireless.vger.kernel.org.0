Return-Path: <linux-wireless+bounces-19772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F185A4E8AB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A3F420963
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5525BAB9;
	Tue,  4 Mar 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTsMnrD0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B082C3752;
	Tue,  4 Mar 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107603; cv=none; b=hC+qEqFP1mjplKkL6bXWwJLem2D6g0lKBvUZ9SYnQsQV7nP85P+cZmUftcgSm69raOfUZtjjCxKbENU468YRpmjvEgJXQfrFgEAfSrcIR7H3eaq61d0rFii2WxZxIuuIsU6ogYBWYiZs/6ICrsBNNZVokEo2uFtyxse39uTAzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107603; c=relaxed/simple;
	bh=JYneFAyU9t/o0Q1mwjBcqdk8nQig06KmAYXko3nzU9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=obRToFBQXQuC9YlkBf8wZo/87LXJUNed1DkwVtwb0pg1mo2185nveqQgEkoC9Ha5bNgA4O80G0IIh3dN3mHIflxSEDSmXFgPQBqfdCvLt5KYYmHQ50O8ye+kMqJg5mFt9s3Cbg1GKCS2xFWhT0ow3alFizrGN2TNJehj6odwNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTsMnrD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A32C4CEE5;
	Tue,  4 Mar 2025 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107602;
	bh=JYneFAyU9t/o0Q1mwjBcqdk8nQig06KmAYXko3nzU9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pTsMnrD0B6LAiQHsc8DVANUB+mpdiqRZTL9Q5IOBYUonBOPkGZChTnsOhYeUDbATk
	 xQeDeRZI10UvFYPJgwHuCNDx1QVl7NG6MQonkEpicL/WL9xsxI7+IqxAzKh8nlnVgz
	 FlUZ3m6AX8/Fpztjnmedzu+nPtJ2mclWLWEF/Jr0zdw5plSEZmMmT5kbBwSj9h6mQc
	 x8pSnUensnOypSd5Nsf1itzDXvVPAz4JQJJMrGWDWjnpg8hL+/rSKn0Fvwy0S/K+oY
	 a1wW5ixSe8oBHENiT44qD1Q1/HOhmIv7JlFLRR4fjLpU/0xRNdqj8PkcMfXVfOAoZZ
	 BaahumoT3JE8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E66380AA7F;
	Tue,  4 Mar 2025 17:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2025-03-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174110763501.220181.14387766968336222382.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:00:35 +0000
References: <20250304124435.126272-3-johannes@sipsolutions.net>
In-Reply-To: <20250304124435.126272-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 13:43:18 +0100 you wrote:
> Hi,
> 
> Here's another set of fixes, sorry for the delay.
> 
> Please pull and let us know if there's any problem.
> 
> Thanks,
> johannes
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2025-03-04
    https://git.kernel.org/netdev/net/c/3c6a041b317a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



