Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C08311FBF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBFTpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 14:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhBFTpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 14:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612640612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1S2w1Y9BXEGL9VrTlAFQUuKDI2gB6mqPL4mp1Aubrd4=;
        b=S97YdHTSHNVTHwHGThe13/gl1ud0AGa7K8NThWLY9HWx9ofX/+V7eWIAAvPy6KecsCtVuq
        tHcCFZtK+GkOd4iRgO0h54NcIA/Nz4e654SzBBv1uWvVS7eBUMb87mqVyH42R8pg293Dh6
        ZEMRQYxaWvAMwKY4LY0cYoVW2tktOrw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-vtt7Vc_uNOWZnYN3fSf-pg-1; Sat, 06 Feb 2021 14:43:30 -0500
X-MC-Unique: vtt7Vc_uNOWZnYN3fSf-pg-1
Received: by mail-wr1-f72.google.com with SMTP id h17so8629029wrv.15
        for <linux-wireless@vger.kernel.org>; Sat, 06 Feb 2021 11:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1S2w1Y9BXEGL9VrTlAFQUuKDI2gB6mqPL4mp1Aubrd4=;
        b=IQx96uS9WODz4UNWC2HXAgCC+wDEHhUJR/6a84RScBR3NJscVMv15jwjfdve/0SH1l
         x0On9JbmAVBAxAfr4a//ARPox+TAjtd254pI89vP2P9G+CoYhd4QtwNQzX/rwyHe4jfD
         EEaIstlqVeUCBTuBEArwL4R/3IzTJfXgfG888k8piHbHlNyvo/c88nppqfTHmUymIQzg
         B4N1VLpbpYXiHuV8oBPdteX6BeHW087PRZoQXbfKZ/07PKQ7EcW8YQxyrrFLhqEyxq5/
         MOt3orfODH4SiQJfDxA2DGBQcj7+GAXZXempbn9IzEGRBZRdc7Fp1WJBK5Fa91aVB8nQ
         MK6A==
X-Gm-Message-State: AOAM533W2bYxgr9QGB3QgA+fuwzxdhiFuL9vlK+l0RuOw7sxRPQ+SvlF
        ZAGvdgnjuanqsTd4sCzo1AnYLvntILxS7u0qs1F2eego4fb3lPY/UZm1Vlklk9P1fDG9uHMDMhk
        +zi5LZOFibDK2Ace+7o7pa06AEvQ=
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr226333wrn.322.1612640609202;
        Sat, 06 Feb 2021 11:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6XPET/a6KapicfnZPXm+qTYikUhvc62aMICzNw1Kx7NoXeUUgcUO7xKqc30olAta++SuWlw==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr226324wrn.322.1612640608996;
        Sat, 06 Feb 2021 11:43:28 -0800 (PST)
Received: from localhost ([151.66.11.159])
        by smtp.gmail.com with ESMTPSA id m18sm22601445wmq.1.2021.02.06.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 11:43:28 -0800 (PST)
Date:   Sat, 6 Feb 2021 20:43:25 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: pull-request: wireless-drivers-2021-02-05
Message-ID: <20210206194325.GA134674@lore-desk>
References: <20210205163434.14D94C433ED@smtp.codeaurora.org>
 <20210206093537.0bfaf0db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20210206093537.0bfaf0db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri,  5 Feb 2021 16:34:34 +0000 (UTC) Kalle Valo wrote:
> > Hi,
> >=20
> > here's a pull request to net tree, more info below. Please let me know =
if there
> > are any problems.
>=20
> Pulled, thanks! One thing to confirm tho..
>=20
> > ath9k
> >=20
> > * fix build regression related to LEDS_CLASS
> >=20
> > mt76
> >=20
> > * fix a memory leak
>=20
> Lorenzo, I'm just guessing what this code does, but you're dropping a
> frag without invalidating the rest of the SKB, which I presume is now
> truncated? Shouldn't the skb be dropped?
>=20

Hi Jakub,

I agree. We can do something like:

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireles=
s/mediatek/mt76/dma.c
index e81dfaf99bcb..6d84533d1df2 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -511,8 +511,9 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_que=
ue *q, void *data,
 {
 	struct sk_buff *skb =3D q->rx_head;
 	struct skb_shared_info *shinfo =3D skb_shinfo(skb);
+	int nr_frags =3D shinfo->nr_frags;
=20
-	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
+	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
 		struct page *page =3D virt_to_head_page(data);
 		int offset =3D data - page_address(page) + q->buf_offset;
=20
@@ -526,7 +527,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_qu=
eue *q, void *data,
 		return;
=20
 	q->rx_head =3D NULL;
-	dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+	if (nr_frags < ARRAY_SIZE(shinfo->frags))
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+	else
+		dev_kfree_skb(skb);
 }
=20

I do not know if it can occur, but I guess we should even check q->rx_head
pointer before overwriting it because if the hw does not report more set to
false for last fragment we will get a memory leak as well. Something like:

@@ -578,6 +582,8 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_q=
ueue *q, int budget)
 		done++;
=20
 		if (more) {
+			if (q->rx_head)
+				dev_kfree_skb(q->rx_head);
 			q->rx_head =3D skb;
 			continue;
 		}

Regards,
Lorenzo

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYB7xWgAKCRA6cBh0uS2t
rBgHAQD5KAy3ewQb/cLDCR//RPheoid10w9MryaxjwAU/2NtngD/beZzbnFs8u+T
ZiVHgyo0+/0HmdWvk9sHoE0Fbs17Iwc=
=/ou8
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

