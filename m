Return-Path: <linux-wireless+bounces-17595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A70A13889
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C904C1886C6E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F61DD525;
	Thu, 16 Jan 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="QPWDH+Gz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294C1A0BF3
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025521; cv=none; b=Zc7NSYJ0pdDosLCgJemKoAXwgaYKKMZqVMs0drEEJwtacyJYOYlmOSC+FVqOZBfKzSL+2pR+3BC0su9L9H+lteB92fPhsNPgVU1+KkxjvzeKIqk3s0GfmLE38N/0j01ugOFxzRLeNCe8k1FHNrmwgK5XsfCyMkExiL7Wrl0JsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025521; c=relaxed/simple;
	bh=Y/KzbjnPllcoWaxW7RIqLvbnYq9ea60i6p2smlEvrYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDk+nD+erBp/cretVPuhcaBlaaCcUPWYpO/GQwjUSRhtJ2J732p/tMQTAIeBpjjF+Ajx62/mLOfPihM2JDQiUVpWlkTbLOWT6WDLDBHm0FJPLkzGmmYQdsZEx+dxKwcPaREcQGpZfClkYZgpKBXCQReSR+XmElvbn5hRJIFYF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=QPWDH+Gz; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1737025509; bh=Y/KzbjnPllcoWaxW7RIqLvbnYq9ea60i6p2smlEvrYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QPWDH+GzeNKC1OTl7fHNMrVqYMIpt5TMV2R+62jusw6S5+WjzdZ/xCAjTQT6jyZxv
	 cs5ROFfzQzAzs9bASpKFynhVFgu/OvYahjqokDCemt2uPi4qIDgs0/CHGdKOOUgYrJ
	 HrwyIMxAjw98n7dQ5U/DfT5WBtysuqGwb4ulaW6oXplLb12QJBRg0Ei8LFbA7FGzRE
	 OHTlrTHZTvLeWwlpwnY7nd1nWq9kq7g8mO5UDNIcfRKjWHvJotTt/VSDLKaNELma+3
	 QWiRFVvenB1PWvgMGACLzOME6i8sEgp/N/bk0KGVQlRHUj6IRVKU4CS7qFJ0x1EVVO
	 0qWLd6EJApK9Q==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 2/2] wifi: ath9k: use unsigned long for activity check
 timestamp
In-Reply-To: <20250115171750.259917-2-dmantipov@yandex.ru>
References: <20250115171750.259917-1-dmantipov@yandex.ru>
 <20250115171750.259917-2-dmantipov@yandex.ru>
Date: Thu, 16 Jan 2025 12:05:08 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h65zow7v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'rx_active_check_time' of 'struct ath_softc' is in jiffies,
> prefer 'unsigned long' over 'u32' to avoid possible truncation in
> 'ath_hw_rx_inactive_check()'. Found with clang's -Wshorten-64-to-32,
> compile tested only.
>
> Fixes: b5f871ab4913 ("wifi: ath9k: Add RX inactivity detection and reset =
chip when it occurs")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

