Return-Path: <linux-wireless+bounces-25238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B58B01038
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16633B04FA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4A182B7;
	Fri, 11 Jul 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH+ENxcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA2134CF;
	Fri, 11 Jul 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193843; cv=none; b=IrME7LdeUmpEiG0kXDgPZqgKuuaFwnRZ8IRuUIK3ksvxVeuuU210GvPrpEJbwTIrc8mhPtlBbs66LoTKiRruoRfx9S6yqf4y7L8F0Cc1qI/LRqJwcRLiijH94+Y5QNLRdOsPwH8Q404wqPUNWggsgaFp5FlVuVPdAN7f1ti9jyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193843; c=relaxed/simple;
	bh=IbAW8Ngs1E9Vy+31aHo7Xar7SazfvYjXRBU6WqoJB/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F0Kz+XtzB4SqGaSk/T+qIoJRaAOiZqi7aSOlCFt7FAROzXoi4EWqge/l6wqarGtE1KbKHaQ8NH4g6FZpiKxCb1LZ7ViH8ruGfcV0m/v0gy6odrmz+6HYuNG1n3XXFXLbXOYd8Y0mNagnOtidJs1CUdCY57htTIIc6RzFBSKRxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH+ENxcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135E4C4CEF5;
	Fri, 11 Jul 2025 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752193843;
	bh=IbAW8Ngs1E9Vy+31aHo7Xar7SazfvYjXRBU6WqoJB/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cH+ENxcGDRe7wXfwfrF+6kl2oJDv5StAoZMFGxXTgbyIoQY60Y2JbcC/MIBtfjV4D
	 Z8SuzbODNhyOtmnVVBSQrnZ3yZ61R8CCq8Xfjx7fEjB63bJ9J0+tIKm0KerbAHtDw8
	 Vgc+eCMV7TYRkk9rHvADWs/DfwvdgTbu8JHEBejfFnOZKMrgKslXXT2vkmHOHYWkHp
	 46Mr7ixlCYd4yJDUV+zSQAmJJ9nwu00spqZ+M12KwRictWaQfpzfkkNpfBkRPlJMi0
	 BI6DaHCDZhbxHB3rsse7WPC1DKLQOpTdZXqjCEJsA1ILdR6jLoCWwpMAbAmbKsDs5w
	 k7F7ThiaNyUKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBB383B266;
	Fri, 11 Jul 2025 00:31:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-07-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219386526.1715084.2808725188836361745.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 00:31:05 +0000
References: <20250710123113.24878-3-johannes@sipsolutions.net>
In-Reply-To: <20250710123113.24878-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 14:30:48 +0200 you wrote:
> Hi,
> 
> And for -next, some work. There's more pending, but for
> now this is what I have today.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-07-10
    https://git.kernel.org/netdev/net-next/c/809f683324df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



