Return-Path: <linux-wireless+bounces-6643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251848AC67F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4589C1C21319
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979845BEC;
	Mon, 22 Apr 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T6eZi+EZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08D482EB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773724; cv=none; b=q37DJFl+McsGeAnNlG/HxcICMnGwI2W8m+L8F9O02J0DsNoCPIlqig7pbj7V07BiJVdnv81OtiKgr8rdx46j1FI+vMK9R4Lb1e+yKoRYozC+UVZlcMp+PZzDDNKZCY954j0Tv8LU1CAp2FXWAzWKlcT4OiDRJLn0J+7sU0SM/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773724; c=relaxed/simple;
	bh=9r7Goxr1R86Zpjb4Anv19uS1EqAQLODdc5Ui04U2Ask=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2ix1KqjMOv6i3RoI3QGDAwG9GdY+t3aQrGowQdrZe8Rh43jIEzD1Cx2/AiwGB6fMaTuFqgCJOI3N6GSYxn2qqkq6bVMp1rZXCgv/Co8m1G4JbZH/LGXHjH5x4J0VhKMeoETxSq1RD800lCF82QRQvXiT6WwlaYLH9g7d4G1YNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T6eZi+EZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vub+ix27sII2Q078iBsECueO4Qo6SdP/7LscawosPnw=;
	t=1713773722; x=1714983322; b=T6eZi+EZXjW4jxvxSRuVErk1s2FL6QV07wI0qVHWgwuK+7U
	pZsrBmEJwz/upbESnEHrY4YiKIXNX91INvsOJw5zSggFHsqYwEsrv7GVvTkiLvpU7m7b4wTQeULJ7
	6x9VoO6xoPBXHbgw+yfq/VvPXv/bwv/9ggjn0UQnncJAC5n9yxhuqb3nKx1QHIVRko/UXrc5zmNXS
	KRIGl1scwFsaDFxg9WkFE/FaLWGBVcNj765Plf5ZUKlbdtaQkAjXSejS4mtTl4R0f+pvb7rclluo7
	bMNui1rnt+q5UE5c3F2idveWzs4X4EbJmhOpnzwAiIGuS6V5nqtf+jE13azxb8TA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ryopV-00000000brH-2QuV;
	Mon, 22 Apr 2024 10:15:13 +0200
Message-ID: <01fc6041e04b05ac6909a9818c9a890628542373.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] wifi: mac80211_hwsim: add support for BSS color
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 22 Apr 2024 10:15:12 +0200
In-Reply-To: <20240416045943.576656-8-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
	 <20240416045943.576656-8-quic_adisi@quicinc.com>
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

On Tue, 2024-04-16 at 10:29 +0530, Aditya Kumar Singh wrote:
> Advertise support for BSS color and then once the countdown reaches 0,
> call color change finish.
>=20
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
>=20

Not quite related to this patch, but I wonder ... what are you testing
with this? How?

Seems like we should actually filter on BSS color in hwsim on RX
somehow? We don't have PPDUs per se, so we'd have to tag it somewhere
else, but that's doable?

Otherwise are we even testing all of this fully?

johannes

