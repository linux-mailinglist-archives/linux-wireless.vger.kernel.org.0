Return-Path: <linux-wireless+bounces-3851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32EF85D531
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4409CB210C1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8833D981;
	Wed, 21 Feb 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PrY0ENqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607583D561
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510101; cv=none; b=IR84pWzFxkD639UwwPw5yWTnF0BGeKIdOg/pgoazrJ8adzIpVvf87g9szofJfI1EHz2kIdf+rlLz6j3jrQ28s94dICt2sjTwNQck/u110/vpRlmv4apk4ek2W25ZPKVD09FXFXlgc7GJKGvnqSpLA3aYKnMB2+V22DakYrl3W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510101; c=relaxed/simple;
	bh=3DLuXIEaqBMqcrfsugE3bvxFwf+7lmYD3G1a+3TGK3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCfpsDfGb8IWKJmE42IhLDkd26D+DAu8udYtp32Ow4YJWlUKdHtYCriPhcx3jHsqyQPXnSxtRzblQAqw3DxRHXrxNqVfr/XMFFHGG+N00e9wFstrVwxlC+DRJaYKS2Lfk3glfjMMELGMXi0F4PXZCIxtsqHAQZCUwn0UMfiTekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PrY0ENqI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3DLuXIEaqBMqcrfsugE3bvxFwf+7lmYD3G1a+3TGK3M=;
	t=1708510099; x=1709719699; b=PrY0ENqIpPoDuqbgoKmeQxLZhV+/yMbCFgT4WAxDq7IgS4x
	4s7McI+1ZKxQIshzVyCqFGiKHLf/7hIBK5WNfbFZ1sihyy89pokc+bJyuLgZAo6/IyPbEXoArZtGx
	tj+amrCY2f8dt5PLTMKdr98BnWk9dEO7GaZA8hEKs8aT7yCtXT5giVxCwycQWPNbQ13Y/gym55EXP
	12nol/aT6fxWCcGIRBDGjvkk1bQIhFNsw1+XqBCc4LvCwpMTU9TMY1aTGAZWTEFTO2cmY2vGBIRX6
	zzLYRLDJ+4VjPj2O+AFucKyLO78SVLH9gYr+zwXBMMV/hocFv5O7vchbvJ3I9TOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcjWR-00000002Aev-1kgg;
	Wed, 21 Feb 2024 11:08:15 +0100
Message-ID: <83af2d42df024032d1bd1c200c774b7ef10f1705.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA
 test case
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 Feb 2024 11:08:14 +0100
In-Reply-To: <20240216144621.514385-1-quic_adisi@quicinc.com>
References: <20240216144621.514385-1-quic_adisi@quicinc.com>
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

Hi Aditya,

> Recently MLO CSA is enabled on the stack. Add test infra support in
> mac80211_hwsim in order to support basic MLO CSA test case.
>=20

Can't apply this right now as we're pushing wireless-next up to net-
next, but looks fine to me. I'll probably drop a 'return -EINVAL' on the
warning case, but no need to resend for that.

I also wanted to ask though if this needed any hostapd changes?

And I guess for real multi-link we need the CSA update things we've been
discussing, I'm guessing you're not going to want to work on that in
either hostapd or kernel since the ath12k firmware handles it all,
right?

Thanks,
johannes

