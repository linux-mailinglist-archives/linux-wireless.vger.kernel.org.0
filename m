Return-Path: <linux-wireless+bounces-12685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FA97201A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59AE1F24415
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBC170853;
	Mon,  9 Sep 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BFMs4tJt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4E16DED5;
	Mon,  9 Sep 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902055; cv=none; b=ZhP4iojERb2DLrpbexlR9u9XW0QwbY8GurhM7b3enrRcncl37YUYX+fMbjLT4jD2tpgr464rcx6J1F9EhjMQRKjg0tyq3zfaCEX2cfiQBckAtmBjpNv7XoU7FS1qTfiDQp93opkY4tNwLvTU2/GpC8p09YxP8mjRHSqSRthyVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902055; c=relaxed/simple;
	bh=Dj89UqQA5atWnoQCpcScySxShccBdx6pUp63yw0mMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9/guP8YNnmo8MsQEY9P0kOKSUcZTE7yoNmBZux11a48PM6V1FxnK6iB+ddGfBYdTMrlUhI5a1LWzON3E+7VExkUEhRZh7VXeyYMTU8ubHQoVLgAcqurLs2Ftvst4jlckxR0wXIjoU5UGG1S7SOKujybK/lJGJx6NwxuuKtCRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BFMs4tJt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 067651F920;
	Mon,  9 Sep 2024 19:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725902052;
	bh=ZWnEpV8lYdN3o5G0RprwiXYB8h0JWmpiyJY2oFgsrQE=;
	h=Received:From:To:Subject;
	b=BFMs4tJtBhahKxM65f+S5Y7C35bjGgjRwQPu0PcH2srsZNEUhzxWfsFyznGxUT5XL
	 7kwhLjI2MRQo7rOpqqhTxBW5mXg0afhynOFzXFvSf6n464CCeKw96avpZAhkhq44V6
	 kvLRNb2pDouCZ7XKaHM+VxSWhZ2qW3utj+BbAFXSKmnNfG5kpoQR2CX4i9g/Xh72jS
	 66ZXUGaMjXttR6q1OGahIxKDJ/aL5tgziLfWUSc9lG/ux32WD7c1jsnYqnetiqfFT0
	 INkyHuVJPd77vmF08q3lrsjV/SuOt9/Tg4Qhnkh+tMUV9fp+WhcWzfyh/jnU0ml+61
	 LKUjQXCuCYI8A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 9DFDC7F971; Mon,  9 Sep 2024 19:14:11 +0200 (CEST)
Date: Mon, 9 Sep 2024 19:14:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <Zt8s4xEun6VL-pHW@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-12-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-12-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:33PM +0200, Sascha Hauer wrote:
> Historically all commands sent to the mwifiex driver have been
> asynchronous. For this reason there is code that waits for the
> last initialization command to complete before going on. Nowadays the
> commands can be sent synchronously, meaning that they are completed
> when the command call returns. This makes all the waiting code
> unnecessary. It is removed in this patch.

I am not sure to understand this. Is the code to have asynchronous command gone
or it is just not used anymore? In the code here you remove waiting for the
firmware init to be complete, but from the patch is not clear why this is not
needed anymore.  Maybe a specific commit you can reference in which such
support was removed? 


