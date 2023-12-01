Return-Path: <linux-wireless+bounces-303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E225E800EFF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50637B20D4B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27D4BA8C;
	Fri,  1 Dec 2023 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5NNSwTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC984BA85
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 16:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC67C433C8;
	Fri,  1 Dec 2023 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701446809;
	bh=V60OBAVdP05ZqICoOO8Mq9RmBiuJ+VOy+KYCJ7A4KzQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=s5NNSwTxawpDkFx2TtNYPNTKv+QKWlKOlWuZH9xr0WzTCCEu1VVEsJJqk8z4EyPK/
	 5M0PwGjYn1dNTVOEmuPQMoRquKdkJlRGvje+R5vlfgLFtKJ/eHbZ8debnmpO1eJw4I
	 rzjanSeAm5rryMNlW5yf7AFwPDYjtj0CBMaUGRUu859wC4DDF2vqMnJuHUMIaWaoQe
	 KN287t6DE3DPGvtAl9epRRJfShFisl7F6BZxanlDP9JqYDaAyZS2QGrRdpzjvrIoj5
	 exKrlb7m9YPc8l/x2MdF1SM8GbsTf1JMeLWXWyRFE9fGnVre2g9WCyklj9PmghfLRn
	 LuisceKNVE1lw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wifi-next 2/6] wifi: ath5k: Convert to platform remove
 callback returning void
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117093056.873834-10-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-10-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-wireless@vger.kernel.org,
 kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170144680660.2201420.10875151176323453923.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 16:06:48 +0000 (UTC)

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b5418d170b7c wifi: ath5k: Convert to platform remove callback returning void
8cc18a70913f wifi: wcn36xx: Convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117093056.873834-10-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


