Return-Path: <linux-wireless+bounces-25751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD06B0C51D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6FB189DAE2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635A2D879E;
	Mon, 21 Jul 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Fr5+jrJQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B62D7808;
	Mon, 21 Jul 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104336; cv=none; b=pjqO40cXd1XMvXEPaZPj8wm6UYPwc9n/7rEBor1+RXnqUbbSMNGz7uEJ2PSWrY93svK6CfF7ShPljxAgeyAKFRshTcXIfKTNoNoCJ+CkPicT0FZ2lj+q92qOYK4Vjq9wDvxkM4OMHEkpkD1+5r6tcAytA+CtvChbXaO7hBMZES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104336; c=relaxed/simple;
	bh=3BIDwNzOo6gy/uw3u2gKAK4THqT/Q6+LLEnJO1jl5Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL338VAQJZqZcemrXUguh+hrMmD5CLyAJ9cjeLFqioMPFLUV6W+sEPQkuJUXs1HTMew4PbNIL3PQMJ1Xo/mzTcvRzqiGHab1fmR1Sc8bNSducPmx85wtvdYXvqZXFKzooDFNPX2WR7gWc9Vj198ZGRUeBNFerydMCL/yDe3962M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Fr5+jrJQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id C75341FAC8;
	Mon, 21 Jul 2025 15:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1753104324;
	bh=3BIDwNzOo6gy/uw3u2gKAK4THqT/Q6+LLEnJO1jl5Z0=; h=From:To:Subject;
	b=Fr5+jrJQhpJC7fP5D+WDespsxGOT9SSofaNkefXc6DqnZsaYSgAVqO1OcQk68JjSy
	 8P3L6xFqu9JeVvVwj/I4/sBkgShmFlrM/Rf+2+rCuG+kF6Va0/sWyrExWC/niaoBRi
	 ws1HHpfmXKHItTYTS2tFBJ8vfRC4Mgp1RLeQceUntW8GYa9Id9XtvEW+UMipGDkvo1
	 AsXAv6lflZy469cNtjH2GNygO2T44eyfDu0oub2ndYsJx0GYdeKTAMf6yWXm4rId4/
	 b5ggAD/MfV1uyx72uwVT7lcp2naYd67X2k5D6xNMiGXNefixAICExk3jT7ledWdNPw
	 8Vloc5awRSQmQ==
Date: Mon, 21 Jul 2025 15:25:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org, briannorris@chromium.org,
	francesco@dolcini.it, s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com, brian.hsu@nxp.com
Subject: Re: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <20250721132519.GA55403@francesco-nb>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>

Hello Jeff,

On Mon, Jul 21, 2025 at 02:26:19PM +0800, Jeff Chen wrote:
> This driver is not based on mac80211. It derives from mwifiex, but due to
> significant differences in firmware architecture, host command interface,
> and supported features, it was not feasible to extend mwifiex without risk
> of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
> will also be supported under `nxpwifi`.

What changed compared to the last time nxpwifi was discussed and from v3?

My last status is the following

 1 - it is possible to extend mwifiex to support iw61x [1]
 2 - duplicating mwifiex was not considered a good idea
 3 - keeping mwifiex well maintained is considered important

Francesco

[1] https://lore.kernel.org/all/20240826072648.167004-1-s.hauer@pengutronix.de/

