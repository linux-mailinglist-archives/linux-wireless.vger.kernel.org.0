Return-Path: <linux-wireless+bounces-25867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7330B0DF8D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BE8188B66B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22E2EBDD4;
	Tue, 22 Jul 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k60e6tuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547C2EB5D6;
	Tue, 22 Jul 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195719; cv=none; b=ru49fMn1Qjn0Y0U9USUpVjxt7qmfgLCIOdHBiBC8AMj2apJ+ARcB5YR1vEHmbaY7B4wU58rnj7loBZC/7ko+/Fth+iNHAY5YGmknuTmSSZSfDXpGVsm0gBVKhAZv3kTTnrfHx4xyfFcRobvV7nHN4QM2YqW3sybJ7qbLJKQXSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195719; c=relaxed/simple;
	bh=Cy2/dXjBdIcuMWjxMsiv/U4bjPQQLW45rYi0mhhzfzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+XFIEjPN5GHdDgfH3JqtyC8ao2RhVyzpX74u8zPboS6YxzHvj5fMrhZ9GKbO1GFQh0gH5XQxX2REkNB4hqDupcHRfOc3HygcUBhiF5B1Xliw/aSdhrh2Artovh8kK+a2ljs3wmSD3v+EGPUYX/TQBwnPjE2RobeHIM3Ymz6ICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k60e6tuK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bnhG1L8sNIVaf/FoCTbqo+iKpFyRChzRQU2I/lhE/Yo=;
	t=1753195717; x=1754405317; b=k60e6tuKhZcYWtkvwoWLs11LBXcSD8oGpL+GyaVSrrpi3qG
	/7tfq2jJv5V93BcqU4CKeFoOuqO7z7CctdNmYqEf76UHKbN1wcZbPHBsS3dtcu6Bu1JRED0ijI9jf
	7tIX1R9hM2J4iTDJ1NgFUK/8okxJI0+tcduWfxd5SgryUFjh2gz8BK+4MO/NJikss1Kd6TmnjWP+8
	41ZH70OX1fjNSVreMazNmYezznd3QOYXSkNQKkAn/UBCa4jrhiCwhiQLfEQzY9GgYCBgR8VFS7Fhj
	AXp2Qh2PL5ElJVDQQ3hmrj6pKmdXNrJp7xLQgr4NCKR4jx66Hkf/kenwpJMLGZLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueEI9-00000002FYt-2QVJ;
	Tue, 22 Jul 2025 16:48:29 +0200
Message-ID: <c1ba74ad02093b04c87d5f9c931d4e73fa42fac6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Baochen Qiang	
 <baochen.qiang@oss.qualcomm.com>, Christoph Hellwig <hch@lst.de>, 
	kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Tue, 22 Jul 2025 16:48:28 +0200
In-Reply-To: <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
References: <20221202130600.883174-1-hch@lst.de>
	 <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
	 <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 07:37 -0700, Jeff Johnson wrote:
>=20
> This predates me becoming a maintainer, and I don't see any comment from =
Kalle
> to the patch, however he did have the following comment in a separate thr=
ead
> where the issue was being discussed:
> https://lore.kernel.org/all/87cz8v2xb2.fsf@kernel.org/
>=20
> > Though I am happy to take your MODULE_SOFTDEP() patch, just wondering i=
f
> > there is a better way to solve this. For example net/mac80211 (the
> > 802.11 stack) has a lot of crypto dependencies:
> >=20
> > 	select CRYPTO
> > 	select CRYPTO_LIB_ARC4
> > 	select CRYPTO_AES
> > 	select CRYPTO_CCM
> > 	select CRYPTO_GCM
> > 	select CRYPTO_CMAC
> > 	select CRC32
> >=20
> > And it's not using MODULE_SOFTDEP() at all.
>=20
> So I'm guessing he considered this to be an issue that should be solved
> external to the individual drivers.

I just happened to see this and never saw the other discussion from Dec
2022, but it's somewhat interesting ... for some of those modules
mac80211 has a hard dependency (such as lib_arc3, crc32) but for the
other crypto modules it instantiates the algorithms via the string
descriptions (such as "gcm(aes)") so it has no hard dependency.

Maybe crypto modules are treated specially by installers and the like?

johannes

