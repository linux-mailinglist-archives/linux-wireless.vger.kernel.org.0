Return-Path: <linux-wireless+bounces-12850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7599784B8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0466B28CE3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660F13790B;
	Fri, 13 Sep 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="fYJAjjyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D214136330
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240797; cv=none; b=FceHXAKjOLB0N4mfkJdNopE/DaQVRdTLA8pOBtmwG/lATM9KWuh+9TIcpxnywfgwEF6K+SrOvIG0uQhzIfGREOA/yRpHs19U5vJxFfQPsnQKxUjxWs+TabcsXjAYJMLEdAma0skI0RJuwg42HjScv7U55S3pBmoJ+YujIzcsJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240797; c=relaxed/simple;
	bh=/mSwvNqNVG4ezTCTZRD9XEoUYqwD9+qoFPU2P5TLmPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+cWR9gef4guuMT4UwMteM5ZDOU0238wDN+9kMgk5BLVZ1KPGixtHpYYkGauTpyWvFILUJpe3VI3hCeTS05HXBnVO0JZf3FUtGrKO9/PzZLIKkSUFFjiiUarodBk0ckMmhbUBFYqCF45f/uukEhWqjykVIap7BbW9uMghE5RzGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=fYJAjjyU; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1726240793; bh=/mSwvNqNVG4ezTCTZRD9XEoUYqwD9+qoFPU2P5TLmPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fYJAjjyUMHuu7GA5lf+SRUbfGbPotvxO22cIbwiNffPqb9h2+hY0YEeLTxOVQcXdK
	 nMSc7GRpasxL31Xc4UpQDakJG4hMw0wYSyZWp7ATMkTrGxbYBxKQ0jpZ6FiSan1tA7
	 4MBD9aJbAHhzZw3ICqZHmUTUOY62NngS8IK54j5+XOwxRu/97Dlf0W8ZVL/QJ+PHk0
	 OgLQM68oIQR1fAVpJ7yfi82ArBS0u2gnNgaqChGUEpYhBrSM6oxULZfI58KzAhvZZS
	 +U0PvvRtUMoFRpDIN0Jo3o3BnPZ3oLYqvj5LaXUqb3n7S+7IjcouJyEGgan+CaJ1ke
	 6vJrCDfybhaZA==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, nbd@nbd.name, yangshiji66@outlook.com, hauke@hauke-m.de
Subject: Re: [PATCHv2 3/3] wifi: ath9k: remove ath9k_platform_data
In-Reply-To: <20240906195359.6982-4-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
 <20240906195359.6982-4-rosenp@gmail.com>
Date: Fri, 13 Sep 2024 17:19:53 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r09na8di.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> Completely unused here in favor of Device Tree based setup. The DT code
> in here should currently match what is available with platform files.
> Any such lapse can always be added.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

