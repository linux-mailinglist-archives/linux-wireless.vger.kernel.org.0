Return-Path: <linux-wireless+bounces-21841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B987A96A90
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270377A2476
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8529A1EDA27;
	Tue, 22 Apr 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="b5WtlO1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA225FA0B;
	Tue, 22 Apr 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325872; cv=none; b=Dr32mhujuVKZs0vmTapiW3xB6xyMTmuZ/jNsai7sh2mxJbWsPC4qw6kYNIlpdn+GC8JkzsyF+FPUGiun361ZhgwUoTS31ewElvZMQXHE6PfMR9uSKmFGtzFIbiKS8tCSQ4nU3zSkk0SYq2kPCOiTq8ee8/LKYUs0x7LlKKV2vCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325872; c=relaxed/simple;
	bh=fwjn2eAipGj8txUYSDvtnaSj4kpK0g4kALgLoZJzw2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u18lCbz1zOLux6y0dNYboQjKc6coLXR+D7NjPn62bBCDdiUnLuMBrMr3phkMr4pUo27fRzA0E/oPX/yR6lJ3fsyH+Bs8807qR7uw76aRHRJPOhdmF1R46ucM45xMPyneQEkoAEO0m1VMus44LF45XHAS+SUnRTxI8EHmhqORGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=b5WtlO1o; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1745325338; bh=fwjn2eAipGj8txUYSDvtnaSj4kpK0g4kALgLoZJzw2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b5WtlO1oBw5UJXJaw02uReybBdy2NpssNOTcIVlk2S6IlIxrjbJ1KkNnhNkubM1PN
	 RuiVU35hdXr+V1ZbtonPAY0NE5zCH/y9PtCu12kBbuMBC0wDD5T9zknXQK8x+4WVKf
	 OdE6AXTM6SO9bDYeQcn3fLfZ+YEi8RuWp6rbw21ZLOVFVQEibMPwwOIWngveRlq42v
	 +UudPgMZmh8G7ar+HkG0dHXuBN8C65IZLvuJ27BZHeCwlrtrdb9XUnCGo6YCyWWyu1
	 f6hp7fpXyy3KVw4pkgVLSKH1HUJ4ivU2LqZ2VpUOxv5W3fRLFyat7Ib4qYBiPJlpvy
	 h6+FqjY4xDpIA==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
In-Reply-To: <20250421040044.44887-1-rosenp@gmail.com>
References: <20250421040044.44887-1-rosenp@gmail.com>
Date: Tue, 22 Apr 2025 14:35:38 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ldrsjrvp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Simplifies probe slightly and adds extra error codes.
>
> Switching from devm_ioremap to the platform variant ends up calling
> devm_request_mem_region, which reserves the memory region for the
> various wmacs. Per board, there is only one wmac and after some fairly
> thorough analysis, there are no overlapping memory regions between wmacs
> and other devices on the ahb.
>
> Tested on a TP-Link Archer C7v2.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: remove wrong devm irq conversion.
>  drivers/net/wireless/ath/ath9k/ahb.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Is there any benefit from this other than code simplification? Because,
TBH, I'm not sure saving 7 lines of code is worth the risk of changing
something we know works already...

-Toke

