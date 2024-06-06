Return-Path: <linux-wireless+bounces-8619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCC8FE828
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3531C24EFC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825EEEC5;
	Thu,  6 Jun 2024 13:50:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EC13C690
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681803; cv=none; b=kJ171vs2/p6THBTqUtwgxNWUCqpyeIRb9yZiHWgz0z/5dhTyMJUSMpgCHRMIBFqHmEoiQRKUSIkK5AiSVGgMwHS+08yQB/qyUzrdMfzVG62wta9FPIXztXm5aI8BCP1wHGQFJ3VS32H6nV4I6L31MCT8DMY6an4Ui/Ubkzm4T3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681803; c=relaxed/simple;
	bh=P9ZMOEVVHuuXQh0Bky2kRzA341Pn39OwdempFqAbG+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noxj+T/aP18TT9OyTsbGkpA5KxITpzU/ZntxigzyZyDzsnL923FwkoYbo162vtTgnYX+VswUl4p4UYKrN1QWl0F6awCInuHKjUmOkCW0psDV+sH7u1qc8CaQKk46Zzz//2MsFWhbm7l3CZ5XdiuAOdC+M8Kw6mA5Xq28mosD4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2118A2800B6F5;
	Thu,  6 Jun 2024 15:49:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 09C5AFF5B4; Thu,  6 Jun 2024 15:49:53 +0200 (CEST)
Date: Thu, 6 Jun 2024 15:49:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Francesco Dolcini <francesco@dolcini.it>,
	Sherry Sun <sherry.sun@nxp.com>,
	Dinesh Phatak <dinesh.phatak@nxp.com>,
	Pankaj Razdan <pankaj.razdan@nxp.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, yu-hao.lin@nxp.com,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	=?iso-8859-1?Q?Tam=E1s?= Sz??cs <tszucs@protonmail.ch>,
	linux-firmware@kernel.org, briannorris@chromium.org,
	linux-wireless@vger.kernel.org,
	Nicolai Buchwitz <n.buchwitz@kunbus.com>,
	Philipp Rosenberger <p.rosenberger@kunbus.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware
 git
Message-ID: <ZmG-gZ306WXZUa-n@wunner.de>
References: <20240605160013.6bea8d4d@aktux>
 <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
 <20240605174709.5043af8f@akair>
 <20240606101839.GA76158@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606101839.GA76158@francesco-nb>

[add more interested parties to cc]

On Thu, Jun 06, 2024 at 12:18:39PM +0200, Francesco Dolcini wrote:
> On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote:
> > But that is all legalese and I am not a lawyer... Best is of course
> > something officially added from NXP. No idea if it can be done
> > otherwise. How to make NXP add something?
> 
> Would it be possible for you to get these firmware files added to the
> official linux-firmware git repo? 
> 
> I am not using sd8987 myself, from what I read in the thread probably
> some file name would need to be corrected (I would say in the mwifiex
> driver).

I'd appreciate if NXP could additionally greenlight addition of:

https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/nxp/FwImage_IW416_SD/sdiouartiw416_combo_v0.bin
https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/nxp/FwImage_IW416_SD/uartiw416_bt_v0.bin

...to the linux-firmware repo.  They're necessary for SD8978 (aka IW416),
which has been supported by mwifiex since commit bba047f15851 ("wifi:
mwifiex: Support SD8978 chipset").

Back in the day when I submitted that commit, I concurrently reached out
to NXP.  Sherry Sun kindly responded that Dinesh Phatak and Pankaj
Razdan need to confirm upstreaming into linux-firmware (both +cc).


The problem is that mwifiex firmware originating from

https://github.com/NXP/mwifiex-firmware/

is available under a simple 3-clause licence, but only contains outdated
firmware for older chips.


More recent firmware available from

https://github.com/nxp-imx/imx-firmware

seems to be distributed under different and much longer licensing terms:

https://github.com/nxp-imx/imx-firmware/blob/lf-6.6.3_1.0.0/LICENSE.txt

So I think we need confirmation from NXP before we can add the firmware
to the linux-firmware repo.

Thanks,

Lukas

