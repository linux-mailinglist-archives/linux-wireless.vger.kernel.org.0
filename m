Return-Path: <linux-wireless+bounces-29155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E327FC73001
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7899346F80
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3C3009D5;
	Thu, 20 Nov 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J+9X7+Se"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED01233D9C;
	Thu, 20 Nov 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629278; cv=none; b=tpY/8eopm7F0rzE6UqtLDFKy+Vmv2aWjOJpkSTSGMNaIVXUlOohortG5xTW5nZtwiK781Az7nfz+Ay608tL58RjdisA3amlyR/in1XN9RLjESK/v0rSI3+d2pDps/Z0jJ7Us5xjKCYxEydu+hMgY1S2a3Ld0Z4Q/a2wb5psH+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629278; c=relaxed/simple;
	bh=7uR4CTQAbFx3KgWvSVJvw3d3hoodvyOk0EWuHsuHq/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrIj4E68hJlyUsv8nB/u4iM1AFfz/0lvKXBORKtA7qGsOyGd67Qy+sQ2I6mZVzOx1snqUa/cbJRSlfO+JZ6Jn2QoD5ZLzzLaLDzSZqJ00auoGkx73iwJVX4+PeC/gvICT2clq1nF8ZHSLcLsOMKsXLyHixYut/IcTdOo5jZeTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J+9X7+Se; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5WG3/wipIjly4pN+xZkGbXUONe61zSslOzS0lWtzaoY=;
	t=1763629277; x=1764838877; b=J+9X7+SeIhe0NK0p1ytcbqi2wV8CYp/zDwGVDV8fowtdw3X
	+hw3kPSU7R/TGe0u2g6oBHc2Rq0rBtgwT1ngU1FsOxToEInT7CES+6S4EhQ5d1Le56ZGqc0YpWmZK
	nkQ9yqe+x13GafdjrpnBIznlYoFbsRdpRZpXexZIJoytF5eO7L78tZGKhgvh3jPIu8oCOMCSZiI8W
	YttkT8KMPBMyEnnbBOjQnE9aCGzgAO1xLylIrmNMm3tgz8HscKYW3YUbVjx2bdKwuk0rN6vkByTKU
	wnICg0AT4iiCXy+yJ3FInpLTyYtuIG7JGA68JecM1nOxjNCVyRsbbHEEeHohzldg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM0XR-00000004U8T-2E7C;
	Thu, 20 Nov 2025 10:01:13 +0100
Message-ID: <2b976b880158605ecf74ca01420c184434371e2f.camel@sipsolutions.net>
Subject: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Chen
	 <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Date: Thu, 20 Nov 2025 10:01:12 +0100
In-Reply-To: <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
	 <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-11-17 at 11:10 -0800, Jeff Johnson wrote:
> So that this series would have an additional set of eyes I ran this throu=
gh
> the automation I use for ath.git.

Cool :)

> It reports multiple instances of using the now obsolete networking multi-=
line
> comment style.
> Starting from the first patch:
> +/* Fills HT capability information field, AMPDU Parameters field, HT ext=
ended
> +/* This function returns the pointer to an entry in BA Stream
> +/* This function handles the command response of delete a block
> ...
>=20
> Current guidance is to use the standard multi-line comment style
> /*
>  * first line of comment
>  * [more lines of comment]
>  * last line of commnt
>  */

I guess I'm not going to worry too much about that, but yeah, we did
drop the special networking style even if checkpatch still accepts it.


> It also flagged one incorrect use of kernel-doc comment style:
> +       /** rate for LG pkt, RATE flag will be present, it shows datarate=
 in
>=20
> There are also numerous spelling issues reported by checkpatch.pl --codes=
pell
> TYPO_SPELLING: 'interation' may be misspelled - perhaps 'iteration'?
> TYPO_SPELLING: 'Dimentions' may be misspelled - perhaps 'Dimensions'?
> TYPO_SPELLING: 'interfacces' may be misspelled - perhaps 'interfaces'?
> TYPO_SPELLING: 'formate' may be misspelled - perhaps 'format'?
> TYPO_SPELLING: 'verion' may be misspelled - perhaps 'version'?
> TYPO_SPELLING: 'Timstamp' may be misspelled - perhaps 'Timestamp'?
> TYPO_SPELLING: 'intializes' may be misspelled - perhaps 'initializes'?
> TYPO_SPELLING: 'statistc' may be misspelled - perhaps 'statistic'?

:)

> Also "wifi: nxpwifi: add initial SDIO bus driver support" reports
> UNDOCUMENTED_DT_STRING: DT compatible string "nxp,iw61x" appears un-docum=
ented
> -- check ./Documentation/devicetree/bindings/
>=20
> Is there an associated DT patch out there?

Oh, ouch, this is something you should resolve I think, so that it's
documented (and correctly so) before getting used. I'm not really
familiar with the process though.

johannes

