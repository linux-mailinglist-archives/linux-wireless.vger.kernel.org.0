Return-Path: <linux-wireless+bounces-29157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B1C7314C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D09CD343D14
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB623EAA5;
	Thu, 20 Nov 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vnv2HX6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880112D8DC2
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630289; cv=none; b=rZzCIXHxm+mloHfa1lJL/IHrsML2rUGS5vhzybpvGrGbG5KO03Y9pNMi5LlVwV1tjze0zqpHC6xzQdEm4qo8g27zwzhpD7sylRLeOBscicrH04a7J0gyni+LfcF9Z78OdP6IAoHn9xPx+BMWcNJbbNepGQ/C7ut1xgMi7ih4pLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630289; c=relaxed/simple;
	bh=FcUfRen6fwR2XekXBwOAEFFxeqpMqk5l8UQmqCBJ72s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjEb4IjVs9bb+P5ba2VaHHlzfFzMhFtWh1fpcPatc+h07o7CMnizsvJ9jEmjGyEKGj4m3Jy/mYHRxHW6A1VMto314+Hbzy36KfMITWCh6qwMFmSjZdAEDRuLupIvIcPcCY04ZpOBAqTaDtLVo++Rn6zfSqD6c9cucyX32O9QdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vnv2HX6a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D0QhmUGBnnYCgj0T4BsheQiCTq9GmRyEC/fS4ECa2yA=;
	t=1763630288; x=1764839888; b=vnv2HX6akgvMW+8Qznt1VprTLEZOBcdjSufVW499SiImHIl
	TdBo4kizEe71i1gOmZ0i8/qQOOvXuwq2PbAizW8+uBspE0ImlJ0uzxJXH0WZQtqf/XmhmFyLJFMoD
	ciCRbvSV62oz1jQe5AMpWMDsGo3GbojU4Euys64RGYfrJFYGy8D1lkkfkpIW+fFxOBALqkgR63EW6
	Q/m+4s87kCWwYsRL2w3ox/0KLT6cUBehjg70kgaPsXDo+fROoiELxTrWGHwPjyUP40Wjj7OQ1QCSx
	Wk78pFLXXLNks1P/mU1hNn6CBB4bLmVpsrHxYaZb7HaWnencFTKlhNkhTs3Vk1Bg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM0nh-00000004W5u-2g3Y;
	Thu, 20 Nov 2025 10:18:01 +0100
Message-ID: <e8b2f5d01e02426d2332710993fbca3418b804f7.camel@sipsolutions.net>
Subject: Re: [RFC v3 wireless-next 2/4] wifi: cfg80211: set and report
 chandef CAC ongoing
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Thu, 20 Nov 2025 10:18:00 +0100
In-Reply-To: <20251115174230.20504-3-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
	 <20251115174230.20504-3-janusz.dziedzic@gmail.com>
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

On Sat, 2025-11-15 at 18:33 +0100, Janusz Dziedzic wrote:
>=20
> +	for_each_subchan(chandef, freq, cf) {
> +		c =3D ieee80211_get_channel_khz(wiphy, freq);
> +		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
> +			continue;

Does that CHAN_RADAR check make sense? This is reporting what's going
on, so probably should report that even if the operation is somehow not
very sensible?

johannes

