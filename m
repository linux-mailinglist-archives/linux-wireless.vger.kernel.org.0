Return-Path: <linux-wireless+bounces-5475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B08904DC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE1B24FA4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3912EBED;
	Thu, 28 Mar 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S6/NF9un"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87F13281C;
	Thu, 28 Mar 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642744; cv=none; b=skXQfMpk1hP/eNbi5APsXMOBLawTglMUkEFjmjLk1oubWAkXMf0lasgBz5rs6cZdomwtloXtvK+5jY33Hh8g+2t38HwJBYkgZ8Z4D2Hr6+aABTgpB9Bd4x94jPsnqihUUMqPYhDZ7XKT/cMd83TdC1aX7uSY/m8kuUpejdGklH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642744; c=relaxed/simple;
	bh=vArowKgbDJzmZWDWeF0zjkz6oCdO1S/8qWK3bsATyZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KD27New74hni8Ipbx8yYGC9IAou1x7fjdzKGjVqvcYl5Sn3Tkdk49S2Z9Kc1UAM6irOc8PtCsNTJYEIc/yOxZTW3/yb1Bmete5w0LXylZlnro3x8ZFElD3ISG39SpAwRfvPAZGvUK9q1ZwU3hEQMrVF3M33UPqwXF0TNuwhHL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S6/NF9un; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vArowKgbDJzmZWDWeF0zjkz6oCdO1S/8qWK3bsATyZE=;
	t=1711642742; x=1712852342; b=S6/NF9unt546w6x2hk1vPBPnsuxLzgjllnx9ZtMtDqoc95d
	wNgOzG8axejD7PtDbS4Cl42RoF3OCfUFuwVUGxP7YlkHUAGyohqowAcPK8qhgUjDM2BnKUsAKhnh+
	R4Cdx0XazzPGcnfhuYQNX7tLy9HwDMnVYSU3MqoX4yvREerN6sfgh3cfV0wANllA84KpDdVI1sZqU
	sIqx6AyWtXldqOTbK0fdOSf/NxWanyXUS+/W979jY1ekUzNW68dTci26M10nIKVrnFVA/qfDJHPBJ
	no6nwsl00J3JeU0DBjzOtexw1SnREbBTM4WPppclSF3YkyPdlpGo8RDfnXP8Xf1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpsSx-000000017qF-1fBQ;
	Thu, 28 Mar 2024 17:18:59 +0100
Message-ID: <0d4878d0dce3c2e9d500d19783dc7be3f995cced.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Karthikeyan Periyasamy
	 <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Date: Thu, 28 Mar 2024 17:18:58 +0100
In-Reply-To: <3cc984766a2cf1452ac44054cd736c913c356469.camel@sipsolutions.net>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <14b739c9-18da-0d58-b58d-cccebc505950@quicinc.com>
	 <3f61f18fbf3372ff88da54cdfbd309e74b2aa4e9.camel@sipsolutions.net>
	 <2b5fdc14-85f0-48ba-9797-c1f43ecab86e@quicinc.com>
	 <3cc984766a2cf1452ac44054cd736c913c356469.camel@sipsolutions.net>
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

On Thu, 2024-03-28 at 17:17 +0100, Johannes Berg wrote:
> On Thu, 2024-03-28 at 09:14 -0700, Jeff Johnson wrote:
> > On 3/28/2024 9:09 AM, Johannes Berg wrote:
> > > On Thu, 2024-03-28 at 20:40 +0530, Karthikeyan Periyasamy wrote:
> > > >=20
> > > > Can you point to any attribute constructed in this way from kernels=
pace=20
> > > > for the reference to explore more ?
> > >=20
> > > I don't have anything directly, looking at the code finds e.g.
> > > devlink_dpipe_entry_ctx_append() but honestly that's really quite
> > > trivial, it just adds that new attribute while iterating whatever lis=
t
> > > you have.
> >=20
> > Note that we are trying to maintain the same structure used by the curr=
ent
> > wiphy global advertisement since we actually refactor and reuse the exi=
sting code.
>=20
> Partially, yes. That's not true for the one I was discussing _here_,
> notably nl80211_put_multi_hw_support(), however.
>=20
> It's partially true for patch 6, though even there
> nl80211_put_per_hw_iface_combinations() doesn't need to do it that way,
> since that's a whole new attribute (NL80211_IFACE_COMB_PER_HW_COMB) and
> can define the content anew

I should say "content and how it forms an array in the top-level
message" here.

johannes

