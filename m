Return-Path: <linux-wireless+bounces-5109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9263A8860A0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 19:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3471F22543
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58656B98;
	Thu, 21 Mar 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="OYPtsuVM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20F12BE80
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046274; cv=none; b=G/n5K1d6M3CZ166hRdi43yrN10elNsZsfEtTER8vF4+bpBHp+XEarFrnqoIh5pumxjYY3VzJ99XZrhk+GPhiYfXK6u3B4z6PvjXsvGj/LxneMp18it+itdyhBkLNOAtpse6C2AN4vzkO8ERO6BiK+eb9f5OuCXQ1lyNM19Gsp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046274; c=relaxed/simple;
	bh=ojZIPiV7g6bmfC8b774a9YG4ZE9m7SBQNwmkKyNWp5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVAvRpgM9bam2jzxOdr4WCXP5UfqavU4w8fAv1W5YjhKnmfUrqY1q0IUYhpvAtvX0Ar9i22HaS8U+PfRD8tDR3ydSa8ol1Rb50lNdNIyfmmMDjXR0UhNHYgxSvC8DZgwrpRrQIR+ivISdgx2FRCc6S9nvRjQu5mINX3o154SiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=OYPtsuVM; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1711046268; bh=ojZIPiV7g6bmfC8b774a9YG4ZE9m7SBQNwmkKyNWp5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OYPtsuVMKn6Lbx/liWSSa0JPXAb8JZd0YPXq4iCulvV/ea6l1cIFHk4Hy3JxLT4Y+
	 8l3SKnFkllM/7Ad4n1v7bj1TrYN7Pva4eOSU+lZdIy/JNMF49wkHhqDiIVg6XNyqP1
	 gSeNC0sHMhifpvRkq7Go0twxhQW/iQf2m011q1rmG7CPgu2BZiS52yy+nhi/WmGvKd
	 zXJsmlIW+IoyJsSaYvl7KDUInt38ZURyAf2Ma6SE7OHkF4X4OWLWgfEC4gXK6eMWwF
	 Eok+eTwRbG6+KHGf7EsACd6cLXOrZOr9Jpljmk1neddnhgLtkeTzoDgZ8Mh6ElBZj+
	 Hatvx07K8SkuQ==
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] wifi: ath9k: fix ath9k_use_msi declaration
In-Reply-To: <20240320170656.3534265-3-kvalo@kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
 <20240320170656.3534265-3-kvalo@kernel.org>
Date: Thu, 21 Mar 2024 19:37:48 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8734sjh1mr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Sparse warns:
>
> drivers/net/wireless/ath/ath9k/init.c:79:5: warning: symbol 'ath9k_use_ms=
i' was not declared. Should it be static?
>
> Move the extern to ath9k.h so that it's visible in init.c.
>
> Compile tested only.
>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

