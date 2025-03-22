Return-Path: <linux-wireless+bounces-20698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B1A6CA64
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 14:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E31898FF8
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7491F9A83;
	Sat, 22 Mar 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="mG7VwQRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9F15E97
	for <linux-wireless@vger.kernel.org>; Sat, 22 Mar 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651113; cv=none; b=WRQyQ/2c4XKwgulU+5TgY6tY8o0gU84bNf288WZg99MOFIlZ1JSFDBiCuxG+ATmE3/2Txrl3gWHnD96ZQvr7XZyppgy09n/4tf4Pg9cRNM+iOZn52jyrktZROqqGvw1xHL949lrOPfO401vdH3wKANLL39DqJW1qhp3T0/6wEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651113; c=relaxed/simple;
	bh=u1xRTo/bl3nok8aKDieXrGIxlQuatKZcNo9dqanP+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC5zoNlsqlIdpLJXLrN/cKS37doq7oQcWXKxAz/VQ3OO3JkGspi8qg6cU2dVd0YZwNqLU7YC1E81nnViPMjHNm9ivxsZpVDaxEYquGX/fIV706f9DHw89Zs+7U/ee3Td1hZt1N2oz1M3SgAvRxV8e5qPw/ccddNF8Isq7oBqJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=mG7VwQRJ; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 6428 invoked from network); 22 Mar 2025 14:18:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1742649508; bh=GB66nzT8hTJiRgeuzoTrv++/2Tkme1+8GVTnCTgJnVc=;
          h=From:To:Cc:Subject;
          b=mG7VwQRJYA4QFDMynLjxK5IWh+KNsnuGuxU98hvvBOzWDiOlq9AYX3h8pgwAOTZDY
           LPkq6K1JG3OzfQMKdUZpGnA6diuPUSLBhcGH/di/GpTRboC0/ypYg1EVxyq/BmhSLR
           qhks88yggKULCKWv7UWQD2V10T3b0rzqRjksjl0pV26aNzSTHuMI5E8Hmqul3tN37p
           Zo8sMrmjzn5cbnGaRDA31hAV3JiMB5P0XqeLmnjdZxXqThtRF0ew/MBXMqVZEQhkMh
           xSxbScD1b2g9hvh4qvgN+2oQ3tsL8cX8HsXANFQsVacUFKy1JkRrFbdWuE4EdJBNtf
           Df84S2pCruJhg==
Received: from 89-64-9-62.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.62])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <dmantipov@yandex.ru>; 22 Mar 2025 14:18:28 +0100
Date: Sat, 22 Mar 2025 14:18:27 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Daniel Golle <daniel@makrotopia.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, lvc-patches@linuxtesting.org
Subject: Re: [PATCH] wifi: rt2x00: remove weird self-assignment in
 rt2800_loft_search()
Message-ID: <20250322131827.GA94848@wp.pl>
References: <20250321134256.821596-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321134256.821596-1-dmantipov@yandex.ru>
X-WP-MailID: 24a13f2eb10c66daa2f2ccc00c2d1953
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ASME]                               

On Fri, Mar 21, 2025 at 04:42:56PM +0300, Dmitry Antipov wrote:
> Remove weird self-assignment in 'rt2800_loft_search()' assuming
> that it was just a typo. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index e5f553a1ea24..b7ea606bda08 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -9393,7 +9393,7 @@ static void rt2800_loft_search(struct rt2x00_dev *rt2x00dev, u8 ch_idx,
>  				   p0, p1, pf, idx0, idx1, ibit);
>  
>  			if (bidx != 5 && pf <= p0 && pf < p1) {
> -				idxf[iorq] = idxf[iorq];
> +				/* no need to adjust idxf[] */;
>  			} else if (p0 < p1) {
>  				pf = p0;
>  				idxf[iorq] = idx0 & 0x3F;
> -- 
> 2.49.0
> 

