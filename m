Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC6136CA4E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhD0RZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 13:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhD0RZ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619544315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UACWlhwtpPH225Xxlp5bHLbRGbheLjGTYAAMyDL4QXY=;
        b=jFQOaPvZ2XxwVfQbgVa54pa++iZAc138ZIIs3pvqyzVDjjv6jhphy/ORyZJitC4PYm3XjD
        /i+ewvuL21gFAeaTntR8xDwwi++6itqLiNiv3Z362un10wsJtIwxhHTI1erihiFlRSODQS
        maPbF8I4rWzYTdVBSQjepy5Mf6qi73o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-wxOHG8swNaKXdIsI3ux9zg-1; Tue, 27 Apr 2021 13:25:13 -0400
X-MC-Unique: wxOHG8swNaKXdIsI3ux9zg-1
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso11447028ejn.10
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 10:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UACWlhwtpPH225Xxlp5bHLbRGbheLjGTYAAMyDL4QXY=;
        b=lgsqpUVn+vFt1fPg+cjHrMp6pplqBJgFDUlSP3Lx0OMiCoxHm4NEcD6x6jeI8OraLD
         znQvYbVTbZXXCktgJ9ICnX4tzg5cyuzZF9Am7BoiKLKseYxfM7mGKgqNwCqN8qrjdaC8
         5OWAuWwxp/6T684tWgQmS32pKZPCaLeMxd/Rq/9NhxdU+JLvCArZAmoEkDG756puTQx+
         o2uwdRmTex6FCwYEBCgxxxqn3pT7d5Sd1sjISyTCZRmP/0ECefexMlGay/gyvQIE+R10
         4Fk/xTdYQNCe6JgtzixHaAHni9MIeXL5VdvTZx+NTMlf3c9M5N+n1UO4Lq7c6SlXh8gz
         TNLA==
X-Gm-Message-State: AOAM532FmT1GsMa4xp7vjtPIvQavyBF4kiAUZ5EfdkiUMPfQLoGzjBmD
        zx1pJQeaD/F8Pdyj5ly+rsT05qqvXQKbyLjRQnYCB2OfZr29PjJ0+x6krvxJOcx/mDUAEcHXjNI
        WRIglta7YgyLdwk9TdbWbtOUA/9I=
X-Received: by 2002:aa7:c98b:: with SMTP id c11mr5833648edt.50.1619544311694;
        Tue, 27 Apr 2021 10:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcSIbmqhHqnmt70UKNN+auLGsAxfSPHLp3gE9gme4gIiwgMvQAuxQAJhoXpyp47x/uWlXBqQ==
X-Received: by 2002:aa7:c98b:: with SMTP id c11mr5833636edt.50.1619544311550;
        Tue, 27 Apr 2021 10:25:11 -0700 (PDT)
Received: from localhost ([151.66.28.185])
        by smtp.gmail.com with ESMTPSA id z15sm284936ejp.122.2021.04.27.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:25:11 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:25:07 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, kvalo@codeaurora.org
Subject: Re: [PATCH 2/3] mt76: connac: do not schedule wake_work if the
 runtime-pm is disabled
Message-ID: <YIhI82a7Auzxu1ZQ@lore-desk>
References: <cover.1619187875.git.lorenzo@kernel.org>
 <aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2VAg8hpK9CcIhjNC"
Content-Disposition: inline
In-Reply-To: <aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2VAg8hpK9CcIhjNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix the following crash due to a call to mt7921_pm_wake_work if the
> device has pm disabled or does not support runtime-pm
>=20
> [    8.412590] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
> [    8.413660] WARNING: CPU: 0 PID: 20 at __queue_delayed_work+0x84/0xb0
> [    8.481831] CPU: 0 PID: 20 Comm: kworker/u4:1 Not tainted 5.10.31 #0
> [    8.488175] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [    8.493663] Workqueue: mt76 mt7921_pm_wake_work [mt7921e]
> [    8.499055] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=3D--)
> [    8.505052] pc : __queue_delayed_work+0x84/0xb0
> [    8.509574] lr : queue_delayed_work_on+0x54/0x78
> [    8.514180] sp : ffffffc010bcbd20
> [    8.517485] x29: ffffffc010bcbd20 x28: 0000000000000000
> [    8.522790] x27: ffffff800015a148 x26: ffffffc0108acae0
> [    8.528094] x25: 0000000000000000 x24: ffffff80056b4208
> [    8.533399] x23: ffffff80056b26e0 x22: ffffff80056b26e0
> [    8.538703] x21: ffffff80056b45f8 x20: ffffff80056b5dc8
> [    8.544006] x19: 0000000000000000 x18: 000000000000000e
> [    8.549310] x17: 0000000000000001 x16: 0000000000000019
> [    8.554614] x15: 0000000000000033 x14: ffffffffffffffff
> [    8.559919] x13: ffffffffffffffff x12: 0000000000000000
> [    8.565223] x11: 0000000000000040 x10: 0000000000000820
> [    8.570528] x9 : 0000b3c738feafd6 x8 : ffffff801feb7c80
> [    8.575832] x7 : ffffff80056b4808 x6 : 0000000000000000
> [    8.581136] x5 : ffffff80056b2888 x4 : 0000000fffffffe0
> [    8.586441] x3 : 000000000000003e x2 : ffffff80056b2868
> [    8.591745] x1 : 0000000000000000 x0 : 0000000000000002
> [    8.597049] Call trace:
> [    8.599488]  __queue_delayed_work+0x84/0xb0
> [    8.603662]  queue_delayed_work_on+0x54/0x78
> [    8.607947]  ieee80211_queue_delayed_work+0x30/0x50 [mac80211]
> [    8.613774]  mt7921_pm_wake_work+0xa0/0xe0 [mt7921e]
> [    8.618730]  process_one_work+0x1fc/0x398
> [    8.622730]  worker_thread+0x150/0x4e0
> [    8.626472]  kthread+0x120/0x128
> [    8.629693]  ret_from_fork+0x10/0x18
>=20
> Fixes: 129fac01ffe85 ("mt76: connac: introduce wake counter for fw_pmctrl=
 synchronization")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Hi Kalle,

can you please drop this patch from the series and get the patch below inst=
ead? Thanks.

https://patchwork.kernel.org/project/linux-wireless/patch/3ff8e1901f38a943c=
4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org/

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 6c889b90fd12..2b1150bf8d3d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -103,6 +103,9 @@ mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_=
connac_pm *pm)
>  {
>  	bool ret =3D false;
> =20
> +	if (!pm->enable)
> +		return true;
> +
>  	spin_lock_bh(&pm->wake.lock);
>  	if (test_bit(MT76_STATE_PM, &phy->state))
>  		goto out;
> @@ -118,6 +121,9 @@ mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_=
connac_pm *pm)
>  static inline void
>  mt76_connac_pm_unref(struct mt76_connac_pm *pm)
>  {
> +	if (!pm->enable)
> +		return;
> +
>  	spin_lock_bh(&pm->wake.lock);
>  	pm->wake.count--;
>  	pm->last_activity =3D jiffies;
> --=20
> 2.30.2
>=20

--2VAg8hpK9CcIhjNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYIhI8QAKCRA6cBh0uS2t
rDdZAP9hYiwAYiclKVo2MzYrl3qXhZj3L6rX1UKk3O1iROba6QEA7mej1y2kiHaA
kyuII8Cxh/rPXrL2d7IoXLpvtEIR/go=
=KU1T
-----END PGP SIGNATURE-----

--2VAg8hpK9CcIhjNC--

