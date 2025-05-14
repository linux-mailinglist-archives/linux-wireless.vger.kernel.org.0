Return-Path: <linux-wireless+bounces-22932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA6AB68B5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A31B414ED
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637C25E823;
	Wed, 14 May 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xD7KrzMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F774200B99;
	Wed, 14 May 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218229; cv=none; b=kF1NpyMjR6Y3FIPFVVm6gmdKCw/E5WV8TsG+Qx+IDH8tY1Rn2KkFZhNSCV3X+u73qUmNGpJu3KeKfZbknubEOhB4hJPlUdbwhrFzBYWwGzJMfCvE8pcEm8qcsY/1Wu1FJ/QSorbfzX0/OGTRHRQ3hasDLxIm4VnIvKd4lBy6oKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218229; c=relaxed/simple;
	bh=9GksAIdQB0QDXvTcF8Ed529ZYyZ0F8mk1QWoA1ETKJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5G5GbiuWIppyhCpyDiWfJThJU26Q4UsIAAX81IHhNSsYDb3cpPXAtJWGxYd8HhtD9V+jyRXJPz+xdIWf2i0crcAXUm3DuZFEIM5k6ARS8AEogcspd+2ASGtQRUR94Nb7C2idf6p7kzxvhUuhNMg44XBjKrVcvB/xtGeEBkZh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xD7KrzMt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LFkjPzGUqtk8aAnu6OMUu1Xl2FUkPFvXEy6O5US/TFU=;
	t=1747218228; x=1748427828; b=xD7KrzMtaOGalPR+ovK2UJH9ovKcDC/8koWae9xmHBAQwwY
	ErYZ4eoU+6gcnxVRMrh/LbcglE7hu3ddPhQ5qy2TnKojadZA6vUIpomFFkDC/nyXsDOwr/NXopNG4
	9uHKriMZ7yU07WQ9xc6WI8EhGgXkVhYt7wsq7NIiitfwTkDRP18BATXs92gH15kbsDqLJBrcJYvCY
	viLvtiSulb3PCElxn50tkb1M+vsVMOwxA7jFk/PDE0Qh4nSP4J7eKlUR9h8ad6Sf5WMoY5Uhwi8Aa
	ZD9eKGR2/SM7lOppulHwNoPOsJ/2gcEBpqkyVDWVU773JMvhvNK1zv5hBrs9FHgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uF9H1-00000007wIL-2gG8;
	Wed, 14 May 2025 12:23:39 +0200
Message-ID: <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 14 May 2025 12:23:38 +0200
In-Reply-To: <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
		 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
	 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
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

+ linux-wireless

On Wed, 2025-05-14 at 09:32 +0000, Bert Karwatzki wrote:

> Then I reapplied commit 76a853f86c97 hunk by hunk and found the one hunk =
that
> causes the problem:
>=20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 3e751dd3ae7b..63df21228029 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4648,8 +4648,7 @@ static void ieee80211_8023_xmit(struct
> ieee80211_sub_if_data *sdata,
>                         memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info)=
);
>         }
>=20
> -       if (unlikely(skb->sk &&
> -                    skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
> +       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
>                 info->status_data =3D ieee80211_store_ack_skb(local, skb,
>                                                             &info->flags,=
 NULL);
>                 if (info->status_data)

I think it crashed later on the status, but this inserts the skb into
the IDR so the status can pick it up to return the status and afaict
_that's_ where it crashed.

Still I don't really know what could go wrong? The (copied) skb should
still have been keeping the socket alive.

> This is enough to cause a kernel panic when compiled with clang (clang-19=
.1.7
> from debian sid). Compiling the same kernel with gcc (gcc-14.2.0 from deb=
ian
> sid) shows no problem.

Right, even stranger. But I can't even say you should look at this place
(which inserts) or the other (which takes it out again and crashed) to
compare the code :-/


johannes

