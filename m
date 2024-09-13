Return-Path: <linux-wireless+bounces-12848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD29784B6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF7B28B62
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AD26AED;
	Fri, 13 Sep 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="wqnVEXtF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B212E1E0
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240793; cv=none; b=PYb4i5W0HXJPTsn1hf+RQQslFnbzCZGgyhne0JWGOfG0KI2T9t8YqGNvjB2n0aI219mI+VAfJpqT2bpVNSzyXoXspqg2zJkKxszml1rpzYtt/TohSJK0kEXdrrZw4M+GD3Y1Zun4YtwR6LevxSDwMlGylH5Y05gQTB5gNph8I/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240793; c=relaxed/simple;
	bh=LjeGBpBssO5GcceSJkIVR/4TvXvCzs5hkLJlAycAF50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FE78Dv03sP/3eetTvzG9pAnmVD6Bva/huffPPbKqZCHipjoWfzK8adEX9BZKAlyFv3ru3F7KOsgPx63zrSeGSNze5+6JkVwI/QXwgWBnirEdG68xhqEju08hujsKwM4ZcKA/p7jOvy9m02Hq8LuCy6TgRieAVgs/YUYjTTvI0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=wqnVEXtF; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1726240780; bh=LjeGBpBssO5GcceSJkIVR/4TvXvCzs5hkLJlAycAF50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=wqnVEXtFLxVf25XYWkYqO0vMVcc5XgXsojFgd2HseJpPkUCSgSTi8PKjKXSiFLXH8
	 PwjqoM/HADfQhv6hrhdP0OfeFdok0xPpjnqM5JzsC1ZRt7ly25HiK3ReptSpP0f2lL
	 ChvlZbm6ZYHBa3Lbz+Y+2IrL/WjLDcBIJkvFjqzhnx5pt+mFzLAdqWqKXiJ48tJofN
	 /94GFXsK4KqrZrPiBBShYLHU1J/bZQU94AUuZhnudQgLH2LvxIBAOwBqMB5NlgIBYG
	 rkgY41uphDf92VX4Lz+NIHXHXA8+fpgogo57bTckZwrCt0Y2cVq8s8s4mIIjBO0aa2
	 ZEQk3h/g5YkIA==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, nbd@nbd.name, yangshiji66@outlook.com, hauke@hauke-m.de
Subject: Re: [PATCHv2 1/3] wifi: ath9k: eeprom: remove platform data
In-Reply-To: <20240906195359.6982-2-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
 <20240906195359.6982-2-rosenp@gmail.com>
Date: Fri, 13 Sep 2024 17:19:39 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wmjfa8dw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> There are no more board files defining platform data for this driver and
> eeprom support through NVMEM has already been implemented. No need to
> keep this old functionality around.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

