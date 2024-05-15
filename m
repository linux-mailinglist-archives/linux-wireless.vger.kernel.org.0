Return-Path: <linux-wireless+bounces-7703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFB8C6BB0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 19:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936431F2566B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CDF158858;
	Wed, 15 May 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TWhAXVE/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582ED15884F
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795110; cv=none; b=dBZgrxHVuGBbYZ67VKdGzBqFV6vea7YfZaQtDPNz8/vWel2PLlM+Bdp85y/dB3qWgsvPsz4Xhx9vnHfJHEXDNa/f61EY61Qfu46hdiUD1B74Z/uFbziIhNyx9K0NN1zZvkPumMK2avv+UnXjALO/qG93jQ9wGGC7uV+0LxB3Ijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795110; c=relaxed/simple;
	bh=+IfYQJOKHAlT0Tkv5zyAQdajtgoPSVl3iGro9//1YY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbtRclLFT9yHW2l06ebnwjICkYmpcZCpzqJukk8tj2PUbHcjl+HsGvLYToO0DWgp6UDFBO/cLMLuxrXNrdOACxp7kuW97r9xYHNybGPCy2I31AmU5raKv/zDi5Ubz1u90gedrlKzRV1Hz508SvI4EjT0A4P67B46d0SHgGDfkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TWhAXVE/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4m0/CSu31nDc6F1zSURoPD0U9WwJzoHKvzpSlwfnfNI=;
	t=1715795107; x=1717004707; b=TWhAXVE/czszw5RcQoGeLebfKjYxnXdTTtlvM/5N+jeAAnX
	r+uxxwPqFlUJg+lEu37Q9ZrsESKqG/RDR/VFa0zxpk+jAkMn5lBUKx0WwXu6QmuBrskymKkrgG07D
	jVqnbwH9lm7vhXkUsLE4sJCcHWdlDgZ4RXC58U21/kH3tZg/EyaXFgR/ybyHnAB4AeQlxDnxXcQ3z
	uRCVJl/4lbuCyaBHB6x0kFf1VqEL0aJsMbeY1kN1IYc1J/v+ioAf9KxuY/PkLnQ78rArpF1fCCOVa
	T178XDMdtP6zCtYhknt4ICEXY4kIem9z7wrJ/fnz2hUk9PaSbrTDoiKnEc3atj4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7IgZ-00000006nqX-3wIG;
	Wed, 15 May 2024 19:45:04 +0200
Message-ID: <32e7237f6dcf98254c2468438665a1b9357d2dd9.camel@sipsolutions.net>
Subject: Re: [PATCH V5 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 15 May 2024 19:45:03 +0200
In-Reply-To: <20240515165231.12114-2-quic_pradeepc@quicinc.com>
References: <20240515165231.12114-1-quic_pradeepc@quicinc.com>
	 <20240515165231.12114-2-quic_pradeepc@quicinc.com>
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


> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP=
) or
> + *	transmission (non-AP STA) of an EHT TB PPDU on an RU that spans the
> + *	entire PPDU bandwidth
>=20

I'm really not sure why you insist on neither fixing the documentation
nor the implementation, but I'll say it again (just this once): they
need to match!

johannes

