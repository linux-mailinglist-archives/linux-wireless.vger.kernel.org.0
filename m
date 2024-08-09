Return-Path: <linux-wireless+bounces-11223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBF94D058
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 14:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988381F219AB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794A194141;
	Fri,  9 Aug 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Ityy9BB9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3461DFF5;
	Fri,  9 Aug 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207040; cv=none; b=MO88P6J5URaqy0B6mg14gacxxuYqx14ZFJukv8U3EP6tVMLNLsty60Rav7SlT2mfyCqD1pnlS5Ozf3FwfjB/bmSoDfcrMYps1AF+Yk93Y+a40/NSY2yw9gqY5OvR2mr2CR8IUqET3cahKgSqArcdzXaDFCZAGz6gNx/nzILs5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207040; c=relaxed/simple;
	bh=HAr1YBK5Iti57WLZAVf7xawM2aVnXg0kQ77MBFfGA9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u44Dki0KCyqYUTAh5ZjmcFckJ/q4vnJNIfT+XQHLN3GNwsgj6b2j944CJHgL0FdhxBPuYZ97CFUU7W7G0CQj4sTF75RcGqnviekLOhE64iW4GflauUdB01o6kusU7cRX3c2ITUBLErQ9wvwa0JLVGU79Qfb8ZSPh5jhEten7o7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Ityy9BB9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9CE962123B;
	Fri,  9 Aug 2024 14:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723207035;
	bh=5TlxZTfYBXeSTqAWOdY0khCP4g3uC9jK6KkgNXu/7uw=;
	h=Received:From:To:Subject;
	b=Ityy9BB992Y8DWemRQiB9DmPglNNPWTsCt6S4Xm1gaIsPSA2nTdInwxvKke73BZM0
	 TY2uD5lWLuCw25pCdylIzLABfiLug0PO6admsTPrcIPPWYZ3w/DJtI+EbktvI0boxO
	 7o6q3k1lvurtM2nNxwTRE4B6uhOAnNgMIrbAzdu+tQMHgGp3fkh/TlWsCtBQ3hGhw6
	 5nB6Nr4YvFmVeaei7gp7SEy7MbneQ1ibSlsVVNVFEeG3MchjE+DzcV3os1CZLy3L4e
	 fVbWGpbsYH5BMrl6AYP4ZGqQyzb7+Abg95pv6GSnOfSQd+c4KDT32TNrHUsOx7pZEN
	 PamlP44xQUOtw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 3E0937F911; Fri,  9 Aug 2024 14:37:15 +0200 (CEST)
Date: Fri, 9 Aug 2024 14:37:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: keep mwifiex_cfg80211_ops constant
Message-ID: <ZrYNex2LjSd09N-m@gaggiata.pivistrello.it>
References: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>

On Fri, Aug 09, 2024 at 11:51:48AM +0200, Sascha Hauer wrote:
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

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


