Return-Path: <linux-wireless+bounces-21973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DFA9AC51
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C191889BC1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B81FA261;
	Thu, 24 Apr 2025 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="chdMyDgz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51F502B1;
	Thu, 24 Apr 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495221; cv=none; b=QPgbfTzPXeddPy+RTFvAI1uLSUvKs04zwMPqJT0vPhzeg9EGcDm/RvaXatQNzlDCusXyHuXCjwlF3tiN3lQK/35CY2l7v1G5J/v8L1NLxnj4b+J/9m/fhlsAIbhu3rzUjgbnLm1dMS6k7r6l/+18Ok+lojvKzv6rJl8dNzv6eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495221; c=relaxed/simple;
	bh=zCg9RYgC23VfHFWsPzJfYA440kDZYupWd0LBJ5Lcon4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keYZ9JTmS8Ggsvopg29sJ2UxK/PixZ7rWsYR4IdFNQ+IRMpeut5+bnvjxBWMeJM8x8FG/OvDAwW3yIvjQGMfahYh/PzczkPdmpYv9ZnRaXmOD9KQ/UTX1Qiccfq3eD/UZg1ogaNoFm0/JCo5pUTsplplmEfV/8s9BAvZVwxBwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=chdMyDgz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cDjTaq2FddbEYNPEQA6TJWwLpYglj/0ApNlSw9/ALTU=;
	t=1745495220; x=1746704820; b=chdMyDgzuMcVDSTvUKuahqZroGf7/FLyEdISfj8JLQmp2dP
	Yvh9+iew2iWz/5OdU8otDQdDC2AYGaiR1uHki8Kz9B1SMtpEQTqqw/jHqxQhv+eK7nKmmPzC/cWDn
	6lz3VQVJB2yCRk4m5/RFGPHl7chlpflIv04s/rmspeJkLU+8d11bo+TymGFrRMoeR7wjQIJZuCaA4
	mIMmLmPU5+S3naZmlLzmm41mln5PiiGU8Lt6PGAmVClcFBQyak3EGgx7mR8cu8PPXKBoNYnka/LDb
	M2mibLqOGRwZXjrvImwxxZdMJjj0aeuUhGPOipkLXAwvv8LKV4Xxfq+R0ZPDDFDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7v2f-0000000H3Gb-1E9p;
	Thu, 24 Apr 2025 13:46:57 +0200
Message-ID: <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Gokul Sivakumar
	 <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Thu, 24 Apr 2025 13:46:56 +0200
In-Reply-To: <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
	 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
	 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
	 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
	 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-24 at 13:36 +0200, Arend van Spriel wrote:
> On 4/24/2025 12:22 PM, Johannes Berg wrote:
> > On Thu, 2025-04-24 at 11:50 +0200, Arend van Spriel wrote:
> > >=20
> > > Looked at other drivers implementing this callback and here are the r=
esults:
> > >=20
> > > [wil6210] wil_cfg80211_change_bss(): does exactly the same thing.
> > > [wilc1000] change_bss(): worse! it accepts everything and does nothin=
g.
> > > [rtl8723bs] cfg80211_rtw_change_bss(): same. just an empty callback.
> >=20
> > OK, though I guess other drivers being bad doesn't mean this one should
> > be :)
>=20
> Sure. I am on your team in this. Can you recommend a plan of attack=20
> here? Should we add a mechanism to expose what BSS parameter changes the=
=20
> driver can handle similar to what is used for struct=20
> station_info::bss_params?

I don't even know off the top of my head what's there and what isn't,
just thought the code looked odd. I guess mac80211 just mostly supports
all of them anyway.

Today the change is simply rejected by cfg80211 with -EOPNOTSUPP:

static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
{
...
        if (!rdev->ops->change_bss)
                return -EOPNOTSUPP;


why not keep doing that for everything but ap_isolate?

Oh, I see what you mean, there's no way to keep that updated since you'd
have to check each value for being changed and reject that ...

Hmm, yeah, that's not great. I guess ideally then we'd have a bitmap of
what changed, and what the driver can support?

enum {
	CFG80211_BSS_PARAM_CHANGE_CTS_PROT	=3D BIT(0),
	CFG80211_BSS_PARAM_CHANGE_SHORT_PRE	=3D BIT(1),
	CFG80211_BSS_PARAM_CHANGE_SHORT_SLOT	=3D BIT(2),
...
	CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE	=3D BIT(N),
...
};

and

struct bss_parameters {
	int link_id;
	u32 changed;
	...
}

and then this driver can just do

	if (params->changed & ~CFG80211_BSS_PARAM_CHANGE_AP_ISOLATE)
		return -EOPNOTSUPP;

or so?


Not sure how that'd be related to station_info::bss_param, that's just
output from the driver.

johannes

