Return-Path: <linux-wireless+bounces-17739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD29A169E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD23A05A9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8018801A;
	Mon, 20 Jan 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="q/XNj3T1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FD19995A
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366512; cv=none; b=XY6lsWeyYRAz2PfV3Ym9nrXhG23CmDA7vOgGYu5RTThtYGNcWCY4aBrMXGH5SFEbdUsTjQ9N2Ci5pbzMIxig02DTFwz+a7dCnOnf2uLdi/goBSP7TPiO76P2NriNxuWlV40mUpRGII5az6HZp4p95KCMy9U+HvQIStWVV0asoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366512; c=relaxed/simple;
	bh=ql32xbg85I1918+rAm9PT3RbU/6ewDkfsHQ7pzfxK7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JuuV15bOyPY75pOzc0+Aq5BmvLh3oc0D+b+7WyTPmTmsVWS/M+pVAnE83o/XRKfPEdPjgh67h/b5LcvDIxJdTY1QPTdJeXl04ee+sViG5qZVPHonvzUSfPdc5z6VB+ovCtt4TOW8erydRIIlZ6n80AKPbi8VX8vNfKmV41a3dN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=q/XNj3T1; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1737366499; bh=ql32xbg85I1918+rAm9PT3RbU/6ewDkfsHQ7pzfxK7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q/XNj3T1kti/qEDjfUwNgwqGjENFEJRmiIUXeHbvb9rnl1zSmrRGAvDZoOQqgCIl1
	 4hzzOeI+p6XLU6k+zIQU7XAQt2mjtGuMWZrQDKZW1J/t4Y5jJMtXwRIbYBS3/iDIH3
	 fpT2zPH1UfqEK0EjrlV69YPRbOxJW8Gzs4cJIsTcn+E9nEI1esV3qiGOFBDK0zhV1J
	 uhFZDX4BtTpcyhlMIVRA+JO2fA/Te2gSlZPpKVledIg/LETvWjG/Q+ixTk52rcdVeI
	 85q3P/a6tfKt9QOJnoRKE22u7CJg0SOqeOSWxyZjQn5pctnbh9Pbb+DFBohd+aiteZ
	 DaIvgtOoOhc3Q==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: adjust ath9k_rx_prepare() and simplify
 ath9k_rx_tasklet()
In-Reply-To: <20250117084823.1193083-1-dmantipov@yandex.ru>
References: <20250117084823.1193083-1-dmantipov@yandex.ru>
Date: Mon, 20 Jan 2025 10:48:17 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sepdn7dq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Adjust 'ath9k_rx_prepare()' to fill skb control buffer directly rather
> than using temporary 'struct ieee80211_rx_status' in 'ath9k_rx_tasklet()',
> thus making both temporary and 'memcpy()' redundant. Compile tested
> only.

Hmm, so the existing code follows the "perform checks, then write data"
pattern, which is generally good practice. I don't think saving a
48-byte memcpy() is worth it to deviate from this pattern. Certainly not
without testing :)

-Toke

