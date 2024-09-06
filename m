Return-Path: <linux-wireless+bounces-12605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44496F7D2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9168A1F23B07
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC81D0490;
	Fri,  6 Sep 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="R2gLNSjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F995322A;
	Fri,  6 Sep 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635256; cv=none; b=UOnDPTJaMB7bs0sybnX+Vpz6HdMqmPo7c4cf2xdQCctVJ42McDzRAEKk4fE+2+r40iNIVDWqUFBhf755iBK8Y0c32dUAyLyVP6NpHx3ip2H7Z9LnZF8DvhUrh3Fyp/KXEyra+iT5Irkk37mQChj8rOPOI1ws7VVrAVM69w44tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635256; c=relaxed/simple;
	bh=r6Lln5TGX0mAia1VSDmKaIdCnYLqVs8rAZm2m4RQG/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5zSshJlT8wB6KVZosaA4Jz8GNJAFQfTUN4+S22MkEMWqu1Iw4MWvyaJC31DcQug8LjkQ0EH+JHesZT67ighmFJqD27opxkPp5tFLGveT04AnPenYeDDD7yhRdIAlLvz/XQfYfYLLLGBN6azEbGo8/thwYT5p+dATDrLdE9ViCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=R2gLNSjy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9A41D1F9DF;
	Fri,  6 Sep 2024 17:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725635252;
	bh=gvKW5oIDQVVHYJOhHAkmjHRIJxav26kqnzh4goxY2JQ=; h=From:To:Subject;
	b=R2gLNSjyffv0iDjnXpvN8tgN4HZa16iS7POaMqJoJCNwV6MljMluJxbMJUD0yUfun
	 qCN26YnQ402M97/eWc9pc2k5bGBN8F1ys3oV2Q+pbdYMJhpJYdf2tEHZsE4oF23MO2
	 V9GF+cBLzmC7ZRsp2+sBbGd4F325YFBEnnD7qjF64su8HcITVFJGApS+r+1B7gn51v
	 0HXTDA5IZEwGurm4ctmoXc/iybMNjRaZkWShqeN2ncvSwzanb6kno9l2L+qPnCEARB
	 zm1Cnd8jkM285q9NRv7DAZe69cuKEjN9tK4O9g427LJaCcY/cMY3fpSfdtjU3ZFrol
	 8PqHwOBTwe+wA==
Date: Fri, 6 Sep 2024 17:07:31 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] wifi: mwifiex: drop unnecessary initialization
Message-ID: <20240906150731.GD45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-5-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-5-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:26PM +0200, Sascha Hauer wrote:
> Several functions initialize the priv * without actually using the
> initialized value. Drop the initialization.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


