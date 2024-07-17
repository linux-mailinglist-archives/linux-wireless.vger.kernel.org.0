Return-Path: <linux-wireless+bounces-10286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F89338A6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7DF1F230D7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED293A8CE;
	Wed, 17 Jul 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="d5TQu/Bm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1578376F5;
	Wed, 17 Jul 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203863; cv=none; b=ba4A/89BdPa6FoSl1U58opyORAGu6WMHkQykUFLavbv6qFL9G+l63GXjWRErusBM4MLtKIbOFV8cNSWYRFgcLKqIkmSH843y1WUn24X9nWddpRagfLWVVNtAFydPxFZ9sr+JSMJ4Kj2mLpW8fiapPnKgJ1yNGPJBrq2LapEzB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203863; c=relaxed/simple;
	bh=pLapTjcE2kZEytq5TahsLB+X7fq7FH2BEgvHXktwvSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm4WHhG7F7mV6yZ3Hx7S5NbBwaTAPJxGS/7Urd4SO2GPnaDTeavBXWcON/VesBR4QHEl3rjtEE8AObNYu5ElKqZC4JA4bI7pGPyI//5pP8Z2/kmLN7Cu2OJg+errL4TWU7oJg8LNrQW0BHgIqV4ym+xL2kyGoMcw6x0rv+CawhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=d5TQu/Bm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 83E001F9E7;
	Wed, 17 Jul 2024 10:10:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721203858;
	bh=epRj+I/Vf7Hbz4lZKmkg1kKE5yO0Sdc343pWiMDDfU4=; h=From:To:Subject;
	b=d5TQu/BmZmt1DOAQTGZnkl9+78CLXbKVFpOR3CqAKQx4uGQQEMfX1vtejlu2yzRlm
	 7yvmfF11BXBhAXzXReOFQJPC71mG8F+wAM5y5Ay/RkTGZ8VFNX0HOzy6XB2XWziD9r
	 Wy7Wg8ajcK9/UkVNeH6G8ISPVYwWOtchNiEQf/8OAVsydW+lmEARXQHImGdQM20MQ3
	 25XQdpHpD7G73H++Pv7m+t6d+Q1v7znC9+TUGYnsygadFH6FAV/pxH00xLj6FUvyd7
	 LvsZm5oDAJVZZwrILDmz8GmayZNr/QiUW8AJGuo04BWPFCiTmUm9DdU2M8ZrU+gCWG
	 ofxNfPAqsrZwg==
Date: Wed, 17 Jul 2024 10:10:57 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <20240717081057.GC3312@francesco-nb>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>
 <20240716195731.GB85916@francesco-nb>
 <ZpdgwCyoYPAFLBJI@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpdgwCyoYPAFLBJI@pengutronix.de>

On Wed, Jul 17, 2024 at 08:12:16AM +0200, Sascha Hauer wrote:
> On Tue, Jul 16, 2024 at 09:57:31PM +0200, Francesco Dolcini wrote:
> > Hello Sascha,
> > 
> > On Tue, Jul 16, 2024 at 01:33:28PM +0200, Sascha Hauer wrote:
> > > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > > using key_mgmt=WPA-PSK-SHA256.
> > 
> > Do you have any more details on which chip/firmware you tested?
> > The change looks good, I am just wondering if there are reasons this
> > might create issue on some specific chip/firmware combination.
> 
> I have a IW416 with firmware 16.92.21.p119. The change itself is derived
> from the downstream driver. The downstream driver also sets the
> KEY_MGMT_PSK_SHA256 bit unconditionally for all chip/firmware
> combinations so I think this change should be ok.

Fine for me

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


