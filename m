Return-Path: <linux-wireless+bounces-28722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB27C456B4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DF6188B57A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965923BCE4;
	Mon, 10 Nov 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G9HyL4Nz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D12EBBB2
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764410; cv=none; b=CoIKY8oxsxyk6m/Y4l/8WThW2NLq4SYm06ydzrgHuqQmXaiGtiJQNmVM6okUgYbB/tOrxZwrxrC3WzOVc7cmyycTcwS4eOOvT7281JafSEBCKVaoInvDTL6h09BJDL/3bnwf1qa9B/cCW8PRWai/KMQxA+3R6ZNguuQcg2mJ8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764410; c=relaxed/simple;
	bh=M6+JC2cUtKr4kYocp+n07aeMrxS5ZJeLQgvN6AlkiO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jp2PGyP0PQCPAljfYH4Tm2/63dJps+ZG/6lqUDd0EUB4La5iPBT8qWcHEI5CtQT80Z6SkGxqLsgdktA8zx2yaJK7b9w3p+ucGb4ZuZzzekyz54jozvL8tKd8NTBhe+SbBhlbmXbdPQSAAJCB8tEpB+zTOfjKes9tiEVkOC6v7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G9HyL4Nz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1UEuF1BScwUbZXtfBOqlA+in72d87+vj/RTzp41kkbU=;
	t=1762764408; x=1763974008; b=G9HyL4NzAZZ7A8jPOLZgown5tgT69/G2zK0wz+4lZCgXnDF
	WlHCK5SkS5UI+bh5v3vBsfljOzYk7mdo177zjvD7/VlwzPaZZt/shPHKphNgF41Dj19eHe3kgDUkY
	ixyK3ISSZOVRWfVQPqAWlKxqwI+akzaTUuxpCjuLEd57FgWy9NZ5XYeyUS9Sym6/imniDX8jXNnS2
	HAU6Uf5cxl1Wodf7J+EYmXiNiU4qUJge+CWZSNZSCDxBPd9+jJHiqVuXpLJ0OAvLah90xX47Hw8ro
	UwMje+OqTNpm2yFjY5qJLkXx17RarINcLkpw6/9ZEU5v7sJBj6Ig9txBlc14RvEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vINXx-0000000B2CS-0p7p;
	Mon, 10 Nov 2025 09:46:45 +0100
Message-ID: <eeb4d8484a590d39590dbbd71d0924851115b0ac.camel@sipsolutions.net>
Subject: Re: [RFC v4 wireless-next 1/2] wifi: cfg80211: allow send/recv
 tagged EAPOLs
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Mon, 10 Nov 2025 09:46:44 +0100
In-Reply-To: <20251109193543.2858854-1-janusz.dziedzic@gmail.com> (sfid-20251109_203602_258603_216EF26E)
References: <20251109193543.2858854-1-janusz.dziedzic@gmail.com>
	 (sfid-20251109_203602_258603_216EF26E)
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

On Sun, 2025-11-09 at 20:35 +0100, Janusz Dziedzic wrote:
> Base on EasyMesh spec and traffic separation we have:
> "If a Multi-AP Agent configures a Primary VLAN ID, the Multi-AP Agent
> shall send EtherType 0x888E frames on a Wi-Fi link in a Multi-AP
> Profile-2 Network Segment with an 802.1Q C-Tag with VLAN ID equal
> to the Primary VLAN ID."
>=20
> Add option that extend current control port implementation when
> NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN used and allow to setup
> VLAN id for control port frames for both TX/RX direction.
>=20
> While easy mesh AP could serve both fronthaul + backhaul:
>=20
> RX accept EAPOL:
>  - with VLAN tag (backhaul STA) - strips tag, forwards to userspace
>  - without VLAN tag (regular client) forwards to userspace as-is
>=20
> TX (controlled by hostapd per-STA):
>  - For backhaul STA: hostapd sets NL80211_ATTR_VLAN_ID,
>    frame is tagged with Primary VLAN ID
>  - For regular client: hostapd omits NL80211_ATTR_VLAN_ID
>    frame sent without VLAN tag
>=20
> Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> ---
>=20

Having some indication what you changed between the versions would be
good, I barely remember older versions :)

I do note that on RX you document the "good" but not the "bad" case: the
VLAN tag should be stripped, but that means userspace cannot distinguish
if it was present, so I suppose the driver must drop frames that didn't
have it present? Then again in mac80211 you implement that both are
accepted, but then it seems userspace should know which one was tagged
or not?

johannes

