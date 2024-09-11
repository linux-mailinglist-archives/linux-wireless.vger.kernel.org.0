Return-Path: <linux-wireless+bounces-12801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36D975D42
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 00:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D2C1F22873
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 22:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73B1BC092;
	Wed, 11 Sep 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz0KHvbz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE51BC090;
	Wed, 11 Sep 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093845; cv=none; b=NS6MQjh/zLR6PnxjcTbv0gelgyMGwoNfJiD594mq1pJpwUMY5VEWi0Ris0zFiZg2FZ1DXhx2tqbyOC7MtEKnmKeX4B/rHogNeS90tMWahloD3YIwaZrb4JP00Rp7htV3enOCChoPglQ/osQ2LrtNXRW91MZg7a1T1tQ6ny9Lmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093845; c=relaxed/simple;
	bh=+0RZQhXILzmEw8W3YzujBZf0t6vLdLC6oYp/GoPl910=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aGJUfksQhCgv7pHg2k/4u1otR5T4evL2at7CRO6MOCwducETMMs9CiD+CeJfffWbLsNzuKv2DQf4g8qY57+7AINrjdughfEpCAjqUx7xtK1a1rgc+0G2J7qkhYoO/FYNV3cEkWiRVVG5lajA6mN2yB7zfFFQ9TUHH48PyCMv5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz0KHvbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BA3C4CECF;
	Wed, 11 Sep 2024 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093845;
	bh=+0RZQhXILzmEw8W3YzujBZf0t6vLdLC6oYp/GoPl910=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oz0KHvbzJru83xqhtkk9xFFlx5NB+1NIP0HIUH35GNWs1E+db/vuxJPoVJ+FEEnY4
	 cK1duUdu6XIXjzP+Xfi7ZJ0mdK660zD/aeyKLkpQ9GSCmlK0Ixo9jeMWcVU0NmpPfc
	 eZAA2fc/hjBS6CpPxwmoDe0NsObbBvtvPBeyIOdaCo6ed877SDWLLfm78Bb4WAzLqt
	 y9WdCbZ79L7NmgNaTo7HVkeu+RXL54SbV/bm7DZ8raHq5kYUThoIbw4Px/YtIjhjJY
	 hUvexewI+qrzvT4gJk2MyhAMOBT+SCkOCKfpQ4fKEv74DPT3IZfo436Gz5ey1qw39I
	 GMtG4Dagq45Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE73806656;
	Wed, 11 Sep 2024 22:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-09-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609384625.1065358.6518424528532813444.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 22:30:46 +0000
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
In-Reply-To: <20240911084147.A205DC4AF0F@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 08:41:47 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-09-11
    https://git.kernel.org/netdev/net-next/c/a18c097eda42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



