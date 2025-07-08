Return-Path: <linux-wireless+bounces-24952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BFAFCE2A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE92D1AA4CD9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DD2E0402;
	Tue,  8 Jul 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tsH7Z2gn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CF2DC33F
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986003; cv=none; b=mfeyfjvSvTP6GR135Fb5MMbILU7KQAAmcq6yGvhI1OZaHDrp+hSZaGy9Z2i24u5Ybzb37R6Pd/YOahdZeDXEnhHU9mH5OYOZ8Fd7kH/IibTDT/ku71XrgiqobIbdsFWXncOzZKPJZPNEO7kRiOhCndKfnl+nbRqUcvJwVZMDjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986003; c=relaxed/simple;
	bh=LdOFD18Nwt0ejNuG+2TIKM+g5zs10jYK+o59KINlkiE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onxYtJSx5ewIabqsVV/VAybd06gXLWUCawpc7yAAtS6X9zvg5/1mlYq9wL01PFkro3AF8XlKpeSeOHTDVPd6itiHj9yvWs777x1XKdRRQQ0KqyMr1t+rn1EibpJqDDI5NbRfrSARo/4cSW+QpCoKUi+ur6GBVWibKIY31e/TL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tsH7Z2gn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LdOFD18Nwt0ejNuG+2TIKM+g5zs10jYK+o59KINlkiE=;
	t=1751986002; x=1753195602; b=tsH7Z2gn9FUYc6Sk4LK5LTabVDGv7jtfLR2aXmFHKq9Nsbj
	ZIrS5jkRrelQMXlhbOZsCye9fX73WbjUe17jaSvauGyp/KNnVbG+1IgBUo/bu8NGp2WBlwYa/giZ2
	k/e2bsPzMoSNU/+R62FcGJDBdSxIGIiU2Nj0x0QUwlmyHhoey171EJ1zjShHnpXqeS6OVZehN242D
	BDyKU0BYegOt/Zkuf3OUuKpaV10xaeNCvSHXVlP20JzdgluB/pbAEPB/8A81rxxtDaxE1vAB/IGGd
	Ppc73MiP5NIHJnhVFkw0vTX7OzoAbK9vv5Xh+XQQXL92MZ2Z7f4stQXE8QqpsXvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ9ah-0000000Bzj9-1PG2;
	Tue, 08 Jul 2025 16:46:39 +0200
Message-ID: <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 16:46:38 +0200
In-Reply-To: <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
	 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
	 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
	 <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
	 <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
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

On Tue, 2025-07-08 at 07:32 -0700, Ben Greear wrote:
>=20
>=20
> So I added new counters, and I wanted them named to indicate it is what i=
s reported by
> the driver, not something specified by the mac80211 stack.

I'm not sure what you're arguing. I know you did. I'm saying you
shouldn't have done it in this 1/3 patch, but rather in 3/3 or maybe
4/4...

johannes

