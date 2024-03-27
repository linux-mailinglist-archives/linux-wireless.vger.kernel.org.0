Return-Path: <linux-wireless+bounces-5320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD188DB48
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211F329A483
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B63DABF2;
	Wed, 27 Mar 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qwOiM01O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4801C32
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535581; cv=none; b=ViVh+MXQmopyEPaCcjmkFvU+fXfHETCY0bnmoFp4u/phv/w/UXv99J8xgK1DhZuUJ0cAUVaQtj05XASBSuF1Xq5DFW9VvEvfYo1yU3T24cAGScML7lOQtpvAymzf45YpeFEA+RBVwvMPGOk7Y22id9n3jEUu2W4kHzmEb0Ts3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535581; c=relaxed/simple;
	bh=hJoWUkjdXDGunBBaPdo1Z+jEaLnPmlcOcciOy8yx4GI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=geV7L59lYbuuIWkWYVEDsdA0Giurx6jNiugAR8IRnFN2Au1Yq2xoqT4OCfbnNP6CDV4DY90JHpX3rdbx7LidTK8PyGsmR3O5tMPE5pITS7aWWfMVqkaKLw15H65jXbBx8xT/Wn+4X5CjCdTat+M+mtMe320L3YHH5hpqP2HILE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qwOiM01O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/vE/qKbFcsr453lP/nQUsxyq9xtcN9Hp1eXb/WHDqZg=;
	t=1711535578; x=1712745178; b=qwOiM01OpzZfSafN2pAgvWEjkQrIW3LiY6lQvRtZizsVsGe
	KKxxrKeaiWOQiX9FH6ID3Bp+88M7Z0ugB8FgpqAzT6nxA3PxyUJr/gcbw/HpBYTR3alxffAmHs2KU
	mfEaTcg1bIHR8OnHbs5nYXOHk1V3NT+poyJrt4jVscKAa/iW1wIAJwMR6EpfhbnFcHigwC130nLPC
	/RNeNUZFlgFX4quv5LL3YV3/OdkmnLGpgXMnWnFkogCGUePYbq4fyJ4UFfozCY7kc0nP/a9be7OsK
	B7J5Vq9iqIr1AjpnhUVIbXVS3AwYafYxV+HW21+cpDty5Zx60jQi3ztbIp+EUG/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpQaP-0000000H0PI-00ZZ;
	Wed, 27 Mar 2024 11:32:49 +0100
Message-ID: <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Hari Chandrakanthan <quic_haric@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 27 Mar 2024 11:32:48 +0100
In-Reply-To: <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
	 <20240319134522.4021062-2-quic_haric@quicinc.com>
	 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
	 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 15:39 +0530, Hari Chandrakanthan wrote:

> Fields such packet count, retries etc can be summed up for the MLD=20
> representation and the existing NL attribute can be used for exposing
> the summed up value.

I think the existing attributes can also be used for per-link STA?

I'm kind of imagining that - once we actually do all of this properly -
the representation in nl80211 would be something like


STA 00:00:00:00:00:00
 - TX bytes: 123456
 - RX bytes: 654321
 - signal avg: -60 dBm     // picking the best of all links?
 ...
 - LINK 00:00:00:00:00:01
    - link ID: 10
    - TX bytes: 100000
    - RX bytes: 600000
    - signal avg: -60 dBm
 - LINK 00:00:00:00:00:02
    - link ID: 11
    - TX bytes: 23456
    - RX bytes: 54321
    - signal avg: -70 dBm

etc.

> But there are fields such as signal avg, bitrate etc which cannot be=20
> summed up.

Right, but I guess we can pick 'best' for those, to at least have a
value? Or we could just not emit those attributes I guess, but not sure
if that's then all that useful?

> Should we expose such fields of each link STA through NL?

All of them, I guess?

I'm also imagining that we change the API from cfg80211 to the drivers
to get the *link* STA information, and do the summing up and/or "best"
selection there in cfg80211 itself. However, I am prepared to accept the
possibility that we may do _both_ in the API, if not all drivers can
even do all of the statistics per link. We should probably still have
the link STAs in the statistics in nl80211, but then they may not be
populated?

johannes

