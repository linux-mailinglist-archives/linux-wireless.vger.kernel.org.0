Return-Path: <linux-wireless+bounces-15322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9DA9CDA44
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 09:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CB41F224A9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F99F16F851;
	Fri, 15 Nov 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w2KgPauQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048452F71;
	Fri, 15 Nov 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658489; cv=none; b=fgE0hNEbJlAW2j6+zFc4LR4Op+kBjTN/GgES47b5yUhpAfPNDpdcWzwZfH1YqzFWUl8pL37V7fpUlYTDCxcqXvDOt1/ZPiim1gCVjpXSZuMWm1k4s2MHMmjXynj2ygzpC2WajY/+rW8F1SSQ2TTxWJrUPBV+H6pZQZEpjr1XK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658489; c=relaxed/simple;
	bh=Zz+KKLNZbPCPFwrQEfX6e7as93w4zs8dGuZMZ9wWDzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Emp6wyo3jJ2hmuLeKdYhASiWxrtf5K4AfkULJ3nXzf7stT0cBkOWVc7Zi5O1fwqcFpgWhH4XydYjRVUhyVBccEGZMA/SlYFGjH5vHkk4lvFrNyCf1CrhM0mwpjbFfKFqMgEN2Flr0wiIhXH7TOJ24Jildt+j09ZyGibH1fl6oM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w2KgPauQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Z3rSfBOuEbtwvyTcUTWbbD2UHNQz3Aojin3UHpftc0=;
	t=1731658487; x=1732868087; b=w2KgPauQK0igyTCsWlrRZOEu6nd6jmuhd8qNyskB9yKtLx8
	sbwVlnbH+74ORn/WiW8EHyoBnWpDDw0lnta4Zr1esaGwe212rwNZXoC9iTmr4JJQ+VVCqicQDLpUj
	D/uLzPM6VjRIygh3EMztVBfsi80r3CIRAt09c4Sv5UvoEWdRoJUDaboSILMMs9mSJMsu+3a8W0t30
	v9U8Abzq56L7YG67tkVOy7eXfx9z6eYrL6iYVTInhfsEeuvfOhurrDmQk/8IjYBbRd5HzhRsXjuRq
	+XkavBp5URSIgWjJrABjWDv8ByIRtDWTTtsOAk8dWIn6FaAAseAlbjp2B1C0xvXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBrTY-00000005Tyd-1bVS;
	Fri, 15 Nov 2024 09:14:44 +0100
Message-ID: <c30bde94d07e4984c02e0e329df7032f95b00a4a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 Nov 2024 09:14:43 +0100
In-Reply-To: <f383c25d-fb76-4e3e-b900-7156f608bef0@quicinc.com>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
	 <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
	 <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
	 <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
	 <f383c25d-fb76-4e3e-b900-7156f608bef0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-11-13 at 21:50 +0530, Aditya Kumar Singh wrote:
>=20
> Because link ID is cleared from the bitmap well before link stop is=20
> called. As mentioned in commit message, this is the flow -
>=20
> nl80211_remove_link
>    > cfg80211_remove_link                -> link ID gets updated here
>      > ieee80211_del_intf_link
>        > ieee80211_vif_set_links
>          > ieee80211_vif_update_links
>            > ieee80211_link_stop         -> this ultimately tries to stop
> 					   CAC if it is ongoing.
>=20

OK, but why does it have to be that way? It's all under wiphy mutex, so
perhaps we could just clear it later?

There's necessarily going to be some temporary inconsistency here, I'm
not sure it matters too much if it isn't very visible?

Alternatively, could do something like

  wdev->valid_links &=3D ~BIT(link_id);
  wdev->removing_link =3D link_id;
  ...
  wdev->removing_link =3D -1;

and accept the wdev->removing_link in these APIs like CAC?

johannes

