Return-Path: <linux-wireless+bounces-28625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EFC3657F
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D01A26E6B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1442336ED1;
	Wed,  5 Nov 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nyG6B6bi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73A331A78;
	Wed,  5 Nov 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355856; cv=none; b=V00CSUkQr0H4twbtiH1nVYKN/kWzB49gMpl+zYV6Mq6ENp2kJt7KWt8ucczIBM99oPs7kZ80Szew611lhrue4o7IvOyxgP5yOwyV269PCbjl4qAG52dTw7D6g29ba+Jb9fMYFBUdahSiY2UinAqKgfdMrkFtEkU5CHb/Rxq8SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355856; c=relaxed/simple;
	bh=K5iaoQEKz/o4zms9Kr7FKaUEi9heCgc1KWqtMtMA/lE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LA2xwI3CxIDKYXo5cTPwsTq9N+JDgUfnp/XPTf48srQn+6t7npyd40rVvBBEIEAzvs7jQjxSdvmQ4iPp5d7pabw//cK/sSxIT2hu3NRlYkA0E/ah8pmVPW4s0btwDksMmh1PLIIChvonrQt64Pjd8qjwnk2NkglQTWycjtmh+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nyG6B6bi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k36qJsWOKynkgtj8i9oEs1iXLy+s8j18nvPV2TKncW8=;
	t=1762355855; x=1763565455; b=nyG6B6bix3QamAuX7aSq+ZTyJqNsgVXgV4Y04i0pdnG2iD2
	mdoK0XbvfsJMHGiKU7TEqG3CV8lePWhYmNaZfjAV8KC6fkaj8uKWS8YEcC6w51bKLu0p7XLATmZIB
	UFl/+e0gnhpMFl2pvU1IRpNqdxQTjRPVDCyu2vpPGPraE8Pdkg+HfAcbUwqr1atTOgfo35icx7D4A
	TjO/Kf2SbZIbAHqcKUb9YI3myp5w0xU/pOHhTO6C/99mIA/NEbRQVgtk15iThJX8xP4VhnLeaY5vp
	tSqGHgNp0lOWNNs8ak8CuaKM7jZeYUOLFaG8t+DtfzWFUW2q3Wxiu4dST3BHwYRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGfGO-0000000FI1u-1z1l;
	Wed, 05 Nov 2025 16:17:33 +0100
Message-ID: <546543a04e7e06a822bb0dccc10227e614a59cb6.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: util: Fix uninitialized header access in
 cfg80211_classify8021d
From: Johannes Berg <johannes@sipsolutions.net>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 16:17:31 +0100
In-Reply-To: <20251103-fifth-v1-1-4a221737ddfe@gmail.com>
References: <20251103-fifth-v1-1-4a221737ddfe@gmail.com>
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

On Mon, 2025-11-03 at 00:02 +0530, Ranganath V N wrote:
> Fix an issue detected by  syzbot with KMSAN
> BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0
> net/wireless/util.c:1027
>=20
> The function accessed DSCP fields from IP and IPv6 headers without first
> verifying that sufficient header data was present in the skb. When a
> packet reaches this path, the header dereference could access
> uninitialized memory, as reported by KMSAN under fuzzing with syzkaller.
>=20
> Add explicit pskb_may_pull() checks for both IPv4 and IPv6 headers to
> ensure that the required header data is available before extracting the
> DSCP field. This prevents uninitialized memory reads while preserving
> existing behavior for valid packets
>=20
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link.Fixes the uninitialized
> header access.
>=20
> Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=3D878ddc3962f792e9af59
> Tested-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
> Fixes: b156579b1404 ("Treat IPv6 diffserv the same as IPv4 for 802.11e")

Commit: 6132cdec43a5 ("net: wireless: util: Fix uninitialized header
access in cfg80211_classify8021d")
	Fixes tag: Fixes: b156579b1404 ("Treat IPv6 diffserv the same as IPv4 for =
802.11e")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format=3D'Fixes: %h ("%s")'


Subject also needs to be adjusted.

johannes

