Return-Path: <linux-wireless+bounces-5459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B047189005D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B9B22C09
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D57FBCD;
	Thu, 28 Mar 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D2ArgLM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EF3032A
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633000; cv=none; b=ZkgZ7udH6If/Nz+9FKLb8YQqDGyQPIJWEbod0zzSFUz3yrLm/lWn7Px2VVwwPH0VJ2/rCn2mbhmtEtGUzAEN3W1az/nm+7JpZ58xt54qlRcq5bZhzVMb67Y85w3lkSwJPjx/jX8bAA61DR39ELwPYy6axtTUBaiSqpsbcW+9UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633000; c=relaxed/simple;
	bh=AXuKMfb1m8kUFUFM+0UkrmTwC52+lf77wR99khTZxqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTRgev3gJALdO7IWbbHuvE/ggCdp0ouhi211dCR/QM2Oip/cnwjsI0QSrPGIy7wkPQoguuOw6eqtIzAFzE/zXhhdp+RCnFM2JqOcQAOThL8h6P9g4XeipC8d92xzSgdZCVCFOwwNeqi6d+phS3tFscm9LROt+vrfUO+WnwLS9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D2ArgLM3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1Rm8OlYxC/AWjajIdqDA4wJmrZGXskO5TRemOf7OBDs=;
	t=1711632998; x=1712842598; b=D2ArgLM32AzcwsOaSnZE81zaEYSl4sNx5Wz7JXhfRyuO9qc
	fezGaiHgD4jM2oz/Wl0NfwghKOzQld7xfft3/DVs5UrXxOXEIhLsWiwXqrIEU3quppuSOIytjTvXz
	myrlaTDPhLGwS6yJenbsfflM6zwViJJYLXU+41lqvv8HN6c/kSvYh25/JDHB9Xf07qBbRrLstB9fI
	e8rB2nsvNYC4NX9Z5cJFdl7T/8/1yQpUgbXSv4l11Xn8OFE2BPpyuxHbi1zX87lUKbKGoNid3JwVy
	Q+TLS5rEiwCLcumLiYesyoosQipCSQM64RYvVwFjRbeIPsyXa9d59JTCOFnDy8Og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rppvn-000000010W6-3K0C;
	Thu, 28 Mar 2024 14:36:36 +0100
Message-ID: <8821e4fe9930560d19809390777451d631821f1f.camel@sipsolutions.net>
Subject: Re: [PATCH 07/13] wifi: cfg80211/mac80211: Refactor iface comb
 iterate callback for multi-hardware dev
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 14:36:34 +0100
In-Reply-To: <20240328072916.1164195-8-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-8-quic_periyasa@quicinc.com>
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

On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>=20
> +	int num_interfaces =3D 0, hw_chan_idx =3D -1;

No point in that new variable, just statically pass -1?

And this really is only a cfg80211 patch, with the API updates
propagated where needed, but we don't list all that in the subject.

johannes

