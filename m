Return-Path: <linux-wireless+bounces-23174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CCAABD22B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D607A91F9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B048261568;
	Tue, 20 May 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qMlAm+UR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9902116FE
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730413; cv=none; b=Wi5VmxJ+nJB8YorE2By9juQH/ipQMlfjL9IaVnFV8Egbt/rhr8g1rJd+AjHuUs4GEY1PAWMSlz/eDm0RooEq2+cE/D3T3KeSqctsdFA6hYrwsHZ4FPKPf3P7IH5T60iubYCtt76NjTsefTAUT0UEaCpiUZfZi9M5OES2oQ8mc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730413; c=relaxed/simple;
	bh=xVZdwrvOiNpo64IZ7RQfUle5y/4+G/NU2j2FeXcQ94A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYEmNj6/ZM0za3nGZsqUQKBgpQdmihkJpGJzaNuw7IoPUd/1dTRFoATWD+20mT5Fa8+GpzSpFgXDBa4s16pIDjN8e6BiTHzPblCsudIUertgX5QtoWAFlnL+Ojo+KEBAFhHmKeV8G0Xcl9dzzeyv9VBmxoY6j5ikSUekH/Wy5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qMlAm+UR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H/XwwYVkjCimhHFXwiHXxuqM6JpvC2IvJcZF5M9JsLY=;
	t=1747730411; x=1748940011; b=qMlAm+URuN+Hb+YNSHfi/Tr50NbI0nfpNxII8tmob+5Ksdn
	y676NDeXajKQK0fWiWD397N3y/7n6dZtT+Fc41Sf+8iL7SDrssikbEq4rnygI+VRS5kVMI09HMvE9
	OOggtL1TKiFhML+vC4pGiGk2qw9T7mk+uVCx/gJAYCgWMghNU5alK2rmHKyGM2Q9FvGUav1FF2lCy
	7BB9LIApUG+5jkKIJ4+aSYehT3z8rHJZWVkck5sglYVfW0o2iWoDSs801jwVHYP753CwFpcnC+Yap
	BRQ9xKOC0XkSeh4MFvjyi62bFuEpbL3OPw34dTpjaeP1Ah4oK1Cy+wOfaGbyaljA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHIW7-0000000Apno-40A0;
	Tue, 20 May 2025 10:40:08 +0200
Message-ID: <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 20 May 2025 10:40:07 +0200
In-Reply-To: <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
	 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
	 <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
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

On Thu, 2025-05-15 at 23:17 +0530, Sarika Sharma wrote:
>=20
> Looks like we can flatten them. In existing code as well we have=20
> flattened and use, during sta_set_sinfo()
>=20
>          "if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
>                  sinfo->tx_packets =3D 0;
>                  for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++)
>                          sinfo->tx_packets +=3D=20
> sta->deflink.tx_stats.packets[ac];
>                  sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
>          } "
>=20

Indeed, weird, why do we even bother counting them per AC?

johannes

