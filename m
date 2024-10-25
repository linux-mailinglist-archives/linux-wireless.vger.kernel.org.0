Return-Path: <linux-wireless+bounces-14515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636149AFEDC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF62B21BA3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A51D3633;
	Fri, 25 Oct 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfsbznEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4212FB1B;
	Fri, 25 Oct 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849829; cv=none; b=Ms27EEYuDCyAFiAECnbhZ+x0p6rMsKlgzLtHDawp1hk/7wZfM1DkX2NoltqFa7oe3f57yno8zfas2H5wQ1jhrw2YSk/uRbctwWLYUdG/CeoWbAFatuDaw0mVbFaGL/ml+Jo4ZXzwlzKb94MXH5XD7AAC5CfLqR8VeRtJ+RY/wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849829; c=relaxed/simple;
	bh=29q9itorHp5Bv3+HMsAEKFSoHqsZe0RxGwUAH7fW8hI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rbzDb4gI8omRXUFr/aS5VmjoGpOFZkYpVgDmz1ue22RFLPdFSTW+NGhIGKTyqzbd2gplq4BThhIMsYAK7gXUHS8OhCiMLT6IGltOIPKcyxas8rj9TOKiJKuH5SMjydvBo5qojOr+Hq/2/sdYKuZ0QVwn3aKlL5fuaeW/f+LLD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfsbznEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C141BC4CEC3;
	Fri, 25 Oct 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729849825;
	bh=29q9itorHp5Bv3+HMsAEKFSoHqsZe0RxGwUAH7fW8hI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfsbznEznadXymsZDs/5Yyguj07rLvpUq+ykrev8YXN3yT//UjDYUvrHuwfQu7C/x
	 az1O9wEwZtBFKFA3xdckQRZn2DG85I1BxkHER1rlBZOEo2/aRm4jDu6Y9OxFByEthH
	 CmfnWM6+niFmfUg+JIfDy2tk+IX1lL6G+eK5xL+TqpBpdlKiDeO40cA4VN5MVI3DOx
	 Lv/lhHVuf/AZF5Zpc682hhNR2u//uVU9DWFSjWQ7TjzOtd7vLUNbAFnWDXvuEZgEdV
	 8AEPQ29GGglomKcfYaIJy1NdDUroo57shLiKJHhfGfGwVVZnWRjNWtufnkotQfNKCY
	 Xo8KVm1EDTtCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC63809A8A;
	Fri, 25 Oct 2024 09:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-10-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172984983252.2847729.4371228428896339313.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 09:50:32 +0000
References: <20241021180617.B49DAC4CEC7@smtp.kernel.org>
In-Reply-To: <20241021180617.B49DAC4CEC7@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Oct 2024 18:06:17 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-10-21
    https://git.kernel.org/netdev/net/c/e31a8219fbfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



