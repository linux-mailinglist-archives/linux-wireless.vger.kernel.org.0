Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF182DC6B7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgLPSrM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 13:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731952AbgLPSrL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 13:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608144344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AIYzajPVqHtLZ185/oHUDAZObqULmJkX3kgXqig0Nww=;
        b=dKd3irJt8yFDfsRpoNG1l3NjAj9wD2MninoWkMP5Q0S5ztpJ/SGe6YmlnfEJrue5so5MtZ
        qRQ3k5WlLg942h2MIRLHeXin/UgDLu1I2SIi44us576lWWVJVdXaTn0dKXXn47VktdTu0S
        6OBM52UR5HWu944ZM75yVHhv2/H6Uh4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-80Bdsi6CO-2Ipt2S5PMYDQ-1; Wed, 16 Dec 2020 13:45:41 -0500
X-MC-Unique: 80Bdsi6CO-2Ipt2S5PMYDQ-1
Received: by mail-ot1-f70.google.com with SMTP id j22so772129otq.16
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 10:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AIYzajPVqHtLZ185/oHUDAZObqULmJkX3kgXqig0Nww=;
        b=AH3uGrb9o6rx2kBIDCPuDHpNG9ZrHuYccJJBUKHIWu+znzD5FfUSdfx7QDck5nBgoL
         F2M02ZB41kZqYe7qT+M1d6g/r1vPRKlDD2sfz05l8O3StRph+lSAf49OSmyXQt2iMc9Z
         HzRL+cHkkPOANAKTSqhFrhK++QsZ+q6KPZxDYCWSjARe9lC2TCHOPj15v8rKsjg++rMT
         ogNw+x6TlMrayqoKe0zj3tYa/lsgz8Tk5YMVYwJoInD4vSQWzjEtWJ2NWECgG78CVbPI
         wbB4Of/ylCa964un4xkRfWaZqF9pX3GQyiGrC+w2NAMe3xvo8c8Abq0OzIXl6+dMD0qP
         1M2w==
X-Gm-Message-State: AOAM533BYMC5ft/xowfnrJrzC9noTiuXMQHmT5SyHWzbofnODiDV0eQV
        iTbDyfMQ88i4FEQvZ9GTMB7ikVAC2SdMEWFKnwhfmYSQ21l21TfAsLBjUckhry4tVDM5Ez8Q8H/
        7YJWa02YaSQWVt0q+4SDeMpanalI=
X-Received: by 2002:a9d:57c8:: with SMTP id q8mr25808871oti.168.1608144340627;
        Wed, 16 Dec 2020 10:45:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOQqi4/yux6aAX39ztSbeycJrClcF5P87lNAvEc5K8jlJje3O3jOY6pM0hmEbZ6XnhgYUpZg==
X-Received: by 2002:a9d:57c8:: with SMTP id q8mr25808862oti.168.1608144340485;
        Wed, 16 Dec 2020 10:45:40 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id w138sm571033oie.44.2020.12.16.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:45:39 -0800 (PST)
Date:   Wed, 16 Dec 2020 19:45:35 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Fwd: [PATCH] mt76: mt76s: fix NULL pointer dereference in
 mt76s_process_tx_queue
Message-ID: <20201216184535.GH2036@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--45wMVEkw4XUbiYON
Content-Type: multipart/mixed; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kalle,

Since net-next is closed now I guess we can consider this patch for
wireless-drivers

Regards,
Lorenzo

--I/5syFLg1Ed7r+1G
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: lbiancon@gapps.redhat.com
Received: by 2002:a05:7110:b009:b029:2b:a2b7:c4e3 with SMTP id f9csp3113629ged;
        Tue, 8 Dec 2020 01:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcfvpSpVkUrLjrnu+cQNZ7/hoY3GcrkB4xxBmRlV0xvC/PG/9HYDW8KL/hptDcz/2C2F6Y
X-Received: by 2002:a50:b944:: with SMTP id m62mr4123458ede.182.1607419104963;
        Tue, 08 Dec 2020 01:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1607419104; cv=none;
        d=google.com; s=arc-20160816;
        b=a68JoV65/aw7qJ61emvCZ2oY08zxs9kSOAlm7mrg3kl62eNvtdAbGg3eQzxb92ylTY
         u5oWbLtxdXgurjh0KG7T+IuLTHETaFYY0SZKQDc66z2bZFrI9CEW+YkLO8VOUuplR5Lf
         5ubTSQstVOCS0kkGXSjznME5GzxvMCE6C15stj6l5a0Dv9uEKx+eBoDqT6gQ4/xEd8Or
         hBdRsZC5FcjEXU+U58MfpNPyXsEWAgk5gnKI/+vSQlc/KreIjhglJCUcKIcOvMnHMBaq
         A9H16GP4aO/Nb+7YDA5cVA4gS+xSEk0V0eWTIgdojOR3xVZqX8yj8GjZWpZy0IkXM7+M
         H5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:delivered-to;
        bh=agYTMVN4m+b5ABTVCvIM2iLOrf2f7Dvskh9yLon0/5A=;
        b=CcGN3Pdh6Pqlcdk2FZAdm3KNk7TSZ0OAhPzM4LjpsxDngYBbBEJ8SZ51RP12J2j+ob
         eff+LKsN5smY6DTQ2yONjWe5E+1MIYIMJ32tRrwqtC7tnof+Nz6az/PNCxg1S9slpNaF
         MhQknzdQHi/zx6xQL3Andg+sTyWzW26zv5YDjLFzRg7k8oAU2Cl4ZxvHKmufEpWVIoCI
         A2oIi116EYwSN359GdITlbIF8ZQI6fa1lRCqroTwPmmeb39NEHYy1H5ore14vLrCCoGt
         sqOvSH+5Yqh5zsrxzjjKqfPaWHByuWwaQIeg+Oeh/9Jeg6HZ1oJmQWsSupphK9IrT3p9
         Fd9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=lorenzo@kernel.org
Return-Path: <lorenzo@kernel.org>
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com. [207.211.31.81])
        by mx.google.com with ESMTPS id c2si9604464edu.115.2020.12.08.01.18.24
        for <lbiancon@gapps.redhat.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:18:24 -0800 (PST)
Received-SPF: pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=lorenzo@kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-n3phEJimOPyC7C0DEaMHiQ-1; Tue, 08 Dec 2020 04:18:22 -0500
X-MC-Unique: n3phEJimOPyC7C0DEaMHiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CB08100B164
	for <lbiancon@gapps.redhat.com>; Tue,  8 Dec 2020 09:18:22 +0000 (UTC)
Received: by smtp.corp.redhat.com (Postfix)
	id 49141112D426; Tue,  8 Dec 2020 09:18:22 +0000 (UTC)
Delivered-To: lbiancon@redhat.com
Received: from mimecast-mx02.redhat.com (mimecast02.extmail.prod.ext.rdu2.redhat.com [10.11.55.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 453171004154
	for <lbiancon@redhat.com>; Tue,  8 Dec 2020 09:18:22 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 388238007DF
	for <lbiancon@redhat.com>; Tue,  8 Dec 2020 09:18:22 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99]) (Using TLS)
 by relay.mimecast.com with ESMTP id us-mta-316-5Lt0d9D1MVa_ukYV7LCTmQ-1;
 Tue, 08 Dec 2020 04:18:19 -0500
X-MC-Unique: 5Lt0d9D1MVa_ukYV7LCTmQ-1
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_queue
Date: Tue,  8 Dec 2020 10:18:11 +0100
Message-Id: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
MIME-Version: 1.0
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection Definition;Similar Internal Domain=false;Similar Monitored External Domain=false;Custom External Domain=false;Mimecast External Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat Dictionary=false
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
X-TUID: yK/qTqKYy0X/

Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
can occur if status thread runs before allocating tx queues

Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_worker"=
)
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wirele=
ss/mediatek/mt76/sdio.c
index 7cd995118257..0b6facb17ff7 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -157,10 +157,14 @@ static void mt76s_net_worker(struct mt76_worker *w)
=20
 static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queue =
*q)
 {
-=09bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
 =09struct mt76_queue_entry entry;
 =09int nframes =3D 0;
+=09bool mcu;
=20
+=09if (!q)
+=09=09return 0;
+
+=09mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
 =09while (q->queued > 0) {
 =09=09if (!q->entry[q->tail].done)
 =09=09=09break;
--=20
2.28.0


--I/5syFLg1Ed7r+1G--

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9pVzQAKCRA6cBh0uS2t
rJ1hAQDmvpTJNfuiCLh5gIw6/HzatKGI7qVShgCZ4EeldCUzsgEAq4wBXgzmZ5o5
3lFVqdYzAHb5PuDb54QHPcloFvCpUg4=
=ujNb
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--

