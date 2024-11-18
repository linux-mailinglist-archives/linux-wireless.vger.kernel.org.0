Return-Path: <linux-wireless+bounces-15456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED79D116E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 14:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193DBB23CB5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6519F41A;
	Mon, 18 Nov 2024 13:06:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D11A00FE
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935171; cv=none; b=CSbmHH7KTu0I9yvT9XbR+h4xZZEnvuuus2FJ63sUqeIdKxX1KehhtPyJJSRG8fyfkdaxZM3wSJwfcxdEbFe58LavscLEvaz4mUUXsqdMiKIceiiAQKd3AvNqfM5z0bkR2akbYWHQ+etnoek+VNTN+/4pIxoAoe1rncITj5kgmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935171; c=relaxed/simple;
	bh=klaaxu55tP7YHH/tiVrmZAXHpaqBo6KtcrSfRg/pKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fznFlOG4oaioPGK2FWSE7CWkJjeKbtk8eiT8lw8Mu89AYe46NBvAgTdJHrvrI20nL3RLqgksEDOuncTg8bht/Dy+JdA7xEx3C5KAXJnGnEGq/GxcO8K/7eZeabr7revW5H8NWcQOyl7Rr/DGsaPUcDfKuFxgra0t1KKuS0ATL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300C597316bE00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:9731:6be0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E766DFA132;
	Mon, 18 Nov 2024 14:06:06 +0100 (CET)
From: Sven Eckelmann <se@simonwunderlich.de>
To: Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>,
 Kalle Valo <kvalo@kernel.org>,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>,
 Felix Fietkau <nbd@nbd.name>, ih@simonwunderlich.de
Subject:
 Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when it occurs
Date: Mon, 18 Nov 2024 14:06:06 +0100
Message-ID: <4937914.GXAFRqVoOG@ripper>
In-Reply-To: <3288096.AJdgDx1Vlc@ripper>
References:
 <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 6 November 2024 14:39:14 CET Sven Eckelmann wrote:
> On Wednesday, 6 November 2024 13:41:44 CET Toke H=F8iland-J=F8rgensen wro=
te:
> > Since this is based on ideas by all three people, but not actually
> > directly derived from any of the patches, I'm including Suggested-by
> > tags from Simon, Sven and Felix below, which should hopefully serve as
> > proper credit.
>=20
> At least for me, this is more than enough. Thanks.
>=20
> I don't have the setup at the moment to test it again

I've prepared a new Freifunk Vogtland firmware with this patch and placed i=
t=20
on a node which "regularly" has this problem. It is a node in a residential=
=20
neighbourhood with the usual amount of WiFi activity. It was known that thi=
s=20
node requires ~2 resets in 10 days.

After having it running for 10 1/2 days, I could see that the node was stil=
l=20
working correctly and the "Rx path inactive" counter showed 3 resets during=
=20
that time period.

Tested-by: Sven Eckelmann <se@simonwunderlich.de>

Kind regards,
	Sven



