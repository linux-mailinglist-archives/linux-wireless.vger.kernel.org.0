Return-Path: <linux-wireless+bounces-22904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD08AB52AF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408FE7B3139
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA5248878;
	Tue, 13 May 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wYWctxyg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C2242D6E;
	Tue, 13 May 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131708; cv=none; b=KbExgEux4gJR8TWPjc6OOGAh1enHtPohxGj6dtaEpnHUzEbIftPLF3LLtXi++i8zKRVx0ov+I4TvtEhGGxNh+nbSuh6+8Wpu+wmNaKgQ6r/J39ZoeqwqzLP1h1JZKuJoqB4fBLtBhEtF0t5Q6SbJP2mBfR8ETuXhqwWTnpUngwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131708; c=relaxed/simple;
	bh=dOQWz25dS34yvdvO5uyg0AwAWBLYuSARUWFPOZoI11U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkYeMXTRpv0JJlacaSv3KPHKzH7qbANjb83hGoaS99jUC3WAx5llj1+83tbwXMEhjBMRrs8mVgpjFBy433Tdsw50Hp95U6CBda0H5G1cYRzudNnVxgmnCXzE5bIoTGyf966FFxL+Sfw5fF6LiMC+nfKddM58aMrNikLduB1yjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wYWctxyg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yEvYQVQMta1tXdnC2rpzqGhHGx2V/UWxFK3Z6l0dfoQ=;
	t=1747131707; x=1748341307; b=wYWctxygCCiRU9Z77TejxBqtckQo5UnlUrJ9viXbMyavOjn
	qNJekXnc8EQF6DbeA6MrdyNK3CWb+21wB0BpNDoj6pWXQMu9/CIF2H8FZ25QF59Ci1MTNCEywIYls
	aXeQyTaqtlr+529KyW0en51Z28Q4TLnwlocOLYNjWC310dCjhhE5nJ+swtspgHEBVVqJjdHqXxyHO
	XGf1doaom3r6YbB3oHYsRDkyozMACvOv1GVaY79Bwvbudv/tppq1GkcBVE1p/DNuLnnrebjeWJyjS
	H6ctF005gSTxYIVveKgdeRC/AyrYW737tl4olev3Oo5HR6FeMbFVpRcMclzAmUnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEmlb-00000005T1G-3LaJ;
	Tue, 13 May 2025 12:21:43 +0200
Message-ID: <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 May 2025 12:21:43 +0200
In-Reply-To: <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
	 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
	 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
	 <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
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

On Tue, 2025-05-13 at 15:47 +0530, Aditya Kumar Singh wrote:
> On 5/13/2025 12:47 PM, Johannes Berg wrote:
> > On Tue, 2025-05-13 at 09:26 +0530, Aditya Kumar Singh wrote:
> > >=20
> > > -		if (sdata->deflink.u.ap.beacon &&
> > > +		if ((sdata->deflink.u.ap.beacon ||
> > > +		     ieee80211_num_beaconing_links(sdata)) &&
> > >=20
> >=20
> > Do we even still need the deflink check? Seems like
> > num_beaconing_links() _should_ return 1 anyway even though it currently
> > doesn't, and we need to fix that?
>=20
> If the ieee80211_num_beaconing_links() is modified then deflink check is=
=20
> not required. Do you want to me to send a clean up for that function=20
> first or would take this and later the clean up part?

Given that you're targeting wireless-next for all, I guess I'd prefer
you clean up ieee80211_num_beaconing_links() first? But no strong
preferences.

> > Also seems the VLAN carrier handling is broken.
> With this patch? Or in general you are saying? HWSIM test cases seems to=
=20
> be working fine for me with this series applied. May be there is no test=
=20
> case to make it evident?

Oh, I meant in general.

So here I looked at callers of ieee80211_num_beaconing_links(), and many
of them seemed wrong because it doesn't handle non-MLO? But now that I
look again, I'm actually wrong, it simply always returns 0 for non-MLO,
but the comparisons are for <=3D1 which makes that ... OK but unexpected I
guess.


But still - also unrelated to this patch - the VLAN handling here seems
wrong?

        if (ieee80211_num_beaconing_links(sdata) <=3D 1)
                netif_carrier_on(dev);

        list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
                netif_carrier_on(vlan->dev);

Shouldn't that loop be inside the ieee80211_num_beaconing_links() if?
Also on the netif_carrier_off() side? At least someone was fixing VLAN
vs. MLO recently, so maybe that needs fixes too.

johannes

