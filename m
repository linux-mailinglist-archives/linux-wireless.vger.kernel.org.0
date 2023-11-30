Return-Path: <linux-wireless+bounces-253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434D77FFB11
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FC71C210BF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC822061;
	Thu, 30 Nov 2023 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVqJPkmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F652A2D
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE0C433C7;
	Thu, 30 Nov 2023 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701371991;
	bh=D/t1L5iXFY2+sUUj0qtsRRU/poD6XOKBGKkCFdlkIxk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DVqJPkmRwg8aYx2hPtn086i1bfbxhmIoea8c/VPxofuFibUFz7n1+Yo6xieg1W2j/
	 Mc9Vmhp3Dy1E5mcCqO8xnHNwYT1KUZmfYgiidZgYuS1ouyaEQ92jxYh+1kJWTmAhqp
	 7C5yXXXhbaAd2/iJ9IlGkZkDGx74ey3JpxO7JE6GsrOhxHBib3ZxkTnR4EhFyq2Kfe
	 pAxD7ve2K6bsv8NIiOwW/BSsOGHotQpGEkyzKU6kpPZtZ87mANQszDpVaZJOlv3x6O
	 +1IUWuEbmZY6Hvj/C3pd8+RinGMyLxjH79VXRu4otWpeOVhbh+btnrDsOkA+Tc1kC7
	 HA74r30ZQYLCA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wifi-next 5/6] wifi: brcmfmac: Convert to platform remove
 callback returning void
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117093056.873834-13-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-13-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137198748.1963309.15550773845288206516.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:19:49 +0000 (UTC)

Uwe Kleine-König  <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

afb154426bf1 wifi: brcmfmac: Convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117093056.873834-13-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


