Return-Path: <linux-wireless+bounces-11950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73E95EB76
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5761C2150F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1850745F4;
	Mon, 26 Aug 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rhU80kAZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB798837;
	Mon, 26 Aug 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659769; cv=none; b=ZNC8Q73hKMk0WvS34aimuYY/ZyXBz4L966egbhExrOYJN/5wpoxfIGjdS7kKc1z08f0ZVLFpV/7QUUkvCkaTRnx+XE7j3IKmbRiXkOCDsH/PHsDdHRMFM4FGh5NVRWixvbJ0PfNBSasc9tzv69/YANIn7nh1p0SJ6PjavCcUaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659769; c=relaxed/simple;
	bh=1iYiAHkIiTEffde6BnDvMjFBeo3wL0SjY/pqqE3E/OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln0FKxMumBWpN9IjMv0dAeOwC4DbPn2lPuov5Fqyyy3Pz3/z3a8cRuEyeoC6xo4Cr03nr+W62H2MvedidDayguWYctGpTia5FSO40XelyJREHMry82a7CFAbMjPCnQlLX44c9/2QFRPSXaOOMjhG3fsET7EnK3i29bu2GPEcrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rhU80kAZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A3BF9206D7;
	Mon, 26 Aug 2024 10:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724659763;
	bh=1iYiAHkIiTEffde6BnDvMjFBeo3wL0SjY/pqqE3E/OI=;
	h=Received:From:To:Subject;
	b=rhU80kAZGiGn4BoidK1qPldRM+NLUso6y0GGROA3lanVlIzOpKIWH2ny7GjSlIDx5
	 LGcAi0kFRqmykj3BowY+Xop5wkQ+3VQe/D3lJMPsY8OM/kGdTqtPTpU8daZUMLDPyC
	 WBCLH981YFdb8InD3YmeZOzPqOQPhqlSNZrI1JxokFxlQbb0cYgw9h2VLzn6ByaYqC
	 HpwHAzQGlUFjAJR7rK2LLP4ysc2bSSLkk3QI6rkQh65PAnQ6guFeBT5PDi/bBhSoiD
	 J7iwyKx/vu689LYyxR0mQbycPeD7vynSBPBQSqvNCdD3h5SPcHhqzRrCB5bt0cfKaV
	 SXu+FAKNcxZUA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 54DC17F9C5; Mon, 26 Aug 2024 10:09:23 +0200 (CEST)
Date: Mon, 26 Aug 2024 10:09:23 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Message-ID: <Zsw4M0oYZI_JdeAu@gaggiata.pivistrello.it>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB96381DEE1E9DC0A8F05C7695D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96381DEE1E9DC0A8F05C7695D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Mon, Aug 26, 2024 at 07:57:39AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, August 26, 2024 3:27 PM
> > To: Francesco Dolcini <francesco@dolcini.it>
> > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David Lin
> > <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha Hauer
> > <s.hauer@pengutronix.de>
> > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> >
> > This series adds support for the iw61x chips to the mwifiex driver.
> > There are a few things to address, hence the RFC status. See the commit
> > messages for details. The series is based on wireless-next/main.
...
> Did you test STA or AP mode on DFS channel?

From what I know even IW416 is not working correctly on DFS channels.

Francesco


