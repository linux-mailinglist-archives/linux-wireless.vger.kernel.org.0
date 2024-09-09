Return-Path: <linux-wireless+bounces-12683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A8971FF7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46050B22F23
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B7175D22;
	Mon,  9 Sep 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RybBgWLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3793175D50;
	Mon,  9 Sep 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901491; cv=none; b=lBTZ7IbDSX1UZ0TkbBejXcX2PHK6+U+7SzAm6dWb1Oq60t7fO6ftnxK8IBao55yb4GJDtl3pIoiqxQnyqAUGWN3OB0xzn6xuAz4fCBd2gvT/poMRC149fsxSLXQhM3ZSjSnfB69OcmRdQ8dxDrl+e3QD0XUCxI9tUPolKDlW/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901491; c=relaxed/simple;
	bh=3WMTD4nsHmBEi3wmdr1n7VhklqTpHe/V+KlygeyVDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXeTLU8+N5ic2UmYXsSN1uK705WAcsQsjXRM5jITT+nLjQOAJzbtNKHu1r71W0fFoF8fDrgMaYinY1P9hN7myxdK1TXNffOOLJTTpNlwDrLX4A1F8ApCHAma+VmIlDvoBpVEelYFLt570eki7NaKgHc8tsIGj32ecmxDqGRh5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RybBgWLS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DCE341F920;
	Mon,  9 Sep 2024 19:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725901486;
	bh=F8ZZbsCJwtwLPGFZO+LYOvm8IWlm2XFoGbMop7JunLc=;
	h=Received:From:To:Subject;
	b=RybBgWLSILXycsDTKksH9na5UmbhghJa4xtTHb/vNguMbZGe7Z/5JIb+VhqDmabEN
	 J6txzHCfVZtZA1Zcuh2wQwC4M+ztYGzb7tYECzXwlymCmBfblYzJ1EDoEeh0cIDA86
	 ZG5qDsVvOrmXPhwSeEapNkOnW2adUGdQFMVHeyJRV2fmXpejYzIJuE4VV6NnLjHUMA
	 H0f+y2Q8SbognfGgLiPWWPm2lh3Fh9C5hWtA/79YinSA43yyHcThV2mtPRIIIX0kJu
	 0JKQ2t8TokeEMNZamgc/+v5W2iJ9NiPMvcqDVWwshs1sY0KF2Bq47TU1Pwill/kQH4
	 GgcHLYdDmFSuw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 867507F971; Mon,  9 Sep 2024 19:04:46 +0200 (CEST)
Date: Mon, 9 Sep 2024 19:04:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] wifi: mwifiex: simplify mwifiex_setup_ht_caps()
Message-ID: <Zt8qrsuMJ-EU9cpe@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-8-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-8-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:29PM +0200, Sascha Hauer wrote:
> In mwifiex_setup_ht_caps() first a local struct ieee80211_mcs_info
> is initialized and afterwards copied over &ht_info->mcs. Simplify
> this by initializing &ht_info->mcs directly.
> 
> While at it call memset on the u8 rx_mask[] array instead of the struct
> which makes the intention clearer and we no longer have to assume the
> rx_mask array is the first member of struct ieee80211_mcs_info.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I had a look at this, and it seems correct to me.

However my brain was really really confused to understand the previous code.
Better if someone else have a look also.

Francesco


