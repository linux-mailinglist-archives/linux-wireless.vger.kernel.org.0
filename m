Return-Path: <linux-wireless+bounces-12603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E896F779
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDDC1C243D4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EE1D1757;
	Fri,  6 Sep 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sGY36M+A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0301E4BE;
	Fri,  6 Sep 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634446; cv=none; b=ew2Qy9GqbguAkQnO2PQT+WF0hXMs1liTZDt8nb8VFqShlVqCacEc7hmrEyReYXJcUqJZHNnUqMmDk81D0aewSecS0FLl28yCiAFlVLSCvdwAOnJRxSbftL3DHmZFznJ+5KOCIhv9ND9waBMbHGyNSUEiaBVXDhcbBS0K3GtoJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634446; c=relaxed/simple;
	bh=FTtlQ9AU7EhLG2vpI/D5jSaRFjoTu0ZUGQDS03cbDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK93W9WtjjNNJiAc76/CJZPhVObg/o0vCL9rMHPN+pQo+S3ZdeFC+16u0WXUDVDogT7tm3DzB8q/8lG9swSlUaSv2BC3eM7imzFD3VR1IcBfEqz5ysJxDb8ixcpc0fv902Z69aMBChwq6oIiXxn031slN/u4fPQIhrmQYkEI52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sGY36M+A; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AF2671F9C6;
	Fri,  6 Sep 2024 16:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725634441;
	bh=KBMTSvLv0lt5Th7fJ5ziyMNCfrIimSHzT7pJ4bVulIE=; h=From:To:Subject;
	b=sGY36M+AKSXZ9yITwb2GrzTMy2M0lfVfYNu3c6eSMkKR91DXZL9QZytEsca3y+eUT
	 +Vph0ftQtZjFjTUxkvbel0Cva0l+MEH7NIUW9/fY0KFAFAFITKI1s/gY692ieG9Ejy
	 ipV85FeB3CLuk2zyQ+GqhmiQCUtcZnztis2cx7CIc3lt9CThMYpyO/axdt2rYeyb3t
	 flwE3ZUmf4UfaerDpyYykGn+ys4InfY+FGdS0eu2LrciOWJSJMbUDhksAu6uJ3DPwL
	 XWEqhE6Rjewr47Iv7xcl+MGQ2biI4cWYvj7aYobroXwGZVHCYF6+8Vl5R94igMW5Zz
	 QJfyBe6njQHBg==
Date: Fri, 6 Sep 2024 16:54:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] wifi: mwifiex: deduplicate code in
 mwifiex_cmd_tx_rate_cfg()
Message-ID: <20240906145400.GB45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-3-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-3-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:24PM +0200, Sascha Hauer wrote:
> The code block inside the if/else is the same with just using
> pbitmap_rates if non NULL or priv->bitmap_rates otherwise. Deduplicate
> the code by picking the correct pointer first and then using it
> unconditionally.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


