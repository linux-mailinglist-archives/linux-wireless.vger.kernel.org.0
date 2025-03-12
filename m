Return-Path: <linux-wireless+bounces-20216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6CA5D7C3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEFA169C9B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DD22CBFA;
	Wed, 12 Mar 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sBKMYHpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42E1E260A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766689; cv=none; b=W60obrVXHyMCseq/fy2FQrWOqFwCtRFDKougBCzLglx9E6MSpZEoUVTcDMxP/VGDyXeOlOMmndQTXnOynNgUzQDplIxXbmHsruhHt6LlrKFZrFf8RzqHOk8hhpSUGfCTea0aXhSU/srZ6tJ7FxteIo84H15BxPt706LazdbGNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766689; c=relaxed/simple;
	bh=Y9XqFciRrefDmR4jX+tRgiQsBvElGnB+I7XeLoaCVrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LnB6QmytII8VL9D7O9QrLms/wfsaTo5gcRO4YDKMrfd7r9jQClwfbajlEdNVBseay8BtkxKD5unQJOPyVHJl3ayHXMqx+CkX4DeUXBEsKPStnH+JvmDgjg+TXFAosSZ8g8t3XeWI03q4jaElxNSqmS3nXlgOl5mIOYd7KObY2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sBKMYHpI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y9XqFciRrefDmR4jX+tRgiQsBvElGnB+I7XeLoaCVrk=;
	t=1741766687; x=1742976287; b=sBKMYHpIrJcTgAaaDn/vYj72FwIJTFVGmX+Nh53fOrck7/5
	kQobx/42rKeya5fC3UOwGV4TjHito/04LGgAzsopU6xvDyp0IdAzXlzXdErvopFiEKZOCoVpn61CP
	jCCm/lxBaeUI8N3RJRGytDxdhLh71Pk1mux5iZ5NonBSMzap6yaEPxBWPGh4JO/fMG8wO9DNvGMg3
	a1JcsS+38otvtlwvR0KW+tn5uX5k9uQZap8UkIBHatBBDQiomtTWRVUQJ5tpjmAOzJb/5aN8iRMiE
	qQUIuLs8hi5WLRMlMEI/Ea5wMya6fUqfuYCyzsqY3QtL/tgzxx1zsekG2zhYAwSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsH4x-00000008n5d-3CsX;
	Wed, 12 Mar 2025 09:04:40 +0100
Message-ID: <517ce53bcf15f185972cc6016e37e8bab0788bd0.camel@sipsolutions.net>
Subject: Re: [wireless-next v3 1/2] wifi: mac80211: Create separate links
 for VLAN interfaces
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Mar 2025 09:04:38 +0100
In-Reply-To: <d3cc0cae-4e37-48e8-9c93-aa489099c3fd@oss.qualcomm.com>
References: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
	 <20250310223528.3528897-2-muna.sinada@oss.qualcomm.com>
	 <6bd5a19c9c87b671af6a0c05a47f5167d032f30e.camel@sipsolutions.net>
	 <d3cc0cae-4e37-48e8-9c93-aa489099c3fd@oss.qualcomm.com>
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

On Tue, 2025-03-11 at 16:50 -0700, Muna Sinada wrote:
>=20
> On 3/11/2025 3:29 AM, Johannes Berg wrote:
> >=20
> > Can this not use for_each_valid_link()? I think
> > for_each_valid_link(&sdata->vif, link_id) should work? If not some new
> > macro? I don't like open-coding this "if (valid_links)" etc. everywhere=
.
> >=20
> > johannes
> for_each_valid_link() is a cfg80211 macro that utilizes wdev to
> access valid_links and links array.=C2=A0

We probably discussed this before, sorry ...

> Using this macro with &sdata->vif
> will not work since, links array located in sdata and is named "link"
> and valid_links is located inside vif.

So valid_links would be fine, but we have links/link naming differences?
That's unfortunate. But now that I think about it, also it's array of
pointers in vif and array of structs in wdev?

Anyway ...

> Should I will go ahead and define a new macro that is similar but
> utilizes sdata or should I stick to using for_each_valid_link() and
> pass in &sdata->wdev.
>=20

We already have for_each_vif_active_link() so maybe add
for_each_vif_valid_link()? Though honestly in this case you could as
well just use for_each_vif_active_link(), it's basically the same in AP?

johannes

