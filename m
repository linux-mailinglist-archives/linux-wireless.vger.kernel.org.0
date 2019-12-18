Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675F3124365
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLRJiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 04:38:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbfLRJiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 04:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576661882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7al46lzASkiG6zEpqv3NoWCOmsYKnduFEdbaSoRQnK0=;
        b=O9Lh0HZFX9SrQWAmnXlunDpiyoqipSB4bevoQPXQCwprZ+ymYXyNzdjiDRKV82MUiCLTLi
        gKKhiDFHc2i3sH8kNdpxJM5HE0YBDjzVR0XrY7PbBa9o87XJ9PNUe+Q9PS/3RnO7sOk+Ub
        3MC10nuOLgbBsmJUAsffg5Ym0G/6cJI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318--PYetmMEOM2KcD_Fx9u0NA-1; Wed, 18 Dec 2019 04:37:38 -0500
X-MC-Unique: -PYetmMEOM2KcD_Fx9u0NA-1
Received: by mail-wm1-f70.google.com with SMTP id c4so249466wmb.8
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 01:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7al46lzASkiG6zEpqv3NoWCOmsYKnduFEdbaSoRQnK0=;
        b=Z2Whw/HKuoGA0GBA7LxvOPg/8uBXrNHnQS4HD+KIFEux/Ab6plAf4se3WQhzaMjy32
         fbR6fDtXT0XukqM+Kc3KG/Phc4NQJa6GtqiF5LWbgdZWIrNY9CrSQJ3NQeDZZrUfgygz
         aKtfzMv4bSPFCQ1Pq4iWyFbrJk0RqMZ3g2kP1j53jBzcidgoiatE/VLKqdlMH6Nvpqkt
         VfFpRtFFarKvcTByDjBj7CzudLOu0SCaTXJtObuHQSOrSRhC/3OhJe41bLcRzitbe0l/
         LOXEDRKQC2xEO2Adh4/ajfbNUOZGu3Fjx3MoWhW4VsMTIeg8qngmx/UStDZxSEkSqqCt
         LH8A==
X-Gm-Message-State: APjAAAXIX5+oED5m5PoaIRT4rLi1ZEcp1+cCrmrahkyWlZW2ZeOdD+xE
        CKX0Ujdlp9vYxJGuvtSbdtzSro00OsB9b3WonOrK7CxuKsUGVEerFctzQR3UENX7YaSuel3l6/s
        iGhNIRWuDu8xGqouG9UC0j2XdTME=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr1688559wrc.175.1576661857008;
        Wed, 18 Dec 2019 01:37:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqygtYVkeGpB57qB23dpK8uijPjSuZ3y9O2nZXVXsATr8vutuZm4H2cmDLaTCsMyk14oVL/14g==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr1688535wrc.175.1576661856822;
        Wed, 18 Dec 2019 01:37:36 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id w8sm1896267wmm.0.2019.12.18.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:37:35 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:37:33 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v9 2/6] mt76: mt76x02: split beaconing
Message-ID: <20191218093733.GA13035@localhost.localdomain>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
 <20191126214704.27297-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20191126214704.27297-3-markus.theil@tu-ilmenau.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


[...]
> =20
> @@ -244,19 +248,15 @@ static void mt76x02u_pre_tbtt_enable(struct mt76x02=
_dev *dev, bool en)
> =20
>  static void mt76x02u_beacon_enable(struct mt76x02_dev *dev, bool en)
>  {
> -	int i;
> -
>  	if (WARN_ON_ONCE(!dev->mt76.beacon_int))
>  		return;
> =20
>  	if (en) {
>  		mt76x02u_start_pre_tbtt_timer(dev);
>  	} else {
> -		/* Timer is already stopped, only clean up
> -		 * PS buffered frames if any.
> +		/* Timer is already stopped,
> +		 * nothing else to do here.
>  		 */
> -		for (i =3D 0; i < N_BCN_SLOTS; i++)
> -			mt76x02_mac_set_beacon(dev, i, NULL);
>  	}

I guess here you can get rid of 'else' branch

Regards,
Lorenzo

>  }
> =20
> --=20
> 2.24.0
>=20

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfnzWwAKCRA6cBh0uS2t
rH5JAQDluT7fk6iRbl3teMxfQGWUfKvmjhnhIyp7oQygnJLgcQD/fBtXsWiDDCcx
ThUmzne1p9hHV+qCm098dYqlx6AUuAQ=
=F75y
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

