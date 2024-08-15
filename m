Return-Path: <linux-wireless+bounces-11449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20053952868
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 05:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D175A285AD8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C233B78D;
	Thu, 15 Aug 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkriTdDc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441733A8E4;
	Thu, 15 Aug 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693830; cv=none; b=XOPmOO/Zdb+BBxM1LtP+76w9BQZjWgJ1YJhSv6HZ95d5JamvReSVVCU/x++yc61+s51Ko1cMCGbB2bYxy8/YaJ3hrU0/2DOXDZX3o17A2isZIzVzlWgndxF0H8VhVF9FwwduQlomEYDzkZYx09UWHOoygpVFTlwrnv0pFy15QHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693830; c=relaxed/simple;
	bh=J6TfNCWEdlDz+aaatL7+SDSulzyogSH2fGSrxfcBNpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S/Wq4i81ok9QCvU380blGqHPuBkRw2PIpjUXeOVbLIWGYT3O3MAqMuuq17T03WH2w6dAMaAse6DRiu/lcpLjYqSx6M6vEwgUlW73fkD2pxkeZqupbj+8rIm/drLzfF6LonB9ixkZwgEnPc18AraNybyQOZckU635YfmST8l5kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkriTdDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11766C4AF0A;
	Thu, 15 Aug 2024 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723693830;
	bh=J6TfNCWEdlDz+aaatL7+SDSulzyogSH2fGSrxfcBNpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MkriTdDcHGNDFJi25X6Rd+TMlSuL85QHa4R37E8bBktSnUht8xm0HT/QBqD/TP2i7
	 2GMgy8nLUsuPXoPTJYxxOZX4Eb0v6aTOd+y28+Ak2GzaqsHj0FDYB3+DwRkbqNO3j+
	 H7kqng5UAHrRDM2FX8KjNgxBusTCHtKhTL80vo1TNHobCch7hwucxCS2BfIghoD3NS
	 2zxAYU1dBpnZIcVC3Z8o8gkYGpuh8wELox6c/Junz3WPWN0ivjJPVi3HyUclZAuF5H
	 nd2AG07EdFA/kS/Ui08xMidOJ2elVNXHLDyDj8wc26/zc0aPI0kQA2aQyZFFbDiM+V
	 v6gfgn2gftzog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCC3810934;
	Thu, 15 Aug 2024 03:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-08-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172369382899.2458412.8318514592045114360.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 03:50:28 +0000
References: <20240814171606.E14A0C116B1@smtp.kernel.org>
In-Reply-To: <20240814171606.E14A0C116B1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 17:16:06 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-08-14
    https://git.kernel.org/netdev/net/c/b2ca1661c7db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



