Return-Path: <linux-wireless+bounces-24913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B09AFC54D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35981892655
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6BD1B0F1E;
	Tue,  8 Jul 2025 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U+WDzF5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF73298261
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962879; cv=none; b=GQoEYAFkwoWYZZSOMdzMtzYBnrNxl38g8CIdmCm3fblvDLaf5eX6PtDU6Bh7D+m8ITaVpz9pf4yI8JftsKycvLC+LGqxDn7XzxCxxXufVl7s3Jn3rEKI/ohdQ/c3nL3Gprrf9uJz99QrFeVpqS75xkvJ21IuIo0DCXmA5haPMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962879; c=relaxed/simple;
	bh=9FDGGat7DSIAxa7cgP2V9wEpPTgLHuvbPii0mExepSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SMKVm7JdxklFcKC68r4UhX8wYtMROQnOOecte7869coYQZp3Ukt9eyz/PNLVDcLW0jpN6OFryls4ppvbxueERS0uJUfwjCQW7RZv1HhCHuRmR1GCoP2+lXXSnsEr53KB4xAG9Wlikw3KHVTtnT0qq31qWbcTo64zH2Rq/kFsWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U+WDzF5V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9FDGGat7DSIAxa7cgP2V9wEpPTgLHuvbPii0mExepSE=;
	t=1751962877; x=1753172477; b=U+WDzF5VMSbjteNCONI8EEOn4bCbSEl2045wiPfXXKw9pk5
	wxhtAadRUUBGy7XkXddPuDXdMBvozlzja6pYaBxalJjCv/dGvQWAprUjQlUFQvJMCM8picwfKS38n
	JdyZRayg6MJPPsvar0BfCQwht7nrjj5Zh0mrInSUNS0j7aUmHcSAUSDwPO64jRBjlX9tuLp93PLaO
	mEqmSOZOlcLmS88/H/+M5M+cTUU6OAfG2xJBt1NonmXgyAx81TUf88JbF0scTiDYbLNKvoozrvG6T
	BiiYm+JT4e+Oy5b+GeFK4DIu2aFhLpL/U5QStNnB9wvYUkoow59zwv4cdPtYnaDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ3ZS-0000000BjWB-3H1r;
	Tue, 08 Jul 2025 10:21:01 +0200
Message-ID: <c28ccc70b5baca6aff28a520d3f8810e196daa21.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: determine missing link_id in
 ieee80211_rx_for_interface() based on band
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=	
 <Evelyn.Tsai@mediatek.com>, Money Wang
 =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=	 <Money.Wang@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
Date: Tue, 08 Jul 2025 10:20:53 +0200
In-Reply-To: <54df1d3fe61bb861b97c897aaa4a2a3e08f71e62.camel@mediatek.com>
References: <20250702104403.2738634-1-michael-cy.lee@mediatek.com>
		 <6c666ab6d83ba45f9f15643eeffed5d0f4770867.camel@sipsolutions.net>
	 <54df1d3fe61bb861b97c897aaa4a2a3e08f71e62.camel@mediatek.com>
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

[btw, you're sending HTML that looks like plain text, seems redundant
and also made the links non-clickable here? maybe try to change that]

> > Hm. Qualcomm has a similar thing with frequency, I think, and that
> > probably makes more sense for them since 'band' isn't unique for the
> > radio:
> >=20
> > https://lore.kernel.org/linux-wireless/20250612121127.1960948-3-maharaj=
a.kennadyrajan@oss.qualcomm.com/
> >=20
> > Or is it not related?

> I think they're related but address different issues about group-
> addressed frames.

OK, fair.

> The Qualcomm patch seems to focus on preventing frames from getting
> processed on an interface running on a different band. (referred from
> their commit message)
> For example, a frame from frequency 6135 MHz should not be processed by
> an interface that does not have a link on frequency 6135 MHz.

Right, it's just in some way I thought many frames should be processed
for a link in the first place, though I guess you're thinking more
generally, and the other patch was explicitly about data frames for
which that of course isn't really true.

> On the other hand, the problem we encountered is that the interface is
> going to process the frame, but the "status->link_valid" is unset
> because the driver is incapable of determining the "link_id". The
> "link_id" remains its default value of -1, and the frame is handled by
> the interface's default link and is dropped because an AP MLD interface
> is not using its default link (sdata->deflink).

Right.

> In summary, the Qualcomm patch focuses on avoiding frames being
> processed by unsuitable interfaces, while our patch aims to determine
> the "link_id" so that the interface can correctly handle it.

OK.

> Additionally, we also think the 'link_id' can be determined based on
> 'freq' rather than 'band'. What do you think?

I'm starting to wonder if either should be in mac80211 at all, but I
guess if you both need it why not :)

I'd say we should be consistent, and use the frequency because there are
(likely? going to be?) devices with two separate low/high 5 GHz links.

johannes

