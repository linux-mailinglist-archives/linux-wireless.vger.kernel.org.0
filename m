Return-Path: <linux-wireless+bounces-27514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54EB88C69
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D603AB0CF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888D2EC55B;
	Fri, 19 Sep 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SlYIZ/af"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1632F4A1F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276745; cv=none; b=Q1JdwwHgvtmT2B8HaJx01wcdV3izjAI/mClWKhHPuY89KZANEojKJCvcprAfNpIPAkijhGDu97UlKTlLOlcRqoPS5lX5ITbcU0O3WbqjIF3YLhihmT7XZXCTO2Q0n5fs+j8fE6Km8SWFIIMxmhX2pY6SKAPOHT7vZOfd0P47WBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276745; c=relaxed/simple;
	bh=ud5FcTkKLO/VDIdhtM5VaQ4TggMFmJlpow8CcR8swTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKnWEONIEfYVgapY2RHCMDHExxhspegtIEIUGg5zIj21J6r5n6VQQ27UPp1NpqJ6Wh+Ueu3Q8ECTdv8wbLL4KdNb7U1DJjqrM8RBB2cDNZcDFbhkQmHCv4L2Gh4d0KhQ9noMiv4AYaW10kJp3tjTtkAKG7r5E+DC7yngJeTIS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SlYIZ/af; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FRHoktF+zi2hfoim8fHQsARQmZOLsh62oHNIdnqHT54=;
	t=1758276744; x=1759486344; b=SlYIZ/afuEFbhzjpWWOkGXcjgfrIuPDM2/EC+nqfd7Llb+I
	PJtwwVEhkNQM3dogBENeS50aQeqxfZoDpO3vp9B0AiJ0YjLo+SvutNt5LYd6FAqp5yBxt/oElAUSU
	wg0PTKSPrbk/BeUeGumbBeSRA7JYpFEQ6utcMtjCG17C5NRFckvwaI3D4xEyXmcd0Ib2TOzvhy28E
	523XLFmT4K0DuvI1CD0uqGeBRSXatVK63fTa0B2JVyscoVkonrgMBByYpl8vO1XoEuqDMSoWpVKfS
	jGqoz2bq0hI89yCIf3AnzCqPnSkfG22+mRGWo64XjvyH5SnoV6BAnN8f2Qjn52lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzY6G-0000000Fg8s-2VC2;
	Fri, 19 Sep 2025 12:12:20 +0200
Message-ID: <7a47888d51c678a4252c7f8c68885d055b8034c4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: add support to
 handle incumbent signal detected event from mac80211/driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>
Date: Fri, 19 Sep 2025 12:12:19 +0200
In-Reply-To: <20250912032105.714949-2-quic_amitajit@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
	 <20250912032105.714949-2-quic_amitajit@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-12 at 08:51 +0530, Amith A wrote:
>=20
> +void cfg80211_incumbent_signal_detect_event(struct wiphy *wiphy,
> +					    struct cfg80211_chan_def *chandef,
> +					    u32 signal_interference_bitmap,
> +					    gfp_t gfp)
> +{
> +	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
> +
> +	nl80211_incumbent_signal_notify(rdev, chandef,
> +					signal_interference_bitmap, gfp);
> +}
> +EXPORT_SYMBOL(cfg80211_incumbent_signal_detect_event);

Btw, also, since you're going to respin this series either way (either
this or patch 2), I know we've done it this way in the past but I'm
thinking (now?) that it's easier to simply export the cfg80211_ function
from nl80211.c directly, there's no real split there. In some cases we
already do that, and then you don't need the overhead of the other
function that does nothing etc.

And tracing would be nice for it.

johannes

