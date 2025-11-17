Return-Path: <linux-wireless+bounces-29050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB4C63DFE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CD13B0EFA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CA32B98D;
	Mon, 17 Nov 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="YhSsoNXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E0329C7F;
	Mon, 17 Nov 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379357; cv=none; b=OOGED0sjFufMxRbT/fyysngwVcyQA953PuULCP2W74A5iWpPblmavzryev0TDFKejzWBUlRTa2UvWprLW693ir8Q1wTG350TNSF9caVSeu6gscE1x/c0EY7MmA2ILD2VNzJCqC9n0UPOnSoDTQjOZykNuv3zykUSsuPrUj4EBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379357; c=relaxed/simple;
	bh=bDfOKHIDAXusTJCKg/AUDLPIj4fgROrBnKXLmJFnynU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHphGNAXr277/1jrOOLsWxkrbTCD5dSW5nSEWfM1lZDtY0Cg1SymlNVyEoCZtnBT+29jzqOpJcsebQzIPCXTfoZlbCDSicSB9cRocsiFG//6HmaEO4vghSwoLLVZrL5esulQQHRoUB4f/TuJgnUc8ZyNh7dokqpPSHZEq3325y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=YhSsoNXq; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763379344; bh=bDfOKHIDAXusTJCKg/AUDLPIj4fgROrBnKXLmJFnynU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YhSsoNXqHGBtqW5WNG4Q3MROeCWbl6qY4BD27WbVy+FcNegP4x7xbnHNRfpIob1Dn
	 jlYE5efAlCMQEjs8vZ23elJgTbG+aAaQGBiveXag+BYuXCLyoVDVobNLlxMJQpzM8X
	 +rCK4pMjxZ1UdA+qcaiN/Np5dasbBnf0Wm8Xn31dOn/n0AWDVlMszQG8E4deMu9Soj
	 kBwViu7enCHK+KyaAoLIwKKx/gFet89vAolXTlNcCQe55HNUdVCteYst1Vhc1ya9UY
	 ysUrnsPxbRZMnfvnnAg+5JZYxBvJ7JYmjV9AtVxYXqCYm+GPVwOrAjKhstaS34K0l+
	 QGBxUQp1Rpc6Q==
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Johannes Berg
 <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k-common: fix kernel-doc warnings in common-debug.h
In-Reply-To: <20251117020251.447692-1-rdunlap@infradead.org>
References: <20251117020251.447692-1-rdunlap@infradead.org>
Date: Mon, 17 Nov 2025 12:35:43 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ikf8oprk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

> Modify kernel-doc comments in common-debug.h to avoid warnings:
>
> Warning: drivers/net/wireless/ath/ath9k/common-debug.h:21 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:23 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:26 bad line:
>   decryption process completed
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:28 bad line:
>   encountered an error
>
> Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debu=
gfs.")
> Fixes: 1395d3f00a41 ("ath9k: Add debugfs file for RX errors") (last 2)
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

