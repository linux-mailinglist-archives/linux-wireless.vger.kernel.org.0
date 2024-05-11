Return-Path: <linux-wireless+bounces-7509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C88C33BF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314E5B20DF3
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63898208D7;
	Sat, 11 May 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQVPtuGr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD746FC6;
	Sat, 11 May 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715459471; cv=none; b=XApxZEWtAfLgV7x1sLpgoCw6CTzUmzN9MXlrwh7Oic+oqBi/nNS0GSsdgrZyKP9N4adFc6DiUqxJ0XhDOGDNPL7lptfPMzZhzgQFO056yVMZb+WXRM/7Z/WPfGuBgszeH0I+UWPGO9ZvGptKrZU5XQdZq7ed9uzosOClHa2wst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715459471; c=relaxed/simple;
	bh=0DxUzvGB/Qr5c+EC7Gh9eYq9VeFtQn8F4tn+2/QbmNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSRCZKQifSU/370VKLVILC0E0pXWJhHcr6/kr9FngpJBh2P+u5R4tVObUY9TwiD//iu1gqNDa7eCpolL171mbIOzyhdSkBqo3rKidxu5aoow7gv1lFOznqMHVKwCKgCrP/ERISs5r3nQHC4klW0onNNr03GmpN2WcgK8cquPQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQVPtuGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC9C2BBFC;
	Sat, 11 May 2024 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715459470;
	bh=0DxUzvGB/Qr5c+EC7Gh9eYq9VeFtQn8F4tn+2/QbmNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQVPtuGrhabTWSuuLYJA0crkQZTOvFp0R+czP+cPQRtib2JY+ItIy+KH43ocCPUb4
	 m+2hpPVJ40v9H5YqTfV36yv0SoBfGu2MlHH2FItMkgf7jvcgHAvcEdzoOlQW9FBhdQ
	 +qC0vlcO9jKNwCfzX638npqmL3jBIILZFsHfwSLmYqKveyHmfePOAETh5w9BU9Pf/L
	 KywvdxR+lklA8JU37vl3pOVhfyXB0Ea2yElsizyqey9KfPjNbW4imTM87PDJDG2Urm
	 yFGPHY2M2eKnwuZc+Ua7Q7r8NVAUU8WhsPWeAqNavVJTEgvqdmVoAJG0vRIqwau4xO
	 D4EscBK6Pv/ZQ==
Date: Sat, 11 May 2024 21:31:04 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, johannes@sipsolutions.net,
	philipp.g.hortmann@gmail.com, tdavies@darkphysics.net,
	garyrookard@fastmail.org, straube.linux@gmail.com,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in
 lib80211
Message-ID: <20240511203104.GW2347895@kernel.org>
References: <cover.1715443223.git.christophe.jaillet@wanadoo.fr>
 <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>

On Sat, May 11, 2024 at 06:32:38PM +0200, Christophe JAILLET wrote:
> lib80211_register_crypto_ops() and lib80211_unregister_crypto_ops() don't
> modify their "struct lib80211_crypto_ops *ops" argument. So, it can be
> declared as const.
> 
> Doing so, some adjustments are needed to also constify some date in
> "struct lib80211_crypt_data", "struct lib80211_crypto_alg" and the
> return value of lib80211_get_crypto_ops().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.

Hi Christophe,

Unfortunately allmodconfig W=1 build on x86_64 with Clang says:

.../libipw_wx.c:587:6: error: assigning to 'struct lib80211_crypto_ops *' from 'const struct lib80211_crypto_ops *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 587 |         ops = lib80211_get_crypto_ops(alg);
     |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.../libipw_wx.c:590:7: error: assigning to 'struct lib80211_crypto_ops *' from 'const struct lib80211_crypto_ops *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 590 |                 ops = lib80211_get_crypto_ops(alg);
     |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
pw-bot: changes-requested

