Return-Path: <linux-wireless+bounces-4793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EE87D336
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FE61F2404C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB618E06;
	Fri, 15 Mar 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ad0dqTdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB424CB28
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525856; cv=none; b=fR2WRZNhXbLNs/E8epheOtHwPpfnKNT937heoGohAO+kMVrZBGU/KddN8NjnV1+LPy8y2x/jaEEHPipRXsTousMFYo7iWIpMPd6d/YLi3P4V7627XrIGIwNE2DvWNj2Rqn4Nse25yHJ9F8yLUiKKcz5kZiR/QLcKtlBE0OBdBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525856; c=relaxed/simple;
	bh=Ah2PnjA47TZk59s7oHnNiYKb5JBspxWBYrziCTrAFk8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsQgUKGP5WRL9k4waP8bjV4Kg58LZpX2q1q4V0eE9N4hZjEuafVlcx6bweB2EMGaYH+ybAjyTQfcgikj4ksHb5NorvbVqgFn4HbmbHN5hxUVmvZJbROaGN6aIsZhR9/lOcOUXwZ8+oiPl1EK4uk2KbpRRUjUvKhZA9s+AKN27CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ad0dqTdm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9aMEx8Ri59+DNsRVlyGijwpeqbx3Uewe9HAXTTSLyhM=;
	t=1710525853; x=1711735453; b=ad0dqTdmES9luHrwdgTVx1Oz54Hn4iyOMwsOKjQAp8IkHp5
	mAM/NMbcaZNorCWrU8wVS1VmeYjEj+2CB6NPcbGW484BmnMpzHxKT9yQdHgZOf/ObKj2XO2Rce7ms
	+2M6G8Z3y3o6tf7jfgF7lqMevRqe0se+v3lbsMRkDX0f+Sisk4N4XGMhYlAn0zPDULUuhKUMmneI5
	CKvEiu8ukv8vIL7V9cZStZ84zGOMHZmEHZcg5M6DVV8w6rZtLf7TxGXAntHs6SKZulNhD+TKzUTLV
	f88K4vgqtQ1KRLxplcJf07c/lYIKjZr6ToOWJeBg52+ykr2kKs0v62WLdwZBYcuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rlBua-00000000Szt-2eUO;
	Fri, 15 Mar 2024 19:04:08 +0100
Message-ID: <bb884b84dbaa1c97f9d3a1e610f98ec6e069a706.camel@sipsolutions.net>
Subject: Re: BE200 - 6.5 backports - disabled EHT issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Fri, 15 Mar 2024 19:04:07 +0100
In-Reply-To: <CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
References: 
	<CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> I see this one do this:
>  if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
>       *conn_flags |=3D IEEE80211_CONN_DISABLE_EHT;
>=20
> Testing on openwrt and using backports.
> Is there some patch I can easy cherry-pick to fix it?
> So far just disable ieee80211_verify_sta_eht_mcs_support() check and
> BE200 works in EHT mode correctly.

Then either the code there or the AP is broken?

That function checks that the client supports the MCSes that the AP
requires. If it lets you connect without them, then it's broken. If the
checks there are wrong, the code is broken :)

I guess you can capture the assoc response frame and we can check
manually.

johannes

