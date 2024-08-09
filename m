Return-Path: <linux-wireless+bounces-11222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8094CE96
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932B21F21D94
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F51922C7;
	Fri,  9 Aug 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwuGCdrf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165418C906;
	Fri,  9 Aug 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199196; cv=none; b=jZ1JsdknykgqDgZfl08Ecf20qhrhJ6nBGkHW+Nn+Vp+0YZ0K+xv6Vx+dAKZlzriTBqmxNcRA+5d6Vls6z3ESo057t+SHEaaGCuY9+OTpwZaY9a7KJ6ayAEybKorl1HxMoYM36afIiahcz145CXF55nbogJtKTbxofXRdgtIqJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199196; c=relaxed/simple;
	bh=6Lh7kAEDNmDxumhP46eTUrxMcFRWUOJSLIzjsEjTTjY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OBZfNgMpkkcI9IMTJYQ18ZruKxIp3nL4e6bkNuA0fwXuLzvScdpURE0yNvaFtb3n1+DHSxutJNQ+IyR0dw3KslOMh75o8duHASKorhsxtnB3xH5SRPl0haIucXmlm+/yN1Fua9MNSzUDMWBPZxm76V76wJB+3Cpw/k7U4K2c9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwuGCdrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B97C32786;
	Fri,  9 Aug 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199195;
	bh=6Lh7kAEDNmDxumhP46eTUrxMcFRWUOJSLIzjsEjTTjY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gwuGCdrf0lcv1LMiJsZbo8mcnVqOgpssKipHmkj1VwfJtIXvHvjsbWatK5vmV87gq
	 8q0vio2jOzjTwswpCF5LmLpyIJOgLpjrE/x/FXycaDFZahBmhMf7bflPcZFP1iuq/i
	 MQCIoj7szG3Tmgek8TE/ggNOcfNZ2RKzpmgwq6vY4zF7/M98P+Mtp5QYQDrSVj4G+4
	 xofUIxDh6JTVqRsJrk/C0mtpZV59CntqT3QXNvgAqGJ795eZz+uHwwnJhCeH8IKqJl
	 YoPL9XQYHIY+UxIVkZrOPhxglSqDLb9pi22phnrQ+bjWV+vY8DATCBF5tCiS+Q6eaw
	 fMfyIVNKzTJXQ==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  David Lin <yu-hao.lin@nxp.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: keep mwifiex_cfg80211_ops constant
References: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
Date: Fri, 09 Aug 2024 13:26:31 +0300
In-Reply-To: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
	(Sascha Hauer's message of "Fri, 09 Aug 2024 11:51:48 +0200")
Message-ID: <87frre2drc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> With host_mlme support being added mwifiex_cfg80211_ops is no longer
> constant, but supplemented with the host_mlme related ops when host_mlme
> support is enabled. This doesn't work with multiple adapters when only
> few of then have host_mlme support. Duplicate mwifiex_cfg80211_ops
> before using it and keep the original constant.
>
> While at it mark mwifiex_cfg80211_ops const to prevent people from
> changing it again during runtime.
>
> Fixes: 36995892c271c ("wifi: mwifiex: add host mlme for client mode")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Kalle, the commit breaking it still sits in wireless-next. Feel free to
> squash this into the original commit if convenient for you.

Thanks for the note, info like this helps a lot. We avoid rebasing
wireless trees unless there's something really critical, so squashing is
not really an option.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

