Return-Path: <linux-wireless+bounces-12165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60679627B5
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2104285743
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73513176259;
	Wed, 28 Aug 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IL/tdCc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF217BEBD
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849417; cv=none; b=jNecaRqa9vZ8ScF4TTHKQ/Ks5fYJxkA4y4R+aiyoS5prLbW1+PtdQuFmVn+EbNa2j4t+XWYYsY8JcJuI9TmDo4mG2CcefbnbV/GZlgQQH4A1pTT/geTW+msTxtOLzI5KhltG23ZTqcYL1M94+gCmPMeueJJLGEzj1HZZ+CpdW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849417; c=relaxed/simple;
	bh=cKhY9q81DBrkTS9eaFJw29GHmQ1H7WsfsC56dvcWLa0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvhWSQdUFz8IqX9w4HVAtK/dMHHXtZ79+z8ZfJy2oxy+QM3lCSEXhPv5PMfPQVGORXcl40/ne3lhWzo6W4r2HfxycPYFek+mLUcxF7gb812lM7k2VlGKFTfmP73g9he5P6PN+Y83z7lMjp1qGWGgb576maDxS9YfIaZ68IBp8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IL/tdCc5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q8ZDO/aFjSvjFmlFlPuwznqLCAgIs0LMpxVuAK3AHXE=;
	t=1724849416; x=1726059016; b=IL/tdCc5pxh+gYqIenDBNP1BDcrbudGnycIAN+bkFcgt0aa
	0WwumGc8gyPyt1Rk0647mAfYmsjEpTK7cVCYaeCLnCSKOhLN4LzwxiTU/bTfSGvJiLbyHOg+9bgij
	ABHDEIhSWPG+4fYmtbfwGHxBDztCFEXAnwMTBewINwoAbtMmOYQjLmBdsWewLqrEO4YsR2eBVp8I4
	Tk4XnGb6/nGxEiT6kfpiunlK2YpKPT+XobVi5SHkhV/iZDh/pFlPgR2Rjgux0lJE3FcX/+mwlPeSm
	EpGgBYzR+c+xUzGMWa3Bk7cMbO5oc7Tn4Uq61pDgsYXWcTNQrPU6WLY/IFZzv/+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjI7p-000000078sP-12d7;
	Wed, 28 Aug 2024 14:50:13 +0200
Message-ID: <fc7fd346ae0bf141385125c03410e428a972012f.camel@sipsolutions.net>
Subject: Re: Per MLO link TX stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Wed, 28 Aug 2024 14:50:12 +0200
In-Reply-To: <dd2c0158-775f-f876-6962-dba30d0bd16c@candelatech.com>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
	 <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
	 <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
	 <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
	 <41008ac0-ca36-b19f-c3a4-61f54ce2d2f7@candelatech.com>
	 <b00a52947670f45c0764d33ea093c90b825fcdab.camel@sipsolutions.net>
	 <dd2c0158-775f-f876-6962-dba30d0bd16c@candelatech.com>
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

On Tue, 2024-08-27 at 11:17 -0700, Ben Greear wrote:
>=20
> So, something like this (compile tested only at this point)?

Something like, yeah.

But also need to define that mac80211 actually consumes that value on TX
status etc., so this isn't really the first thing to do.

> +               if (link_sta) {
> +                       info->control.flags &=3D ~(u32_encode_bits(0xF, I=
EEE80211_TX_CTRL_MLO_LINK));

don't really need the encode-bits here since the mask is already 4 bits
:)

johannes


