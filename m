Return-Path: <linux-wireless+bounces-4274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD986D6FA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3F1F237A0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E744364;
	Thu, 29 Feb 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iVZOhk+A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DF16FF47
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246848; cv=none; b=bxN3l/SQIYJsYv4Jp/0euktN0WboVVPha7Vg3U1TIHpmW1FHRMkb7aR6QfjSkSPLiYaloCBRqUhMORT40/FHnmpOeGz4xl04ulJm8iuSFjbt/6vPjeFdllF80LSBEr7kP1OeQWWOrspSZ/RtwIYs87f0CpziYnpeuo7E68MXhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246848; c=relaxed/simple;
	bh=IFL2UTuP7GjeNNucKAwdaH3o1YbcMQYfUt9xnP/oyn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwLDXlyg39Bw/BEQIzrRsMmWTlgg4yhsMU/p5sZQa3LbLiTAH7GXNYi1oU2M+O2gok1MxFAYqR2Wxcv7+vwb3pKI/zyGCzcZwmegkm7QLM0/VRWIUtcnBJJUHXZOj08Pty3tWBSxwCQbwUSgm8dYXZSzizcNd0Iha6XxzgpEc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iVZOhk+A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=whHqOi4K4MuTBvtTPXcBH2zyy2R21VV+8M9moi2Ie/I=;
	t=1709246843; x=1710456443; b=iVZOhk+AyUKz7AbxdPBejqS4xJNbuk3v8bC9HwzLAB6Tg+t
	1tgqvQIrvhPXSEV1aPVwMpRQ2ePHMopTNyiGsUb4/eCYWERXj35j2EtD6LNJSVFpF2mIURvq4TGKw
	8PKVkMhDwQJtKcCb3LGpwK5E2IQUcq4YkUcd0xFSMdjOV9SjNSpVbzovYhoSEDDdN/j9O6ZKHoX59
	QfJ3TLhW9lkTKVVQvt5BL5AnqokCsjwLMj+kEJCW0jKzM/v7XJcOpaOoBagnZOauQVfxnmRKN357g
	WKfMsbLMGHa9FDo0vg+7xmLGUYwZJWx598RF0lW5GbOYPl48u9MAmYYsNSDU9Gkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfpBP-0000000DvAj-26S8;
	Thu, 29 Feb 2024 23:47:19 +0100
Message-ID: <4b906144041ab6e7bf4fb35e6cb42635c8cd21d5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 11/13] wifi: mac80211: fix advertised TTLM scheduling
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Ayala Beker <ayala.beker@intel.com>
Date: Thu, 29 Feb 2024 23:47:18 +0100
In-Reply-To: <b502cc28-865c-4f00-9f09-76851d6629ba@candelatech.com>
References: 
	<20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	 <20231220133549.15079c34e5c8.I0dd50bcceff5953080cdd7aee5118b72c78c6507@changeid>
	 <b502cc28-865c-4f00-9f09-76851d6629ba@candelatech.com>
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

On Thu, 2024-02-29 at 13:41 -0800, Ben Greear wrote:
> On 12/20/23 03:41, Miri Korenblit wrote:
> > From: Ayala Beker <ayala.beker@intel.com>
> >=20
> > Handle a case of time overflow, where the switch time might
> > be smaller than the partial TSF in the beacon.
> > Additionally, apply advertised TTLM earlier in order to be
> > ready on time on the newly activated links.
> >=20
> > Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TI=
D-to-link mapping")
> > Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> > Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> While rebasing my 6.7 tree on 6.8, I notice this patch applied, which I t=
hink means
> it was not applied to 6.8 upstream.  Was that on purpose?
>=20

It's there as far as I can tell?


commit b1a23f8ae0d76ad32fe36682730c050251275b0b
Author: Ayala Beker <ayala.beker@intel.com>
Date:   Wed Dec 20 13:41:44 2023 +0200

    wifi: mac80211: fix advertised TTLM scheduling


Maybe git rebase reduced yours to some whitespace changes or something
:)

johannes

