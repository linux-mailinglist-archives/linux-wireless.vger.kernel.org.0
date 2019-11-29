Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01C010D5B6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2Mco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 07:32:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2Mco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 07:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575030763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmmG7cTDF8j3dDlK5mWBV5RioNEA0v62kDAoZGSQA9M=;
        b=U/fTjMCxuOu9kNdkIlrKF6E4XK3sbHVtPZtLhUhoykDEXMQE1RkZBk1bufZ3N6mD8j0oFX
        wiWh781HX6jzSkPnpAnHODlib3AvEZjwDp+PcGlWnOOH2MfZv/z9CeDzMC1PSgVsuRepEP
        Y2pyPfbGAGt7UM+CmDOfTG5WuO52ans=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-qygBvUreN4q_OnwxnU5glQ-1; Fri, 29 Nov 2019 07:32:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23BF800EC0;
        Fri, 29 Nov 2019 12:32:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2485060BE2;
        Fri, 29 Nov 2019 12:32:37 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] mt76: mt76x02u: do not set NULL beacons
Date:   Fri, 29 Nov 2019 13:32:27 +0100
Message-Id: <1575030748-2218-3-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qygBvUreN4q_OnwxnU5glQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With current implementation we do not cleanup beacon memory, so is not
needed to call mt76x02_mac_set_beacon() with NULL skb.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 3dc3682d585a..c06d8b5f7995 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -198,7 +198,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *=
work)
 =09=09container_of(work, struct mt76x02_dev, pre_tbtt_work);
 =09struct beacon_bc_data data =3D {};
 =09struct sk_buff *skb;
-=09int i, nbeacons;
+=09int nbeacons;
=20
 =09if (!dev->mt76.beacon_mask)
 =09=09return;
@@ -224,10 +224,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct =
*work)
 =09nbeacons =3D hweight8(dev->mt76.beacon_mask);
 =09mt76x02_enqueue_buffered_bc(dev, &data, N_BCN_SLOTS - nbeacons);
=20
-=09for (i =3D nbeacons; i < N_BCN_SLOTS; i++) {
-=09=09skb =3D __skb_dequeue(&data.q);
+=09while ((skb =3D __skb_dequeue(&data.q)) !=3D NULL)
 =09=09mt76x02_mac_set_beacon(dev, skb);
-=09}
=20
 out:
 =09mt76x02_mac_set_beacon_finish(dev);
--=20
1.9.3

