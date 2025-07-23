Return-Path: <linux-wireless+bounces-25917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA5B0ED1A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E211AA42C0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189F272E57;
	Wed, 23 Jul 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xXQiWIQk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10825743E
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258980; cv=none; b=RnvCLf6VNd0DnRcAmtbQwly2RFZICguyAV5owOZ8nwgGp9omwBNIwvoEaMwtH50K3UayHPWKZhisC/CgLZmkg0i67jHxBs+y4X+4fN0XYaPK0GWwR5c7rDPMZ/LLSYMVM67/xRZc6v3g7dzQKbAORZGIGBDSOjMTsAUskR+XyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258980; c=relaxed/simple;
	bh=aT+y65LX/V/C2Vtr89dl72qHWo5DugOS6VavmaNu7OA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q403ygQ0w1SnfP/c/mwFnLP7qYR8ccwo9hdTcMlv39MBsqPE+NeLSDoSKxxKNIVRLgTYwvv5Px1iitUNeRdhAexW9S2WRmyu9gzJo7cgdPYD+jW/U2S94kemKpFSb1VNb4nToZQHq7DbYkJ0veLliBW+yh9T8qLMTZE2yUgumxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xXQiWIQk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aT+y65LX/V/C2Vtr89dl72qHWo5DugOS6VavmaNu7OA=;
	t=1753258979; x=1754468579; b=xXQiWIQkATb95QKqWHJ2I6Y/VUdc9+mJIZs/LTbhejuPSpH
	PztGaI7hgqdvz6RVWOb6+RC2yz42Ab0K+fDIlgOZAex/b3EqGRw5vKpq/BOKhXKGhhNvWNb/BAMWD
	qMSM/tZL7gUeBIdiFK0barNWDtZogQZIdmTLuRLPWLJ7Zb6gAb7+sJsB4mXK1HQTNEZHCdIytmYj+
	pOXUs5rWAtl9Gd1ImwfIN1nnfd0T19iox3xMITQNZpwXebfby/zGQJVXgFxnR7aBQHImfgHdzjRK/
	BcI4lRGZ9C2hXz6u5/i/Xmjvey2/AePi+hVNlcFLWEfQy2NN5OG/oKll+XuwiUsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueUkU-00000003b48-2M76;
	Wed, 23 Jul 2025 10:22:53 +0200
Message-ID: <02c9972445c54b9c3077a4bdff2995c38e8efef8.camel@sipsolutions.net>
Subject: Re: [wireless-next 1/2] wifi: mac80211: support encoding S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 23 Jul 2025 10:22:46 +0200
In-Reply-To: <d97f20cff120e813b83c3a7d41bae63b151da26a.camel@sipsolutions.net> (sfid-20250723_100610_808413_E7D663D4)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
		 <20250722071642.875875-2-lachlan.hodges@morsemicro.com>
		 (sfid-20250722_091728_659585_C991C363) <d97f20cff120e813b83c3a7d41bae63b151da26a.camel@sipsolutions.net>
	 (sfid-20250723_100610_808413_E7D663D4)
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

On Wed, 2025-07-23 at 10:04 +0200, Johannes Berg wrote:
>=20
> If you don't want to limit to 1600 then I think encoding wise we're
> limit to 2048 (but in practice to 2008 with the AID limit in nl80211),

Actually I guess without paging anyway to 2048.

> struct element *tim;
>=20
> pos =3D skb_put(skb, 4);
> tim =3D (void *)pos;
> // add all the stuff including PVB
> tim->datalen =3D skb_tail_pointer(skb) - &tim->data;

tim->data is already a pointer, so the & there is wrong, sorry.

johannes

