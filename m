Return-Path: <linux-wireless+bounces-556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA50808EA5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BCD1F21082
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA449F89;
	Thu,  7 Dec 2023 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="GVhuPJSB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4BA3
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 09:28:06 -0800 (PST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1701970084; bh=ieCM9QfCFCxf9HKT3GIFEUdcjpfP9qA7KGhg+yZrbo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GVhuPJSBsbykzRB5sBd6Ro2YYQdH41JyGkV6yXH6mAL6ZsrmvS/6W67JICL05VTx4
	 NRQSSuPSOzOM7iTgY98gqDQhOWJqpGtDccwp/b4yKggBw+GA98lpZCTPsejzJmUU7Z
	 5BGR+BA0NDMItIqfD4YCUztx+LJsx7PhnRBZwMqUicR4U3KCEJWCDF69BHDyXaukpb
	 XlCvTEE/L2Kirqe1DYCaCK78k/Cq1gw/ymdt1BL3+hYHZhNUqjduvWtxg6klS94wU/
	 /L+QSkbTWjnX+ShbzOsT1TImhezxapAkKOxRewzqCQDiQy8kke/9Ey5GeHuSiDywjL
	 4e4cRzxbULUKQ==
To: Hancheng Yang <hyang@freebox.fr>
Cc: hyang@freebox.fr, linux-wireless@vger.kernel.org, kvalo@kernel.org
Subject: Re: [PATCH 1/1] ath9k: reset survey of current channel after a scan
 started
In-Reply-To: <20231205170623.3029689-1-hyang@freebox.fr>
References: <20231205170623.3029689-1-hyang@freebox.fr>
Date: Thu, 07 Dec 2023 18:28:04 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874jgtly6z.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hancheng Yang <hyang@freebox.fr> writes:

> In the `ath_set_channel()` function, we only reset surveys that are not
> from the current channel. This leads to the accumulation of survey data f=
or
> the current channel indefinitely. This may not be the most optimal=20
> approach, as we want the ACS to rely on the most recent survey.
> So reset the survey data for the current channel at the start of each sca=
n.
>
> Signed-off-by: Hancheng Yang <hyang@freebox.fr>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

