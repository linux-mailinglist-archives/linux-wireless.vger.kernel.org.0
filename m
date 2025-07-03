Return-Path: <linux-wireless+bounces-24798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E763FAF7E38
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556114A3BAB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B85248F5F;
	Thu,  3 Jul 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UN0ZqC/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C71804A;
	Thu,  3 Jul 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561654; cv=none; b=k3tvqMzpxNacKs6JRu/kufGI4f5nBPWIWsEbg2Xd32PnxQQ5ipZ16R2AuAsgkaxHCRYl5uNNsLNDPDszKaXl53uTTVqYd5eadxQk5rya+uFfpgw3bY1P8Fit0DCkcLcoaw0yGTKsJ/wEIQ6/ufnid3N074c1S+kxAoNW72lN0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561654; c=relaxed/simple;
	bh=RW0IfchVo7MJxIYM7d362pMnzo5nycFf1HXLEBxbIVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uB5XRv8IjZ1WcKqusA1KKI+W3PrhcT+DPKXtAHWbpK5XC0FYqJprb1bmdN+yibF641SJJkNp1JhJptRpaavZ8QUKQpl4Z6RnWBFop7tAV7j5iDMSDuOdDlCJVd9cREWT2pR5w4CEcX0qDeLECQTVLJuXi0PZotVTtrYPhP4wUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UN0ZqC/2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8tSAj2yt9qfQ16qmhmFGf5l7dehPpx10XvpWLTkHXyA=;
	t=1751561653; x=1752771253; b=UN0ZqC/2LuEacHnj9T+ouD8U33H5umNogJZAZcLgfIXbK0Z
	DDfl6rEG+nsFMO0zbPuJeKyGsjGMI232HmRuC8eORBsPhdkCUKU6+f5kvwMmCS5SdMYe6yzQdqPD7
	XOKPhHdyWPpPJSMXq4eQxL+eYHX+3nigDejigPNPHMnDrJ+F8XJ37sHn+7YCQKWik3tuSSlViF44Q
	NDK0b0z3EKUNQxuDbmg1/+nLB4rmVmJ4DgHJGNs6uJhrfl+yfoIXlik875ov1xKFSVFvdQ0cJEiYC
	bm+bDh5tCxT1x4McpfwUukfwOg7TEPKRpwv76jZIdKttU5bt0CFWDTgquWMY/rhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXNCM-00000005XNf-0Kcc;
	Thu, 03 Jul 2025 18:54:10 +0200
Message-ID: <5fda29626ca04e7c2ad46ca4a3d0eb1d992789d9.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
From: Johannes Berg <johannes@sipsolutions.net>
To: Moonhee Lee <moonhee.lee.ca@gmail.com>
Cc: Nicolas Escande <nico.escande@gmail.com>,
 linux-wireless@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Date: Thu, 03 Jul 2025 18:54:09 +0200
In-Reply-To: <CAF3JpA7ZeG5uxLJr1NQBBzF=UZRi4sj4TSfBw=Pvx7xb1NCqTw@mail.gmail.com> (sfid-20250703_183535_569381_928B48E3)
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
	 <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
	 <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
	 <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net>
	 <6ecced8b962cf3a6f5056a87aa3442c49941e74c.camel@sipsolutions.net>
	 <CAF3JpA7ZeG5uxLJr1NQBBzF=UZRi4sj4TSfBw=Pvx7xb1NCqTw@mail.gmail.com>
	 (sfid-20250703_183535_569381_928B48E3)
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

On Thu, 2025-07-03 at 09:35 -0700, Moonhee Lee wrote:
>=20
> To address this, I plan to reject the set of channel widths that are not =
valid
> with VHT opmode. This includes all channel widths below 20 MHz, as well a=
s
> 20 MHz without HT (20_NOHT), which is also incompatible.
>=20
> Would the following logic for v2 be acceptable?
>=20
>     /* reject channel widths not valid with VHT opmode */
>     switch (width) {
>     case NL80211_CHAN_WIDTH_5:
>     case NL80211_CHAN_WIDTH_10:
>     case NL80211_CHAN_WIDTH_1:
>     case NL80211_CHAN_WIDTH_2:
>     case NL80211_CHAN_WIDTH_4:
>     case NL80211_CHAN_WIDTH_8:
>     case NL80211_CHAN_WIDTH_16:
>     case NL80211_CHAN_WIDTH_20_NOHT:
>         return -EINVAL;
>     default:
>         break;
>     }
>=20
> This allows valid HT/VHT channel widths, including 20, 40, 80, 80+80, 160=
, and
> 320, to pass through while filtering out values that would otherwise trig=
ger a
> WARN_ON.

I think it'd make more sense to go the other way around and list the
bandwidths that are _valid_ here, even if I don't see it getting
extended any time soon (anyone working on TVHT? ;-) )

But in some way I also have a feeling we _should_ be able to reject this
in cfg80211 already - although it seems that right now we cannot. Hmm. I
guess better to have this validation here now than fail/WARN, but then
I'd like a positive list of allowed values, rather than forbidden ones.

johannes

