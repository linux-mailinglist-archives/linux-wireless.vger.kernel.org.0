Return-Path: <linux-wireless+bounces-23374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE6AC31BE
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 00:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414D1178C84
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36113A265;
	Sat, 24 May 2025 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TbSDtnbw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8B1548C
	for <linux-wireless@vger.kernel.org>; Sat, 24 May 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748124242; cv=none; b=nj1ajMsvN37SbvyKwwRl9/wXL96ChTvA9jIF46MKLE1YAERkE6xgzEeQ8alc3lyaBOvK21ZTb8XowtIf8xk5dwANtOQtLdHzvUsPn1Tdn0KHzs8fOn3pnmwQR7Q2AU47/S1jpoGO+b4WHzH9TntedzsGQpMLf+IoNVs1zRgdHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748124242; c=relaxed/simple;
	bh=g6HWyTgrWHj3wMzX3wotfZ4gQUK4ewdp6ZWySYiaIOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACeS/zxjq/e8BBOvdRIbDdGpEZLww7WvjswjNOmHa8fhc4lDaYw+gSrJb1Y+5xorKCdxbNZymrH2vc+rgzC627db5SS1YcCvOs8FNcW7Qk/veMcpwwFRQw76h1A5GilPIqucrXGVUmRvcx6nB1A7AASb/1wsyS1h3/iwfVoVx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TbSDtnbw; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 80E801F95E;
	Sun, 25 May 2025 00:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1748124228;
	bh=jxS4Ln3oPbm4sy1YgNsCi+sBXuqW+jXL43x4PIqWT+Y=;
	h=Received:Received:From:To:Subject;
	b=TbSDtnbwR6u4HQPQ4qntVuxBFNUGTDFwwZKXLW66fi9ikAq+3Pv1u/5bUdxhES8pA
	 M/YMuwWJbFscjlAS4O1158TiI9aUtT+WCpjExGPLjda7FeJanlJA4P6jAq4Cgxs0Eg
	 VmydGL7OXdmOav7fGgxYoPib3pM6DJLHVGqrqsyGes9KM+da03+e0HoDecoEmqRUrk
	 5VFqD9xgKGvBRzkam+D2xVaOkBDA5ZHEoF+FgFUKfBG6LnIqaphgu6C3iT55gQNOL2
	 +jLx04FMuAEx5imRIgdJC9ZgHCZnYA0FTc7XyZiq6Qswz5MubPILbZowOpT9nYIYtk
	 R6L717K7XqPig==
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 395647F80F;
	Sun, 25 May 2025 00:03:48 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1uIwy4-00048G-0K;
	Sun, 25 May 2025 00:03:48 +0200
Date: Sun, 25 May 2025 00:03:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: ath11k-firmware: WCN6855 hw2.1: add Silex SX-PCEAX specific BDF
Message-ID: <aDJCRNUCzgtvTKjs@livingston.pivistrello.it>
References: <Z1bc_jn-k-88Io3f@gaggiata.pivistrello.it>
 <20250121113234.GA28230@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121113234.GA28230@francesco-nb>

Hello Jeff,

On Tue, Jan 21, 2025 at 12:32:34PM +0100, Francesco Dolcini wrote:
> +Jeff, that seems to be active on this area.
> 
> On Mon, Dec 09, 2024 at 01:05:18PM +0100, Francesco Dolcini wrote:
> > I'd like to ask for inclusion for the board file for Silex SX-PCEAX
> > radio module [1].
> 
> Any comment on this? It's been a while since I sent this and I had no
> feedback so far.

Jeff, any suggestion on how to move this forward?

Thanks,
Francesco


