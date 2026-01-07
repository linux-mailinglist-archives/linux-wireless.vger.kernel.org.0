Return-Path: <linux-wireless+bounces-30433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7ACFD1CD
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A632A305D900
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E12F5A32;
	Wed,  7 Jan 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="GXx6D1jY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10C2749ED;
	Wed,  7 Jan 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780219; cv=none; b=GusK+dpskov8AXNm/tzGfWfe+zvB2KhGdjlSWY/z99TwviicCmlJ36LJwg3x7L5wXfGP/uwmGBcywU6Jp6BggBkJuBIxJhFbBnG2eqqg2La2QHSTk0u9eIX39MwOaT5YAN0DGppz1ZyuECFDedlLV0mA4Hq19srO3Et/iGMQYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780219; c=relaxed/simple;
	bh=wUER6/AtB1sTr+YA/nTEw5OU1G8kDQVbz2TCDiIyqfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SSTvzp5mz0GM/8bSTX/DU+AmUNvZbIu+Db59e6Fa7hRUn+TWfDy2at4crfw2NXHvteJsJUKaP9Ir0KPeWCSdTfg1FVvvw9+eXIO472HGw6JIGKdsv+1cuUAbLnHuLBCDXQsvfIJLVKkKIwykWX9LZbF4nUy65F0OOyxPINpuErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=GXx6D1jY; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1767780214; bh=wUER6/AtB1sTr+YA/nTEw5OU1G8kDQVbz2TCDiIyqfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GXx6D1jYoQ8tMVPJ/QVi2jgT22RIbR81vhat9nv7d8DlVd2esDrLXfEw+C1Dz8Ekd
	 WaqX07Jn/lUAB5oaWLWnrnVKfHiMGdXxyfpe0LU5aGXl9WOpGt9pHZMSvJJ4Yzk7wh
	 1kFt7qv1YuSSUpG8cGJUyx+rnYRvtTGTYv3JJE6Ib0CRgFUP3WgEAePwTJeOZkbe43
	 d4E+qR2OKHVX9NGGmaFcWmnBTlaAnlEG8JFLjDbGeGQuPUa7FZD7wwyCJZjPPor2c4
	 GcUyIaSezYdKEfd/cf5wtWqX4lhoHNdDjmcSEwpVO8ECWfKEgIvkriI/9vweYrua3c
	 vodFHPtHOKTYw==
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Tuo Li
 <islituo@gmail.com>
Subject: Re: [PATCH] wifi: ath9k: add a defensive NULL check to prevent
 null-pointer dereference in ath9k_beacon_remove_slot()
In-Reply-To: <20260107031203.170628-1-islituo@gmail.com>
References: <20260107031203.170628-1-islituo@gmail.com>
Date: Wed, 07 Jan 2026 11:03:34 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87eco14u4p.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuo Li <islituo@gmail.com> writes:

> In this function, bf is guarded by an if statement, indicating that it may
> be NULL:
>
>   if (bf && bf->bf_mpdu) {...}
>
> If bf is NULL, calling list_add_tail() may result in a null-pointer
> dereference:
>
>   list_add_tail(&bf->list, &sc->beacon.bbuf);
>
> Therefore, add a defensive NULL check before invoking list_add_tail() to
> prevent this issue.
>
> Signed-off-by: Tuo Li <islituo@gmail.com>

Are you fixing an actual bug here? Otherwise, this is not worth the
churn...

-Toke

