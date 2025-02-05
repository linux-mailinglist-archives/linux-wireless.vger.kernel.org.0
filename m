Return-Path: <linux-wireless+bounces-18491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A287AA28559
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA067A229C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54224229B2F;
	Wed,  5 Feb 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aRYFWaIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85788229B29
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743238; cv=none; b=dT+U77mV8Y+dttx8VCmlwxAdUWXYwXgpilSe1wvcMJG/jeYFQthNkNVdm3OtxsRqRUVS7XD/alp7cebt3NaiAGBYOomKXi/7gJGEmCGkFws0QqRO2xdILtj/EW13QuDTRgHplmdYizLO0VImPtPnWon+Q+k88QpYz5f/VtsEpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743238; c=relaxed/simple;
	bh=Dm86s1+Wicwtcq9O0AWdjJbNbNx+Zc3BXqSz2iMKbyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGPUUKHwILi3zxJBmScWg1Dhp7BcT/OE8+jYTqMFHm8NCcZhV/qsgNGsX/hcHRmyiCu+aFZqgEiEg1Jki1IKa68EcriGRkrQNrAUJX8/s2LI5K8oFgYyU25Mgc7ciN3o9GeJ60DeEvUTjJnz1o3W/UkyFMlmP1bX44AHj2LC+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aRYFWaIk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xhM6OTAnkMBLygr6hmksES12Ta6K/q45+lv8gfI5H34=;
	t=1738743236; x=1739952836; b=aRYFWaIkpDZciWxw3GfxtD//2O0n+2xgs7IXU8JV88Yp7ZI
	Vx/6UuCQR4cdmRBioQUzOhXv3qL2EdZVtfapJGiJ6WObKIqFH8Oy/wO3aeBvRDKgpdrWtYWEUWEBL
	bLUbPiJ3X3VmXxs1WvTxkS+XZG7LTX++j8KyOmLuluiVZv+5IbadpGPx3TSzRNET5jnXpOMw/xG1F
	hFsaz7tHaqMg3BkhTJrltV7ieWTe/AyS7Z9P73z6l22Chitouvw/Zy6BgzSYUsqDfAJguNCj/llDi
	kCSyDklbXh54tKgKCW0E6PLxI0VFVcl5/8LUOvNDjhOM+Z047kvI0/2p+okMTQPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfaXR-00000003hyu-3FNn;
	Wed, 05 Feb 2025 09:13:38 +0100
Message-ID: <60fc3088542ca84a6cc2c32991f8192b60b08530.camel@sipsolutions.net>
Subject: Re: [PATCH 00/20] wifi: mac80211/cfg80211: updates - 2025-02-04
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 05 Feb 2025 09:13:34 +0100
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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

On Tue, 2025-02-04 at 19:41 +0200, Miri Korenblit wrote:
> Hi,
>=20
> This series contains a few features
> (EPCS, strict mode) cleanups and bugfixes.

Yeah, that should be split.

>   wifi: cfg80211: Fix trace print for removed links
>   wifi: mac80211: fix MLE non-inheritance parsing
>   wifi: mac80211: fix vendor-specific inheritance

Seems like these should go to wireless? Also seems like the first one
should have a Fixes: tag?

>   wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
>   wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()

Perhaps these too? Not sure though, maybe not really since the problem
is really old and nothing cared until now.

>   wifi: mac80211: don't queue sdata::work for a non-running sdata
>   wifi: mac80211: ensure sdata->work is canceled before initialized.

And maybe these?

> wifi: mac80211: add HT and VHT basic set verification

Seems like that needs an adjusted commit message after all our changes
to the commit with strict etc.

johannes


