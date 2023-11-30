Return-Path: <linux-wireless+bounces-241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046707FF7BA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984C8B20D82
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D155788;
	Thu, 30 Nov 2023 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4XTjG8y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DE46432
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 17:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190DFC433C7;
	Thu, 30 Nov 2023 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363967;
	bh=C9xNgVVhXRSyE0l4y+M6+IWYv5jkCVWMh6VIt0VA/fs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=g4XTjG8y9knI3NBpjmTbY0jzFw1mcc8iGTdhzD7XCC86xTR66ytM4U3sCJEbptvGC
	 WaURhaPOoe0YRt72iQB5S8OT3kTeOHpJXFqqkUoRlXzw107QCz1bBK/pnOq6Wu5WGd
	 3mRQBGy355RRvxnoF7KEwJXXbOQIbdkVQ7kr4qJ8Phe34meaoksvynwBQb9DYmbops
	 L9FzU5EVrZOTLUm5oKo6v2XcyzO8V3qlzqSIT3yAO5/8Z2yMAhkKT3YB8T6W7W+wMf
	 tovsKxEmGSU0L59zRi5GhbYqwnwGbn8MFHx+xplKXYD5q1hwU8wwCbBXU1LZHU0/2P
	 FfJUYY21ujKOw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wifi-next 1/6] wifi: ath11k: Convert to platform remove
 callback returning void
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117093056.873834-9-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-9-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136396402.1435047.15867746880964995534.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 17:06:05 +0000 (UTC)

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
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

62e31362033e wifi: ath11k: Convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117093056.873834-9-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


