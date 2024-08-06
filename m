Return-Path: <linux-wireless+bounces-11005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2B948BB7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29B31F230E9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB51BD4F0;
	Tue,  6 Aug 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsJl8uQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CA165EE2;
	Tue,  6 Aug 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934450; cv=none; b=cVPaRZ2kll/4DAtuqJsikLnDlDAIzu+T5U4bVtXYVbIIX6dZSuK6Re5tPIOaumHPo1p4+AlVosRZQ5SPP4jq6YUZk3nXZTwoe4lIdgMzM+KgDabzhvq4LbVP49sdOI2+i4euiRd7ktedLtmjFv19L6iIs6m9hxMZK6Lw8IQJLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934450; c=relaxed/simple;
	bh=E3AV3eX7Ux9UT3jrUISKJBTttSAn+nDf+KULm/qlh3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WleYnuWLHYCetXVNslBtczZnV8MIyd3Gt5s/paMA+WgwPR2shHJbdZJeXjfL2RCl7d6Drcegt3R5IeoLXE7qP0Dq/RTf+2HBc5ikDjZY+2vMNEq4rT7+R80rrGRyPX9+mO6o2/1uQmOPhVxp+e0U/e2yTUtkJijchq/RkZi4C/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsJl8uQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08418C32786;
	Tue,  6 Aug 2024 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722934449;
	bh=E3AV3eX7Ux9UT3jrUISKJBTttSAn+nDf+KULm/qlh3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsJl8uQ4zZNauJmzBHNss8dUIfzSHt+vlWQ2rsnthwUT0MolMYFTEP1nLGrxS8Qin
	 yGzyoH5vwR3TB7zWduCuFdZEjG030wcUfO1Vi2ir/xnfLNQwJn0iaNvWWrHnXny16h
	 7m9FwAd5ZVI0qtTZSHVvTuViAx4XWWWHI+i2Wgf30twsAN1VueSXYgghr4duOHyV8/
	 frEdMDGIgAEEyWzP9TYEKA6/1pRe8XqGCyGcImhGIUZgmytyF1s5dCv+zs0/QuOXoo
	 yBlRl6zpnbmh86isc5lfrvcAjgBk3l8K9cEH1bZe5fUZ4tCiG2YovHqoqB7rcIshjw
	 qpqoyCWroRSSA==
Date: Tue, 6 Aug 2024 09:54:04 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: stas.yakovlev@gmail.com, kvalo@kernel.org, gregkh@linuxfoundation.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8192e: Constify struct
 lib80211_crypto_ops
Message-ID: <20240806085404.GQ2636630@kernel.org>
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
 <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>

On Mon, Aug 05, 2024 at 08:40:39AM +0200, Christophe JAILLET wrote:
> Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
> some structure can be constified as well.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


