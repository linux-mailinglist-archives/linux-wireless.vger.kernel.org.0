Return-Path: <linux-wireless+bounces-14421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3D9ACE65
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254F9282CB0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB087404E;
	Wed, 23 Oct 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sU6FeVZJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD92EAEA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696529; cv=none; b=uVgg6vtnEnnARH9wq8dWb2ZTkhjEz9Xj9PJ6/ZL1RT+kkVHj65QC6dra74PezWaERewqL4TxIbJtG84IqgGcX4gor9o8lgkukTG2sdZpElTbtFaJAMPUJHfuKcVUmAabDIa02ibCzyFy7okYnddNlHESG3oE7/SXVDAfvF4HOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696529; c=relaxed/simple;
	bh=XKzXUoViudw2r7D1WDadWyYhFKJgSVQxue9vQoG9wJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6J7O/G7RtpRGpH/MbIYUswwGGERYr1qrjdRHJqm9elyTghdfnIuWNnagI1loIKRNrUXDi0KCtVt0QO4z9GZR0WsJWhgQwMKb7l3LVv2OoVIJuyo1WbR7vrevIn/vaEXNOhzAdgZCPm5T7lATdP8MAdUr3lORFARdCTi9/qhaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sU6FeVZJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XKzXUoViudw2r7D1WDadWyYhFKJgSVQxue9vQoG9wJs=;
	t=1729696528; x=1730906128; b=sU6FeVZJtWSjhmwnwsDD456bxkVs7fd8ZIc6ZTgWSEhCvvL
	JG59WM3GzljBALYFDbL6o3l1uCrXzimkCw/MCiAREt/VuD/BnNny+NRnw+fpg9iv97a5lsHHMHAXN
	42Ue3VC25+SbH53FmV4dwbxBymEF3Wq+ADvT00ThLIwmJOJKOuRIDxZJnaDIuX1wByaXf0m9VfL+/
	D5FU2Zhp5803rDNM64DM7Ql91Xn1qaRSxghLjoZrOASVLymcIJDIcgu/NiGMONQMoubZFKjnHorJm
	6rHfW2LZyXIOWPaMX/of8GlDz4TYOiuRqlmbxuyjT6OrjR6ahskfdXjryrwx921w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3d51-00000002jiU-34Se;
	Wed, 23 Oct 2024 17:15:24 +0200
Message-ID: <c1f794fc30150a0972d747fae79133f4c6e159c2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: override HE/EHT capabilities if NSS is
 zero
From: Johannes Berg <johannes@sipsolutions.net>
To: Ajith C <quic_ajithc@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Oct 2024 17:15:22 +0200
In-Reply-To: <c700b251-8300-4d58-be9d-7f78057d84ac@quicinc.com>
References: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
	 <30ec97d6ecfc4bf83fbd1477c0dba255bce9e6fa.camel@sipsolutions.net>
	 <c700b251-8300-4d58-be9d-7f78057d84ac@quicinc.com>
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

Circling back to this, still had it on my list (but am going to remove
it now)

On Fri, 2024-08-23 at 18:55 +0530, Ajith C wrote:
>=20
> I=E2=80=99ve noticed that stations are sending association requests with =
zeros
> in the EHT-MCS and NSS fields. According to draft 6.0 (Table 9-417p),
> a value of zero is allowed for NSS to indicate =E2=80=98Not supported.=E2=
=80=99
> Therefore, I believe we shouldn=E2=80=99t consider these as invalid reque=
sts.

I still don't think it's valid to connect in 320 MHz and then not have
any rates for 320 MHz, so I'd be totally on board with hostapd simply
refusing this.

johannes


