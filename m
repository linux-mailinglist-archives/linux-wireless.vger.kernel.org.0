Return-Path: <linux-wireless+bounces-4502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A5876A35
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C511C2123C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9495380F;
	Fri,  8 Mar 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56hgiTy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEB51C4B;
	Fri,  8 Mar 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920245; cv=none; b=G8yWlH7NV2+UrI9YQdyUr7kZEGwpoSqI+mYFXSLgqddzFpfFmbOwG6FLh+fhK9LjPFvg1BkLPogVCslyziqqtt4oo/0kN9+VL+TU7qkKM7syEupH2RNIMxsssLfxMYnOSMrsJM8hVEIRBa6i++IC1bQKA2b0iG/wN8aPaXNfcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920245; c=relaxed/simple;
	bh=A+hvmdLaV/gTU/Ui6twpNLDf9/QkGRWSw9vHS3ATObE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpKVN4onjRICxnVj70mXYLBPcq+rOXANkJYVFX4jZK8+QeZ1RHWigyUbDCIJFk8cBZyqs2LBpOqti4N0rgORSPdF24LIDE0ykrIm6CK5Mroo3M15PFKJxTHPlQCKsH8rGqUS2aCombmtrwzI9WzDyqunX/rnjlg9s4inY/5YQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56hgiTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 971CAC433F1;
	Fri,  8 Mar 2024 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709920244;
	bh=A+hvmdLaV/gTU/Ui6twpNLDf9/QkGRWSw9vHS3ATObE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c56hgiTyGicInhof79N01EiQMmsFNonjWrHUqRpCf5/DvGX0856zgxCy/nf/NV6EA
	 FgCiBXuJCuTZ7VqvDVHi4QX7VdYMIlIv7l2AnUDhdhv5mwF/mF7aa3xufpWGUq7Ag0
	 fR5r1k/O1GnkKgo2Z3QagEpJIPrfEYFL0rvhhqnIAKb0aKYLatynKWCQTiWJ57tuIV
	 kJ0MbCw+QsMVsL3amFr3SeFfczxR+gnCXTh7XaMrRrefchRAyH1CNEKZAxC1u6VmzE
	 BcpWDkq4mPD8geplk7kjYQQABzen4KvHKJmbL4jqO6viQbKQgjzwCBik58XSCizKMo
	 gJGKMzxYMN3pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72B2AC39562;
	Fri,  8 Mar 2024 17:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-03-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170992024446.15593.2682606960737891240.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 17:50:44 +0000
References: <20240308100429.B8EA2C433F1@smtp.kernel.org>
In-Reply-To: <20240308100429.B8EA2C433F1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 10:04:29 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-03-08
    https://git.kernel.org/netdev/net-next/c/75c2946db360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



