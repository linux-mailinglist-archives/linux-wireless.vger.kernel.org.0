Return-Path: <linux-wireless+bounces-21437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB3A856FD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF687A9D9A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06502285404;
	Fri, 11 Apr 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rtA23MRC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BC293460;
	Fri, 11 Apr 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361472; cv=none; b=qpGPYF0gnZgZDLGlQfZwYnqUdHNFD3DuXPbtckgXynYOvNJzKQDFyyJh/ZB2+tYX9hoU9276GfzO6aEgzRsL6/hRvfChnqYYItCcVq43ae8t7VDERAI0sBmFtWHXCDdNgzKo1rpzWMsrEUshgyhC43cSEC7zH7ueKGp8xpRnO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361472; c=relaxed/simple;
	bh=kYpJyOSltHztf8wsqxfrG5s4+D5Vv+GPPbUznlhTZI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fazlr+LtPwBkZxzFgeahTCl011/ivfzH/8H1qSq94KNjBm3mgCvhVgF5DpmevIafnCtwl4r/ze1y+LAAh2HNgaU43MQb71NbdcSlC2ymInlzt5uvI7tkh2YH5y3FCswZ2dvTeVYGQtkzeqz8CKshQW8WJ9+vmMS0UM4CIZ1bw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rtA23MRC; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 099D01FC05;
	Fri, 11 Apr 2025 10:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744361467;
	bh=/83PsOQhnfOwQmx5jgp5xx5lA23xBFtCaIePkL2B114=; h=From:To:Subject;
	b=rtA23MRCnuONTI2erPuIQEO+bLXKtiF5xNvIwkreRvQIuZ1XIrLwM05/tDt6GOjUX
	 dVpBAoPpdbMGiKk7xebnrNpXiwR4Os40/0lseFvwRIfcKzxkNvT4oEcC328eEWQxij
	 +VUbLcyVPdJ1rjhVLNI+5T5p2B8Q08yy2ePPXyjcIqWVNlJ1Lj3qXJFc2yZ6LQE21R
	 gqYzRMt77TRQSQnCCyAlmp4iQW4g+p1H89Y4bm+PtZyoeXbf2bc0L91jx+AiQsrn1m
	 55MYhBPercGMt2SjYQ4KE5onsjFX+MakjR7ysNdQkOwNR976fW6dhTg/pM2P80p2nR
	 rKjDd+EonH8Og==
Date: Fri, 11 Apr 2025 10:51:05 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/4] wifi: mwifiex: remove mwifiex_sta_init_cmd() last
 argument
Message-ID: <20250411085105.GB24608@francesco-nb>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-4-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-4-6a212fa9185e@pengutronix.de>

On Thu, Apr 10, 2025 at 12:28:46PM +0200, Sascha Hauer wrote:
> The init argument from mwifiex_sta_init_cmd() is no longer used. Drop
> it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


