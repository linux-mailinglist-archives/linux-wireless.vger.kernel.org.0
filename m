Return-Path: <linux-wireless+bounces-7668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09228C60BA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659651F2212F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097933BBCE;
	Wed, 15 May 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JJXSQ3uY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242D3BB4D;
	Wed, 15 May 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754230; cv=none; b=Fibemo+3CuvsroWN0JWejxlU4WjVZi2KhOBM8eHkDTNssQKaW/dy5wKXV+RdUnZzIYwy6mEulDCj/ozeSwQoz03lOySV6/EnTcTgopj25HORxJVAP/g1j6B4FTpcXdtJhD1FLNnh9jz7WumtlLiqbYjebinxRbgt43kik+7dQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754230; c=relaxed/simple;
	bh=+fR3/NxAITdhdq3Ycr1Czm/xkzyiUXiiJ++SU9SO1o8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8JSblCXAbAOsaM5m2B1JsAhMn18FkPcc5uNEeE/+UNgWvSFw5NlptJidINmzyzTRCwoQTogFIoPw8uftdGHnaVsH6CcSMWSarlsXED5RXsoMtPd0vJl8H34G5kR0UL8lmRORWbqQ6FsyscLJmBeWmOOQmrxDA6CqvB8LF1yUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JJXSQ3uY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+fR3/NxAITdhdq3Ycr1Czm/xkzyiUXiiJ++SU9SO1o8=;
	t=1715754228; x=1716963828; b=JJXSQ3uYfIAk/qeCNjRdcpf+S43VPjgZEKY7Tgr0NfXKNET
	zrEiudhNJJW+qXHSmDRyzFftXTY8K91gXFsSCYQ0kBkbINcm5zQcjnj2pX3SYpr4plS+/DLSN+ebT
	ap7ac54ZqfMDKPz57rJKlbZboVzW9iOhyQp8SjA1Rd+8+WiT0Jg+6ICj+vRkIJl9+WI3gnFrLkEBP
	r6sjFd6tiJ7FX1JTFbEGg6nV2SJzwfBqnSTtMWlRm6gBu0ihdqhuTOafusb/mU6l16Klu4w6PL1Eh
	tuyPH/278vtKmDbwt0i6hPl/qrsNAqjaOy6JSDR+J32LKmEgph9kAVgkiaH0Ml3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7837-00000005zBf-1jNr;
	Wed, 15 May 2024 08:23:37 +0200
Message-ID: <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
From: Johannes Berg <johannes@sipsolutions.net>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, "Linux
	regression tracking (Thorsten Leemhuis)"
	 <regressions@leemhuis.info>
Cc: linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,  Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Peter
 Chiu <chui-hao.chiu@mediatek.com>, StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>
Date: Wed, 15 May 2024 08:23:35 +0200
In-Reply-To: <2341660.ElGaqSPkdT@natalenko.name>
References: <6061263.lOV4Wx5bFT@natalenko.name>
	 <2341660.ElGaqSPkdT@natalenko.name>
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

On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
> Also /cc Johannes because of this commit:
>=20
> 6092077ad09ce wifi: mac80211: introduce 'channel request'
>=20
> On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natalenk=
o wrote:
> > Hello Felix, Lorenzo et al.
> >=20
> > With v6.9 kernel the following card:
> >=20
> > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI=
 Express Wireless Network Adapter [14c3:7915]
> >=20
> > doesn't work any more. Upon mt7915e module insertion the following spla=
t happens:
> >=20

6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
chanctx ops")? Huh?

johannes

