Return-Path: <linux-wireless+bounces-14694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1579B59C9
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF707B22117
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B03192B79;
	Wed, 30 Oct 2024 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKRDE8KS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB0450FE;
	Wed, 30 Oct 2024 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254248; cv=none; b=dR9QySLa9iSqY+2glQlGeT/fqcd2yh0P3ZxehQdtdAl/4xrZ0aOYelku+vaFjECH9FfThrq6xHfgtHL+3i2KgQ7w2c7DXhFsJjqKTzPB7rgHOUCEKj1S3dfW9UkAWha+JSBkpU6JIlKZJ2zVBwJ1JH0m1d7WJt7guoxo22Gwq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254248; c=relaxed/simple;
	bh=o4IStuXVih2RWC0pjl+5jWp3JWKvkawrSuSJaw41CRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EHmIHBGQlIQvPwBFcAx9qB0ikt4AxAgBL6eZw/t5UTxZiKNlF/yEmDQ6X7B6eA5NzSU3UcXZnK4rUszx0791gOjm26RyoMP8+bF50dqTXp6rlwy5XJv73+OAUUzTMWmULx5IqBJ9PLopNZxHty0yGfXUG5XjYAacULkJOQWeeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKRDE8KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22722C4CECD;
	Wed, 30 Oct 2024 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730254248;
	bh=o4IStuXVih2RWC0pjl+5jWp3JWKvkawrSuSJaw41CRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKRDE8KSuOWFD6wHMPqM5LYZ1gJfPZC6kQFKA00pkHODciZWSRfads/1VmTI/rL9Y
	 S7iwyFHVlWlSNZz6C+EwJQKB285bvt5svLw7318aqYrNmBXLnMASo4i2FzxMkfN5Zz
	 Bi+Lpcna9UQQI5Z2NBdBAho0yq8OAJ7Bb7Q1f5mzZpH7uNu2lwdrfVJvKgT2ZyiGCj
	 yvBV+jb1uKeTRf3MVhItui4tTxZuE7mi5+4WtazZ9LdrA2YtVNrs2sVxxHcNCgg1xG
	 F0/JIyBS7vLF5zxF7JpBSdTy2T9UPeWB4s+OkDRxjl7LXCkoXja5fGlPQeXcNPACl+
	 3qBGS7mH7RT8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD7380AC00;
	Wed, 30 Oct 2024 02:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-10-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173025425548.887219.9646740073157404590.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 02:10:55 +0000
References: <20241025170705.5F6B2C4CEC3@smtp.kernel.org>
In-Reply-To: <20241025170705.5F6B2C4CEC3@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Oct 2024 17:07:05 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-10-25
    https://git.kernel.org/netdev/net-next/c/71e0ad345163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



