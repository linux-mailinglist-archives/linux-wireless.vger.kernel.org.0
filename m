Return-Path: <linux-wireless+bounces-12189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1A963688
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 02:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DCC285D52
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7622EF2;
	Thu, 29 Aug 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfBDRCzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026D1C6B4;
	Thu, 29 Aug 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889629; cv=none; b=E/3m3+6jAGWtXjz+1D2R78IhF3EZsjIIylmKrS0zd2TerDIeofLrmxIKP4g6LbMKNWr/fXh6dklGEBbcD3nhmsn5TG00Ki9j5UpT45+Io9lbv9psP82OBTHh4IlrxvlvRZsv6nGwJIOpkGo/r4eSEphAwwLOaTgs91qaqxbEPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889629; c=relaxed/simple;
	bh=fxT4Jz8+7vQyg9peDeNhg/RmDOru7iF/eU9biynwK0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I7ZEYIoQelL8UF0EzOr5e1nVXvuYqMgsVVdvj0awDbInH13TpT50RYVwDqheTJMNUKbzYTozkVRLOqBxY1NND6mZ8I+GXZWVradgJSlsXnwuKBNwk0M1DHbmVOw3+SvAJyezqXfmDn2n7IczzsRqKMEXzzbaWZcU/v2WOmOotCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfBDRCzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A0FC4CEC0;
	Thu, 29 Aug 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724889629;
	bh=fxT4Jz8+7vQyg9peDeNhg/RmDOru7iF/eU9biynwK0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfBDRCzfNZG7lZis37LkWwmPw3VmaqJgMguUrToVv3+NfZY/Tp4oqxid3THgFK2JJ
	 Dh53GzQhlnKmsgdxzS4bskLGzax38koEcKDRB4BFgE4wqS7lFyUMo8eg97tEW+zBog
	 2ismwrC+9+w+crmVjZUKxpU3Jbn+V/qtFwHKX2kZkh3BwL7L/sbS3dadT5LWOqcG0N
	 FDFsZTqu8cuislPFOsEFdDK3dYY7bXGJyye28xk4AIQHWCqjhLAG13Rnv/nVaQDkbo
	 aJdBaFlu+SJvhwAcXcBfmugtlfBNcMva6ZeHLxWj+GiairTNVTtpJcl0RWP/Hg89/2
	 XtGSiHX2p2h2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D213809A80;
	Thu, 29 Aug 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-08-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172488962927.1469665.4899333321234828298.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 00:00:29 +0000
References: <20240828100151.23662-3-johannes@sipsolutions.net>
In-Reply-To: <20240828100151.23662-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 12:00:33 +0200 you wrote:
> Hi,
> 
> Sorry this is a bit bigger and/or later than I'd hoped
> for, pretty much everyone involved was on vacation for
> some time. Still nothing earth shattering here, just
> quite a few iwlwifi fixes.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-08-28
    https://git.kernel.org/netdev/net/c/41901c227e00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



