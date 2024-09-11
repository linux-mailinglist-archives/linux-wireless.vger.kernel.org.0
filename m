Return-Path: <linux-wireless+bounces-12792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB41975456
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C69BB29CE9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B91AB523;
	Wed, 11 Sep 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X82l93Ul"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16D1A704B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062034; cv=none; b=Ewiae2qC72Bf50DCCviVxci9B8jZgfj+ELlEl1QFsqHQdALptToFXFAsVj4idwYpUpGyKaltWvhQKFlEpFkPpJ7D8FLRN1y9x9zySTQVMr/KP+sxLn2+shomwOsQamuY9UX81PyFLc8XSLS37XzBjWLwr9rZQxad7cKB61skpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062034; c=relaxed/simple;
	bh=DeD/vlt6ocaYPExJ341XkOVpNa1p4HkwQ4VIlHpPsLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVLXyOzI0/2LJ9ez/1wViBfUro0X6bI1xLstUUK1Vg1Tg1u+8hP/m5UEwh1EDW85zttPXn5Q3aor66NhyHg3/Oo7TwgdjtRRah5VcettpXIveqk3ahYma+KAVjjsTKVgiUXpBAONirKpR3jAwXH34RnNxhwPwK560TLy24GdeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X82l93Ul; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DeD/vlt6ocaYPExJ341XkOVpNa1p4HkwQ4VIlHpPsLU=;
	t=1726062033; x=1727271633; b=X82l93Ul6JR4oqZBQ4k3PCESypjbAEQKoOA7f2RzyVapb+7
	PcEcWiSkN2oeBbxZH67jbLmIPAnHqmQKlCKyUZlppaLPoB7bt691Wfd5VLFznZ0oTOUGzNQxBXyt7
	Y5upJhVPRSs7KN0jC7ZoI82trZ4S0oAPf67xEJB6uUTscdTTu0VC0YztPHwTvNOBwsPSpJTVop1s0
	/IPn8QQxCKDwe5jJTwdwJIYcC5Ccqj0QwTKuN3Kn0UOxDRm2KaV1SM5M23zRmGJbriirbFCgdIrme
	SwkUkpPspl6l1gR2wf3379plF3Tv7zzrvG04eu9EYVg2f5Xo20JXpQEgWOlALA7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soNa9-00000008w8W-2Yb1;
	Wed, 11 Sep 2024 15:40:29 +0200
Message-ID: <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, Felix Fietkau
	 <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 11 Sep 2024 15:40:28 +0200
In-Reply-To: <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
	 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
	 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
	 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
	 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-11 at 18:45 +0530, Karthikeyan Periyasamy wrote:
> > I guess it depends on how you interpret "combined". It must be somethin=
g
> > that can actually be done *regardless* of radio assignment, to be
> > compatible with older userspace.
> >=20
> > So if you think "combined" =3D=3D "superset of all radios" then your
> > understanding is incorrect. You need to think "combined" =3D=3D "what t=
he
> > device can do without caring about radio assignment".
> >=20
> The current implementation of radio specific advertisement global iface=
=20
> combination (NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS) expects the=20
> superset of all radios, wherever the radio idx is -1 from caller of=20
> cfg80211_iter_combinations().

How so?

johannes

