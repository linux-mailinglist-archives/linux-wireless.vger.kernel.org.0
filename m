Return-Path: <linux-wireless+bounces-22801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740CAB1C80
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D25B24CCD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707223F26B;
	Fri,  9 May 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WmAImbQO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAF23C8A1;
	Fri,  9 May 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816002; cv=none; b=jvePSIJPB/NP+e6PE4cCwSFjvRbzvX4Kw+yIe+CZa6ctI5Q3xePihs0+aTw6eTjNPVGAdWMBcEBLh0CERWzxERiIodK9kS2LFGceaQCamW8aHuHWLwiDpd9mFwChPhd6rVuFRwxVbBGEUW6oQUWwzTx0fJHhiIy+r8Afyyl+w/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816002; c=relaxed/simple;
	bh=ufmL1F9j89Me952zqGsf7M3WE4S+gVmrururGD8UdSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LajNAl7vrf5hK2fAaOJGuXzBDv2yoMLDnw/KAkui3n5QeRM9cH3hOeXDJzzb9esdX3hKCt44OZ8uD2+JnG38J+GQaDpmnuNZH5KIvkXlFsu/4jM5aAnC2AjqF0lsJdmmVhCDoxr6Wj4/+oTkQ9SZiUnfkLktxZsEu93soxQ0rYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WmAImbQO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ufmL1F9j89Me952zqGsf7M3WE4S+gVmrururGD8UdSU=;
	t=1746816001; x=1748025601; b=WmAImbQOpUoexebyckMwo+varKDaZs05PEdWmC5JNgUcQOk
	NZQwkzY+K97pj+rbjlW7vQSLQ08pZJs/ha6+cuInfPxPHC2SCdIPWEBcY1n3EsuZYX5wkU2PEWWVZ
	uIgt2ChpMdKcaeSlQJvl5agGWXO/jYyaA5q3zaEtFBKBz+Q0bdoWnuoANJ+ghGx7+Y7FomRgtrAMY
	GYIXK05B0/UMZG6KT8cIGgiMRlr2j45YOxN9/Hh/NRVUqNzFhb0MfAk66a2ccvLSO+0hTruXd0a4V
	Xm+7guOLwnHQMpMjVvRbSnKDoPaOiwymDP3wma6mYpk5n1Lzhu/ki7nvascv21xg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uDSdZ-0000000EBo6-38MN;
	Fri, 09 May 2025 20:39:57 +0200
Message-ID: <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>, James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
Date: Fri, 09 May 2025 20:39:57 +0200
In-Reply-To: <aB4hMsBfyawYatoj@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-09 at 17:37 +0200, Jan Hendrik Farr wrote:
> > Yep that's it. At least we can take that out of the equation.
> >=20
> > And yes, in the PCAP I do see the confirm's being sent but no ACK. We'l=
l
> > have to wait for an iwlwifi person to chime in. I suspect we'll need so=
me
> > iwlwifi debugging enabled to see if the confirm was received at some le=
vel
> > in the driver and dropped, or never received at all.
>=20
> I have captured and attached a trace collected using:
>=20
> trace-cmd record -e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg
>=20
> At the start of the trace iwd is shutdown. I start it and force it to
> connect to a 6ghz network. There should be at least two failed
> connections.

I think it tries to connect to a 5 GHz network first.

Could you do trace and sniffer at the same time? According to the trace
there was no authentication frame from the AP. In the sniffer capture it
_is_ there, of course, but I'd like to look at the timing.

johannes

