Return-Path: <linux-wireless+bounces-12794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF79756F5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD871F23E78
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17891A3055;
	Wed, 11 Sep 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VWit6t5e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2362C1A2
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068326; cv=none; b=NGigByPAOYMbmVPOGS3kHcbcPZHWp4Mq0hyaD+gAypERpsni1FONhgvhoC2D+V7gU7iGqcLU7CAiofc/v0reMQzcdqznXXdhho9LB2/5GTNAy2EUpD4PSSyvHls5W84CdclQJjwzum5lHL1BAajd6qEWWhIzsnaB4JqNJoHfQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068326; c=relaxed/simple;
	bh=cQvDH/QA2bBST+4Q25wR0DRN/78uNNIiNfFSSED/YwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpZxrXCaYHYYbo9dQc/DRm0MklZkccMNDj9vc0xeAB9cxLYtpdTe4IrxK3kQtaIhEN7GQCaBsTWdAXTyZxMge4ZY9Cvc2E/AJffY8TLKQ6Nd8Ykaa99oLGh5wD0I44dt4AQ/mGPkcRbiv05dZ5M+nBhSsiY5v4J7Q3Vg7QJ30do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VWit6t5e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cQvDH/QA2bBST+4Q25wR0DRN/78uNNIiNfFSSED/YwE=;
	t=1726068325; x=1727277925; b=VWit6t5emPmMpM4sfDvkpMnzmPB5Zo9Vsls2hpd7FZA5F4R
	dc55IXDeoTWHRc83C52D2giskgT1iqzNs+TL+mehI2RJ/1C5DGrQx1f2xhYp0m1jfgU450vV6eogW
	q+8ZeJgLX9kgTx0uDsMV6MrWsVX2AmqVUp/QQyfXFM0lwZwSI/lpXbJdsmqdTmHX+EG+a+rNtEt/N
	QBj2M4sGgUiurW6yrCTJ+tON392dn8aaqdNalhUzWsk50p48I9OnoIUUADLgtkwzc8n6S/rWUvSrb
	qY87+PcivaubPjoWqUVkbbJQLi7x3EF9Gbkvzii7h/7RttnINriE7eQFVDJufI8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soPDd-000000094Z0-3pA7;
	Wed, 11 Sep 2024 17:25:22 +0200
Message-ID: <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, Felix Fietkau
	 <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 11 Sep 2024 17:25:21 +0200
In-Reply-To: <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
	 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
	 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
	 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
	 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
	 <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
	 <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
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

On Wed, 2024-09-11 at 20:51 +0530, Karthikeyan Periyasamy wrote:
>=20
> ieee80211_link_reserve_chanctx() calls=20
> ieee80211_can_create_new_chanctx() with radio_idx (-1) to calculate the=
=20
> max channel (ieee80211_max_num_channels) after the iface combination=20
> check (cfg80211_iter_combinations) passed for the global iface=20
> combination. Here the expectation is number of channel context is less=
=20
> than the number of different channel. So in multi-radio advertisement,=
=20
> each radio support atleast one channel, so totally multiple different=20
> channels advertised in the global iface combination to pass this=20
> ieee80211_max_num_channels().

So maybe that's broken then, I dunno. You should figure it out with
Felix I guess.

The intent was, and clearly it has to be, that the global combinations
are something that can be handled regardless of radio information, to be
backward compatible with existing uses. Therefore, it cannot be
something where you say two channels and radar detection on both because
that would imply being able to use channels 36 and 40 with 20 MHz at the
same time with radar detection, which isn't actually possible.
In this case, the "two channels" is only possible with also two radios,
which has to rely on the per-radio advertisement, and the global one has
to be just one channel for radar detection.

We still need the part of the patch that calls the validation on each
radio, but it shouldn't be different from the global one. If you could
make that patch I'd appreciate it.

johannes


