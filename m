Return-Path: <linux-wireless+bounces-3423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED1850B07
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C257281184
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853155D462;
	Sun, 11 Feb 2024 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RfZzNTLL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9736113
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678509; cv=none; b=Hj+OLZg985DozzAwES31H8qyJe0ZcU2nSc8Tckm6UiKhU9H38+bcyxYevqLkRjdGP80TZ6iqOoAgjJ4vX7FicocDjkk58HkepnssvO+XgTAtjgBDl3NCKqcr7OWwJ4zcGCBHzhcOh4FY9uK0xjZcj+aMHcMoEpN9/6qbr28ZmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678509; c=relaxed/simple;
	bh=c7u3/VlzKb6A2NKID47+3/eqQIv0/WYBG2nbxKYEesM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llS3qc4nj2QmnceoMQ372ihW8cS36XagfGbw+x9RErJIfRlgixULdOtf5RKLETzhgXpetmmhPGM748WzVmo15oVuOR2eli0UD9KtsohkyImvIS7RZYcU/jHln7K1jcF8bw3NQFKA/E/kTd3NgVQuIQY6wiIX7MbRI8TUMsXN8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RfZzNTLL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wz64LrnBBtsua+pXR5kwULmT8pSz2Bfo13R/BBLSuGQ=;
	t=1707678506; x=1708888106; b=RfZzNTLLi/fMHlfNZxFdCBx1LliuYrnkD6IUO+x1eLRYTQ6
	M6yFJgQS7PQxsOva0M4+2WV6B9TnIUNUvt5kkLlYwRoWtBjkI2Sq9QdaH5rWxe0ZlQf16gL2cNoDP
	hOUbiTIsYPdKZ0DHdORxLS3bW3w5TUPl31fZ4cCDbzYshmsYVNErIU9F/otUwbv2JhcSOcBxWqGe5
	j67FETddRYOzv5Knd8KS/hQBuXbg6SiWuQ/J1OuXG+nqI5Se3KkAC2hCjuYAqwophLs43udBdlbHM
	K68IHSIJ4CojSy1eRYoWiYyAqwvxD7yEHWwt47OMYN1k54+QrnueDw2H+kSS06OA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZFBY-00000004d4s-2LV2;
	Sun, 11 Feb 2024 20:08:16 +0100
Message-ID: <37d3b28692d113453dd91eb1fd10722921522e71.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Vinayak Yadawad
	 <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date: Sun, 11 Feb 2024 20:08:15 +0100
In-Reply-To: <ae2a91ed-841f-47a3-b0b8-1e46244721f9@quicinc.com>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <ae2a91ed-841f-47a3-b0b8-1e46244721f9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-02-09 at 17:01 -0800, Jeff Johnson wrote:
>=20
> > +	[NL80211_ATTR_SAE_DH_GROUPS] =3D { .type =3D NLA_NESTED },
>=20
> can/should this have a policy? not sure it can have a policy, so see
> below...

Yeah not really.

Should it even be nested though? There's not a huge difference to just
making it a binary with a bunch of u32 values, and then the max length
can even encode (and make visible to userspace) the now hidden value of
CFG80211_MAX_NUM_SAE_DH_GROUPS.

johannes

