Return-Path: <linux-wireless+bounces-14987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AF9BEF39
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B749284617
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E51DFE39;
	Wed,  6 Nov 2024 13:39:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A201DE4CA
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900361; cv=none; b=pkSIxr3F3VWhlGmc/C4fdb5mXtN59AJy2MY6fVnqyz3mOChPogBwxQ+UhhACNz2ppckXDJr63xAuJbUWK6Tget28ymKw8q2UCL8U1UpFHyke5w1DBzF9F7zLmxaqoJNBIKvidRF5uEROm0E/UUM8LKfxrlUzOIrjCPcrYN/+33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900361; c=relaxed/simple;
	bh=PtWUZ2AvdD603QWm+izhju9qdpKjMYYxQttFTkDVFPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/AaMY9+Gv/A2fcWg2gky2bgFJYuY8z2N1M/cNNZumqOA3BTvukxVEi6ooE13Fz7K+DQ9XYgGM+rn/bt9mZLb54mugOPrtLdz1AKCntfP7QxIQcE5EJEDCXHNR+II3L/RZm3El3yL6W151Vuz05VqC/R5FSEEM5xjd1iNLuPeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300C5970b92E00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:970b:92e0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E8370FA132;
	Wed,  6 Nov 2024 14:39:14 +0100 (CET)
From: Sven Eckelmann <se@simonwunderlich.de>
To: Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>,
 Kalle Valo <kvalo@kernel.org>,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>,
 Felix Fietkau <nbd@nbd.name>, ih@simonwunderlich.de
Subject:
 Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when it occurs
Date: Wed, 06 Nov 2024 14:39:14 +0100
Message-ID: <3288096.AJdgDx1Vlc@ripper>
In-Reply-To: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Thank you for submitting the patch.

On Wednesday, 6 November 2024 13:41:44 CET Toke H=F8iland-J=F8rgensen wrote:
> Since this is based on ideas by all three people, but not actually
> directly derived from any of the patches, I'm including Suggested-by
> tags from Simon, Sven and Felix below, which should hopefully serve as
> proper credit.

At least for me, this is more than enough. Thanks.

I don't have the setup at the moment to test it again - maybe Issam can do=
=20
this. One concern I would have (because I don't find the notes regarding th=
is=20
problem), is whether this check is now breaking because we count more thing=
s.=20
In the past, rxlp/rxok was used for the check. And now I don't know whether=
=20
the count for the other ones were still increasing.

* RXHP (rather sure that "high priority frame" wasn't increasing)
* RXEOL ("no RX descriptors available" - I would guess no, but I can't say =
for
  sure)
* RXORN ("FIFO overrun" I would guess no, but I can't say for sure)

Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>

Kind regards,
	Sven



