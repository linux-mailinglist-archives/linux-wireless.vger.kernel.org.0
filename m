Return-Path: <linux-wireless+bounces-28647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331AAC38D17
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 03:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5D53B6F72
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 02:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42023BCF7;
	Thu,  6 Nov 2025 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fojT00xJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061423A562;
	Thu,  6 Nov 2025 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395037; cv=none; b=ZRzFBcxAxLvqW0IDKQzD6By+rvLCQgPXJ9hZtVzrDryPEpmwoDhOPsvAMkotApjXrP4Az3puyWwYlCiU8l13v0pzt3Y1VfFUmStsMM8+UHPuObzqZazdMOMM+f8z0FkMxildjAAvd2QTKjFmm9GTIC4W/6Kn53GWnnLXIRNrasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395037; c=relaxed/simple;
	bh=ZcJyx2dt59RlKkBinyUSlEs5z1cZarbUevn2CAf5G64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DbmUTPd0Y0QRJM/Dw/RaXm1Mzxj2uKqSF644DOJuU7F6YZrNWTDYBvO0XB2UxOGixlvovbJ5LEV/gGE8mx2TFFQi9Hx2YbrrpuzXpXj9GUHDw9dC8Kf6P7Vuo6i0Ma8b/K5tGF9e8DU58OlC+bg/if1XlDpyy/bgWiYiiuFaLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fojT00xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB561C4CEF5;
	Thu,  6 Nov 2025 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395037;
	bh=ZcJyx2dt59RlKkBinyUSlEs5z1cZarbUevn2CAf5G64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fojT00xJFhkKxumidKAmcPylcTkUSIy0HZdqUuosEOqUi39vFtEGMm2/h2OizYcEY
	 iHEIOgK/AwvmO9uS7rFpAqxXVMgmyGtcx/UNHRB7x7HjozvQLKU+c2+IyVAab8NdRt
	 QdNoq/N+YW/WkgYLDtVzsXC4JzOKIXaqVYpacSh6ldVRKLX/7zJ0i70yuKfUJTpP+h
	 0Kk09l2WC6/lYePs0b+i29l7l30QbUsNii93OcWMFQMr/uKnRJ1Pjap3jqzRge1GtE
	 +6sea5Q4ViFLicPW6gky4NBdcKCeFKDHJhWMGQ6xUK1ocmHfoFzC6eARz/voYHAfgP
	 T7izhYi5jduVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B4E380AAF5;
	Thu,  6 Nov 2025 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-11-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239500999.3834029.3666821078740882385.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:10:09 +0000
References: <20251105152827.53254-3-johannes@sipsolutions.net>
In-Reply-To: <20251105152827.53254-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 16:27:39 +0100 you wrote:
> Hi,
> 
> Just two bugfixes this time, I know of one more but
> that's going to wait for next week, it's not that
> urgent. We also have that netlink socket matching
> issue more generally, so will have to fix that in
> other places as well.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-11-05
    https://git.kernel.org/netdev/net/c/7d1988a94385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



