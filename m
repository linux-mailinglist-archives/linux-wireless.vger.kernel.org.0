Return-Path: <linux-wireless+bounces-9938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF99268A9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C9A28E475
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2A188CB4;
	Wed,  3 Jul 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jRq6LLdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE911862A8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033023; cv=none; b=DMW8PleXAMgPg7uT06+ZzrmDEhXlz8sKbXDi4rWLXZaROACI9PQi6qM3DlU7d3IYjqCmlkfur0QbpWIyYTkd5F1kwWNAQ3usmehvoESn+QhrbZRDB2OcLm99PCUbpPePZq5QLUlr2TqsMAUR9oyh0+HUvQMdZ+A0hkF90YHen0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033023; c=relaxed/simple;
	bh=QDFXI2YhPBCubJ/5lIQiqgoFW4BcyaURvmnEnwDkpFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPE7n4b9gbMv7PGcEZiKtTtG0h7RXRgsUz11gxU73RafaJiO0cs8tSeK4EWSN/hBmCqmGErW3r1yyJTaqAjbLF22rIbnM2ff0d0PrQqe6c07MJrr5JIRFB+qgViq1yyPKfcR0JjcQlWXrNuOwvQcMATJEV3cElVxAwkBwFVEBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jRq6LLdM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QDFXI2YhPBCubJ/5lIQiqgoFW4BcyaURvmnEnwDkpFI=;
	t=1720033020; x=1721242620; b=jRq6LLdM/DEYQ1uHXOgujmOhbt+6LXy/J5I41y1MoyJ1bVx
	SZ1srDqNyzdxIUDD2DICXbZ6qH/NAqEPVB/D6lahWD7ZdbFnYQWajfp6arDKUD4xsVrJo/2etWzy+
	IHfNXUqdv2R9jZQIXggznaJP0zUs6uvH1c8IgGAynpHUoutd0aQACwXelvh0gb44a23QhUDtWZtUj
	CCMIT7yDah4bCJxNKZUAqwR4o6hdmnqGlbNcloS68XLCOguDRejxxgp+h6AKLXlO+pNthgwe0fVvK
	pP1t1NWXX0TlnMx3wIAVPbRXd0Ko0ColpDfyubTrjXaMAu2GvsvFalDeFguMxgnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP59x-0000000A5BY-3Q6Z;
	Wed, 03 Jul 2024 20:56:54 +0200
Message-ID: <938f9ad2e93299a3dd73577cdcfb40d4ac14aac2.camel@sipsolutions.net>
Subject: Re: [REGRESSION] wiphy_register fails for mvm (AX211)
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, Alexander Wetzel
	 <Alexander@wetzel-home.de>, miriam.rachel.korenblit@intel.com
Cc: ilan.peer@intel.com, linux-wireless@vger.kernel.org
Date: Wed, 03 Jul 2024 20:56:52 +0200
In-Reply-To: <19cb41af-6197-4977-b8e8-9c9bcdb3dc61@gmail.com>
References: 
	<20240618200104.3213638262ef.I2a0031b37623d7763fd0c5405477ea7206a3e923@changeid>
	 <20240702104128.26394-1-Alexander@wetzel-home.de>
	 <19cb41af-6197-4977-b8e8-9c9bcdb3dc61@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-07-03 at 20:16 +0200, Christian Lamparter wrote:
> On 7/2/24 12:41 PM, Alexander Wetzel wrote:
> > The commit 5c38bedac16a ("wifi: iwlwifi: mvm: unify and fix interface
> > combinations") breaks mvm hard. wlan interface can't be created and eve=
n
> > rmmod fails.
> >=20
> > On driver load I get:
> >=20
> > WARNING: CPU: 5 PID: 1358 at net/wireless/core.c:689 wiphy_register+0x8=
ee/0x920 [cfg80211]
> ran into the same issue. Debugging revealed that the " - 1" is the proble=
m
> because wiphy_verify_combinations checks if the specified limits in n_lim=
its.max
> adds up to at least max_interfaces (=3D3), which isn't true anymore with =
the
> " - 1" as the ieee80211_iface_limit with NL80211_IFTYPE_P2P_DEVICE is mis=
sing.
>=20
> Not sure, if this needs fixing in cfg80211 or iwlwifi. But I can confirm =
that this
> patch "works" (not sure if it's correct/intended though).
>=20

I sent the exact same patch yesterday :)

https://lore.kernel.org/20240702130001.8c871a3f0b5a.I08a6542f52f63c5bd66bf3=
feb09e1998ce7c60e5@changeid/

We have a version that has another array entry for NAN support and then
subtracts 1 here to add it conditionally again later etc., and this got
mixed up when sending out the patch.

johannes

