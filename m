Return-Path: <linux-wireless+bounces-24765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D20AF5887
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947CA4E2887
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DEF28724B;
	Wed,  2 Jul 2025 13:19:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75B286D5D;
	Wed,  2 Jul 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462375; cv=none; b=ShalVzZFRv8eW6/Ic19GCHfeL39tNb7yeePA2dFwcO2+I+1q4OEhvRNGG9rjfcv9dpOJEyX5G/R0lFBv1rAkk1Fb7SOMtLnEXf7wsvsfKEqxDwCXBz2mcDdesa0myZoq7QCcIgASxMGQYb8QKMMZggJbyYFQC8ghaKa9KZ5FbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462375; c=relaxed/simple;
	bh=U21Vck/VgyCaiFV68QQ9fY52qyjiIU3NzWjI2rcDFEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxe6UfwCrSm/AeBepOOkyizstYvZK24OS9McVE74g+y5buLDYZ4F9BNW0z1SQ/M+YNOKwu36QrkpZ+Be8HqHu7jsXSEE/D6ZoCH+eLbjzrKpE4cfi/AINjFg0+hXlmXjZfT1kH2Qs8ucOqjtlfr/3yYZvcC1iipGNG7sl99ztDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1uWwab-00058S-00; Wed, 02 Jul 2025 14:29:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E7961C0C1C; Wed,  2 Jul 2025 14:28:11 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:28:11 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	nbd@nbd.name, Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCHv5 5/5] mips: dts: qca: add wmac support
Message-ID: <aGUl2_kSTkF4qUgZ@alpha.franken.de>
References: <20250609030851.17739-1-rosenp@gmail.com>
 <20250609030851.17739-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609030851.17739-6-rosenp@gmail.com>

On Sun, Jun 08, 2025 at 08:08:51PM -0700, Rosen Penev wrote:
> Now that OF ahb support was added to the ath9k driver, we can use it to
> enable and use the SoC wireless found in these chipsets.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/mips/boot/dts/qca/ar9132.dtsi                       | 9 +++++++++
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts         | 4 ++++
>  arch/mips/boot/dts/qca/ar9331.dtsi                       | 9 +++++++++
>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts             | 4 ++++
>  arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts           | 4 ++++
>  arch/mips/boot/dts/qca/ar9331_omega.dts                  | 4 ++++
>  .../mips/boot/dts/qca/ar9331_openembed_som9331_board.dts | 4 ++++
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts              | 4 ++++
>  8 files changed, 42 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

