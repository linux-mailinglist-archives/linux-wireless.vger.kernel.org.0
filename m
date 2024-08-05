Return-Path: <linux-wireless+bounces-10958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664B947B05
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E2D1C20E06
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB6158D87;
	Mon,  5 Aug 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="tEFtfgu6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4D158D85
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860755; cv=none; b=GGKCQzbGLoSXs5VBIaIMXur/QpTIavK8YY0mUSDWwwq3V4oSDsF7LoZO8NDZFS8rFPCkZ4Dpg7jbJyHC02pV+6OCYf/hkOl2cC5ZHZwhHD2FAwuoBxNqw8W2cbx0hY5UCWEUqqt4eTEP6ND2LXzYTcwfla8uCD/5fNeoCJh6h3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860755; c=relaxed/simple;
	bh=E6gEyO0owtJJ63AQRj8EYToNV6Su3tSLaCYoOJt0raA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbAoRItfdAPbuBKb/NYhT5zNKEtMIVNXMcUl5UdTn1EFswu75uYdd2OahA0+i7EGHYqf3wbr8cM0DcGzsy2WjbQXt96qSXpyFnqGs+bcFR16Nci9kaggmPQZnxuu81qBvdLwB90nwjf01zao/BeBwgIcjcx2vOtbelf0V04n5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=tEFtfgu6; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722860749; bh=E6gEyO0owtJJ63AQRj8EYToNV6Su3tSLaCYoOJt0raA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=tEFtfgu6wP8/MUNJu6Yup2H14WWgiaXIpt7PZRnOCdS9ySz1/pCS61hsyZ0BLauWu
	 kay+TFSuy3Ird6NTVzvXgxL96Ilpg6M/y158WHwjzTk8W8Y2TB228zIYrnVGBKBndM
	 suwd/eRzAsYJvS4yXJubb3PXVWE1tlHkwV6wA0Sd0OZMJ36+rWxcJGhWtQLXJU0aRO
	 Fg7JnZjZIG2V++lIQfvr6aCqVM4Omx8X2TUov2HtmEsTlIvCTYhHFv8u82/Dyx/uN7
	 gB8qQiCwn8cQx7WIexAxm1i6oYoKqxVXXP8gjOzBWFny+Ngmh/E3KIebGo/LGgc8SN
	 ZD6cnNHdmzGmw==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
In-Reply-To: <20240731210243.7467-1-rosenp@gmail.com>
References: <20240731210243.7467-1-rosenp@gmail.com>
Date: Mon, 05 Aug 2024 14:25:47 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zfprdulw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> Avoids having to manually call free_irq. Simplifies code slightly.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

