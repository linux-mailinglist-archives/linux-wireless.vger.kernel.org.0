Return-Path: <linux-wireless+bounces-33445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGpWMRpgu2lujQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:31:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355DA2C4FF8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7B0302204E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2832C21FE;
	Thu, 19 Mar 2026 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbctZx26"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BC277C9E;
	Thu, 19 Mar 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887418; cv=none; b=hpOLepy6hIbFmvtPriZPIzBTe1mbS3zA8qjqCMoacdykYYmosVS9UAdaiMrQ/kVsVTDmdv9Vd8d4Auw8tU4WaxmT0o2UnHPaf50grJEkpKr0btm4Z4GJsdZ0Va+VdodF6lBa6gz1vwSvq8Gpi7NlL7TlQAvedDF0uEt5XJ+WMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887418; c=relaxed/simple;
	bh=3LlOkU2NQ+zxCPAFgs6MqMzjKMu/bPeJ3o20uox+nVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JS1TeHdzBGPk75EFCP3Kbnef7Qmo4P4c4iV4cuXKCALkwo0X6ZW59VeOuA3k8M7F/ZhbyBE0XnkHwnsSP0S8AxALwsSNgXcEwvkLG+Nmyf8V3hF11J988sIsjgoeFerYYh9YSfOXskceyp53yDvSFnoG7ZukuJ29qqoQyeFoCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbctZx26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF5C19421;
	Thu, 19 Mar 2026 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887418;
	bh=3LlOkU2NQ+zxCPAFgs6MqMzjKMu/bPeJ3o20uox+nVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UbctZx26OLNVLUpvedn0yVdloqu0JiIoTi4BknjNSZ0kP6L5IwLB0w44h+oDiKHBD
	 FfjjDJeohvj7vJp4K7kl4BfRmoZyDSpgZJpACZt/Kme1fOu1Q9SiRX/8kPjOw+OacE
	 LsXQFS4N0cHlt3nr6lFVxuQH2PWM2/gJe50QVwoMDY0fYhYudzLwR7F1eYG7ZZe2MZ
	 ZQbwXOJvUNFCsbDopmxV2nqOpqtwLrsQ7oMu77vIYo4DNEbdlSOkpiCKHHoU4L5Vqn
	 b+OldFZxrTiKV+CUYvKYTiokiAxbug71Dq6Sl+qtPDvVYyC5l9nB5qnitkEJekWYRg
	 GQBPYg+fAbTqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FA33808200;
	Thu, 19 Mar 2026 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-03-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388740979.997016.8859554824549272429.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 02:30:09 +0000
References: <20260318172515.381148-3-johannes@sipsolutions.net>
In-Reply-To: <20260318172515.381148-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33445-lists,linux-wireless=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 355DA2C4FF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 18:20:49 +0100 you wrote:
> Hi,
> 
> So maybe a couple more fixes than I'd like, but here we
> are, and it's small. I also failed to notice the missing
> "wifi:" subject for one of the commits, but didn't rebase
> just because of that now.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-03-18
    https://git.kernel.org/netdev/net/c/7c46bd845d89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



