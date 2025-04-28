Return-Path: <linux-wireless+bounces-22118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46425A9E82B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44161897986
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA208F4A;
	Mon, 28 Apr 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wQvIzitN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BA33CA
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821718; cv=none; b=NgsfXsIcHZyjxt7qz24My1kGcd1KvingRnHe3W0dZ4jnwjkGK5NNyK94VuuvgGYEbsKpCPN2EfsPxVtB4jjdhXbxuczEKoQthm5bM9YEXa2cRy3lFVfR9EZKea6AgLXDVzSSZRIBx1GrTVEWVthGPA83a+dW13snoXhMXAOlwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821718; c=relaxed/simple;
	bh=C2RxFCSz/65K15fdmcTMXi/jwfX9zsbfvmL8sX5WGsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqTrDChibII/bUTx2DSTPfgLS9ksArw2qM9qjQh4hIE6ovc1SksXvyBTqQYi6Vu0pi43270MFq7uj7B/8XHB6Io6kvo4XlMWqTiPC3tCWpQkz7ZUqoxrah/Irq3orZxpbTHwjzE/yCV8tKZ+P1dO9nxqeBE5pf1sHLLp1wQL2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wQvIzitN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CrxJP3GPcb7aVK/QvSLBQyg7vJ4pT4WJ52hvixw4aFY=;
	t=1745821717; x=1747031317; b=wQvIzitN+M0ZsZQAFjrCctF2GPuX8Iji7VWSS2pZ31I0FvB
	cGJS11AuER9SRmqDe7HVSWteFK0QfKUKABV197GcxzUVM5Eh2hM0XkX91RAKZefRCiErPn7IgoU4F
	STQZBMco+FR8YtMIRPD/52bBV3JbrFojBQn8k4DZx1HR4FNCdnrE2DNfOrO2IaXdLj1hwkpHCh7ld
	5/bKc6MhF3RHPVaUnfO7eWTM5Pg4oMY+MwxyFOryX88Kcx8sviCECC+oQgx1yrwazaRFq71OSt+pZ
	UY1QDFNYdRFB7iuVQjA9tB97a/8k7WqKDmkQB0VlxuB3zJELG3wPb1rGe6wiZ0Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u9Hyd-0000000943l-2Zrd;
	Mon, 28 Apr 2025 08:28:27 +0200
Message-ID: <56b7fa3cb0eed29e4011213db90d7a7708e3d292.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 0/3] wifi: cfg80211/mac80211: Set/get
 wiphy parameters on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 28 Apr 2025 08:28:26 +0200
In-Reply-To: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
References: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
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

>=20
> v8:
>  - Fixed warning reported by kernel test bot regarding variable
>    initialization.
>=20

You should probably also check patchwork 'wifibot' results :)

johannes

