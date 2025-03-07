Return-Path: <linux-wireless+bounces-19990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BAA563C7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C473AEB9B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF33201278;
	Fri,  7 Mar 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="cRHA9YOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05891A314C;
	Fri,  7 Mar 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339765; cv=none; b=FyBL/R0XWVMrHNs/nIU68Pd80U2HMjHyRbfnx5ij0HZVRDF24mCpQmPwSJe22jGHe1DBHD7GtzDiDJkC9e+t8EsL+yevBdU8C2T5MTczEBURW0NwAouXyLsniWWnSWq7DNyouCBrjotZ+H9SklajXtJRwq/GflqczBn3+9fhCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339765; c=relaxed/simple;
	bh=7Bfh7k5UFdmVJJ49J0KDeGRQEWeJgvMMCfSW/OTRfHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqjSNloDusTHNJ4J8OVMjpezSPuIihBm5ZHY320qMlwg0K2StBwoUPwDgTnDsK2mkT6YYw+NOSraeNt1ayfbNDzBGrIzzqKQKwNvJ+UdvPuOBHOoj5W+I3/o21C6k6ktSoJ5v0ZF8Ll3qTEqw5xIfGF/c53OcSd/u1ZRMmzYwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=cRHA9YOt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2FE081F93A;
	Fri,  7 Mar 2025 10:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741339759;
	bh=GoOiJhY8rRPZ1FkH1+d35YRgNoOiXclww2mKrX+grYU=;
	h=Received:From:To:Subject;
	b=cRHA9YOtsK8T9ZERn8VJgDzgCNizecLxpfsGZl1vaxUvfO7AT7NN1vHTkDP+wY+4w
	 FVTD4YnTsiVTrSH/wrFuwqWQnhphWwJBLmmcAFgQ1coazjDfMkO8QCdq1bk6fIvvTI
	 YM+6eEaMBYHYfk/kjbuAJcTr4e6he2UnkG0DupH42rXHA2OuJYES3wBJlqoExQJ/sQ
	 yA3IzvmWY/6yoMVq3lZQFmTVIhNd+NLJUlIjhtpefN0q5C6RolcwNT4AliaC6ywzRQ
	 pt/URsyPkYcjAcRg6WlNrr4OIpGnzWakZvdPdbjPIroCXrCXfI15JF0KpPIw9h4lFs
	 Lwcb/RUOywG7w==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id CF8567F934; Fri,  7 Mar 2025 10:29:18 +0100 (CET)
Date: Fri, 7 Mar 2025 10:29:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Constify struct mwifiex_if_ops
Message-ID: <Z8q8bleeyyavuNeA@gaggiata.pivistrello.it>
References: <03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr>

On Sun, Jan 19, 2025 at 06:48:39PM +0100, Christophe JAILLET wrote:
> 'struct mwifiex_if_ops' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   61439	   4367	     32	  65838	  1012e	drivers/net/wireless/marvell/mwifiex/pcie.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   61699	   4127	     32	  65858	  10142	drivers/net/wireless/marvell/mwifiex/pcie.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

> Compile tested-only.
I did also a brief smoke test on 88W8997, and the driver just probe fines.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin iMX8MM - 88W8997


