Return-Path: <linux-wireless+bounces-20996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F91A763D8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA0C167EAF
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413321DE3D6;
	Mon, 31 Mar 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FTJp0gU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5C1DE2DE
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415750; cv=none; b=AxBvYtgVM/HfoSPQKR8rRJ4rJYQ2GUg0R6uNRLiT9IYeP0Coh+o0ESNXnES9KDv01rTl/SGArgZbfMzBy7fFUxSyV8Laoh2HoI0tZcs4hF5Sc2kRLsniGFdODdk3HeJLmzA/hF3Qx/Eblqd05YePQo+QzYomwUDY3pVQrMKc2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415750; c=relaxed/simple;
	bh=Ykj5H+1hK0jl6T6+etm2b8PIdc5scBZynweZ786e6lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFAlIo+BlD4mKwBDY5OlrPaVbFeUHMgG37xhlMCvQ/x0/y9uHhJVi0A9vyXPI030x/DrzQkFJzo0xyVPXEMvkX89gtmnBXv3r32g8E48c827z37tut4IkxC9ky5PODHO8WAYNqQ5hNLi5yVi6esp4Kpp61mexlWuXX7Vy+mdHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FTJp0gU3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pNOxqJPY/YHWbLO2RHaiqSmt9tX5hxrtpOUoQm6ztDU=;
	t=1743415748; x=1744625348; b=FTJp0gU3wjBwYubdj6FFR6evZUrpxTn5zaDin3aa2gNZFRg
	1VR4pAWXXZq0plu6ZR6db3RU2NP1auIHtu3zW/Hr/EZc+hfLKPUKA/WfWbnk67Gq0TYi6/P47bN18
	SchRznxAenEvJRjlb1sRnWzfle/hJsKCJKf/BjWQBdYGcUfHsdS4lQRPhSmTBcuICLNTS6aQj+4Jp
	pHmzm+b8kDiKIHmkBh1qmMCf+z9UcRsJmDeVzIbYyGSIwPailGyvqEMQmR8aJ+WGQ/0hMDXbR+9e4
	1G08NLq3iZ+b2cek27GmXMJiejb6Lp80Kv1Okl2uCWbxH0r5lolVRnnDPcNESP+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzBna-0000000B8Kn-3SWD;
	Mon, 31 Mar 2025 11:51:19 +0200
Message-ID: <bb2c561c7b849dcf9c129520a28f8d5667e5bd8e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7925: add EHT preamble puncturing
From: Johannes Berg <johannes@sipsolutions.net>
To: Allan Wang <allan.wang@mediatek.com>, nbd@nbd.name, lorenzo@kernel.org
Cc: deren.wu@mediatek.com, mingyen.hsieh@mediatek.com,
 Sean.Wang@mediatek.com, 	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
 Michael.Lo@mediatek.com, 	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
 robin.chiu@mediatek.com, 	ch.yeh@mediatek.com, posh.sun@mediatek.com,
 Quan.Zhou@mediatek.com, 	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, 	linux-mediatek@lists.infradead.org
Date: Mon, 31 Mar 2025 11:51:17 +0200
In-Reply-To: <20250331091747.2592021-1-allan.wang@mediatek.com>
References: <20250331091747.2592021-1-allan.wang@mediatek.com>
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

Was just idly wondering what you were doing and it's your driver and
all, but ...

On Mon, 2025-03-31 at 17:17 +0800, Allan Wang wrote:
>=20
> +	req->is_eth_dscb_present =3D chandef->punctured ? 1 : 0;
> +	req->eht_dis_sub_chan_bitmap =3D chandef->punctured;

That can't be right?

johannes

