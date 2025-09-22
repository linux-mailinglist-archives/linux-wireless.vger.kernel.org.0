Return-Path: <linux-wireless+bounces-27566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57DBB8F309
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DCC1897AD8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDE212578;
	Mon, 22 Sep 2025 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vX9IfvH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47132182B7
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523620; cv=none; b=LuofsAQIJ70HDNxE9D4YoD+SGXYDg7zhy4HDgXsOTD/RiRGigQzBUlB2O1ZMubAHOveJ0h1eAu/ENzPI8smEhiKNTe9ANeHFoy4aEOBRjZoHxMwsT43UYM3C8dooz7CcG2NBK83ji7x0XRx0zmbAKUH4lS21U6BI4QxgdEshZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523620; c=relaxed/simple;
	bh=7jA5S55Zi3epHlBT/J7Z8jmtcM6vazpQQuEaf5bzXGI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKxOzgv5Etf//sSZsyopJZn/QrlU8FFzGtSRNQ35hlXCPvf0KHOUCO318y26jxo8WwtlCsC0BTf5uG4WxuJE5j+19YQnDn1k1TOY7agBEbwMqQ48wG6IJaSIiPO/jafvKyNxwg9uArMUOWJwa9YNRvuyNlnDD6i4xSg2oFe4qgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vX9IfvH4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+DBwvUMJb1thkoSZF4bZMvGjfW+vl+Zb9Oc0Gf6S2Wk=;
	t=1758523619; x=1759733219; b=vX9IfvH4XKoreo4R4s30H+OVlIDNkfog/YbnXOXtXkpqRqP
	SMOG0IQYlR8iQhGcyfft8zRnkJ0L1My2QlDkugVmkFbT5aiFWYMzDJ6wSueZUQvSYj5ze9n3jDDts
	XJ1WM9nKL7nYcVyT6cpzuLPGX0uV8ForEKK+UwCdmkILpZdTRQ57E6K0YKnvaghKRneVwBJfClzUx
	6uGZujqL+bWKeFPGnQ9dNr18QMOYb3jj+t9e1PUftclAaetdV8mMewztMDZAOA0818/qxDR3LNqKb
	R0C8CEZs3HBfDXbQNrsqzzceZPWg8Ixo3ueCYXq/xXS8Tm79zFAIJUb1dJQUPGhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0aK7-000000049Cy-3M8o;
	Mon, 22 Sep 2025 08:46:56 +0200
Message-ID: <40c186606df108c5147173dcb253334a749f2661.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>,  Aditya Kumar Singh
 <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 08:46:55 +0200
In-Reply-To: <6e8eae56-54f7-4e90-a0a6-d5aed312b783@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
	 <20250912032105.714949-3-quic_amitajit@quicinc.com>
	 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
	 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
	 <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
	 <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
	 <a1ef1d78ab5c790d5fa3b6972a604949e210ccfe.camel@sipsolutions.net>
	 <6e8eae56-54f7-4e90-a0a6-d5aed312b783@quicinc.com>
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

On Mon, 2025-09-22 at 12:14 +0530, Amith A wrote:
>=20
> On 9/22/2025 12:08 PM, Johannes Berg wrote:
> > On Mon, 2025-09-22 at 12:07 +0530, Amith A wrote:
> > > On 9/22/2025 11:47 AM, Johannes Berg wrote:
> > > > On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
> > > > > The workqueue mechanism here can be removed as
> > > > > ieee80211_incumbent_signal_detected() will be called from process=
 context.
> > > > That's fair, but somewhat besides the point - it should be OK to ca=
ll
> > > > the cfg80211 function from pretty much any context, so even if this
> > > > weren't the case for your particular driver, there'd be no need?
> > > >=20
> > > > johannes
> > > You are right. Ideally the cfg80211 API should be safe to call from a=
ny
> > > context. However, in its current implementation, it uses nlmsg_new() =
and
> > > genlmsg_multicast_netns() with GFP_KERNEL, which assumes process cont=
ext
> > > for memory allocation. That=E2=80=99s why I initially used a workqueu=
e to
> > > guarantee process context.
> > Err, no? You actually gave it a gfp_t argument in the current form.
> >=20
> > johannes
> I was referring to this call in=20
> ieee80211_incumbent_signal_detected_work() actually
>=20
> +		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
> +						       &conf->def,
> +						       conf->incumbt_sig_intf_bmap,
> +						       GFP_KERNEL);
>=20
I guess I'm lost. That doesn't mean anything for whether or not you
_could_ be calling it from process context. Clearly, you _don't_ in the
current patchset, but the fact that it's not necessary to do the
contortions necessary to not do that was exactly what I was pointing
out?

johannes

