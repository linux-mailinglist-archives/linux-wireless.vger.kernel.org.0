Return-Path: <linux-wireless+bounces-24664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA031AEDC5F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F0E1885359
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A6C28507C;
	Mon, 30 Jun 2025 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XqE9fh3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4E27726;
	Mon, 30 Jun 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285528; cv=none; b=LIP/tJZzmPv76CIDxbql686aDqQFy79dN8mRRiQOV/t2L3/0YsUq9LPZtILLUWNOBGX2JdW/y7SCqcmQq3szR4kelbWUbPPAY4BGMhEmqczJIUdjVXsvNLItNgGSK5GbVhRe0+Ga0qCAaKBscnbPBmE+9Zwy+TALknuoN5+7wrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285528; c=relaxed/simple;
	bh=vivnRFXDAAz82GUWwNPXDfAlxh69B6b3d2ENBZfVKsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8Ee23xUvcn3BvfJNZmFrqlBn3xqHX+d95NJfI0+Lba3jTsIKzBmNZpJrAYyvh3k//EPxVA51bRtMFTScArvhd+ZdqqCxFOvzmKcrNArv8JNZfMGtWEPCoOmjrpQ3aWoXv285BGzfXCc5kysL6ZeeJCy8QHhAazghLXhmZgkiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XqE9fh3D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4Utdtws3qFpWd3h2rnJnLtmtOA+LpMly7BwnrC1eTp4=;
	t=1751285526; x=1752495126; b=XqE9fh3D1S4doURDty84xRwA+Z9lgnjsqXE6g+r1f3bhuHk
	nT3K9P1kcwpzfEQRvudMrgaRGUo/n8cKVPTB33ATXfSIjtoongMNGi4du3T0WBzTqTIIId8HEMEuv
	SS5N0vBPlJl6LHI5WVR7ZqnXO7N0OVWGwhZ309OhgfW3H6nTwRRY9tly6btFycFktkF6sx05tY90Z
	1u5c6+NHfCTMw0vByfLUMF/2z/PUPZmMue3Npjh6AcJGlTZeEYwHCBdGK2RXATPp89aHwhX27JKvw
	H5clGpt/HvS0Jbo4n1cXUgmKwzbqKOCmYAgN0giIeDIN69TgUHLUA9aT0kO7+P+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWDMh-00000001CMh-0HFR;
	Mon, 30 Jun 2025 14:12:03 +0200
Message-ID: <3cfa6ddfb5493aff609c5a51c84d61a7ed36d13f.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] wifi: brcm80211: Deadcoding around phy_cmn
From: Johannes Berg <johannes@sipsolutions.net>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Date: Mon, 30 Jun 2025 14:12:02 +0200
In-Reply-To: <aF7aPZc3xXfcc-UR@gallifrey>
References: <20250626140812.56700-1-linux@treblig.org>
	 <7625f178e7c2be9fd11f1b4cdeb4da47a4635c93.camel@sipsolutions.net>
	 <aF7aPZc3xXfcc-UR@gallifrey>
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

Hi,

> > 2) it'd help for the automatic bot runs etc. to have, in the subject,
> >    '[PATCH wireless-next]' (or perhaps rtw-next etc.)
>=20
> Oh right; that wasn't too obvious to me because get_maintainer has
> linux-wireless@ in the list but also had the brcm80211 - so I
> didn't know if this went through brcm or wireless picked it up.
> And what's rtw ?

Hmm, right, brcm80211 does have a separate list but patches still flow
only via the wireless list.

Currently, we have:
ath/ath-next - Qualcomm drivers
rtw/rtw-next - Realtek drivers
iwlwifi-fixes/iwlwifi-next - Intel iwlwifi driver
mt76 - Mediatek drivers
wireless / wireless-next - catch-all for everything else

> (Perhaps a Documenation/process/maintainer-wireless.rst would be good? )

Yeah, perhaps, though it's kind of difficult to really pin down the
exact list, it has been changing a bit.

TBH, wireless / wireless-next is mostly just fine anyway. Only if
something depends on other work in the specific trees would the other
tags really be needed, i.e. for people who work on it more actively.
With wireless / wireless-next the bot will still build-test it etc.,
whereas without a tag it may never do that at all.

johannes

