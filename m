Return-Path: <linux-wireless+bounces-27215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739BB51954
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D4E3BB6FA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435E32A3D7;
	Wed, 10 Sep 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="jNPRAyq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F31E5B70;
	Wed, 10 Sep 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514474; cv=none; b=qEjt1eBwbkChhIoTBbu/9vMPOIQP0eaBoJfHWsD9DfESA3lfFPEDbY7jz0v/kFdKCPi1+R/bryDDhYK1bea3fDMnA3V5A3V+kxA3kEOgwnK/iS2p75tpcmmY+x3EGynuzxuMNgKaEB01VWnqmnM5Da+gHMEmlkfvi2AGTJJH5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514474; c=relaxed/simple;
	bh=8okyQkExgyyexDlNGmfq4CqyItome90K5wufQ6qthqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svoJ8PLqOofkUUtlDnecvMzcbuRBNOcYBNwDHeDnerZjVaBJ3P8YEq/qvFn22qZ2uzYurl8v4S1MIjOhFzlRBMyybPO1D1E/IrIQTukMToPHs2BySWRhJfZBC2++SxRcDGw/NtRG/JIw3nEHmb36aLyFQ0UGk2Fg6z9cK6Pp2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=jNPRAyq5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F0681FD38;
	Wed, 10 Sep 2025 16:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757514462;
	bh=z5+cnXGo/HFRyM+iIluhGe0ybgQ91z40QrTwNYLkdDE=; h=From:To:Subject;
	b=jNPRAyq5E6mGNa7vwQl4hNZud7A3+NwkNwXX3fjWzMjPI5tM+kk9wjtl2VL9oOXkP
	 GNlZyLRZEKXbOoxRABkLaI6AyS9Kh6uDY4p6FaUem14HYE2g6jO3dQhD+FLJ+fvus8
	 0vvYc/Lhwzl/dJhivGx+DCG1KdZROhuP54yfPZyXLASfEH4loTSmCHdZtXMHX/nzRm
	 s6qaAyk+6z3vk0O3MDDkh5yFiEdP4tPOS7DByRpUb6+YgrnNDJTQBcnIiIPL5ku9fx
	 Ogjfqyf2jb/k23UO/JjLnwCqMdib6e/jeT1AvNE4ukWbwg5YBH31C/97PMSWObvTww
	 55er70eR6iZYw==
Date: Wed, 10 Sep 2025 16:27:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix endianness handling in
 mwifiex_send_rgpower_table
Message-ID: <20250910142741.GB41850@francesco-nb>
References: <20250910-for-next-v1-1-3ee311706231@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-for-next-v1-1-3ee311706231@pengutronix.de>

On Wed, Sep 10, 2025 at 03:03:32PM +0200, Stefan Kerkmann wrote:
> The length of the host command is a u16 stored in little endian byte
> order, which needs byte order conversion to work correctly on big endian
> systems.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/aLqZI4FfOI4iJZtf@stanley.mountain
> Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
> Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


