Return-Path: <linux-wireless+bounces-17425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C3A0BA41
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27BF168F3B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9D22F836;
	Mon, 13 Jan 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qwlDcw11"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4923A11F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779557; cv=none; b=CVSwyRaQpuWGCyI0M/hsyK8qJPmJcI5wsNUqOrUfhdZVFybeRyEqT+cqzxL/+0S+TBzf9LuuWbXQp+z7jiy65jbs3Xoqrp2cyCwIUq+NPGkuZ/sAz2yjTJXn+Xps73rRcv8LCvYtCgV/9A4EsfXFlxWV71gUAR4mQOAf8JwRYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779557; c=relaxed/simple;
	bh=Gk1A/He6PA4sd8FOm0CikxjCfa15Okglgx6JNNLIXpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYi7Cp1L9QW/JfvgIZj3tVXAQAFw2EIKPN/Fh7pW8eDxJJCmVJ0sPlErOx2SEnwUjJGAbo4SNlZJg8tVH+Kxg8ifrMQf7qR4Jp28iSOWfrjY0NnmvmgmfRqWybxboQbpPZ6M/rg6oUOJmtypctMqZWD4LCY3ApvIbfN0zx1Pt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qwlDcw11; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Gk1A/He6PA4sd8FOm0CikxjCfa15Okglgx6JNNLIXpA=;
	t=1736779556; x=1737989156; b=qwlDcw1119TMJexML1PxVZfUI+p9cx38+ECOGMbpgvrW5+V
	aLTlxnhbOITp70qh/CTkyiTkFHWGLHIuqsXZBDnv7CFWGBHSoGnJGaLhFxekkstLLFPbNZvT5KyrG
	BMpR0nOfe4JyCvSI3YdDAfGkDbHJ0VUt0Md9j5ue7OC15Mvi2zzva3+lfBnuvjO9wWPBSV/54qP4n
	WOyBdR9FBgY9QJSkSUux+yTjtyLnfMSUpxEd7P4VrNAel3FTrlmmDucPLwrYR54Nz+uFVSArQ7ZbJ
	ij7iY/9X/17edg0Xu5pVUPMvrJA2I2X2aSOOhHvGyPgfzkr9/yaC7t8FQD/glXBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXLhQ-0000000DdpQ-3O6Q;
	Mon, 13 Jan 2025 15:45:53 +0100
Message-ID: <5113a67ae69d32e03934124dc077c65f6bf16fdc.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: adjust allocation of colocated AP data
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tova Mussai <tova.mussai@intel.com>, linux-wireless@vger.kernel.org
Date: Mon, 13 Jan 2025 15:45:51 +0100
In-Reply-To: <20250113093922.149240-1-dmantipov@yandex.ru>
References: <20250113093922.149240-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-01-13 at 12:39 +0300, Dmitry Antipov wrote:
> In 'cfg80211_parse_colocated_ap_iter()' and 'cfg80211_scan_6ghz()', an
> instances of 'struct cfg80211_colocated_ap' are allocated as if they
> would have 'ssid' as trailing VLA member. Since this is not so, extra
> IEEE80211_MAX_SSID_LEN bytes are not needed. Briefly tested with KUnit.
>=20

This doesn't apply now.

johannes

