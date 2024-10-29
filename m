Return-Path: <linux-wireless+bounces-14632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106199B46F0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58812837F6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45291DF985;
	Tue, 29 Oct 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJqK+YQ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C17839E4;
	Tue, 29 Oct 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198016; cv=none; b=QyGtN7yx11qy69bP5AniRGIVlffczmYvy0Y0ZPJ//806ZlxIPJW2khxhuRIaxBBH221Xp7O93u1Kyt4ZWi9FDbaI71yjdMMWB/XXnSWvbil+R7HhzCcvHFhLIf6D5FnEIQDLWv6PgN1cfLDCtALHYFRYRCOk8NxOd6YHPnx6Isc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198016; c=relaxed/simple;
	bh=ggiYV3SOqSdqpsSC+FT+VYF9dOh54HbTZqH3/AFF1h8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tJiN/OMbBcZ+TuOI+zxgj7xu6W3onZ+8QLc6s/fxpoblFS714pEo2dyir6GY7wzsoNUeibXlOAkOmm8eOBrz2Gcd8Ln4myuZWMvUxwO0kJ7oLYS3iH76r/QkiRl8Sx76WK8P4xqDTdMhJkGS6Me3uEVEy5D9V4dQGYkZYM8rv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJqK+YQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73C0C4CECD;
	Tue, 29 Oct 2024 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730198016;
	bh=ggiYV3SOqSdqpsSC+FT+VYF9dOh54HbTZqH3/AFF1h8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hJqK+YQ+CxRI667u72Y7zWWuEfxdC22kq3vaHk62zFt1YHCjZ9jSnx4Pe42NR0Tvx
	 r5+YkKzg/bT7Sx17V97zWykDt2H2DnV3V7vUwOi6cZOxF7fYiyht3g46/WGwk8pnjw
	 bPCYJL/XcnwtMlf6plsasMnl7r3CuuaWLi2o8LzvkDVGBksD+VTIo5iMX4iyo2saWw
	 5voC1IFqHnSz6aZ1n/XTRbVoGH48d8SCmomLWhCCnTn/y9Gp/rUMt2gdZM33iMkdW9
	 uwiuzJrWnHni9cKzo/C2KyZS0pDH2yDKwgwLeyeUGMO9KTkWWnie5HOXVTlAHRKQlm
	 nERUiX5F4U1WQ==
From: Kalle Valo <kvalo@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: pkshih@realtek.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  xiaopeitux@foxmail.com,
  xiongxin@kylinos.cn
Subject: Re: [PATCH] net: wireless: realtek/rtw89: Add check null return of
 kmalloc
References: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
Date: Tue, 29 Oct 2024 12:33:32 +0200
In-Reply-To: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
	(Pei Xiao's message of "Tue, 29 Oct 2024 17:12:01 +0800")
Message-ID: <8734kf2o77.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pei Xiao <xiaopei01@kylinos.cn> writes:

> kmalloc may fail, return might be NULL and will cause
> NULL pointer dereference later.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

We use 'wifi: rtw89:' in the title, please check the documentation below
for more.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

