Return-Path: <linux-wireless+bounces-12612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6096FBD1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838CF1C21FE2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E91C86FB;
	Fri,  6 Sep 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4Iky4iB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC61B85F6;
	Fri,  6 Sep 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649693; cv=none; b=lFmzIB7824VHGLHA0aRQKCPIoAedoJg7qSdNX4qGDYrHdPfVVqXftC4PRcSrueTVCuTW9JD9xxmIEKP26QkFoTSdujFox2g8DS/8dIgXzjSIkM8KYAdUk4FiTT5YA3EZkiC7kkEKUKpXQyKbR1WGhTtEapwm0AqoRNSj4DtzYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649693; c=relaxed/simple;
	bh=jbbmfOoWUbC4j69VdJclhXgy88Y7aBK8mHR7RUQLmHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZX1QlUXJDpg6r0Ab4RwKPtyBFXNQDLo0KCy9f+YOveLMZ81n79TedWwDXpr7JZT2TXuaHlALBxE91yyxYxJ/VQWkmZqwxP+I82f4Wh/1kMdnb7C/I2SYD6TBtTBpTPb/qslUfTO1kiuwiRvZDsTZ5LydRU86zIJlCDARrxV9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4Iky4iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1CBC4CEC4;
	Fri,  6 Sep 2024 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649692;
	bh=jbbmfOoWUbC4j69VdJclhXgy88Y7aBK8mHR7RUQLmHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4Iky4iBrXJkiBHLTd46P2tHZH1qU4RDmepEmG2eFxN13lDErEGqcUR9vnXcYZE+f
	 5IdMgJzk0WesQlCCo9KgXvms9PKx6iuJOIT7f5yZGuxLtdGSl0F6N2I7ddiGt0lCkg
	 QUWv1lzS0zwDslZHP38HflmL9+wORBETAHHT1VARiK1nZCSlY9tsR2Qj1yg4usvED1
	 BVUmnrSTAGtCW+TLdWkJm+rQg8aIhav3Kq0mo8KdXI7Vn8ZUMK3DAb4EMVkiDHouS7
	 RYrGUi2eYtgn8+8NVIJJF7CmDEGFY91rXCnLf1y4GxaEgbZoXYS7QazJPOMTGchZEJ
	 g2A6qV+kdWtQg==
Date: Fri, 6 Sep 2024 20:08:08 +0100
From: Simon Horman <horms@kernel.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
Message-ID: <20240906190808.GL2097826@kernel.org>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>

On Fri, Sep 06, 2024 at 05:14:55PM +0530, Rohit Chavan wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  net/wireless/lib80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/lib80211.c b/net/wireless/lib80211.c
> index d66a913027e0..87c0e09aa676 100644
> --- a/net/wireless/lib80211.c
> +++ b/net/wireless/lib80211.c
> @@ -227,7 +227,7 @@ EXPORT_SYMBOL(lib80211_get_crypto_ops);
>  
>  static void *lib80211_crypt_null_init(int keyidx)
>  {
> -	return (void *)1;
> +	return ERR_CAST(1);

This seems wrong to me. ERR_CAST is designed to cast a pointer
to an error pointer. But 1 is an integer, not a pointer.

>  }
>  
>  static void lib80211_crypt_null_deinit(void *priv)
> -- 
> 2.34.1
> 
> 

