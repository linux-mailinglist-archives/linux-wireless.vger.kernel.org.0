Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98E610272A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfKSOoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 09:44:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbfKSOoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 09:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574174658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0JWsfYHM0XgxJyXBOYuCPN4SUIWfIiYJoC/EN++bYM=;
        b=FXF50QXQUF7h58aH8TKcFyEhXvutD+IoH1f/zJ/hs9Nc41NvsMGgOVX2qg6gkKk4bzq1ps
        S5Kvb2Dgo2D90a278u/Bfde7OsIa58PdjdK+3UXSBict7g8LnUVbVHmlVIFuR0boIl5zNM
        IA0jOoNHjWBuU/x89sl2WptKRK5y2w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-czSFfpPSMpy2LqhqvBJioA-1; Tue, 19 Nov 2019 09:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABBA88DF459;
        Tue, 19 Nov 2019 14:44:15 +0000 (UTC)
Received: from localhost (unknown [10.40.205.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9087F1D3;
        Tue, 19 Nov 2019 14:44:12 +0000 (UTC)
Date:   Tue, 19 Nov 2019 15:44:11 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v5 3/5] mt76: mt76x02: remove a copy call for usb speedup
Message-ID: <20191119144410.GA23939@redhat.com>
References: <20191119122410.12588-1-markus.theil@tu-ilmenau.de>
 <20191119122410.12588-4-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191119122410.12588-4-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: czSFfpPSMpy2LqhqvBJioA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 19, 2019 at 01:24:08PM +0100, Markus Theil wrote:
> This patch removes a mt76_wr_copy call from the beacon path to hw.
> The skb which is used in this place gets therefore build with txwi
> inside its data. For mt76 usb drivers, this saves one synchronuous
> copy call over usb, which lets the beacon work complete faster.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 09013adae854..a9df8f2d41b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -26,15 +26,15 @@ static int
>  mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_buff=
 *skb)
>  {
>  =09int beacon_len =3D dev->beacon_ops->slot_size;
> -=09struct mt76x02_txwi txwi;
> +=09struct mt76x02_txwi *txwi;
> =20
>  =09if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi))=
)
>  =09=09return -ENOSPC;
> =20
> -=09mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
> -
> -=09mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> -=09offset +=3D sizeof(txwi);
> +=09mt76_insert_hdr_pad(skb);
> +=09txwi =3D (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
> +=09mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
> +=09skb_push(skb, sizeof(*txwi));

This require enough skb headroom for txwi . Mac80211 reserve headroom
for us according to hw->extra_tx_headroom . Currently we ask for extra
space for txwi only for usb in mt76x02_init_device().

So this code should be put under mt76_is_usb() condition or,
what I think is less preferred, reserve extra space also for mmio.

Stanislaw

