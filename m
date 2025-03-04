Return-Path: <linux-wireless+bounces-19774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A6A4E9CE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FD24241A7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5F283C86;
	Tue,  4 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq7zEUQd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91982281375;
	Tue,  4 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108820; cv=none; b=eGJwHBIEQviT5mU67d2/4KtAyYkerYswh7SUn93jpdOgJYQNLNQYx66xCIUKJJJe9k9qtvv0S42pJjVhPrOcIHGracUbDSsuDwuQJYOnQkFhrHUrgq+0c1oggzrEGq1FD547eSJHmqRAaecKC+65/OCIWvuOPT7al5YVTUf+mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108820; c=relaxed/simple;
	bh=9I3tKO8zDv2JU3sF3lxuDWV0VacRsINVYT0SAF8yqQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CL8mHMIzd4Jr5c9CDywi+VnN17AdpTPlpqIhf4u2dW8bEdqQc7t56DLqOBW7UvR8aRxpJDgIRPCUrE9P5BvcFwqHXUETZp+QoVrKh/T2KUY5K+3vJMhT+fxXOJ+Vz+oS6mG+DSqSr5+AdvP/IzT7lMQs+HDA4RHTd7PmM5959Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq7zEUQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5B4C4CEE7;
	Tue,  4 Mar 2025 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108820;
	bh=9I3tKO8zDv2JU3sF3lxuDWV0VacRsINVYT0SAF8yqQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uq7zEUQdE+xNFRNZK0KT0/ntbi8mPXdbg+IiTNt32J3QGMP3yz9CFvDBuqBy0TaWu
	 1m6IwN5y0iS9Qv7y1jqK6e3LVj2CNV2JqpiC5GgJ1+lAr1O6mXWrhV5/ur48+0KChJ
	 5EP6TjRQ2oNJmVGRAxdmvQ/rgphMXudl9t8MfK67s3H4VkQ0ZiK2zulhoEtjdgjDDO
	 2TVs3VP89pGDh59r+Uyn0XoA2oSIMa+gP+4CYwh3MV8/yYktSr8Tpx5V3ibhW3led+
	 tPFBN9PktL1mPrksvFWjWo+Eu/CYZsTwlVMePws68GZtM7qYHre0XKfNYuBZikdOMV
	 Fed9egeyzWTuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC4380AA7F;
	Tue,  4 Mar 2025 17:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2025-03-04-v2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174110885298.229776.8496520049877393323.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:20:52 +0000
References: <20250304125605.127914-3-johannes@sipsolutions.net>
In-Reply-To: <20250304125605.127914-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 13:55:24 +0100 you wrote:
> Hi,
> 
> Here's a first set of new wifi material for 6.15. It's not
> that much yet, but it looks like we'll have the new split
> out driver for newer Intel devices next, and then some.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2025-03-04-v2
    https://git.kernel.org/netdev/net-next/c/71f8992e34a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



