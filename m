Return-Path: <linux-wireless+bounces-16155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E1D9EAD7C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 11:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB815188F87F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC691991B6;
	Tue, 10 Dec 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="rbfzhWL9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD878F33
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824787; cv=none; b=SiDGVKXgB5Kchc7upjTKA9Ao9MU8xYbW9OYlvrVY1f0IBLapiBkgUP4+eR5WKPwq28zt9k+lUNYC12+V+kGglCFRJYJtC7Vik+ikpu1tM0Uyz1XoOqJxcLydKxvyVwZbj5XfO14mXdORrqGlUMIVVttw98dY+G47Qd2bClhmKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824787; c=relaxed/simple;
	bh=BexBHxy4oYUDZ/FdkFU3Og8oqxAQIZygFMsmeXqucVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=upsg4StAJbXTIlfsSck2ITmXuJ+G/uhL9PXnVsgHpj7wkZeVRlYWs70X4LBrfH/+gDlQj9taxUkdiDC9A/J6m8ATj+FnJLJCbGUy8B1YWr2vdPRT3wTOhK6yyPi6zwRHpsyZgJYy7hYY3w+njtpCTZiICbwxx3BDd8LEDqEUG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=rbfzhWL9; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1733824783; bh=BexBHxy4oYUDZ/FdkFU3Og8oqxAQIZygFMsmeXqucVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rbfzhWL9lknc6KezNDJy8eGk1EoARaZA6w9ihomjw2PxTewBSqVJqyiN+2xE3P9LC
	 8zXkXnylMaAnWUaXYjSFUa4HWhpaQpBmzAFGi6El3CbXcA+cHb1jIlLUOcj3dI/Zyi
	 +E1JaJsSz7juPqr6yVDT3EkWcGPCyYTm6mgHTbKU9wckmzF6VyPOB83fGycEWzwnc2
	 dKYia6b510u8RvuZgp+9Ogdf9R77J8GfB8LiAfVgDqqWHOdf6uT28d2h2esY1yFhtn
	 O58WW3OH3pOfWYpgMRAPpIfn+01GfV7KdDWTmAl/89ULmqvLtOGB5bgMF1Z07of7qD
	 8oAup6T/1luWw==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 2/3] wifi: ath9k: cleanup a few (mostly) TX-related
 routines
In-Reply-To: <20241209155027.636400-2-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
 <20241209155027.636400-2-dmantipov@yandex.ru>
Date: Tue, 10 Dec 2024 10:59:43 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pyf7t9s.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Remove unused 'struct ath_softc *' argument of 'ath_pkt_duration()',
> 'ath_tx_update_baw()', 'ath_get_skb_tid()', 'ath_tx_addto_baw()' and
> 'ath_tx_count_frames()', adjust related users. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

