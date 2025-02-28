Return-Path: <linux-wireless+bounces-19594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F55A49C5D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56681896619
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AC2686A0;
	Fri, 28 Feb 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vAYEbWTQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32A25A2C0
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754041; cv=none; b=WWcyfG59ahH803kdEihvmgVHCxFbpiAuurbWaNlLAKphUHS5BbcxcZNP5SOITymrQhyLaAUO8srNN3PvSfnZw5lwb3YN99Cw6EenBCibs+We3xiILtsS+PHV/wcGC7cSm2wj5yHFSbdtfh9Yp+Z//sOz5408ljrLEvletHSd5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754041; c=relaxed/simple;
	bh=MdfHUlpQoLC0Nugq4IOdqz977pXtsk3eezHFYl/8Tmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nS+2sQw0gQHW8eAQTXOT/iYKMftJ9sAHqwWFl3951zKNjQ1FPYVLcus2WOT5z9zdE53AatwuLj5VLHh42fVb/eHwkpm+nPWciKZAwoTVg79jPASqQWFT5gu9bqH6HIDbzk0idmzSWqOGR3CAx72oPMRgxReqc34kcV8JboCIf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vAYEbWTQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kGLhWHWHHrUcn/K2DevO7C/lKbip8Fc6iOYRxlyVDXY=;
	t=1740754039; x=1741963639; b=vAYEbWTQddyUqT3C4stOUGewWv/gnP76fyoIWTCf1/hIQbC
	4isCwB+c5oHdMEiOkH/wq4r8QHeuDTw4MZXM4TlaAgd3r6BlC4UGDWfZHyS7ZC+JDxXcDH//tz6Pc
	lU7DZVwOBOXcUu0/C1iJ+fGd1cC2wFbF5zkEiywZ2H3mMvPhFtGwPskDYwrmw7WXzvaQoBRvW8zJ5
	//N2FHNm7K4kcZH47mznC3sQFxOscAsOWpoO0WRlj02p+KItYitXjSgfwtNwksaIKN9cL95JGlcSt
	l+Vwt1daOxRK82bwOYm3baFC3AIW/ilWYYsfAYwo0BZD55kJv8zWMPk8gNeM1OPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to1e0-0000000DoXa-0fId;
	Fri, 28 Feb 2025 15:47:16 +0100
Message-ID: <470352b7b5ead19e80be47f9b49d9285b870b65d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Allow monitor creation in
 NO_VIRTUAL_MONITOR mode with active AP
From: Johannes Berg <johannes@sipsolutions.net>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 15:47:15 +0100
In-Reply-To: <ad67cbfc-e158-8fb2-c94f-e1e3b01a5c28@quicinc.com>
References: <20250123010950.1958211-1-quic_nithp@quicinc.com>
	 <20250123010950.1958211-2-quic_nithp@quicinc.com>
	 <61c22a40a2b8bfe28175c2e7031b0a22fff2ca06.camel@sipsolutions.net>
	 <ad67cbfc-e158-8fb2-c94f-e1e3b01a5c28@quicinc.com>
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

On Fri, 2025-02-28 at 20:15 +0530, Nithyanantham Paramasivam wrote:
> On 2/28/2025 6:20 PM, Johannes Berg wrote:
> > On Thu, 2025-01-23 at 06:39 +0530, Nithyanantham Paramasivam wrote:
> > > Currently, in NO_VIRTUAL_MONITOR mode, when creating an
> > > AP/STA + monitor, there is a restriction: if the AP/STA is running,
> > > setting the channel for the monitor is not allowed. For example,
> > > in a scenario with three supported radios where the AP uses only the
> > > 2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
> > > due to the restriction that rdev->num_running_ifaces must equal
> > > rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
> > > we are unable to create the monitor interface.
> > >=20
> > > cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()
> > >=20
> > > static inline bool cfg80211_has_monitors_only() {
> > > ...
> > >     return rdev->num_running_ifaces =3D=3D rdev->num_running_monitor_=
ifaces
> > >          && rdev->num_running_ifaces > 0;
> > > }
> > >=20
> > > To address this, add the new wiphy flag
> > > WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR to advertise no virtual monito=
r
> > > support to cfg80211. This flag will allow the creation of a monitor
> > > interface by bypassing the cfg80211_has_monitors_only() function.
> >=20
> > I think it would make sense to call this differently in cfg80211, per
> > what it actually _achieves_, rather than per the *mac80211* logic about
> > it...
> >=20
>=20
> Sure. Perhaps I'll rename it to "WIPHY_FLAG_AP_MONITOR_SUPPORT"

I don't think it's about "AP" either, really, it's about "concurrent" or
so?

>=20
> > > There is no need for special handling after this, as
> > > cfg80211_set_monitor_channel() will manage all interface combinations
> > > and allowed radio conditions.
> >=20
> > This sentence just can't be right - you're changing
> > cfg80211_set_monitor_channel() and there's no more code after it?
> >=20
>=20
> Sure. It's better if i remove this sentence.

Well seems you should still explain what happens then - i.e. that the
driver, or in this case mac80211, needs to check that it's possible?

johannes

