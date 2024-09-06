Return-Path: <linux-wireless+bounces-12596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBCF96F3B6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA1B26221
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1A1CBE82;
	Fri,  6 Sep 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RJVWJl1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4317C9B;
	Fri,  6 Sep 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623671; cv=none; b=Xr83EvDIC71BC6DQiTCfOkSWqsFlvx7sbdqr6G9JCZfmVK8tpZF99Zd6bVVq7UliwmoHjMFRJYJ8z+uIVnCeAUx2fbffqZZiyRgtKC2x5KteF32WtM9M+l4MNh2M/+vH8PPJYMslJND0pR+EvlIZAh4EEeD4viqcFI87N8LGt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623671; c=relaxed/simple;
	bh=DH9K55Kya4maLwmGGYmVVeSg1a2KAD998l95BnomRcM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPrSUhOn23QsRQcASXONJ5fXAdABjNCQRR79DmZQw3HMh25AaQx+OFOAEhpPcDMpYRMDkzZcAVYgAe6cg9NZIzUiIUcBLSfTX9X14b43g7VI/jVeywq7YZwFGfhhlt5e2qzTSB6UElD1AIQ68Avg1K7onIU5Xxz2gjEkCqGvkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RJVWJl1n; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DH9K55Kya4maLwmGGYmVVeSg1a2KAD998l95BnomRcM=;
	t=1725623669; x=1726833269; b=RJVWJl1nw3YmBCkzhCC+tCi5bN6gNtDqfkr30muArwXUhG6
	e+rAMn7hB3lUETctfsdyqVNrd5VopnvCNbU57bRTBRkM5qH6+0uzlO/qq6J7m5oiMab0R4dpgLpku
	LxEwGqsFgi5mR2zBRG0eyJInVQimqRxqupQtft7QO263ldrkVNomp4Jr+GObiyhZA+DYq5UMTEL8u
	PLwldNWYUNFcPLNd/hk7PKs6SJCboth0SBqUTAgrPx1t2NeWUJJkyYxzjLXoc0A1r2Gl11Rt9AiZy
	0TlmDGz2Y3TCBHp6EudyKC6/lH8+4d7rpIE4Zlw2sBkSbwwACv1mSHZve4rWUfoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1smXXe-0000000A4Dh-0Dik;
	Fri, 06 Sep 2024 13:54:18 +0200
Message-ID: <3a907615d3c32c8af08a0c70b5bc008cfe910eda.camel@sipsolutions.net>
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
From: Johannes Berg <johannes@sipsolutions.net>
To: Rohit Chavan <roheetchavan@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 13:54:17 +0200
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-09-06 at 17:14 +0530, Rohit Chavan wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
>=20

What? Why? What's the point?

johannes

