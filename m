Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9DDE10524B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUMbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 07:31:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbfKUMbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 07:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574339495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWFxmPPY+uhKB7xJ64QBT6KxC50RJ41crjdk7XdS3H8=;
        b=foB/XgPJSOXv3ICpmI2g5Yri3usUDAfRL70EAHHl+DSBjPGVUymQOICBAfOMkKgY3cdVK/
        epvdzmOMaT/MF6k2F89FfWSydjCkVXb+2gzwZVBy1LRd11phBatQX8VZ9zqrHjIWkJJ4hK
        GIbMMaMs5sju6zCZ1ftGh+t4YYwCd1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-gze3rO8aPJyrlr-0fzgMxQ-1; Thu, 21 Nov 2019 07:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87ECE477;
        Thu, 21 Nov 2019 12:31:30 +0000 (UTC)
Received: from localhost (unknown [10.40.206.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB3B6A500;
        Thu, 21 Nov 2019 12:31:26 +0000 (UTC)
Date:   Thu, 21 Nov 2019 13:31:04 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v7 2/5] mt76: mt76x02: split beaconing
Message-ID: <20191121123102.GA13833@redhat.com>
References: <20191120222826.14871-1-markus.theil@tu-ilmenau.de>
 <20191120222826.14871-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191120222826.14871-3-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gze3rO8aPJyrlr-0fzgMxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 20, 2019 at 11:28:23PM +0100, Markus Theil wrote:
> Sending beacons to the hardware always happens in batches. In order to
> speed up beacon processing on usb devices, this patch splits out common
> code an calls it only once (mt76x02_mac_set_beacon_prepare,
> mt76x02_mac_set_beacon_finish). Making this split breaks beacon
> enabling/disabling per vif. This is fixed by adding a call to set the
> bypass mask, if beaconing should be disabled for a vif. Otherwise the
> beacon is send after the next beacon interval.
>=20
> The code is also adapted for the mmio part of the driver, but should not
> have any performance implication there.
<snip>
> +=09 */
> +=09if (mt76_is_usb(&dev->mt76)) {
> +=09=09struct mt76x02_txwi *txwi;
> +
> +=09=09mt76_insert_hdr_pad(skb);
> +=09=09txwi =3D (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
> +=09=09mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
> +=09=09skb_push(skb, sizeof(*txwi));
> +=09} else {
> +=09=09struct mt76x02_txwi txwi;
> =20
> -=09mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> -=09offset +=3D sizeof(txwi);
> +=09=09mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> +=09=09offset +=3D sizeof(txwi);
> +=09}

You merged another patch into this one. Please keep them separated.

> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
> +{
> +=09mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
> +=09=09       hweight8(dev->beacon_data_mask) - 1);
> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> +}

Well, this code still does not look quite right. At least it is not
compatible what the BCN_BYPASS_MASK description said in the manual.

I think the code need serious testing on multi-bss (USB support up
to 2  AP bssids) and with broadcast/multicast with some PS stations
on the network.

In particular adding second bssid and remove first one should
be checked.

Stanislaw

