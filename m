Return-Path: <linux-wireless+bounces-943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D38179F3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFF31C23206
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A172045;
	Mon, 18 Dec 2023 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmyT3Kut"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284771454
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C00C433CD;
	Mon, 18 Dec 2023 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702925180;
	bh=UxbmYt4wzt61w4RDlw4yyVto5bL1k+r3HJIN1d+K8qA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FmyT3KutRh7p/YwBd8cXp82/g/zOz69FelqF+3eFPShR5uiHk2f82zU8UDFU9OMfc
	 fdb620vjj1Xpg8uMkKteoCtA+kR2dlHi4kn0axSZ9wnqJoEO4LYEtLkzyGl4RlcAs8
	 RBWXnTe8S21ZR/syop6CJUGIErYNWN1sdX6xYjJb9b6UF8XXZCo0kRKs2MJLNEjzZK
	 Pg8Au0rad2QI76Ol9na3h9xDHqR6NN7zM5mVZcpD6PDmuxL2vid1m+hHIOKt1buP87
	 BroykYyV55Zt8e13bpQzUM5DLPBNJ9P63uzjtsmNH3AxYLUVnYih2fnB4cMV0SEA38
	 H0u/91b7BEJ5g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wifi-next 3/6] wifi: ath9k: Convert to platform remove
 callback returning void
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117093056.873834-11-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-11-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-wireless@vger.kernel.org, kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292517703.424292.10957565262543688436.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:46:19 +0000 (UTC)

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
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

27ce06d018ce wifi: ath9k: Convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117093056.873834-11-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


