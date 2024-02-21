Return-Path: <linux-wireless+bounces-3842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8785D268
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AAC1C236A8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6073BB3F;
	Wed, 21 Feb 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SQjIsPJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5593BB3D
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503636; cv=none; b=uTo5BbdP3Q4nXZp7DdJP5Otpu6e5+jk5eVKEsjVKHDr8nXbTatYpnGPPScG18XlFLTyoXKSFCd3+KYAVNxcWK+q6Db6MzREt1rjpexIKaktvOfJD0qnrfgglWo/lHxuzD5A/PCP5YBMKHjhraeJ//tFnGkhc6QaJ+94ZFmJHuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503636; c=relaxed/simple;
	bh=1DLNmhmnekccevXo7TNnzpEBjUqrxvHWDv+Fb9f/Bn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkt0d3DPmgQcWq+pAMGigtulZYYl1vNmtkm/M307AaOhWH0LkDf1QIrmZ1Mg8EAqtI+UqWrUG9msJ0X9vdAREsXY/ewsphNRUKVTBQ+NHc0qkC3E+fWPfprR9OuBvHvXujyqz61jR4C8RvRAsy6llx5NF2Nsvqmo67gwL/t9lNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SQjIsPJK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1DLNmhmnekccevXo7TNnzpEBjUqrxvHWDv+Fb9f/Bn0=;
	t=1708503634; x=1709713234; b=SQjIsPJKlo82ufNxUiqcynwEhXQdgjKUYP1P0Q2ayUOdA47
	ftUbCyelkS5k8lU9vALlz1BRDLwApjl3iNjJxwhPmYYJtANTSj6uZarOYrbEVrBeS6uDdvVgTIOsD
	ItVq9mfVXQdAWXw6rSvIoa0bZ12/Hc7A42RAV6LgjAf5Dk0WMnXxmm71egCGtXzgyT6tfzQgXGIny
	C9v+zXp9b8MYUjkHwcZ5WPvrtEsa4Cj3I3DG2m7/gmGK5cPOciNc9ateyxyg7TIP5KRGbwE9XphvS
	5PZ9jvBywUINyl4CFjrI/VdLYDZntnnEfO+fICpp+n/g3LBtAi4lO7SCmTrVBG2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rchq8-000000026Rc-2pe5;
	Wed, 21 Feb 2024 09:20:28 +0100
Message-ID: <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@openwrt.org>
Date: Wed, 21 Feb 2024 09:20:27 +0100
In-Reply-To: <00094ae0ca73461c88799c070ad9b55a@realtek.com>
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

On Wed, 2024-02-21 at 08:19 +0000, Ping-Ke Shih wrote:
> > -----Original Message-----
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Sent: Wednesday, February 21, 2024 4:10 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Aditya Kumar Singh <quic_adisi@q=
uicinc.com>
> > Cc: linux-wireless@vger.kernel.org; Jeff Johnson <quic_jjohnson@quicinc=
.com>; Ilan Peer
> > <ilan.peer@intel.com>; Jouni Malinen <j@w1.fi>; Ryder Lee <ryder.lee@me=
diatek.com>; Arend van Spriel
> > <arend.vanspriel@broadcom.com>; Felix Fietkau <nbd@openwrt.org>
> > Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel =
switch on link basis
> >=20
> > I guess that'd also apply to probe responses? Or does it not send those
> > at all? But we discussed before that maybe we don't have to be perfect
> > there, so I guess we can find some solution to that.
>=20
> Unfortunately, Realtek firmware doesn't send probe responses at all. Stil=
l
> need hostapd to reply those.=20
>=20

Right, but filling in the CSA counters?

johannes

