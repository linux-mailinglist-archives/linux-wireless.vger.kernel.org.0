Return-Path: <linux-wireless+bounces-4387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F72872487
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42349287FDA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BEC129;
	Tue,  5 Mar 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B9TLHnG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C73D2E5
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656865; cv=none; b=DXSd50ufW96CTTEsmwQtm3cBbEp5xU0Jq7Ys//in3+ICgg/A6MrV0DtPd65NRL/42KElPi0bhf3iYoX9rps04XFg8TpHFEDunAWHxsc8NLT7BInJt+Vd6uhQkW94jPKw1VwvUywZ2FBbjUyDYN3O0wcNRmDfclFL85x9WDVaKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656865; c=relaxed/simple;
	bh=bvr0Fo9tP0S1Q2TW/+oACpudFpAGZ1hOc/KQGLzLwYs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bswT1uG6zUJiLw6ux6pPLdFD15AxvjjkJlbR2MJDgql5fBKlSF3QtQnHeX0QygtaB/wAuI5H1wE5ULi+7q6C3dvlXzHfQ09j8nwgP5AcCwGw42CQaphicirzA6Nf/Lov2M0OawjV6P9jWd2fXNiHzC4EU9CUdCGhZ9NHIWmRILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B9TLHnG1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bvr0Fo9tP0S1Q2TW/+oACpudFpAGZ1hOc/KQGLzLwYs=;
	t=1709656862; x=1710866462; b=B9TLHnG1ZoWFzhYRizBDyYcbtrY2qsspu8CBmFoIrW84/4d
	p1UoZl8ImJ7aB0/NbLKv9RU1cuqFN25ZNU8T8u0fsY94MiL3c+CUTbYDDO8T/Ic7PSkrO4C3vGyd+
	rOPoAjYFTFRT6RmSZkfIznHqyva60L+tpHblaNtHhzEgNYA7bZVz60JQSFUpBKhi5P4QXN2akdakZ
	wlJHyGjnG+5pxWXC7ERmPpdE00zvndZgbJRkFh2XZ0Eta25xcTmJ9p9kMRU3t3NY/sgzhkJbkl5G1
	Jb7MlwDoZvnFCLHnq6eeTwqBmlwIo1b4mrbfG7aMSTBnRHFGkL+bC8FodKiOoFqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhXqW-00000002vqw-1yeM;
	Tue, 05 Mar 2024 17:40:52 +0100
Message-ID: <c8b3ede515d22a9d3b7ecc1c72b7a7ebd730b43d.camel@sipsolutions.net>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, Isaev Ruslan <legale.legale@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 05 Mar 2024 17:40:51 +0100
In-Reply-To: <e873f69e-e4b8-4dd0-a54a-191e9826ab56@quicinc.com>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
	 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
	 <7eec23f3-5e1d-4787-bba3-6b06549db091@quicinc.com>
	 <e873f69e-e4b8-4dd0-a54a-191e9826ab56@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-05 at 22:05 +0530, Aditya Kumar Singh wrote:
>=20
> Yes it did -
> https://patchwork.kernel.org/project/linux-wireless/patch/d9739fa6d3dd085=
587c4f413087dfd6c.legale.legale@gmail.com/
>=20
> Looks like the first reply started a separate thread. Probably=20
> --in-reply-to was missed.
>=20

No, somehow I got two copies in my inbox, the first of which hadn't made
it to the list for some reason, but I didn't notice in time that it
hadn't ... Sorry.

johannes

