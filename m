Return-Path: <linux-wireless+bounces-10429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDEE938DB8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EBD281A72
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7416C852;
	Mon, 22 Jul 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="cnE7bsik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196681BC2A;
	Mon, 22 Jul 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645829; cv=none; b=sa0Za8srevPPTjSut/JyV6sdGCXdzJFdfJUem0WSBBRLU7CuVcJWpv1dCyFuxSHxgGTHGOqQBR7f3W4b/FmZZU47bTcnm3dRNzdvK4i+d+sf2J+MdeFmUE5gnBpZI1H0YJZS3qXswcyHKjy8Lxq23ykjcQHHTK1BgKW0rdUiOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645829; c=relaxed/simple;
	bh=2HUTmjLjv8tJOQnridOoOJzBzC3sCecsAw7atIiJ6Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmUexTFQoVx/RTL68xEdmym6LK3SUsLb3p2oWun5GyuD5YoyLwFsTc987WWAdwxFnMFv3Ov4GdF2JLDB81FaZafXutZDYRK0Ui4h6JBIipqYohSo7OpQj2bH6uPFqpUcuhz2hr0zdIoKGlor1Pz5x60POaB+Ia44aoxDgx6ybPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=cnE7bsik; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9DDCF1F83F;
	Mon, 22 Jul 2024 12:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721645821;
	bh=2HUTmjLjv8tJOQnridOoOJzBzC3sCecsAw7atIiJ6Xg=;
	h=Received:From:To:Subject;
	b=cnE7bsikAhRhao+ViCfQf8oHQ++weskZ3BE6Jebq0RP/ONWIlT/b4FpiyweQHVC5/
	 vo+Ox9W+3C3rumk2RM2UZdm6MiRskXHFh+FK8zEAEKX7OVTn1PGwl526cR80zE4I5K
	 KaiQIlzZnizabYKPCTFNgvkZtnHmpNi9VoV7BxP1fncQ9rjnSHd/yFAxySjNEufz1b
	 7CT6DgthCmAPlGEWkyNTo8R3RlvfaQpq26ly3nnM/oocMBA5EiYjZZa/C7ggCBkFy9
	 nUrnlNAMBjzgXRWTnVHZ5fPV67dC5exsgAZrJyaJHx9I4Lq8XYNS/mIizLptTrj7DQ
	 y9Fo0pIQPx3nQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 387897F911; Mon, 22 Jul 2024 12:57:01 +0200 (CEST)
Date: Mon, 22 Jul 2024 12:57:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zp46_UOZN0OzJyw5@gaggiata.pivistrello.it>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
 <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com>
 <Zp4O68Y6oss_pwMm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp4O68Y6oss_pwMm@pengutronix.de>

On Mon, Jul 22, 2024 at 09:48:59AM +0200, Sascha Hauer wrote:
> On Fri, Jul 19, 2024 at 12:05:01PM -0700, Brian Norris wrote:
> > On Fri, Jul 19, 2024 at 08:04:59AM +0200, Sascha Hauer wrote:
> > > I could change setting the key_mgmt bits to |= as it feels more natural
> > > and raises less eyebrows, but in my testing it didn't make a difference.
> Thinking about this again we really do need to use '|=' and not '='
> to make the result independent of the ordering of the AKM suites array
> entries.

Yes, absolutely. I missed this while looking at your changes.

Francesco


