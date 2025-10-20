Return-Path: <linux-wireless+bounces-28107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFE7BF1D44
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67F3C34D609
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDB32F5466;
	Mon, 20 Oct 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r9dvdsmG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD12FC879;
	Mon, 20 Oct 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970316; cv=none; b=DZCuaGn4wSRMXez+7x0kXQ28/Pbj4cch4rg13E7JLyXLbe0XxwYYlktZLi+3OIEN2cJmJxDTVg2fxSfx+d8FCC7xCIqSX/vtfKLHnnGln/OjRqrLdezFCzdzxCSA0sSqCOyx5LDN1e9W6L4MM9FsLA6iRik8eDqQHILL8YTYEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970316; c=relaxed/simple;
	bh=xzx/KILlu/k+PYO6Mo5bYNQxIWS3X82u9ZCo4BcvVFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxQYdRXON8Zycg4pktsrjlzQElbTQoC3K/I4UR6CgtLqV660/K9jtLXw4GClUadbsLj386TROukoABcDe32iKJn6N0d35ABtXfw4W//DlFfQi5tSbyqj04zjb6b3nsbzHuCmghgGogkRJJxgy+toucBl7ysmLPcVmfYaWf1LDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r9dvdsmG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ql6VIoTcMfomJunkktUdjzrMiXsFWDL7h2Eor4f6FTA=;
	t=1760970315; x=1762179915; b=r9dvdsmGRQ+fJsADnIqIRQDOMZSmljkY/j2ghQNuoJDa+NE
	+RJQ8ES49FqPXBMYFHTG0SEdVvoE9ZT2qDSN8Bd8o/Zcr3Ufow3eRi5azLt2UalsoJ3Dr41z4HV+w
	GrgPCXfNAcCqONr+Thc9FCVNmrtsWJdk4jrz+qPYExzczZ4dPQVohiu6OokGfEYsAh7j7CkgyZ7hH
	7yWwikv1ZM0y8FlmEjgvHxek00r2hbYXYjz22IRR3US3ahmiRX98ceUbYM0x6hrS2rIN9Gyj/5Krh
	WtmXC8bTbmf+xsXJO2UGgnyB3Q9/qOuztoKeg3me4LnXFvabXva8IJFoJrfhS7dg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAqow-000000094e6-02Bo;
	Mon, 20 Oct 2025 16:25:10 +0200
Message-ID: <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: advertise
 puncturing feature support
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2025 16:25:09 +0200
In-Reply-To: <20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
References: 
	<20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-10-17 at 09:32 +0530, Aditya Kumar Singh wrote:
> If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_BITM=
AP
> attribute, the kernel with mac80211_hwsim driver currently rejects the
> command with the error: "driver doesn't support puncturing", because the
> driver does not advertise support for this feature.
>=20
> At present, the following hwsim test cases utilize puncturing, but the
> bitmap is not sent to the kernel. Instead, the puncturing information is
> conveyed only through the beacon data:
>  * eht_5ghz_80mhz_puncturing_override_1
>  * eht_5ghz_80mhz_puncturing_override_2
>  * eht_5ghz_80mhz_puncturing_override_3
>=20
> A future change in hostapd will begin configuring the puncturing bitmap
> explicitly, which will cause these test cases to fail unless the driver
> advertises support.
>=20
> To address this, update mac80211_hwsim driver to advertise puncturing
> feature support.

This might be a good time to introduce better checks vs. what we have
now in hwsim_chans_compat(), which just uses the control channel rather
than any actual bandwidth/puncturing/etc.

It'd also make the tests actually test more. What do you think?

johannes

