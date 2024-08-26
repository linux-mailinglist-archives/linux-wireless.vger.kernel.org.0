Return-Path: <linux-wireless+bounces-11940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E295E92D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BF91C20F71
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CED2B9A1;
	Mon, 26 Aug 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="pG+wwiOk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BC63D;
	Mon, 26 Aug 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654467; cv=none; b=Vx6hL2k64Db3kb660w4Quc4sGiMYvKXr+Sn5tgAoNhVF9AzOKQ2XMBnKtHFPYibhkKyLPkfFiAHDHy+VU4Fgn7t4GZ87Y7hMGRMNuQviZx0isCQV0rW3qK5YEBXNH4r197QgLDsIuJAP9SN7KX+o4BDg2C7zv0rdHk4/aoBQAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654467; c=relaxed/simple;
	bh=0MNbDp5j8YL2LJF6o8a921rlsDxFgtGr1kYAHKk6zP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHj1uK0tU8AEZVXqTwvPRMAFFGhrrrNiS3AbweqzLGfTK9hlQxF52s9pXwTctfUxPS9UBrXi2qg8H/URlI1iV0zimdIO/vcZNN3j/Lhf+ljn9odnTjduZsYbR7uNv3xVQ4nDqxUqkBfDCV+boJG4jEpG0UNhrqEAOFEIO5b6K1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=pG+wwiOk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2105A206D7;
	Mon, 26 Aug 2024 08:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724654452;
	bh=KTSMCsd5RlYdxlu7gKuUWUz8NpEjUYSu7rhdQ1dxezU=;
	h=Received:From:To:Subject;
	b=pG+wwiOkVyEByMy1jmwifyB3vtLpoV0Rr/l/D43slej69+hUO74PZgwf9TDmlgTVz
	 qL8ul2tNZCFvIoqxBhP9Ytt8na/+3NDc9/S1UDjmQnwTYAxEm5EU6XXn44JdUrCvbh
	 Ata1XAMyrRkqIwkoM7jx7xuV2OM4EeNiEq1+DNsvkWYyJ0e8TTeSBN0HmxOumoFGsd
	 5wFelroMGiYlRWVsJP+P/dq0+PUFEzIqAitSSKMuruiIGxuf0YusPudLHWODbkuNsE
	 4kfnF+sV7qTkgbH1RE3ZgayhT60oTY74AfQO/3a2IrHpZlSllLfQdkObgTiYA13xtB
	 b1ih1HHIRmtqQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A67847F84D; Mon, 26 Aug 2024 08:40:51 +0200 (CEST)
Date: Mon, 26 Aug 2024 08:40:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?utf-8?B?6ZmI546J5Yeh?= <chenyufan@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Message-ID: <Zswjc9GjE9V1C7VT@gaggiata.pivistrello.it>
References: <20240823070320.430753-1-chenyufan@vivo.com>
 <ZsjAZJjBvjGLkG7f@google.com>
 <c2ae3b1b-d654-47f3-8520-888bdaea873c@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2ae3b1b-d654-47f3-8520-888bdaea873c@vivo.com>

On Mon, Aug 26, 2024 at 03:18:28AM +0000, 陈玉凡 wrote:
> 在 2024/8/24 1:01, Brian Norris 写道:
> > On Fri, Aug 23, 2024 at 03:03:19PM +0800, Chen Yufan wrote:
> >> Use time_after macro instead of using
> >> jiffies directly to handle wraparound.
> >> The modifications made compared to the previous version are as follows:
> >> 1. change the type of mwifiex_auto_tdls_peer::rssi_jiffies to
> >> unsigned long.
> >>
> >> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> > Changelog questions aside, this looks fine to me:
> >
> > Acked-by: Brian Norris <briannorris@chromium.org>
> 
> Thanks, I will pay attention to this question next time.

You should just send a v4 with this addressed and add the acked-by from Brian
while doing it.

Francesco


