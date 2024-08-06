Return-Path: <linux-wireless+bounces-11004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D242B948BB3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106651C21463
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8011BD4F1;
	Tue,  6 Aug 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYPA8Y8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944E165EE2;
	Tue,  6 Aug 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934433; cv=none; b=iBRNRWGOoTHU4PQQh+19qd+ljN6MQMKlhZc7UfK3oMpN9SCAsp5+EjdN0o9JaBjeLYmhfqYyMG7fLX/7TaBI0QBGpFUtHnsR0EpwnIGHOQleS9vtIwGtVvxzsI6+oh77KiqJFkfzBYzukDXTRGzHwPWYwJ8ckRsJsGdGLnQumWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934433; c=relaxed/simple;
	bh=jJiDKtpTZPBGixNvY1xeALOuKA+bJwGe+gpGsecz10k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egIGlno92aTVOj1KSJPSB9jncD3jrzNCfOYjJCrr7MkCWj+jZzF6PykqwjAVBJE13Y2JbOQ6WQFKUqmwiuGQUREceQ8dJ0P6sZlXZzJBqUNRdev26PcfdrHKyS6uqtLsQSyBM4lf80H7g+W55w4gs24gJ75OBzehMLoV/OKntV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYPA8Y8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBAC32786;
	Tue,  6 Aug 2024 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722934432;
	bh=jJiDKtpTZPBGixNvY1xeALOuKA+bJwGe+gpGsecz10k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYPA8Y8w2KT75Gt8JnlT9ZCjDddV8wLtOcfUU+uTaVRZgR6bsrHvnWwD2DwRYDnsl
	 itkcxaeq3JZ46SXvqHmvnRtUI18MKOp3LlwFOFw/c9juV1I231hbghW9Hg5D2tpTdf
	 ytv7dyau/8ucyP7L10Hj/nqtcp6JGV/z1rbDRez3XmXumP9ZIXML5rlexaTQXFalJP
	 3hpBotfHb3t1GuEBNLAq14PHDeNJ/Xrz2gOjGeOYpl2QgmsbrhY/Z8GV1Dgx2TZPjL
	 0vVBNXqDCVV8Ml/Qllh0/8nVSeDQezId38CR7JADdjpIpohGomWBcMbGkhHtwb6Ksr
	 URZpBzD1QPfDA==
Date: Tue, 6 Aug 2024 09:53:47 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: stas.yakovlev@gmail.com, kvalo@kernel.org, gregkh@linuxfoundation.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib80211: Constify struct lib80211_crypto_ops
Message-ID: <20240806085347.GP2636630@kernel.org>
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
 <0cc3741c15f2c502cc85bddda9d6582b5977c8f9.1722839425.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc3741c15f2c502cc85bddda9d6582b5977c8f9.1722839425.git.christophe.jaillet@wanadoo.fr>

On Mon, Aug 05, 2024 at 08:40:38AM +0200, Christophe JAILLET wrote:
> Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
> some structure can be constified as well.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7273	    604	     16	   7893	   1ed5	net/wireless/lib80211.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7429	    444	     16	   7889	   1ed1	net/wireless/lib80211.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


