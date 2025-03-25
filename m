Return-Path: <linux-wireless+bounces-20807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34069A70748
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996681883B82
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741EB203712;
	Tue, 25 Mar 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HYzOoOuC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8118024;
	Tue, 25 Mar 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921116; cv=none; b=LSYjZMmK0wfZ10NINdN7zkJZNXSV1+ZWFFm1pLnoANAv01PEtwQJpRQ9zEERSllFPDcmJ5qW+nSWKtNJEEqcDdPJYze6WZylCGFJ+oDCs1SSpmXvLFHyoqTZ/IfpIcWLIC4bJzd2G7nTCEA2bYqr3WFja51RPYVxBeTqvV36vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921116; c=relaxed/simple;
	bh=c2N4XDwsMb8BKswNCl/cHwanunEs4IDpR/UWKP31p4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBBcc5tZZ1Bn8tBc2C9SfHEofaqsEsK49mYq3a59ht4CforiKred7NUPD5pQukqaGCotN8LpnRvOgZ+aBYWhO5lni+GW0D8zrFYz7+sheD/a5FytWIj8Y6SGrtme9bTzOxCc9+DxKCfPPDY+E4vpn/HVUVrvxihtVQUmHV/zVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HYzOoOuC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c2N4XDwsMb8BKswNCl/cHwanunEs4IDpR/UWKP31p4I=;
	t=1742921114; x=1744130714; b=HYzOoOuC+VcN24Cop6bZBLginbcGiV+BUiDy01gO3EB2Esq
	KKNPkIaOecVozQH136AwoAb6cY4rIWHY4wDyhvo0QC9kjg6r6+bIOzgwTJ2l6oVAQqE5+YCq0tlWB
	J7E06fR+i98mch0ZYbOh4WmcE6OhlgQlpc9O+G1hLLbY4EriiQ2xDsiP5OnRxM35UdjEbQzyn6pfI
	XrQskSpckQTWHTJLR+aiK5PdvfrwLOtPanN6xZsCfaQvzxgss2c+DsU+q/kIfWv1crj8VpBlNu8+2
	+RxjwxyrirLrt5NLUNLMR1viBbpxm7kFEDLoXzrfGQpvwOXeHVeS432SvgySEKPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tx7Op-00000005Dqw-3KuS;
	Tue, 25 Mar 2025 17:45:11 +0100
Message-ID: <fe70fb090164301d8b2a894dd350850c175a03dc.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release
 of RF calibration data.
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "briannorris@chromium.org"
	 <briannorris@chromium.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
 "s.hauer@pengutronix.de"
	 <s.hauer@pengutronix.de>
Date: Tue, 25 Mar 2025 17:45:10 +0100
In-Reply-To: <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
	 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
	 <20250319162842.GA46894@francesco-nb>
	 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-03-25 at 16:43 +0000, Jeff Chen wrote:
>=20
>=20
> I have decided to withdraw the patch. I appreciate your feedback and atte=
ntion to detail,=20
> which helped identify this oversight. =20
>=20

This goes for _everyone_ on this thread... I applied this patch a long
time ago. Whatever you need to fix, you need to send new patches.

And I guess next time I'm not going to apply any patches for mwifiex
however innocent they look ... thus making the situation of that driver
even worse than it is now.

So please get together and form a plan on how to maintain it.

johannes

