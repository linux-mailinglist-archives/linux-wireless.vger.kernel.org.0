Return-Path: <linux-wireless+bounces-12686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9267297202A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5441C23533
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5716DECB;
	Mon,  9 Sep 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TlCqGXy9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EA16DC12;
	Mon,  9 Sep 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902285; cv=none; b=ipApMYN3wlvL3SGV3XbuF7eHZzH/PY9N1BOaNRoEH9XLiwZ8akGyOCVs5B05f0ycG6HuIWiIp27xlidHhBwkw9Bo/5msmsWgVdX2CCLvClF3OCHRdXnzYUoV3dfNELJQrfKjmnFObBPKPhCvzjJ+O0MuqoTdJeIXglWUVX6Gt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902285; c=relaxed/simple;
	bh=jRvcT5vaZ1yjNBImWnpk0V2uFwgoGBAN6uyiNxAhmzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/fB3LRRU3DY3m5RFCIH5PZ8KxwWfEItLat2jjviODJHIb4/OPVwG3TbHgh84eApIgSia1FSL4HN0GlnjItOeK1MsEMNQiczxvkJ+vj88Nl9adj2KKx461wWj9IyLekZbGer5fJ+CY8l1Ik5V0okYogfYeQl39jyXlVKEJVeX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TlCqGXy9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F9522160F;
	Mon,  9 Sep 2024 19:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725902281;
	bh=9yaN+6PvTWZYukxvwhGYhSOARqeqhXV3MjF6RYf1eEk=; h=From:To:Subject;
	b=TlCqGXy9JIvdXVnexYw/htm7OE9JoTl4q5jTTulWLYpKVj3ZbII3oo5u1qeqNoPvc
	 HFoZgVbr6OoSQL+ecR2LafgEFcDKmE97UT97C8hgO6cj/KUw/L4eANhe2iodRLgt47
	 8I2kyNUwFHzkYUZ3kIiOvzCRjayEnxW3UQW8AhdfOrhsjQP9aby86gu/JHkHXnN8GE
	 OMdqDbw52vCjyvsdbvsiT+fq3pLCV9E6Q2NxLuICLJGK+naGemVxdC5pd2+BBLWWfA
	 48yGJ0Bhwrgv3r3FSuX5vJgoRXsIIv4YvMLnx2l6mEPBNf0tj05ycEzGCNL8yHKP/H
	 pr7d1J2voOIEA==
Date: Mon, 9 Sep 2024 19:17:57 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] [PATCH] wifi: mwifiex: Ensure all STA and AP use the same
 channel
Message-ID: <20240909171757.GA60827@francesco-nb>
References: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
 <DU0PR04MB9636AF11600D2ABF286FA6EDD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9636AF11600D2ABF286FA6EDD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>

Hello Sascha,

On Tue, Sep 03, 2024 at 07:31:34AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > The mwifiex chips support simultaneous Accesspoint and station mode, but this
> > only works when all are using the same channel. The downstream driver uses
> > ECSA which makes the Accesspoint automatically switch to the channel the
> > station is going to use.  Until this is implemented in the mwifiex driver at
> > least catch this situation and bail out with an error.
> > Userspace doesn't have a meaningful way to figure out what went wrong, so
> > print an error message to give the user a clue.
> > 
> > Without this patch the driver would timeout on the
> > HostCmd_CMD_802_11_ASSOCIATE command when creating a station with a
> > channel different from the one that an existing accesspoint uses.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: stable@vger.kernel.org

...

> Please use
> https://patchwork.kernel.org/project/linux-wireless/patch/20240902084311.2607-1-yu-hao.lin@nxp.com/
> to replace this patch.
> 
> This patch can't let AP and STA running on the same channel if some
> wiphy parameters are set.
> 

Sasha, any comment on this? It seems you are solving the same issue (I
did not look into any of the 2 patches myself so far).

Francesco



