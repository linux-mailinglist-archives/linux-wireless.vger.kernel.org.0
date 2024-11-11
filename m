Return-Path: <linux-wireless+bounces-15181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A49C3E07
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310FA1C21968
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78619C56C;
	Mon, 11 Nov 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTNitgwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB019C561;
	Mon, 11 Nov 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327063; cv=none; b=ZNVwV8aWZUSfF5MJuhSIL6zDyV2E/K569UFCmNuwFM6cs3aoY/yWsNTOWWYtTsC68J+VBnT+SUImPF1GwW5WS+OcC9EleLU4GY7nIqmTcYu5eD/oj7DOlapWY7fznfDHAgvoCJBD/QOHkAP/qGD8Ua2uPbJQWY3PDahjPisw8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327063; c=relaxed/simple;
	bh=gjcOJBAgJBHb99bfi5+v1hj3THzAbdFhTu2HppVYKP8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Z8LO3Ajow1YqPC6GMz7oiozHBfdOIRL35pJ78W02ZDeUJChTX6yHmO/MPcspcHgCQrwRAU8neftia8l6Cd3Os1+7ztTgEkrRa9psQilrZZUarG8b1CcRrlphSNJbIj4ciitusBnLn4b5kfodj84o0Smb5lA83ynDkO/Ud/BSwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTNitgwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A69BC4CECF;
	Mon, 11 Nov 2024 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327063;
	bh=gjcOJBAgJBHb99bfi5+v1hj3THzAbdFhTu2HppVYKP8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mTNitgwriKvXyx8LtAnfRpPEJ6rbpf63J9iYsWVCJc2KqQsxYnasa0wuSbOuPWiBm
	 Sb15+hbZ3ccnJ4/HLFhl0n2jXB5xcAZ3delcLD8o3dhXAmU6VlQRjgk0eTMKvEi9Yk
	 m155+/QR2a+UraJqBoq5/e2Jslikc4zSAhrujGYUR9vnbNYW+usy+kHEnYmpnc/F7V
	 MZPnXJeIiaG8QydyvBSc7Iy50x9RZiR4PDU3pQizpfniBONEs+t7LGYLOzBnpqKG1N
	 PIYod071416al6tl8E4O0wEUB/Oy62bAKYQjDJNUnnHSwZdyEnwV6X5Yu0Jli9v9IC
	 P7Qm4oVyUb8zQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: Switch back to struct platform_driver::remove()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
References: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Loic Poulain <loic.poulain@linaro.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Breno Leitao <leitao@debian.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, wcn36xx@lists.infradead.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173132705627.852485.14271331752921398347.kvalo@kernel.org>
Date: Mon, 11 Nov 2024 12:10:58 +0000 (UTC)

Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:

> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net/wireless to use
> .remove(), with the eventual goal to drop struct
> platform_driver::remove_new(). As .remove() and .remove_new() have the
> same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> En passant several whitespace changes are done to make indentation
> consistent in the struct initializers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Acked-by: Jiri Slaby <jirislaby@kernel.org>

Patch applied to wireless-next.git, thanks.

b41f96ecb9b7 wifi: Switch back to struct platform_driver::remove()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241106170706.38922-2-u.kleine-koenig@baylibre.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


