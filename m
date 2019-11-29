Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A064410D5B5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfK2Mcn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 07:32:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41346 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2Mcn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 07:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575030761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2fAuEBBSRpY/CSNwJra01Bn9YnaOkh9MtKcG5tFe0E=;
        b=GwKbmN2Nwwcw8CXZ1hTIcm1cj/h68n4Cca6jKjcHPndY/8skIEqXIEVyfD0Ah7U2BcEU43
        earDUd9OG307gO14ZumJPmHxCrms1UlYJIe5CuqBtgSm6yaRWQ7Gue2a8erc9cgXIAlB0X
        rpJcg9KiSMowujXYbZiMmEbWW4DQ7jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-Z0aioIREN7OjDpgUYbMl6A-1; Fri, 29 Nov 2019 07:32:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38275184CAAA;
        Fri, 29 Nov 2019 12:32:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4E2D60BE2;
        Fri, 29 Nov 2019 12:32:36 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/3] mt76: usb: use max packet length for m76u_copy
Date:   Fri, 29 Nov 2019 13:32:26 +0100
Message-Id: <1575030748-2218-2-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Z0aioIREN7OjDpgUYbMl6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For transferring data over USB the optimal size is endpoint maxpacket.
For my hardware maxpaket for control endpoint is 64 bytes and changing
to this value from 128 bytes further shorten TBTT work time from
3ms to 1ms.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  7 +++----
 drivers/net/wireless/mediatek/mt76/usb.c  | 29 +++++++++++++++++++--------=
--
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wirele=
ss/mediatek/mt76/mt76.h
index 1981912de1f9..c268c3d76b3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -381,10 +381,9 @@ enum mt76u_out_ep {
 #define MCU_RESP_URB_SIZE=091024
 struct mt76_usb {
 =09struct mutex usb_ctrl_mtx;
-=09union {
-=09=09u8 data[128];
-=09=09__le32 reg_val;
-=09};
+=09__le32 reg_val;
+=09u8 *data;
+=09u16 data_len;
=20
 =09struct tasklet_struct rx_tasklet;
 =09struct workqueue_struct *stat_wq;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireles=
s/mediatek/mt76/usb.c
index 97b263ce3872..a9ff2bd62fc9 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -163,7 +163,7 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset=
,
=20
 =09mutex_lock(&usb->usb_ctrl_mtx);
 =09while (i < len) {
-=09=09current_batch_size =3D min_t(int, sizeof(usb->data), len - i);
+=09=09current_batch_size =3D min_t(int, usb->data_len, len - i);
 =09=09memcpy(usb->data, val + i, current_batch_size);
 =09=09ret =3D __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 =09=09=09=09=09     USB_DIR_OUT | USB_TYPE_VENDOR,
@@ -950,6 +950,15 @@ int mt76u_alloc_queues(struct mt76_dev *dev)
 =09.kick =3D mt76u_tx_kick,
 };
=20
+void mt76u_deinit(struct mt76_dev *dev)
+{
+=09if (dev->usb.stat_wq) {
+=09=09destroy_workqueue(dev->usb.stat_wq);
+=09=09dev->usb.stat_wq =3D NULL;
+=09}
+}
+EXPORT_SYMBOL_GPL(mt76u_deinit);
+
 int mt76u_init(struct mt76_dev *dev,
 =09       struct usb_interface *intf)
 {
@@ -974,6 +983,15 @@ int mt76u_init(struct mt76_dev *dev,
 =09if (!usb->stat_wq)
 =09=09return -ENOMEM;
=20
+=09usb->data_len =3D usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
+=09if (usb->data_len < 32)
+=09=09usb->data_len =3D 32;
+=09usb->data =3D devm_kmalloc(dev->dev, usb->data_len, GFP_KERNEL);
+=09if (!usb->data) {
+=09=09mt76u_deinit(dev);
+=09=09return -ENOMEM;
+=09}
+
 =09mutex_init(&usb->mcu.mutex);
=20
 =09mutex_init(&usb->usb_ctrl_mtx);
@@ -988,14 +1006,5 @@ int mt76u_init(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76u_init);
=20
-void mt76u_deinit(struct mt76_dev *dev)
-{
-=09if (dev->usb.stat_wq) {
-=09=09destroy_workqueue(dev->usb.stat_wq);
-=09=09dev->usb.stat_wq =3D NULL;
-=09}
-}
-EXPORT_SYMBOL_GPL(mt76u_deinit);
-
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_LICENSE("Dual BSD/GPL");
--=20
1.9.3

