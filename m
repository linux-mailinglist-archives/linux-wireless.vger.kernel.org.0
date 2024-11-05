Return-Path: <linux-wireless+bounces-14924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B29BCDC4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6982831D2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B8C1C3050;
	Tue,  5 Nov 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="h/7t/DpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D571D5CD7;
	Tue,  5 Nov 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813319; cv=none; b=rkSLe2t4YHus/g51BAMAzeATWHoeYquUj2xlXJfgTEbtODrbSOGQ6gjgC/I+legvcHYvdUpq6Ig5VrzmGMPtD2L0GxLCp1HfFboB1O8HIkNRZsqJJFoPYqhpcS3Pz9vi9NvYS3gZUH24S4oCPKlzTGOypNeziFxs2YRKcLlAa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813319; c=relaxed/simple;
	bh=J61vCGKLZBK/tEwV1LCTVcI1/OUtjb/LQz+d00BUtNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSvuQaGT3GL208hgj+enzpH7IHZOA1wmpVCKWNu/OJpkVJDEypHkQSbMEO1Ryt3YlsN8N7XCS+lDUOGV+3Dn+sL1SKp69B5R33Q5OwP1E3sDCe/h9J4ERHUOpcksnlhm39A9apaobKiKK7hYvE6Kc53QadA9f76wQaZvRjkChPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=h/7t/DpQ; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730812863; bh=J61vCGKLZBK/tEwV1LCTVcI1/OUtjb/LQz+d00BUtNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h/7t/DpQeUlddCXNyz6cSsqCPgnZ+L01ZcEjwnu00nyGA8PWNUURfGd3+1sIEAilF
	 MUhvPcMJO3/iSyf/cs1fYiHyCEXf77ZAixVWA1q862QqZqYFlEuG+iD3ci2QzAgW80
	 RDrQhHXwTR2V27ZP4gWlP5SkoTIJ33Ka5W8nzaoQ7H3LnauWRlAXm0COCJHxEAQorz
	 1tyPaoxsKSPuyCO4nYci6KTJvu5NxvN9tMTU46yAw/hg9F8n7+MXHeVxzye79PJS/q
	 shNpNpZH83wajroziamgCUOLBFOGjV5IgccQfujfJKX9S+sNZNJpb+baPZJzthV5gg
	 PClT7m5qLlrKA==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, nbd@nbd.name, yangshiji66@outlook.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] wifi: ath9k: return by of_get_mac_address
In-Reply-To: <20241003021732.1954299-1-rosenp@gmail.com>
References: <20241003021732.1954299-1-rosenp@gmail.com>
Date: Tue, 05 Nov 2024 14:21:03 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ed3p95q8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> When using nvmem, ath9k could potentially be loaded before nvmem, which
> loads after mtd. This is an issue if DT contains an nvmem mac address.
>
> If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pass
> it to _probe so that ath9k can properly grab a potentially present MAC
> address.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: modified commit message
>  drivers/net/wireless/ath/ath9k/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
> index f712bb6d1f47..5f4efc760183 100644
> --- a/drivers/net/wireless/ath/ath9k/init.c
> +++ b/drivers/net/wireless/ath/ath9k/init.c
> @@ -647,9 +647,7 @@ static int ath9k_of_init(struct ath_softc *sc)
>  		ah->ah_flags |= AH_NO_EEP_SWAP;
>  	}
>  
> -	of_get_mac_address(np, common->macaddr);
> -
> -	return 0;
> +	return of_get_mac_address(np, common->macaddr);

Hmm, so AFAICT, of_get_mac_address() can fail with lots of other error
codes than EPROBE_DEFER, no? And with this change, if it does, we now
abort the ath9k device init, where before we just ignored any errors.

So, to be conservative, maybe it's better to do something like:

ret = of_get_mac_address(np, common->macaddr);
if (ret == -EPROBE_DEFER)
   return ret;

return 0;


WDYT?

-Toke

