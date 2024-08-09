Return-Path: <linux-wireless+bounces-11224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE094D060
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7271C214D7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9A1946C4;
	Fri,  9 Aug 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kboeo9Dv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F017BBF;
	Fri,  9 Aug 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207335; cv=none; b=b3/AVdi/MOQUeuW4fK2OOO4tqZW1JJ4vdK6Z2rRYOmVPuZJwaubXGxDvqeCSiK51uJWO49DhZ7QwkE3s0MV2EuXEsFPrVolnjZsMFkDc/qZlIhjYLZotBSgvJv1ULNnV7m+VBgmuF1MGd3bf7vJV3mO86CDhpCPbGsgqHG5FQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207335; c=relaxed/simple;
	bh=yIahYZ07aWyWxU0yFWmwIGEE58zc5LynmOxxqoncrns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3bzqGN4PCbghyX6U8lsMlXTKjnokmCnQu6jUyx0PWWXH9mtCmXdGeapxZKIdSCkmiL4LX408jyC4ohW578Ay5CQCSbAZAS2QGZAMRsoHZifwx7ZdPuBU+z5EXyAhN1e9x5GKRu8B9oJhrsRwTL7NtSeCn9nUPAmFVybTIp/riA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kboeo9Dv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 36FBA2123B;
	Fri,  9 Aug 2024 14:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723207330;
	bh=mAdsZ4ZkKnviA8Ia2Q4VxyaL5nzQPmXGq5rdi5fFuIE=;
	h=Received:From:To:Subject;
	b=kboeo9DvXEQBA3X6Pm6PymITn7ioU/zrnzj5lc+Jj24qm8DQi6NLWOtKIpBNoHlUe
	 Uny5+wW5ERFbm+r3lmRv98Y8KjtarN4gpfDYBJ23V9kK7eO6+NQCyAx+q1jtjoMMxz
	 8MMUwjtvQShJVO0s1Cnp1glaw7bzWUm74kR1opWG7XOeDQ10ZeVn+8kUMGxOjKy/E1
	 XSF6N6+GCzMAlTB5oOJvimC3ahOisjxmW9Moo9JkBuyPNLjtk/khkpPTjNHtMVGqDO
	 qG8x0SalHdlIN88hnD9F1HRJPmF7CC9ul+oPnwbWUMLhfQ2n72lMMOz2oaC1EQmu2q
	 38nojC1YirAQw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id CC2017F99B; Fri,  9 Aug 2024 14:42:09 +0200 (CEST)
Date: Fri, 9 Aug 2024 14:42:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Message-ID: <ZrYOoTRWlKTL_e3o@gaggiata.pivistrello.it>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>

On Fri, Aug 09, 2024 at 10:11:33AM +0200, Sascha Hauer wrote:
> mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> used and modified in driver instances. Duplicate them before using
> them in driver instances so that different driver instances do not
> influence each other.
> 
> This was observed on a board which has one PCIe and one SDIO mwifiex
> adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> the statically allocated struct which is modified in this function.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


