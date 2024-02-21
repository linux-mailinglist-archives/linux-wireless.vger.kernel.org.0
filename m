Return-Path: <linux-wireless+bounces-3846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348185D2F6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443931C24905
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3EB3D0DF;
	Wed, 21 Feb 2024 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L8dlMd+L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAD3D0A8
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506003; cv=none; b=l5tnyMDTLkSkec4G/Pj3GmZCVvFc1uVdTmdjuKrvBSCltBNhMRmAt7qTs+me+q243bVQ0pk0vZf9f5leAD9nNrTZEMT37NrlIEYm9UHRxlGGhDIivFalimzBwIMRStFEvc41nQ408O2h7Us8LAES3Cc4eyceb+KvSgSOqddsdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506003; c=relaxed/simple;
	bh=10tzTNPQ+Mhrc8e9CqSysoSr5mh7gFsmHeTJ/8qhOqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uys6CWGJbgptWbUfYspfwzLcCBISA5ZXZ892U29/rTJy+gC117bnoz767snuoy3sNAgkXEZiTZOBIvcYsxgx1zcLE7fiD1ShoNHKQt9vdPMOZ4NAwsdgfsHm2I6Idap1hBtcqME02cZLqTCGJGyCpvpTw8+dFd/WHC/0pJzPvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L8dlMd+L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=10tzTNPQ+Mhrc8e9CqSysoSr5mh7gFsmHeTJ/8qhOqg=;
	t=1708506001; x=1709715601; b=L8dlMd+LyMlLmIxxEUeMo81SwIzisZKq0PxS2hxwVslsQ2v
	RlqGmEAZolQZ8PUxibvHvvLbctLbqbKfntPjnwXUJeIVejsHl19kTjNKkHXEstWV3I0ZdmdX6kcve
	57QrpByIHTZhVm1PJx+MWXco7yVUvJl5tDpnqVZh/KizMrhySZkHqdAYSXZCx+f5PdT/uMqTE3cyk
	gRQEFF5Zb5bOJsUHxyHkPepfNvxPRsKH/KQDGDAJMNq69TQYb/k378Ncoq0mYOfDFCuk0RzyyvHB9
	zo3wjXCOdMK9Ptl1lVdYcQy10/BtAwwnzgy5kxUVh/xGwRHwuVvEyVT3VgbtXc3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rciSK-000000027wF-3WRA;
	Wed, 21 Feb 2024 09:59:57 +0100
Message-ID: <64d1af77e7392aa14a90273d4004dbc23a4ec8ed.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@nbd.name>
Date: Wed, 21 Feb 2024 09:59:55 +0100
In-Reply-To: <c0f3930196504d2080907c12864493d8@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <00094ae0ca73461c88799c070ad9b55a@realtek.com>
	 <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
	 <9d3bea8152fe49278fe9804167ec8871@realtek.com>
	 <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
	 <c0f3930196504d2080907c12864493d8@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-02-21 at 08:57 +0000, Ping-Ke Shih wrote:
> > >=20
> > > No, firmware doesn't modify content of probe response frame.
> > >=20
> >=20
> > Can you get that fixed? ;-)
> >=20
> > With differing beacon intervals etc., I don't know there's a good way t=
o
> > keep the counters even with a semblance of correctness, especially if w=
e
> > don't know when the beacon was transmitted?
> >=20
> > Or maybe just fill it in the driver since you probably have some beacon
> > timing data more easily accessible?
>=20
> If driver can get CSA or ECSA offset simply, I probably can fill a reason=
able
> CSA counter (not sure if I can get 100% accurate counter for now), but
> seemingly neither ieee80211_tx_control nor ieee80211_tx_info (SKB_CB) doe=
sn't
> have these offsets. Any suggestions?

We're not there yet! This thread is debating how we want to handle it.

Although .. you have a point, we have that issue now already, and we
don't pass the CSA offsets in probe responses if hostapd is filling them
in. I guess we also have work to do on this.

> I wonder our out-of-tree driver generates probe response itself. Let's me
> check how it does.

You _could_ also actually just implement probe response "offload" in the
driver, then you get the template from hostapd/mac80211, and that should
come with the offsets to fill in. Might be easier, overall.

johannes

