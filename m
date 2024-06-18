Return-Path: <linux-wireless+bounces-9148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131490C949
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910D81C23167
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352A13BAFB;
	Tue, 18 Jun 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOlFUz/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9D13E025;
	Tue, 18 Jun 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706253; cv=none; b=LL5orT/tXZl8STxXD/QYskaDVc0z8gjjEycwNxdEUG3COS9wZW7OdqrMvJ2gWzFH9ppkACL5ED09K8LGYQk9SxMfMABqJIvTakg7opx6eUuGsNAWU3jFYWBhBZ8AgY4G4Wn3fC3LWxM1LmVJJ/iC8GUgdKJ5QqktgUkgCSPDZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706253; c=relaxed/simple;
	bh=MxznYWE9emIG2Jmi5hmcjdQRRO+W9jsbDZ0bOwkwP54=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=szYWyG0p5msri0E6TQuddC+g+ybYNQ9jNgissJ4XARKNfWTh30ivRGsAe0AGqlMktVb2jTWiqqwricY+MCK0uI3+wOweFxePOob9M5Ay5EeIy9vmMSCDOGi1OzKaPjLqoKVIzLAorpyhQ/0N5zTZ11xjooNSgCQ55lbFxg+/lvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOlFUz/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685A4C3277B;
	Tue, 18 Jun 2024 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718706253;
	bh=MxznYWE9emIG2Jmi5hmcjdQRRO+W9jsbDZ0bOwkwP54=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qOlFUz/vZecYUdbEYhlJXX7+NIEaRF239HoNOnuzwY+PtQdXZIGiH52ucUWUUJPUd
	 jyYqszixtVpYXaIFPKzdlKjcHWClz61h7vJFQ1wXPrHEx7H3qFwJglRhwyGTjeQC6h
	 Phm0wtH47y5BeGu9wL4vLNFDNMFv3JDUk171gNpnj8W7Ut7osHLbQDmgQbovPKbp6y
	 SNSWFCDIBwummJaiDmqsp7UevTGzI/tuyjlD6pJeUXZSfsxrlun8btFhtDkKUE4Q6j
	 QE7EYQuU6UVXWvF14i6zW0UxqZ0X/K5e+/z5n2jq0Mo8feUsBSAwQJC6+ksHzuupJ2
	 kv8rsMEM1sPuQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] wifi: wilc1000: disable power sequencer
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240613-wilc_suspend-v1-1-c2f766d0988c@bootlin.com>
References: <20240613-wilc_suspend-v1-1-c2f766d0988c@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171870624981.452784.17242642371617019106.kvalo@kernel.org>
Date: Tue, 18 Jun 2024 10:24:11 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Driver systematically disables some power mechanism each time it starts the
> chip firmware (so mostly when interface is brought up). This has a negative
> impact on some specific scenarios when the chip is exposed as a
> hotpluggable SDIO card (eg: WILC1000 SD):
> - when executing suspend/resume sequence while interface has been brought
>   up
> - rebooting the platform while module is plugged and interface has been
>   brought up
> Those scenarios lead to mmc core trying to initialize again the chip which
> is now unresponsive (because of the power sequencer setting), so it fails
> in mmc_rescan->mmc_attach_sdio and enter a failure loop while trying to
> send CMD5:
> mmc0: error -110 whilst initialising SDIO card
> mmc0: error -110 whilst initialising SDIO card
> mmc0: error -110 whilst initialising SDIO card
> [...]
> 
> Preventing the driver from disabling this "power sequencer" fixes those
> enumeration issues without affecting nominal operations.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

6 patches applied to wireless-next.git, thanks.

70ed0bdab1ca wifi: wilc1000: disable power sequencer
301e44e973eb wifi: wilc1000: let host->chip suspend/resume notifications manage chip wake/sleep
25d086ba1964 wifi: wilc1000: do not keep sdio bus claimed during suspend/resume
a814112e9545 wifi: wilc1000: move sdio suspend method next to resume and pm ops definition
1e9e258d9fb5 wifi: wilc1000: remove suspend/resume from cfg80211 part
5ad8897fd15a wifi: wilc1000: disable SDIO func IRQ before suspend

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240613-wilc_suspend-v1-1-c2f766d0988c@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


