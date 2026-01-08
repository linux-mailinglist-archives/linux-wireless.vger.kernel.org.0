Return-Path: <linux-wireless+bounces-30537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9059BD03A2C
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4709E300A28C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109E4946E8;
	Thu,  8 Jan 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BlsdYqXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32D4946D5;
	Thu,  8 Jan 2026 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868174; cv=none; b=SGlO//zxuFE6hYDvjDK6luJ0kfJcJwgiUVjNtVTQo5kGrvpVGlN7LHjWiMoLfV9BPMr1kCUMC3ToZ4a5Ndp6QV3JOsIthbHxyeXSqhY3+nA6XqjeitbX6Mqdfv3WPqBEz+GIjNvs0KdM/q72VHCZyPJsg9677vN32H355AZIw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868174; c=relaxed/simple;
	bh=AXctEuFPJmwtfPkOGcjf6qdNvy0D6p0Yp9XAj4v3PIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAk6InOA6BtTD9xC8cmRR5nV0HE89KzdW2TZfJHoxVA9qr1cyGr2TnjIIiDBUxmK6ZoXxl/5HRFQ4r2U0U1GDSB006qMn/HoqFOZQlvmL0HHKWzrmm+hsZ9RB+YlApwUqiwavfr3cfUqhm0ilHzlm52kEr7rqERpptIc9P44Blg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BlsdYqXu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+mlgkDdxt+nLlgqbNNOfBYZnSsAXsni0ZJONjFdvqAg=;
	t=1767868172; x=1769077772; b=BlsdYqXu3+gfjJLz4llkfwfGWRfCyOr+/QgD3M86EGd33t2
	248ORSG5Gk25fGxG8kFUcaT72Rdh+/PMXv2MwBIt6mKcWoKS4SvbbFO9GVCSlGB2mDf+jOwbGeWc+
	i3HVxbGIpDJxSJO5nHogArx3FHr371rZJoziPMm3qXHTnK7knvcniMHFg1PXIv5GqeI9JsDKsNrnS
	Ia4k6AnXi+E7snnzKQtRLjK9FuY9/0j/BwWOXVdE2bQAR1k3rcmm+1knbN/wgPZbbwKph1WNapqzH
	eL1RIm5BT0yJo3CZ7KK/7U5e8aRVyR7mU+mjKpwgUNSqLDc4ulw610Cic2qxCbwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdnGe-00000006Rcf-3716;
	Thu, 08 Jan 2026 11:29:24 +0100
Message-ID: <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com,
 syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Date: Thu, 08 Jan 2026 11:29:23 +0100
In-Reply-To: <20260108101927.857582-1-edumazet@google.com> (sfid-20260108_112630_391137_9C1D2E9D)
References: <20260108101927.857582-1-edumazet@google.com>
	 (sfid-20260108_112630_391137_9C1D2E9D)
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

On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> struct iw_point has a 32bit hole on 64bit arches.
>=20
> struct iw_point {
>   void __user   *pointer;       /* Pointer to the data  (in user space) *=
/
>   __u16         length;         /* number of fields or size in bytes */
>   __u16         flags;          /* Optional params */
> };
>=20
> Make sure to zero the structure to avoid dislosing 32bits of kernel data
> to user space.

Heh, wow. Talk about old code.

> Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
> https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google.c=
om/T/#u

Was that intentionally without Link: or some other tag?

johannes

