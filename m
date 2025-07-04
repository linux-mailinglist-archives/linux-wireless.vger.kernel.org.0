Return-Path: <linux-wireless+bounces-24830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519AAF9A82
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2454C7B9E19
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B1217727;
	Fri,  4 Jul 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ywj9SUYM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33821215789;
	Fri,  4 Jul 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653357; cv=none; b=WwP/blvwc55bAJ9G1Ls8swYZaJGTE46kurMYctqEPFySafBD9+daY4t6N6uJT6sVRaXVBjTPKXcLc0epyUVsrYCbTJIp85yffxgACqlhVS9x9SpcVrw9RbYVl78KyP1GnJz6PsSGmvg/VT3iRquh2BZ7PA8IgBt736lvZU2ILQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653357; c=relaxed/simple;
	bh=xZiG/pUC5ivyvjny/Jo3gzT6ORDrAk9o48nwb9w3eng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6ScmHVl4ex1dzt+dZCbQWzTMr3CjpnrHRiSvJTwmDi8YFkZrcfpOWFGwhR142RkadOfoF9fFbucnrLImHXrAABXXkGXkQoUvgrXqNrRi/jQDY1noK9pkOM7zCGzFmcYh+G4gs/fNbYLD4324XheUkNlnxEqeWJU1J00L2LMELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ywj9SUYM; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EAA761F901;
	Fri,  4 Jul 2025 20:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1751653352;
	bh=n2sJ1cjIIyagn20/uD0dl3omt8NxJ7dGLZUTDggrAdk=; h=From:To:Subject;
	b=ywj9SUYMGN5khkUMEf4bsRw5A140ywJFyxJHPxQB7L0tiVim9jKUjCy3fDKwjSdMq
	 weyH/B81I5TRxBj7mmMwHqJaXD6xXoIPsDL5BvcbYlfzeuR+y3rUzVpkY4brchrLjz
	 iLKjGYklqyqGuIekya3ddLKb3DbrSal7f0F3qk0dtwFyMsYexCZXAg16rRCqdo/O8/
	 yUheAqD3e21wt9toNV/HhbE2HZvT2fEeP/PXM/n2szL5orw8Zhr4wsfHcSEPiG+/HQ
	 POmG9UKIT1pwLBKndIF0oBGBjwjYRUiwpK652yoHs0PiXKBbAYoeqCK4LMNVVynWDa
	 mkFKVku8rF43g==
Date: Fri, 4 Jul 2025 20:22:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v1] wifi: mwifiex: discard erroneous disassoc
 frames on STA interface
Message-ID: <20250704182227.GA7800@francesco-nb>
References: <20250701142643.658990-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701142643.658990-1-ivitro@gmail.com>

On Tue, Jul 01, 2025 at 03:26:43PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> When operating in concurrent STA/AP mode with host MLME enabled,
> the firmware incorrectly sends disassociation frames to the STA
> interface when clients disconnect from the AP interface.

...

> Add validation in the STA receive path to verify that disassoc/deauth
> frames originate from the connected AP. Frames that fail this check
> are discarded early, preventing them from reaching the MLME layer and
> triggering WARN_ON().
> 
> This filtering logic is similar with that used in the
> ieee80211_rx_mgmt_disassoc() function in mac80211, which drops
> disassoc frames that don't match the current BSSID
> (!ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)), ensuring
> only relevant frames are processed.
> 
> Tested on:
> - 8997 with FW 16.68.1.p197
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


