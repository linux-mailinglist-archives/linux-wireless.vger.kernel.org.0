Return-Path: <linux-wireless+bounces-26250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BFB20871
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB2C18A103A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869002D3A6C;
	Mon, 11 Aug 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="y1/6tjFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C62D3ED2;
	Mon, 11 Aug 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914226; cv=none; b=LfgXPNq8oZcqW4CBvnRQwuvN9LhJjYqgaaXuYBwAe90wGOpSHg8n5FdjT+7cFIa84eeENQ3CrPCwQepW+i1I2C9iM0Wp7Dk/VHnDNpbojo0Dd+QB7vhmyShZVvqEEyD6O/R5CRbG6WbmGIQUhM8YROMGM2/AmQlpySt5uaFKpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914226; c=relaxed/simple;
	bh=lLSvV00bz1B+j0kmhQVbyBiFNd0rYImHlOy1K44Hl6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEYhCbGRgEyvJKxIUEV4K8oBRDshQ8GdGg5tAOcstRc/hRRbIheYU+iaThRqXQlIZzcH8E1azYntg37kEq3CrV4kxheIopNB+fxFnFki/3fC7gdmVcUqLERk8rINkkQVYQXx9oNI9+GxW+T2f6tmYx/zpZp8yBYcX8caedVpfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=y1/6tjFh; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1754913667; bh=lLSvV00bz1B+j0kmhQVbyBiFNd0rYImHlOy1K44Hl6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=y1/6tjFhtdmvv4yy4cCR8IDGyWHFU2N9b2u7ifYVtppJX5RkSY3bVy0+DeBxvGnsM
	 RVU951GXI2wFaSRcKe4Au0Zzj43Vvv4TmyzHve0LKt35YgVNPw2o1S/bVE1bV2bF+l
	 b1QTt+KgysRpoi3wiqao55TdL9XeZlH3kdIpeYzrJbOPtlfhARdKXJJRMi0NvqaZf8
	 SUVK0FmDzEQ29I98jNWXzm37ojW+46LzNV41Eg90UoC9djtheRAm16XPf09WZq+QLl
	 y2K/KpEliD1q5WNJe2IpYHEHbh2HnzFcTTEmawFoPyGxhEJF82tMAQ8l1RE4IAx1Pv
	 LJfFFKoFABLng==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 wireless-next] wifi: ath9k: add OF dependency to AHB
In-Reply-To: <20250802000432.3079550-1-rosenp@gmail.com>
References: <20250802000432.3079550-1-rosenp@gmail.com>
Date: Mon, 11 Aug 2025 14:01:06 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tt2ekqyl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> The conversion to OF missed adding a Kconfig dependency.
>
> Fixes: 2fa490c0d759 ("wifi: ath9k: ahb: replace id_table with of")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

