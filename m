Return-Path: <linux-wireless+bounces-23178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E874ABD93F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619C84C29F6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46248241CB2;
	Tue, 20 May 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l99/oof6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48B2417C4;
	Tue, 20 May 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747332; cv=none; b=ZaQlUc/avQhsw2TkU5Fht9wWyqHr/bnu4U52WiOHU1HjGdSnxuG/Y5LVcJSjcaOI3w2121ohtT9/fKJGPRw0CUeprk6B3XskGm6Kz7wstMya2Sf02bErermWKTSt0wjqjuQ149kyY9uBDf0BhiMUpfGFj4/flw5Bt0KZzAn99JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747332; c=relaxed/simple;
	bh=pLEHwDiVuZvXiue/k5tPps5MZhvaONMk0WPltQccuT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lC6J3rGDlPMdEF6+VH1HwTjYUD8gGFKW35AFEtKACRO0ejvRDsIUpznk2HQbQhYh+CHWlg01oXFQpAVCjbVNvNx8BBMbfO6Oczfd2dmBAA5VK5kWVN0lkylxrD4GmRm6sBwGwqvGq9dJ5I9ZyPP4SQvms4mpXyVPI+bvpsKY0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l99/oof6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qGkxzvfqtbfpZxZZ9+czodAziIbE78FPgucChcrRJxE=;
	t=1747747330; x=1748956930; b=l99/oof6S4VuaqXcfvyKHhA+yq8KB7AWdSRYnaNvK2XXKtn
	0jtZef6qFsYWmUR/20MurqIntl5NCIyV+k1uaIoVlw542kUoMrCLlIcvdGmzDSI+cwcIFudIik3wX
	Be5tEIbG23vX1f84VJz3EJwKvqSk8SZtZTaVfwUN6XPh4VbjZ9jpYzFomHODM38facN7DiV1U1+Y0
	r+ssGoXyvzFoWpSbOd+M32MADJsJh/CaWSHbRH9LoBglwj1IC76Mti3qH914oMe0qIXs7atJAcaii
	0vuVfePA62sTetL3dk8ukv8uLsFIm3CfVBhv8t4MBH8WYf3Sk4LP70wRqfK9klkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHMuz-0000000BckJ-1tcs;
	Tue, 20 May 2025 15:22:06 +0200
Message-ID: <f6d119025a88b766ec803ef948dbbf7c97574b74.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: Check if socket flags are valid
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Jason Xing
	 <kerneljasonxing@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	netdev@vger.kernel.org
Date: Tue, 20 May 2025 15:22:01 +0200
In-Reply-To: <20250518164546.4612-1-spasswolf@web.de>
References: <20250518164546.4612-1-spasswolf@web.de>
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

Hi Bert,

Thank you _very_ much for doing all this debug. I was somewhat following
along on my phone, but was out over the weekend.

> +++ b/drivers/net/wireless/ath/wil6210/txrx.h
> @@ -618,7 +618,7 @@ static inline bool wil_need_txstat(struct sk_buff *sk=
b)
>  	const u8 *da =3D wil_skb_get_da(skb);
> =20
>  	return is_unicast_ether_addr(da) && skb->sk &&
> -	       sock_flag(skb->sk, SOCK_WIFI_STATUS);
> +	       sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_STATUS);

I feel like in line with sk_is_refcounted(), maybe we could add

static inline bool
sk_requests_wifi_status(struct sock *sk)
{
	return sk && sk_fullsock(sk) && sock_flag(sk,
SOCK_WIFI_STATUS);
}

perhaps?

That's basically all the checks in all the callers.

I can also just do that though if you don't want to resend.

johannes


