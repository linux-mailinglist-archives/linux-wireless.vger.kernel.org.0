Return-Path: <linux-wireless+bounces-12654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C279713FE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FFC1C22CDB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D981AD3FC;
	Mon,  9 Sep 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a/qR3uOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2711741C8;
	Mon,  9 Sep 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874869; cv=none; b=g+Ip87ArXzWc5sjm/51uur3PeNAke3T9uzGta012jMbe9BcIZHsU/63Wbu2WpPNFINa2ULwDPDpBVyZwVj5lqZwqTaf63fUc73OiwOYM/xnoHSNbr+RWxl2Tjs9QjDOLTqvyvQBpil2yquo4LHpnR0M/twswDTUbcIFKh0eOP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874869; c=relaxed/simple;
	bh=3N42rW920d6Vugk4DbxBfxF+GZkBmGZde1OUtyetVwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMuU/gfrxwY3vxZR0RZ3cHqciUcxye0Mn3OFBzb633IDoTNbYJrauhRf8rQHnslDdoCxsTNDDP0kVgSQl75OTZ+qdAjGTu03xpodAh1HFhhdmbzYK4lS4BXmh/5IgDfk2UCHSXJC19obMlV4bwkaN9kexLPKvZiqNGhUBtjJDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a/qR3uOJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3rF3U3vmHpfPcmokJPPRhAa75wEQKBtpcfNTesoYMyU=;
	t=1725874863; x=1727084463; b=a/qR3uOJUb3aWpbUQkI6Vc5NIUlzeVgK6gbFD1A2IL2MJsT
	dcSsnzpy75lJY6qb0/a3dygL91yh03Dy7/3qKOd6iDYP4RxUn7TGcohNMjdqL3OP8MMj0D6YDTzgt
	aDrfpqzUpTY+tGbHhQex3/IA1MD1mZTjqMQmMIXjNCILxY98DYFTqwOR2Tq5Q8lf+vUcpuKz8Aztt
	hlr9eQH7upJa/93oaNciJFH3QVGw9iXXWJi7HYAZl9rD1vsdlIzpY9Ayxe/79xN7V+IwjXMaGYoIb
	ERCFnxuVlNClBqdZ6J3qMOfRjMFUoUdSOFXh2ur8fwyGxJMtzYi4Wh2zLL5Am1Kg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1snaDC-00000002I2K-201P;
	Mon, 09 Sep 2024 10:57:30 +0200
Message-ID: <dac6bfc0a0d5b92fdcb0d330d5e4839d2e119154.camel@sipsolutions.net>
Subject: Re: linux-next: build warnings after merge of the wireless-next tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>, Wireless
	 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>
Date: Mon, 09 Sep 2024 10:57:29 +0200
In-Reply-To: <20240909183924.73c3c91d@canb.auug.org.au>
References: <20240909183924.73c3c91d@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-09-09 at 18:39 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the wireless-next tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg8021=
1.h:6219: WARNING: Inline strong start-string without end-string.
> next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg8021=
1.h:6219: WARNING: Inline strong start-string without end-string.
> next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg8021=
1.h:6219: WARNING: Inline strong start-string without end-string.
>=20
> Introduced by commit
>=20
>   62c16f219a73 ("wifi: cfg80211: move DFS related members to links[] in w=
ireless_dev")
>=20

Thanks for the report. kernel-doc htmldocs isn't part of the process I
usually do.

I don't even really know what this means, but I'll try to figure out a
way to fix it. Looks like it's due to the @ references there, which I'm
not sure are correct anyway, so I guess I'll just remove those.
johannes

