Return-Path: <linux-wireless+bounces-24457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EFAE7757
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 08:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB297A2C92
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 06:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E733074BA;
	Wed, 25 Jun 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e358nW9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5993074A9;
	Wed, 25 Jun 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833942; cv=none; b=CFg16p4Iv7xPpR1KHZPzgJXb9qNQXUaMlAadeG+Cl7ua1xtybYUj65KfLkGCV/p7txO2wjFaacxahra1FPLCGOWyvFkdxV+BXXj/YgjjVgclf7k++fjuTXW9J7pQ8pbYGS+ZNaS9o+H6ef9RMCvC/DggCVpft5qdwDojZHdPKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833942; c=relaxed/simple;
	bh=HT93cWViqpWS2aTEIOaemqPNEO6x5Lz/c8DBkSJlNvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gG1AMEbgfuxeLWf43tQGmEai4lThU8/2XbiotBXmYf3hiRqUYLcMVE3pu+wHFVJlwwNbBu3brKjGEXMfPoUE4bGRuhbN2xeUTpUHG5aHUzt0OdHFATn2KV1ofvIjjvYcr/7bKypHafwhCPJA2x1oVsLtusqmiz/sG3XCTrO6Uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e358nW9t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hb6/3DRM/RbA1HkQbys/qwqnckKcr0/Zq2L66H0aGQc=;
	t=1750833940; x=1752043540; b=e358nW9tFIllPYE4DtIDMP8qZ+4CTZzubZaeKOwJ6IVTQFm
	WlavCfjjgrJbBATTWk5AsDCxVYXQE7ihQy7+DoF0whh7+Ty+4TDCdz4OegbzbS326RJJ2HaGS+7Cu
	nbDQ/O+qJ7N3stbgZNIdwkzOR6vsJupxMonAiTWRZV6QubloMrqP/8A4TjDxR4B7Zas4byqOp+f1j
	Halq7vPyzEg1NtG9qofpiK67Q3UBPFaiJAjo3u/oiGxLFoaD8eMETQVsYymRPJuTAjWAJ3jiaI/wG
	DluX9dCdAVrJ1j7U15a+1UPw+Yz3sueg5VSHHEqousPWT7ARjnB1mOXHbphNmU2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUJsy-00000009lI7-2aWT;
	Wed, 25 Jun 2025 08:45:32 +0200
Message-ID: <4d62cb5cd352ffc7c23be18b208865798137b966.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no
 AP is associated
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Date: Wed, 25 Jun 2025 08:45:31 +0200
In-Reply-To: <d63e5f8a-8e0a-4619-98a8-e73c80e307cd@quicinc.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
	 <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
	 <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
	 <89dd111db62029f1575f7a7113e2a0cb5a1a8d5f.camel@sipsolutions.net>
	 <d63e5f8a-8e0a-4619-98a8-e73c80e307cd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-06-25 at 11:58 +0800, Zhongqiu Han wrote:
>=20
>  >>>
> We have this WARN_ON since 687a7c8a7227
> ("wifi: mac80211: change disassoc sequence a bit")
>  >>>
>=20
> this WARN_ON was added in func ieee80211_set_disassoc() but not=20
> ieee80211_report_disconnect()
> I add WARN_ON on ieee80211_report_disconnect() on my patch v2,
>=20
> It was precisely because of the WARN_ON at 687a7c8a7227 that caused
> ieee80211_set_disassoc to return early(when panic_on_warn is not
> enabled). As a result, ieee80211_set_disassoc failed to properly
> initialize frame_buf. Then, when ieee80211_report_disconnect was called,
> it ended up using an uninitialized value.

Sure, but now you're talking about something that's not supposed to
happen. The WARN there means "someone made a mistake in this code". I'm
not even super concerned about using uninitialised memory in that case
although I agree we should avoid it, so the trivial fix for the data
leak, without making the logic more complex, would be to just initialise
the data to zero. Not to fix the syzbot issue (which btw is already no
longer happening according to the dashboard), but to fix the potential
data leak.

Since ieee80211_set_disassoc() returns early only with a WARN, with
syzbot you won't ever get to the uninitialized memory use though, which
is what I was asking.

> The bug was triggered as follow:
>=20
> Commit 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")=
=20
> introduced a code path where ieee80211_set_disassoc may return early if=
=20
> WARN_ON(!ap_sta) is triggered(panic_on_warn is not enabled). In this=20
> case, frame_buf is not initialized.

No ... that can't be right, we _know_ that syzbot enables panic_on_warn.
So this particular bug report from syzbot is definitely _not_ triggered
this way.

> Later, when ieee80211_report_disconnect is called, it attempts to use=20
> the uninitialized frame_buf, resulting in a bug.

I agree this is a bug but it's not one that requires major surgery to
fix - the only bug here is that if we already have another bug that
leads to the WARN, we can leak stack data to userspace. We can simply
initialise the data to avoid that. I'm not worried about reporting a bad
thing to userspace if we already had a WARN indicating some _other_ bug
that we should fix.


I'll happily take a patch that says "initialise the frame buffer so that
on the off chance of other bugs, we don't leak stack data to userspace",
but I do think that's about all we need at this point. The syzbot report
is already stale and no longer happening anyway. If there is another
report about the WARN_ON after commit ccbaf782390d ("wifi: mac80211:
rework the Tx of the deauth in ieee80211_set_disassoc()"), we need to
see how it's possible that we get into the WARN case, but I haven't seen
such a report.

johannes

