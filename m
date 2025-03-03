Return-Path: <linux-wireless+bounces-19697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F0A4BBE6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC5916E498
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB41EE7DC;
	Mon,  3 Mar 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dl+phk2Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9B1EDA04
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997240; cv=none; b=r0oMdgSKzWLqItpDdQn4MuqnU0czl9Vl+yp5cgO+HR7YPJJgnzxQDf+tQxs9wDhxHwwSg0GsGy9Y5fnr+ah9UjvWLRR5esLvECP+T2T727si5bv5dE5iSLwxrdH+eD2rqO425sb3kblcBXSD30uakl05W+eeIAaXc5g9jTRUfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997240; c=relaxed/simple;
	bh=XeFbnFcAK2zQyKLrv4wf5LagDM886IAczDHShwWuPdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ph38GJgZv3Ag/fnNqfKNhgSSdnW+PYAa77Hw8rXRDodK4pbio8KK+D0fVNrDFlSP+gJeW22VuoFlMCqgJ2UcLkyri4wad71gLAomeZyYhRnCCwl9Wl6CFHJtGSJTHzMMAc1/xfDZP1tVvHszp48VaFRPcdaMinUXtRaFpmpdpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dl+phk2Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XeFbnFcAK2zQyKLrv4wf5LagDM886IAczDHShwWuPdg=;
	t=1740997239; x=1742206839; b=dl+phk2YTJXuogHpktHkBTrreReFb1RoNdnH75/sC7x6fJi
	Uw6vkzYc3pI0JZLBQZQWfC1a3DZ2aQ66OR0cdVqzV/qiZLBPSA2cBdsl4RRRPLJY8EZU265A0dZ9t
	w0k1bFEeqxxtJdsc/Ghv4EnXzFrQ27LsNWPR7VYNINV5kkIAyhOAvkAHYi89b/SeTOipKiLQVKZpT
	rYNWV6xQ4KuweXDiRO1Sr9hxOyG55FzlUao0V36hlZvVq07/rotP7PIkj8JxHnxmnma12A79YnSb7
	ZnrG4rYI2OTDKF6jzCLezRI8qKQEz0xdwE6ImIbdKlZPQu5jqG/4LrcOTP0pRQ0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tp2uZ-0000000H666-2A1v;
	Mon, 03 Mar 2025 11:20:35 +0100
Message-ID: <2ed1cf759e1b8eed21cae42f856c1012dcdb59e9.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 03 Mar 2025 11:20:34 +0100
In-Reply-To: <28d36a7f-3408-4072-9857-8bd652260926@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
	 <a2bcb0b6507c843b13e0ef98d76727a76b53f129.camel@sipsolutions.net>
	 <28d36a7f-3408-4072-9857-8bd652260926@quicinc.com>
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

On Mon, 2025-03-03 at 15:48 +0530, Roopni Devanathan wrote:
> >=20
> > The order here also seems really odd? That basically means the driver
> > now needs to propagate it to all the radios, but you still have
> > different per-radio values at that point, that seems bad. You also
> > didn't even document any such assumptions.
>=20
> The idea is to maintain different variables for global RTS threshold and
> per-radio RTS threshold. Each time RTS threshold of a radio is getting
> changed, we are trying to update the RTS threshold for that radio alone. =
If
> global RTS threshold(rdev->wiphy.rts_threshold) is updated, we are trying=
 to
> change the RTS threshold of all radios. This is the reason we are assigni=
ng
> same value - rts_threshold, to all radios.
>=20

Sure, I get that, I just thought maybe it should be *before* calling the
driver, that way the driver can always access the per-radio thresholds
anyway, and just has to figure out whether to set all or not?

Then you have to roll back if it fails, but the driver doesn't have to
track it individually itself?

johannes

