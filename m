Return-Path: <linux-wireless+bounces-12065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B996095C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE991C2245E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481419E825;
	Tue, 27 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zw6b7p1B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470A139580;
	Tue, 27 Aug 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759768; cv=none; b=EQ7I0wn5YAb/47EZXsfxekUfIXZEVRas1mcNAR+RrIcNYG8V9Mn0EdQymK8ojwTqrAk4EhmnYpP7Z8FEZ2ZomCKlmTRqgGd5B0E6g5Nu188qB4Ob6J0X3cQgazTVZ2zH02/AhLNytEqcsc3MvCNgpG8YgcHaGRoowFILRjnKqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759768; c=relaxed/simple;
	bh=a5ZV9Z0+/DuwbgA21cGCMJWVPlMG8o4hKX+L8T0B3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfM0flIiEFW++ZlmIwa4TGZ9zKkMYRN6Qm836OSYG9BiI79xiva0nCdXNEDgGetQ5cgAemGQD4xkBh83Eek0RelvYg6a1jEMKo6vf78i6xQGt1E3Dnpo/8iW/LEjdLrNOGEEmfV5+gYUx4rIZkppyl94w2EJYPtzYfTfG6lFavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zw6b7p1B; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 51D6B21AE5;
	Tue, 27 Aug 2024 13:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724759752;
	bh=CafeksWBlGGflx2ww0XuQ7ArLYM/LkByOh8sKeK4ecw=;
	h=Received:From:To:Subject;
	b=zw6b7p1BGB2U3GGDPqTkpk6gSPF6RNOifttVHFPCgAWHACBw/iF2VXALaimn5CRPF
	 uYczt9ZJJgAmVMBE6132c0ZDrTfYwgQTnUHlDkM8/psirM+50me1MJaXGbdAGekvyP
	 wTTptFc1wGr5M88HOTxM/5bhrwKJXesmsAQuP7zJk52EdnFyE80LM2nElf8fC4fs7I
	 fiXllFxzr9vEUK46BPLkIgfWa/10+e1D+Oq50zuv4bOCE2Z8bdNtgnO+Z0OQjkHAC5
	 PNQ5JvqlsjAxMXtFaJSPE3aVSdo9wkmNkwQtuM/PiAfrGhxJPplFJfjKum55OU40Tc
	 2hpmFQ6U/1mEw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 06E807F84D; Tue, 27 Aug 2024 13:55:51 +0200 (CEST)
Date: Tue, 27 Aug 2024 13:55:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] wifi: mwifiex: add missing locking
Message-ID: <Zs2-x6nuAzKvKfng@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-1-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-1-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:22PM +0200, Sascha Hauer wrote:
> cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
> with the wiphy locked, so lock it before calling these functions.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


