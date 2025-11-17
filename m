Return-Path: <linux-wireless+bounces-29049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAAC63DDA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A874B367209
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1720032A3F0;
	Mon, 17 Nov 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="bFYmCeGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1632A3EC;
	Mon, 17 Nov 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379355; cv=none; b=jDUZPp8wdHrT76MHq0U26TbJYwc41bm5xjrRqegS31v3GkP1bzfcqBBnah5E34LeBb6fWoM6bhhlrc/e3F/EPXK/h57XlKo30Z1nWQZPbmX722OIpfvTzZbIF3FjAQXv4G9Tpy/EbCNYeC6h7nbkPc2jHNuxyKxgOltjobOlvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379355; c=relaxed/simple;
	bh=qnDe/p9OoTpzCNkQq0CQP6XXrv4GRBtIByogwmqVom0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXYUdbyvP+K8tUcQIeux9s4H8ZodbyveDVFnc5rxvOEfkZIC1zcrUHnyNar5fByrvqrWBqvBonv/W9DAS7cp3QYAYczp8qkFppRQWjmTUhslBQfWSREj1iJFwidb/DLmBS6jGmVLjeuzqXtIAK7HSjM3CZ+mIsN+q26ybkZANPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=bFYmCeGj; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763379338; bh=qnDe/p9OoTpzCNkQq0CQP6XXrv4GRBtIByogwmqVom0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bFYmCeGjonin1JtlGL3KrEeIBYG9hz7EBqnzqeKba4J5z0aHi32T8j4MmmQgFLiXC
	 jBX5JWzzbFGJGBfgSwYK+3szMRBTMiBzwoukjY9apNIPbc/C7ZOC24IFDdZ144XuSk
	 YP1O1sXZLPdV7f9+R1UWg6awIKtvvvXAoIvPc9/WuSEYeNH2bKRCHI0AafZGp7AM6s
	 DbJNrxSzJY5ZB+DZv8xxosDmi72h4mCukLPaTV/RnmqJwa7w/ud48+UVOIf5GgD73W
	 8ML6Di4UAnIhFamEPNJvF+ilHpd13JUyyC93lYWrUMxb7GdIEUCSAzBFcQQiRdIQ8T
	 Mwrw5uLD7cYNg==
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Johannes Berg
 <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
In-Reply-To: <20251117020304.448687-1-rdunlap@infradead.org>
References: <20251117020304.448687-1-rdunlap@infradead.org>
Date: Mon, 17 Nov 2025 12:35:35 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ldk4oprs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

> Repair "bad line" warnings by starting each line with " *".
> Add or correct kernel-doc entries for missing struct members in
> struct ath_tx_stats.
>
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>   Valid only for:
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>   - non-aggregate condition.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>   - first packet of aggregate.
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'xretries' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'data_underrun' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'delim_underrun' not described in 'ath_tx_stats'
>
> Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debu=
gfs.")
> Fixes: fec247c0d5bf ("ath9k: Add debug counters for TX")
> Fixes: 5a6f78afdabe ("ath9k: show excessive-retry MPDUs in debugfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

