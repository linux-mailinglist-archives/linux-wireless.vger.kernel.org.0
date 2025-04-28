Return-Path: <linux-wireless+bounces-22121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A6A9E9B0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 09:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740AA7AD7D0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F41FDE02;
	Mon, 28 Apr 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cABUYaGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097E1C5D4E;
	Mon, 28 Apr 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826079; cv=none; b=VJ5XTg88AF2xAkMMfStL6TUY2w4ElhQE7MiOR7iRqa3WV7DUHbrYt8itc1Vv33/HRZA8HiTqQatMYGahNMnbK8WPf92luGG1nxZB+BxiinWpzNi34gHxBpganXhx/DxcDcg2AlbwBBck+VOeWh6hj3MPDzkWErV++C2udbE4bFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826079; c=relaxed/simple;
	bh=X6Gnc3UJtlUln/zoa3xj6s9DqpYSLwTzq+n2L2kMjE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kjRFvB6bvO4rPXi4gaCBzz7v7qDyfkfLLs1M0RPo+TQXUBvjBhg4lppDO47DgMJKilRTZeW2cKs54IKoigJyoRLxEPKC8jruXQ/X7p0sUwQ15CJpBUAHr/LnVo9l4PbnwZ9cY6ldYOfSTbi3mhtjUDFGWBQfdiM344P3RqcB8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cABUYaGX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X6Gnc3UJtlUln/zoa3xj6s9DqpYSLwTzq+n2L2kMjE8=;
	t=1745826072; x=1747035672; b=cABUYaGXYByaZPfDkKyDRopXVCezuncVkosND/bzJ8wWicS
	dsPj6XFT0u8DE650ZOpWICoO/rvDrVYZi5u2hGeJa3GraWCxS4nxthYNK/fxxDa/S/fE4irwFUh/o
	UdxGsCtEZD34aJxlXoF28f7f7Ba7yqolmgU50VuMT3Y2DfZA+TMAP4Dv/JtUPo2DFlKBHjf7SFaCK
	7cdfW0DMfNqBhJ0kqq/o4AsC05GF/YIYQvN2VR8Y6SfR7jDYIW1283iZ7XBWndg0XA3EnFm9xmt69
	h+Re/Be5GkxdsJQJ63uHSfU5m2Pm10cUiDtDyqVqSaeltnGfaDYi7D2AekpR/vRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u9J6z-000000097xB-1djE;
	Mon, 28 Apr 2025 09:41:09 +0200
Message-ID: <ca3dc0f08de0f7ba251e7e481c3a9c107a2bde0c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 28 Apr 2025 09:41:08 +0200
In-Reply-To: <CAL+tcoBSj_ddXkee9q9Yr_GUTEAVHprBC-JNEAJZiJZP-+324g@mail.gmail.com>
References: 
	<20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
	 <CAL+tcoBSj_ddXkee9q9Yr_GUTEAVHprBC-JNEAJZiJZP-+324g@mail.gmail.com>
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

On Sun, 2025-04-27 at 07:55 +0800, Jason Xing wrote:
> Hi Johannes,
>=20
> On Thu, Mar 13, 2025 at 9:01=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Someone mentioned today at netdevconf that we've run out of
> > tx_flags in the skb_shinfo(). Gain one bit back by removing
> > the wifi bit. We should be able to do that because the only
> > userspace application for it (hostapd) doesn't change the
> > setting on the socket, it just uses different sockets, and
> > normally doesn't even use this any more, sending the frames
> > over nl80211 instead.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Do you have plans to repost it recently in net-next? I'm going to
> implement the rx path for BFP timestamping based on this patch :)

Oh since everyone seemed in favour I actually just put it in my tree.
Will be part of the wireless-next pull request when I send it soon.

johannes

