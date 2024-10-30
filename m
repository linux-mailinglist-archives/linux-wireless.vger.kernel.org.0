Return-Path: <linux-wireless+bounces-14693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A819B59C5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BD11C22171
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EC193402;
	Wed, 30 Oct 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWpbMUWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93449450FE;
	Wed, 30 Oct 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254224; cv=none; b=XoJuk15HvqdhCKpZaqHL/Z70BA3R1vPYjUPR2CcGi8nNJz/reXv59UVKnj8JtUzD4/bN4AcVt1JBx36uPJOvynSxnm+HnVdA0OrtvYtt0DF/m9aT8widM23blkX/9ZeZGjTwTVxIGaIHKLVCQFPXwStTP2bqKk2shFX7fM5AG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254224; c=relaxed/simple;
	bh=2Bo+tpdN11mOq52ImKkDh71pKFNpp7fIWqmjKTRvCGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlfldxSum1mIIsJtq4V5DmeMEgYg4xQbxCMIRZOR3U491IT59GKfAaEIU61tVwBIaUXDJPnrJjWcVWDxjafXjhqZw8lc0mY+dsMuhWJ+FV0Gt+4QEJMjhAn0Kbh2sdyuP0DTbCsXUHTb3sdwSw2dZgqbjnsTIxeUfw2kWCynflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWpbMUWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1982EC4CECD;
	Wed, 30 Oct 2024 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730254224;
	bh=2Bo+tpdN11mOq52ImKkDh71pKFNpp7fIWqmjKTRvCGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hWpbMUWaoPyXT5bFqE+8T2ozwB8uuSUoX2BQ1NV3wzaYMCUababLrgi8kf8J70NIP
	 1AkUodqXzUJaBfSuawVhDzzhBGgA/c3/9Jp+zC+ZKxvGVKqJqSqnhVr1rDPbN/Obx0
	 yMcDcIOXo6uaamgK2vfVEJQDwtSLoPcyzcpaF4qUtFjGsXLnfUx4kjypl6ysiv4mVV
	 pU6EQ1FYzDke86Mx0ssL3DGJo4CgSFVoJ/tncTnJ9RZ3efZhwFzBl9yhOslpLnY2SJ
	 7ytPFLzvEqystgXW0/sT7/UJ4zY0sDqBHoN8u7vySSoyIK0JEE87mE/xhp439J8tOr
	 U2VVgjgj9yCPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8F380AC00;
	Wed, 30 Oct 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-10-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173025423177.887219.6294992792386958614.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 02:10:31 +0000
References: <20241029093926.13750-3-johannes@sipsolutions.net>
In-Reply-To: <20241029093926.13750-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 10:06:23 +0100 you wrote:
> Hi,
> 
> A couple of important bugs were found, notably an infinite
> loop in iwlwifi but also other bugs, which is why we have
> a new pull request so soon.
> 
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-10-29
    https://git.kernel.org/netdev/net/c/c05c62850a8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



