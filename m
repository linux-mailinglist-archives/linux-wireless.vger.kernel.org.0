Return-Path: <linux-wireless+bounces-27038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5FB4519C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248527A9731
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720030506C;
	Fri,  5 Sep 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WDkOKG57"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B927F171;
	Fri,  5 Sep 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061163; cv=none; b=drspvWGvIOe1h72MoR08Xea45MnFQwu/TL6Lnw6wY8p16X61f3vQ+uvkmOnrMqkK7QByzD5v5XIywV6qvG2FSMOIWrVkh2q0JEJ/ez6OkKUSZGDNi+eYqe1vh00uC9H6ED16cnUFyU83Ztd7DJGsZN6K8GuebKhoFeJ0si5r0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061163; c=relaxed/simple;
	bh=gdgo98UBu9tnVI+LdlIj+s28S38NIHJ8D93VYEcJTIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUeoFE4JdikKreSDxpVWqzWfnBggyWnNP3R+ys7T9l78gBm/6rcS13kOHc5en7yc4cRj7NY4B+l0uU+77s9tVjxbqhSCATww9Bl0o6lGk3gu6vyLgH+WH2EhbqowWbxOZGWbLB/HxMta9yGeijSgxUR66o9tjxetEdtywknJLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WDkOKG57; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CCDA724598;
	Fri,  5 Sep 2025 10:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757061157;
	bh=zBvxlXtecnfYqqxLnxD2HAlJrXPLBmw6QuB6xtPx9c0=;
	h=Received:From:To:Subject;
	b=WDkOKG576lqakNyGGdvYPd7Wgj1TvBIZmr+04CzAEn5RFeqDFStNUslf5NNXhbY4o
	 P3n//MPtCGruVAHoUJZACvVo8KGGXLBGz41h+uh1yELtDw+lYKh/cLeXW4qX02kxLQ
	 PbrMWllYzL4yjI8TPJDDG5LK2Qth9fW4v1heYp+qGvPSl7JSkoHVu/qhpCQhbMbiLj
	 /41XCSIDOimwqQMA2Xfz/64+3oJo/MBWAesTPEddKhPHl5InLioto1oqp/Sx0EZFYW
	 l5S5hS8iNlKI/UmPpLrwR0z3/KH+MXbgCvDDz+0BMjlNaNZ5PxB84CYJY77OPkQXMM
	 U733ImH1Wm9IA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 2E22C7F8D7; Fri,  5 Sep 2025 10:32:37 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:32:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: mwifiex: fix double free in
 mwifiex_send_rgpower_table()
Message-ID: <aLqgJQP1M-YHbEpT@gaggiata.pivistrello.it>
References: <aLqZBh5_dSHUb4AE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLqZBh5_dSHUb4AE@stanley.mountain>

On Fri, Sep 05, 2025 at 11:02:14AM +0300, Dan Carpenter wrote:
> The "hostcmd" is freed using cleanup.h, so calling kfree() will lead to
> a double free.  Delete the kfree().
> 
> Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

