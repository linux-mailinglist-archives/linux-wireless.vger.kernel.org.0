Return-Path: <linux-wireless+bounces-16295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900129EE141
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C8E1621F0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD020C499;
	Thu, 12 Dec 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xzps2kEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D920C48B;
	Thu, 12 Dec 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992143; cv=none; b=JOwsRSea3903NFuXyRXYhSCQJ/wQ6FFe7KLeluZdv8iIxukWbTe+7FGLBi6wmhtvd2pvqdZLJg+mOntIf8uwbGamXVxjt7SbQH93Di7HEiPHlTUVE37/eiPuo4xzoiTcKGZcUV3mnnjQVDMz4xDavRPD/XBEmPttdFn/afCmsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992143; c=relaxed/simple;
	bh=YjRGGlIppSi8DnkcherZr7bx8xNkh8MCPS7D2+iT4kc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBcruIY2t7hfPu0nHf+xWSMMLcVZwc8iSGutzRJnGgSmfg+k/iFQp6/AcR7A62hHWw4Uh3j2KZEf5s3+Ja0Y7yUDp0GgoiSLXHQDzyRoRa+rsv2S8inXnj6h2h5NF67RGHbr0JeisABb/sgLKlV4jzj8HwX403ilPsdG1LQPgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xzps2kEz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YjRGGlIppSi8DnkcherZr7bx8xNkh8MCPS7D2+iT4kc=;
	t=1733992141; x=1735201741; b=Xzps2kEzx2L1umyfohgFOC4M7EtQ1FlynLgERIzb5ZVipgo
	y8ZyJCJq6WkVu7bbJzjeWsZj5a4yoWiToJh4iaWnAsBCKn/7LK4w2aiT9S9xOT3aOs6DIt5v32+PR
	RAg27/+y2nfdG157DY3OoyhUGBHWrxtZPZFjbNQNSc3FlFHCwKAdx2Awht7TCo/KwNVubOg0JWUhN
	RtjcKNO7ZkDaq8Tre1rytQjoQoNX421Bm0rv9WzGrIg0MGD3Hphxgef+MPFE1GsZa4pAzSlxEW4aV
	Cuh4jdhmLpuJgRSEndEKAvlsaI+G0irbXrDIPDMZvsJeOR3NypFq/DvrzvsaXdTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tLeZ3-0000000EM2Q-0bHh;
	Thu, 12 Dec 2024 09:28:53 +0100
Message-ID: <bb26c5bc9f6c3fd35351b9f9d170ada583d9964d.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: cfg80211: simplify
 cfg80211_mlme_register_mgmt()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, 	linux-hardening@vger.kernel.org,
 linux-wireless@vger.kernel.org
Date: Thu, 12 Dec 2024 09:28:52 +0100
In-Reply-To: <20241210143951.5685-2-dmantipov@yandex.ru>
References: <20241210143951.5685-1-dmantipov@yandex.ru>
	 <20241210143951.5685-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-10 at 17:39 +0300, Dmitry Antipov wrote:
> Simplify 'cfg80211_mlme_register_mgmt()' to allocate an instance of
> 'struct cfg80211_mgmt_registration' only if the latter is really
> needed=C2=A0

This part is very much broken, and I don't see that it's actually useful
to add a new "goto" just for the (unlikely) case of not needing the
allocation.

> (i.e. when the list of registrations should be updated)
> and prefer 'kmalloc()' over 'kzalloc()' since all of the members
> are explicitly initialized.

This part I disagree with, who knows what we might add. This isn't a
path where we might possibly care about the cost of zeroing, vs. the
added maintenance requirement.

johannes

