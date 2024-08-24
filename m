Return-Path: <linux-wireless+bounces-11887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F395DE2A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C581C21004
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC715098F;
	Sat, 24 Aug 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QNgck6oO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419C376E9;
	Sat, 24 Aug 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507337; cv=none; b=u6EqtV9ic5XvnSJvycervBmelIgmExUoiv9m+dl99Aw4NFHOJm3BrSgkMj0yvwH3ZPluTOSn0fM3iCCWE2OQmuAucKaXK/T46LqxSbrMZG0I7YxLXtZKTTXXXDHjfyJwh2aMVz/utwiOXi/0iEv0o3NwJ5KKwB8HzkHTlejToCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507337; c=relaxed/simple;
	bh=bMpwfF99z3Y4gYG5ywp24cpVC5QDZU9WU0GT2cEtTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o92drh/SUS6WMpwCExCyQ7VjlGbAzXm5CY0ICZsq8QyoBXJTQo6eq0XpY1Og8xuWIoomeHvZAvVzmKkGqtPtAs7YvCTfmliqLD6Icm4WiTSg9bmiREs5AJdn555I0hvK6oxHuDMExSPmdHmfvZS19rp0RW4cH618LGHHy8LXUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QNgck6oO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EB81E1FCC4;
	Sat, 24 Aug 2024 15:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724507324;
	bh=LCGuYpwiP/UsbuMuxfXNSyWc/GZn//vKkpAVuorNXEY=; h=From:To:Subject;
	b=QNgck6oOT6zubxXartsETaXT5i7JTl8V7HeXnKSaLYdFVb3cozFxs6gP5s1rpOX+/
	 ITU+zNg9+FMsXNb/32pFBSwbFWl2Dyx5IoKZTT2yHlc59WheDRtkAGIv61Fipd1n99
	 PWjGQL2JNfU52uLxfURsGUBAhTCHSiQSs7vJEwkN0IQPU9ASxii+oLbI1Myagy/9XZ
	 QGdSlT+wYWWPMNzdF6aQbh622sAC3AAw/hf1xQrGoVKvFkdFC8tMPl/j8BeRPQ+LKa
	 4MGc7tno14AH/yZV3YF/9TWA9MZ1CZ1GlYGpJTFqHngR/uNsoAQWu+yCqcXuprYLEd
	 2i6a6l76o2Pqg==
Date: Sat, 24 Aug 2024 15:48:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>, David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, johannes@sipsolutions.net,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <20240824134839.GA21315@francesco-nb>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsc1efkBHDXdZtfJ@pengutronix.de>

On Thu, Aug 22, 2024 at 02:56:25PM +0200, Sascha Hauer wrote:
> On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > This series adds support for IW61x which is a new family of 2.4/5 GHz
> > dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> > tri-radio single chip by NXP. These devices support 20/40/80MHz
> > single spatial stream in both STA and AP mode. Communication to the
> > IW61x is done via SDIO interface
> > 
> > This driver is a derivative of existing Mwifiex [1] and based on similar
> > full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
> > kits in both AP and STA mode.
> > 
> > All code passes sparse and checkpatch
> > 
> > Data sheet (require registration):
> > https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> > 4-plus-802-15-4-tri-radio-solution:IW612
> > 
> > Known gaps to be addressed in the following patches,
> >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> >   - Support DFS channel. This initial patch doesn't support DFS channel in
> >     both AP/STA mode.
> > 
> > This patch is presented as a request for comment with the intention of being
> > made into a patch after initial feedbacks are addressed
> > 
> > [1] We had considered adding IW61x to mwifiex driver, however due to
> >     FW architecture, host command interface and supported features are
> >     significantly different, we have to create the new nxpwifi driver.
> >     Subsequent NXP chipsets will be added and sustained in this new driver.
> 
> I added IW61x support to the mwifiex driver and besides the VDLL
> handling which must be added I didn't notice any differences. There
> might be other differences, but I doubt that these can't be integrated
> into the mwifiex driver.

Maybe you can share an RFC patch with what you currently have available
to support IW61x within the current mwifiex driver?

Given what David @NXP wrote here

> > [1] We had considered adding IW61x to mwifiex driver, however due to
> >     FW architecture, host command interface and supported features are
> >     significantly different, we have to create the new nxpwifi driver.

David, given the code, he should be able to highlight the limitation of
such approach and hopefully we can find a good path forward?

One of the challenges with the current mwifiex driver is that it
supports quite a few wireless devices, and any new addition must be done
in such a way to not break the old stuff. Not to mention the "Odd Fixes"
maintenance status of the driver, quoting Brian: "My only interest in
mwifiex is in making sure existing hardware (especially those used on
Chromebooks) doesn't get significantly worse.".

Francesco


