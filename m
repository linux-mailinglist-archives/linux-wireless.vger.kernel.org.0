Return-Path: <linux-wireless+bounces-14157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618A9A296E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B521C270E7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE71DF758;
	Thu, 17 Oct 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyyIBCV+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384D1DF256;
	Thu, 17 Oct 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183558; cv=none; b=vGI5bq++0SCFdJU7ukRwmQBotz7wREiFG6+aS61sdJjwgri9/QQZBKrRWELF/XXaCzqdPBqtr0c4+Eb62GXZX/aovd6XwTdbBmGYHtmZ1p5HuZE1RY2Kf0VRIQ+/yQ/Tl7Mer84oWPafz1MYDUIS8+SXQr8Oakzpu+nn0Iwt1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183558; c=relaxed/simple;
	bh=QHneU9Wgn9ML3zh1+lyjPw5tJB4+lJoJkq8OjBO/Wbc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=N0eyfd4BVGaXGf+8uLlzm/K1NAElUtTdhLWlf0ulVQuMIkvWzXNWITdJhTKv+5SZgwmzUIrZLpZiyJEwtKWvrtUJ5kL92a2vZTYO7/JovoFEaomw9qo4TeBQclXOkvYbTc+OJ+djGpCS/Trrugr+IbGj4lH1ezHIZkAbV3+OMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyyIBCV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F074FC4CEC3;
	Thu, 17 Oct 2024 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183557;
	bh=QHneU9Wgn9ML3zh1+lyjPw5tJB4+lJoJkq8OjBO/Wbc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PyyIBCV+kfJccA59jTefR895WRoknPP/DpVChRE1mA1HsdnGCrtn2cn5MzUw+mmRF
	 77X4USaoYStwd5feqxkWz28ebX0aRYPcDvXhbsN8Bibe79ltO0GbYcKrfL5ZiostZK
	 OKoY9TAheILCZBO2H7zeVd299E9l/siu/PrcT6R0mlzBx16+01E+/FpFwyi0dY8w19
	 JFdm4gsMF6JayBth/URdKiv6mZlbDAko+27iZICVAw7ZvRBdPlE4nR/eujJrdnJKXz
	 UbMt8gTViCxjVsoeNeR7z+dT6Q+8JRCYVlTrmJd4q0CkeW5ZXvzOPN/7UIF4wd+l0J
	 BnqF4ylZy0BHg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2,01/12] wifi: mwifiex: add missing locking for cfg80211 calls
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918355438.970100.13680988913493703053.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:45:55 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
> with the wiphy locked, so lock it before calling these functions.
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

0d7c2194f17c wifi: mwifiex: add missing locking for cfg80211 calls

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


