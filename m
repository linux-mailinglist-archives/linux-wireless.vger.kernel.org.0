Return-Path: <linux-wireless+bounces-27002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3FB437BA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6E3B1D01
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0A2F60DD;
	Thu,  4 Sep 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fCs/Lvoj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD32D12E3
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979923; cv=none; b=O9n6HyYy7OWMiG2yzQPiuz+D9amufSDxJaAoupxhpzHLZbfN1QAovqKdeGAcQ4YOxtLsmI4qFgwTl3pRVea/7kQziEB0A65OERlmy3hlSUI1QF620++F7DlSrP1q5QgcwGAyWlnZs96TAHSiNJYBlY3PPZsY00nXOKuOA4KtHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979923; c=relaxed/simple;
	bh=6pJbKPp0RV9xRwbPhJm/R90vkNPUFnyKZn4K9ZdJvO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLWc/mu/cOuv5O8PlJPiWbsX4Qam156Q9b/rtRj9114aB8c5rSmzJ+mUD5pgd3n+a2tlQcrWqAgUHihnG4F53K72zfKzOH3q6G/M+aU42Zr+ZhKYer98u7GC5iW+DM3f+IQC/lkt+E3TGlkQMPMj9kjHoIxlDs0lDe7fFO30CTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fCs/Lvoj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r6QVmDYan9jQCwzg/fbX2Wh+ZKncbhIOrcbTvb2FWSc=;
	t=1756979921; x=1758189521; b=fCs/LvojtO7n8yw4EMiKFfvnlTYK4nQIWzNfBJ9jVNfOGpa
	DJ6JEN5kLyohFkuRzVXqEwwU4S/qxOkJLGyq47HOmE7BAbf5s5QZKoMDIrKO9m8v40h0kz2qjv6S2
	o3JPAh3Hc2aKRc1RvlfkmSBn3RMXimUiiV1tzGORj0kHlD7iCuIgRGLUwjj0oAkbJyLHxA567Kbc/
	rrmDyVlNGpfMFlHiyi0Y+BD8Gs4B26kRV6fOZSycJheJeKI2Jy+UpYF1VBKpMemA481ewPnc011pW
	Kon7eAujhHQskPPMKkvdydEZWkYEW/PYVNE+GKiPpFdH1Mvhh1ZN6OQ22cUge48g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu6ji-0000000DyFw-1o1w;
	Thu, 04 Sep 2025 11:58:35 +0200
Message-ID: <83b5c2e55c7ad55851b9877c5c085a57b6414ad9.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: add support to handle
 incumbent signal detected event from mac80211/driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>
Date: Thu, 04 Sep 2025 11:58:30 +0200
In-Reply-To: <20250818101947.2464612-2-quic_amitajit@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
	 <20250818101947.2464612-2-quic_amitajit@quicinc.com>
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

On Mon, 2025-08-18 at 15:49 +0530, Amith A wrote:
>=20
> + * @NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP: u32 attribute spe=
cifying
> + *	the signal interference bitmap detected on the operating bandwidth fo=
r
> + *	%NL80211_CMD_INCUMBENT_SIGNAL_DETECT. Each bit represents a 20 MHz
> + *	segment, lowest bit corresponds to the lowest 20 MHz segment, in the
> + *	operating bandwidth where the interference is detected.

I think you should clarify how this interacts with puncturing.

Are disabled subchannels not considered part of the chandef, so if e.g.
you have an 80 MHz channel with one disabled subchannel, only the lowest
_three_ bits are taken into account, rather than the usual four for an
80 MHz chandef?

Or, perhaps more easily, are disabled subchannels part of the bitmap and
then must be zero since there cannot be incumbent signal on them that
matters, since we don't even use them? Should the code perhaps then
check that those bits are indeed zero?

Or something else entirely?

johannes

