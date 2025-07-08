Return-Path: <linux-wireless+bounces-24969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF72AFD5A3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494094A5C75
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CE6FB9;
	Tue,  8 Jul 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L6L8LurX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79F2E5406
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996947; cv=none; b=HwX6URdGeQiC6plbMjZ782Cni4atRuE5o0I2SvTL9WkNM8gRuUoeCEOOP0ccczUEeXgK9HtXn+U1BNpkS7Ni1Zn8Cs2jupkyAAPdeGDyp7kGA1jkvDi8Rzl5EZpPonwBwmrrMRF9xgLMtAOe1NSKqzGfIBR//ahhBGnbBplUZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996947; c=relaxed/simple;
	bh=h74gVXhR2GPzo+6bu2MWjkOZewX9BDgsrIV0Rsm+72s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j0uaXLGw0thDPDOXscpb6T2/nR7kct2rdz0Zxavxj0VjSvusPG/B8gKGdGtqrfTRkWEj52fVbQNW+XmS/NO8H7ZOoeKQJYoYKdQR3qtWfostFzlajNfMVd7q46PPUy0QnZqUOUZsVj1iX02XnoVp5I4BeUCT1PE02Ao/Sg5jv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L6L8LurX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EVy4EmSBwNqt5XjI+hXUC2y3O8boq5xkdIc5EPRnWKk=;
	t=1751996946; x=1753206546; b=L6L8LurXGh1ZKApbaQVBFMTlyF9ooCCIxGvVkbyh987VI0X
	bDUhEtgWY2UK8BvDObTMfmjatl0qaSO59q0dBdVjosYNfELofMfs/bZmYYIgUaBOpgxPi3Deim1UX
	gwYH+X6lWUUXvrfNrmCSyIQA6p2GtieWP81DensRihDL9NXjT6eqCbNrpu2kputjxGfU/VrZTQShz
	xH3tYLlB1fHAIyRr9btbqJB+iQUxxBKSWIBI6AXn6nAHMj5dvgVpCr6HetZqpGIv79dsAgD4lHI/K
	9nszSNxidLu7wELVQfZxyK3LARU62YYMC+F7b8PJi2+eyEUF6kA7RIQ3IqKMw40Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZCRD-0000000C9m6-29TM;
	Tue, 08 Jul 2025 19:49:03 +0200
Message-ID: <6b32e05fb9ad731c4bc950c2040904414fc506b4.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 19:49:02 +0200
In-Reply-To: <1ce17d3b-90cc-c0d0-6146-bcd5de0c5ba9@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
	 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
	 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
	 <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
	 <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
	 <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
	 <9161a3ba-e5b7-4cbf-ae1e-242e1baf5040@candelatech.com>
	 <b1d4ec44d7ce817ffb98db7293578c6a9b1351fe.camel@sipsolutions.net>
	 <1ce17d3b-90cc-c0d0-6146-bcd5de0c5ba9@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-08 at 10:32 -0700, Ben Greear wrote:
>=20
> I feel we are not communicating well at all

Clearly.

>  and that your complaint about
> the patch is without technical merit.

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es
[...]
"Solve only one problem per patch."


Anyway, yeah, let's just take a break. I'll stop reviewing your patches,
maybe someone else will be motivated to have this discussion with you.

johannes

