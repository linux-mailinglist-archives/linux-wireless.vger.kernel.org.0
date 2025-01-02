Return-Path: <linux-wireless+bounces-16997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C6B9FFB55
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0123A2E16
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87612E7E;
	Thu,  2 Jan 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="vWzI/mrz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212779E1
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833994; cv=none; b=cCv078/UoWBKzzK56nRiR004yvQz88I9RDJMQ3DqTyRaYf28VT6xFWnd2kO7b+QQgJ8tzN7MAPD8pm9OZTTIyDbuyeB7PYWx91MEoPUU9bRZx+E94vctZ4IQwCLHJ5l4spXbvW+lRgFZHQbPTb820YbqXPSy7HJLqeHe/DmoDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833994; c=relaxed/simple;
	bh=b6cF/ocVVHNscGZA0J5/ZJKyhif4Bx/ILRI5o7tJsgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTQCoHKlnm6GiAHE8B8L/SQOewQSbpXJSkj991STNKjHCQ9a+jdXCKfaB6B3gWVOJ8X5OlZryuUZU34pvXByt9bNHPeeZpF9hKs+f8QdP/dRg9rvwpjHc7h4RdDMWTK2YAE8fXLIeANA+27Z0pAYEt7aDaenOUdrCDrEfQfbs44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=vWzI/mrz; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1735833532; bh=b6cF/ocVVHNscGZA0J5/ZJKyhif4Bx/ILRI5o7tJsgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vWzI/mrzVXxJCmx69hMLqAZQatAHeXjUCJA6iGFd8pRDYyVtyoLgaOddiOXyzRwDC
	 eTeYQx+vPMuQX2FNcIYWf/aqR9nJ67a2bbpBpLFTHHeaj5Olvikw/U5LqEA3zLQo9O
	 dP/c1iH/rVFyearo117ddJB3EMWi4XB2L0ubTuZV6derDHPKZ08z6XyPlJcIuws/oC
	 qfJZ70gcS9lV7mK/kVh2I7fzH11v+Q+13a+Sl0lTR/aa5a5sG0Gx6qw732oM+krIcT
	 xZ5YJYAa42I1mle8l/Eklrwef6ebHWDROA8f5bfU5a8eFKHqh9qDzL9sKcmUHnmNp3
	 kjRvbTpjLXMIA==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
In-Reply-To: <20241225144535.104787-1-dmantipov@yandex.ru>
References: <20241225144535.104787-1-dmantipov@yandex.ru>
Date: Thu, 02 Jan 2025 16:58:51 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bjwp8ax0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'ath9k_hw_get_nf_hist_mid()', prefer 'memcpy()' and 'sort()'
> over an ad-hoc things. Briefly tested as a separate module.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Thank you for the cleanup; a few nits, see below:

> ---
>  drivers/net/wireless/ath/ath9k/calib.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
> index 4b331c85509c..26465c1a59e2 100644
> --- a/drivers/net/wireless/ath/ath9k/calib.c
> +++ b/drivers/net/wireless/ath/ath9k/calib.c
> @@ -16,29 +16,25 @@
>  
>  #include "hw.h"
>  #include "hw-ops.h"
> +#include <linux/sort.h>
>  #include <linux/export.h>
>  
>  /* Common calibration code */
>  
> +static inline int rcmp_i16(const void *x, const void *y)

We generally don't mark static functions as inline, but instead let the
compiler make the decision (which in this case is to *not* inline, as
the function address needs to be passed to sort()).

> +{
> +	/* Sort in reverse order. */
> +	return *(int16_t *)y - *(int16_t *)x;
> +}
>  
>  static int16_t ath9k_hw_get_nf_hist_mid(int16_t *nfCalBuffer)
>  {
> -	int16_t nfval;
> -	int16_t sort[ATH9K_NF_CAL_HIST_MAX];
> -	int i, j;
> -
> -	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX; i++)
> -		sort[i] = nfCalBuffer[i];
> +	int16_t nfcal[ATH9K_NF_CAL_HIST_MAX];
>  
> -	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
> -		for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
> -			if (sort[j] > sort[j - 1])
> -				swap(sort[j], sort[j - 1]);
> -		}
> -	}
> -	nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
> +	memcpy(nfcal, nfCalBuffer, ATH9K_NF_CAL_HIST_MAX * sizeof(int16_t));

The third argument to memcpy() can just be sizeof(nfcal).


-Toke

