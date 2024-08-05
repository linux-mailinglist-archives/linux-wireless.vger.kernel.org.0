Return-Path: <linux-wireless+bounces-10959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF5947B06
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124AD1C20C07
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D4158877;
	Mon,  5 Aug 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="AdIpiuGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04F158D85
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860768; cv=none; b=YT4Bkm10ppje1H03M1iFSwx5YZf6eUF8YTQTcnBkB7IE9k523topRQ2tL+2oY//nQ9GXXjgTeE+k4AMR3FbzU/zSJGnUiRCeql6k5/ZkoG/8U3hqdl0PJeeDDIdBWP7NBW16ECoxCHOFbMFxEBKTgHEDm2LJIwxmqY3d+wMnTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860768; c=relaxed/simple;
	bh=7Xi8k8X+Wr0jsb4CPNmvgjZttvKumv8gtA4EeEnQCy0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JqEeF0q9Ucf83KjFxxfkPHUOJzpGN1YVXr1n86D3PtgcqsYrdg66B7SKuSqHiPw0wn8m76QDiBLDZA1QO+88we05bvZPwmAwN1JqCh0JySuF/7RcOp/RM4HD+WWXz/sM6QwmThWtKkkSZyJqUZCt3OTaw61I2hEV5+UqvIh9T0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=AdIpiuGI; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722860763; bh=7Xi8k8X+Wr0jsb4CPNmvgjZttvKumv8gtA4EeEnQCy0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=AdIpiuGIpq0ipamVCsLZ8GKGhrY5cpnXI3sLOz5lSf9+jGWZCVNxsVqyxvWhYdW3T
	 K1eNnwmcX0lzHYrCDfl9mfz6F61IJ/FfWMn65w/zG7lyozQ7HC9ML36Pztis2g5OSU
	 Jy0Eaesej1qws770HqQFwRZ4230Om2hADnHqSg8mITMs2YuD9Us4SwMiZ1UPTJVzyc
	 SBf8Eg3jemRV+w1Ar1nmmJF2n6WYEcbq2+3rOKKZtUw9tpaMBfbfKDN9IScdz+aIQV
	 t4VI9aOjX+n6u/Ng2Rn/8Gaof6kADz+rHbCVRpqUQH3E9Pgj1OsTyG2W+Kx3GUzv02
	 hehfOptCIGH0w==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
In-Reply-To: <20240731210312.7622-1-rosenp@gmail.com>
References: <20240731210312.7622-1-rosenp@gmail.com>
Date: Mon, 05 Aug 2024 14:26:03 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wmkvdulg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> Simpler.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

