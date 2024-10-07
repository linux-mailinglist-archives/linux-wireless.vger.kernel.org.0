Return-Path: <linux-wireless+bounces-13579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C69925D1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 09:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD6AB22A70
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77013A40C;
	Mon,  7 Oct 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="f2MWCU5e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53387156225
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285368; cv=none; b=N00c9ikyXq7OVhQxGsxS3Dd7LhvQ62ZASnPO6kDgW+7djiiNfIHAvhVH6ATGNOMPdHQoDLy9g7+97O8WmQawLMwnS7MXgwjG4sOb+A4XE+p67wl3ejUDBt2iUXYcnb3ars44pX1i/HAw9KQyoytaNj3mtNkvnQKTK0dUexdPyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285368; c=relaxed/simple;
	bh=veVRfnqUWcX13YYbWp06/huznQbNhoFTxKcJ9zyVr24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcScB70qHgzOsWYJuMPIqUTaegQM554XWP4O/fp69z5XMynGZED3i24mpr7/A9QsfvF+h+QTM1jggpzpgevquZg9FcwIOP75qm4xZkPgjzGx2eWIRfZE3AtlZPCw24mEau5FJ0iA8HXrnDY4oB2ADaSowPE4ElnOSnxp/feMcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=f2MWCU5e; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1ACB91F92A;
	Mon,  7 Oct 2024 09:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728285355;
	bh=VOGDphXcd/gTLWvGdIyHjgTuLM4LaQMbyT2nSFtyRvc=; h=From:To:Subject;
	b=f2MWCU5e/ehivq69IMVV7Lg1Acw4Ag7NG35NVXQ6hjRT5Urisr4U41INosnQg5sBL
	 8oroI5FqArvk9MEcgfWSQcCq9SlLb+S5zECcLrulsW3sjmvAIVIGbR/xb1Gb99sIem
	 ecouyQhyOXl+YX5ceWkfuLMgH/eyYUqyh/lBKGYpiB+kMJvd1JgsxPBTvEawrZV68X
	 DiaUUkfJ4vX6V/IfgJkALHKKGdmJxwwiE0pV7oGldgcVbGZsx1uVWS7M905dt2aMki
	 9R5Alms4d38jr1+xrogiChN2UXu81U9t2OD8TdCSUIxiZdCPNcT1NcEodsxGT60h+m
	 URxmsBLHwEoEQ==
Date: Mon, 7 Oct 2024 09:15:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
Message-ID: <20241007071551.GA10017@francesco-nb>
References: <20240927084317.96687-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927084317.96687-1-dmantipov@yandex.ru>

Hello Dmitry,
thanks for your patch.

On Fri, Sep 27, 2024 at 11:43:16AM +0300, Dmitry Antipov wrote:
> Remove set but otherwise unused 'do_setup' member of
> 'struct mwifiex_auto_tdls_peer'. Compile tested only.
> 
> Fixes: 9927baa3c724 ("mwifiex: add auto TDLS support")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

It looks like you are not having in Cc: the right people, please verify
your workflow.

In addition I do not think that such kind of patches should have a Fixes
tag. As you correctly wrote in the subject this is a clean-up, not a
fix.

I personally prefer to have a cover letter anytime you have more than 1
patch.

These applies to both the patches in this series.

Francesco


