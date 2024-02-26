Return-Path: <linux-wireless+bounces-3997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D51C866DF1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547D81C23598
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1438DD5;
	Mon, 26 Feb 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fSaHsDjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8B18E3F
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936306; cv=none; b=Sk24qLOgKOZi6oNkEvRMEIuooOwdshUeKxQNlcLLRVWGafPsDwWBIB4qxhhHBWD7rW2UlPUU62id5n6SrXe54oUhozbVgkCSusg7umzTiSutR1kLHg9C8yUo9ORIvzZ0LXZhhnVkNMU51iLwcFgBzIV4X4lT9TJAqD6tcvR6x+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936306; c=relaxed/simple;
	bh=nw1w1ya+r68TkmVTR1ws6QK3QMyXcidwoXzAgXCx0T8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnaIumPk+GJlLesiWnG8/5Vj4+x3fRGi3Ig9XFyFm5W43OX1cwov/7Cg4wpdG9a7kHfdhfwQWhZ86gbWoubliN395mVHULxKejPyv2HdXxsnDIAvi/IjaRkPhOWd6EGb2oYaXhv5GMKFG6jiKRpy/Xl1rKf2K3aHMNVMwfV9aUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fSaHsDjy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p8Dl8g22eUdmFxX5j5wZ+ZsU6se0mQqZf32WCzYmULA=;
	t=1708936303; x=1710145903; b=fSaHsDjylHzKw+lgoJ1zPSSk+09ezTdCoaHSMUzSIMl5lk0
	szcNk+8+0pMGDuiiXg7WnkjNWfvB5nw3nuVBiiE2qQHjYHo4/tIx9+984LVRurD37SS8/McfKBtip
	479bwmFbPravopQ1N+iBvVdvX7JoNtfTLRkktt+C7SXRw2hZ0bksKMjOGY/ypLOvjiA2Q84Sbsxlm
	rGxH0lX7nzTw9AkRK23yVrGT/IJDEvT/OlLtkVBRULS7hQcO5gRA1XNidpRRR4i4iiZaaocqdP0U5
	05l0NGYTExuvehg8JC6TtFl+JsGj82xqXf6cJkxBcpnCD9BhpGRIU1OSVIOHjJkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reWOb-0000000957k-3qch;
	Mon, 26 Feb 2024 09:31:34 +0100
Message-ID: <abb0c320d284581adc80ecf8328599df9bc2d688.camel@sipsolutions.net>
Subject: Re: What is the lifetime of an instance of struct
 cfg80211_chan_def::chan
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 26 Feb 2024 09:31:32 +0100
In-Reply-To: <181138f2-77c2-47f5-94d0-28ccd52fb166@quicinc.com>
References: <181138f2-77c2-47f5-94d0-28ccd52fb166@quicinc.com>
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

On Fri, 2024-02-23 at 14:14 -0800, Jeff Johnson wrote:
> I'm concerned about a potential race condition in the ath12k driver, but
> need to understand the lifetime of struct cfg80211_chan_def::chan to see
> if there is an actual issue.

Almost certainly isn't - the 'chan' pointer in chandef is to a struct
ieee80211_channel, and those are more or less constant and need to be
around for the lifetime of the entire wiphy, at least. Often they're
just in static memory in the driver module.

> This is the target of my concern, which at first glance looks benign:
> static int ath12k_mac_vif_chan(struct ieee80211_vif *vif,
> 			       struct cfg80211_chan_def *def)
> {
> 	struct ieee80211_chanctx_conf *conf;
>=20
> 	rcu_read_lock();
> 	conf =3D rcu_dereference(vif->bss_conf.chanctx_conf);
> 	*def =3D conf->def;
> 	rcu_read_unlock();
>=20
> 	return 0;
> }
> Note: I've omitted some error code that isn't important to this discussio=
n.
>=20
> This code starts a read side critical section, gets the config from the
> BSS configuration, makes a copy of the conf->def and then exits the read
> side critical section. What could go wrong? Well what is this conf->def
> that is being copied?
> struct ieee80211_bss_conf {
> 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
>=20
> struct ieee80211_chanctx_conf {
> 	struct cfg80211_chan_def def;
>=20
> struct cfg80211_chan_def {
> 	struct ieee80211_channel *chan;
> 	enum nl80211_chan_width width;
> 	u32 center_freq1;
> 	u32 center_freq2;
> 	struct ieee80211_edmg edmg;
> 	u16 freq1_offset;
> };
>=20
> Note well the following:
> 	struct ieee80211_channel *chan;
>=20
> This is a pointer to some memory.=C2=A0

Right.

> During the time we are in the read
> side critical section we are guaranteed that, if this pointer is not
> NULL, the memory backing this pointer is valid.

Actually ... I would say since that pointer _itself_ doesn't even have
__rcu annotation (and doesn't get copied via RCU), the RCU does nothing
for its protection.

> But as soon as we exit
> the read side critical section there is no guarantee, at least not one
> enforced by RCU, that a writer might update, or even free, the memory
> referenced by chan.

There never was though, since you didn't rcu_dereference(chan).

> So I'm trying to determine what else, if anything, protects the lifetime
> of this pointer, and I'm getting lost in the mac80211 code, so any hints
> would be appreciated.

See above. It's always pointing to an entry in the wiphy's supported
band's channels array, which is around for at least the life of the
wiphy. At least should be!

johannes

