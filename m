Return-Path: <linux-wireless+bounces-21388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9BA84172
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2403BE31C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475622424C;
	Thu, 10 Apr 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="MoW5F/pN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580A1DF991;
	Thu, 10 Apr 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283181; cv=none; b=mD+6iqTVT9uyvUFuAmOQrbFTYp45kLgTJ8NXkuFBfPXY0l8YRBbMfBW7nTxKHk7ET/NkfycEiPLPCmzN/vguvMVe8DRinONFj21VIiKvbh40YStrq8pMh9R0BAVVnP1lB7/N+8G/7OnGL3nfjtBgtSLMm2+RIx+NDY8oyve5Ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283181; c=relaxed/simple;
	bh=AwuYDhxevKB+JgmDNskH6m+IaqfRvSBXWyZej42Fs/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=noGgQO36tl40ZVtmGM4Ey54ViHfBgzubwXJp2bkZP3fhGSOaXSM8VpOJCLINz+UVgwfOeYWdSpA3H/1HrraPb+IfzvxXPRHmaX/5Gi34CjuH9AapNpygVRSce0f3Cyv8fdjsLsKVm1uW/nbKxPU51kNqTrXZ/J2a07LkzItpmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=MoW5F/pN; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1744283165; bh=AwuYDhxevKB+JgmDNskH6m+IaqfRvSBXWyZej42Fs/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MoW5F/pNORr0VSzalNiRIh57Vzyn2rXf6oLbcBLryLS0Kjd7k5zVgJW6U1MGAcEdW
	 LaleM5OmbYJBWtiGZELMKH+osEVMdSNr++HDLjKH0GF69sQSNUNHoRHkW/+ZsuZiJv
	 8maAoU1HzOCdn2u4zlMG3uqq/X0XKqlu+0YQChXUfGduzQ4QMEW4J45KodE7xRwkHH
	 xjR3SW+J3oetlt2wdZFLJNJ6EF7wm24nYo1dgYvi1kyXOQlM97rxdEFXD2ct0c6fzA
	 JdNwjJ+MUpxw5e2R105zS6cCgUI/mRmleUK98UMu5u9fn8wIZAJqiyZwb49V3s4shI
	 PQkSdTTJWxhzg==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] wifi: ath9k: use devm for irq and ioremap
 resource
In-Reply-To: <20250410004130.49620-1-rosenp@gmail.com>
References: <20250410004130.49620-1-rosenp@gmail.com>
Date: Thu, 10 Apr 2025 13:06:05 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87plhktgwy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> Avoids having to manually free. Both of these get called and removed in
> probe only and are safe to convert.

Erm, huh? The request_irq() change in ath_ahb_probe() is literally the
same change that you sent once and that we had to revert. Not taking any
more of these, sorry.

Nacked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

