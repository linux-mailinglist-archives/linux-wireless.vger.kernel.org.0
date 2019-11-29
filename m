Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEE10D5B7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 13:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfK2Mcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 07:32:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfK2Mcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 07:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575030764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGVrxcKeZmdVG6IhI5+njp7E8j7/1R+N6N+9xWzbHzk=;
        b=WH2wU37IhGpx2yWdNNIdYLnVSpNtvMvki0mp5VEc6U7qhEJ6v8T1vBaGt1arVbI3wyZAgq
        VUPNjfkfiycKxle0R8iQ8f8g7AOhXBG15lQTx7UoLpLmnJHNe0BRqT4g0DkgacBuvI8DsW
        EWipkkwlEPYnxsIdwTxZTq0gm2mWZnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Tdnfg5KaPVygrTRYlJAapw-1; Fri, 29 Nov 2019 07:32:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3F1100551B;
        Fri, 29 Nov 2019 12:32:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99549600C8;
        Fri, 29 Nov 2019 12:32:39 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/3] mt76: mt76x02: minor mt76x02_mac_set_beacon optimization
Date:   Fri, 29 Nov 2019 13:32:28 +0100
Message-Id: <1575030748-2218-4-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Tdnfg5KaPVygrTRYlJAapw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We do not call mt76x02_mac_set_beacon() with NULL skb any longer and
we do not need to return error value.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 14 ++++----------
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h    |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_beacon.c
index 68a4f512319e..3cc5226b05c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -67,21 +67,15 @@ void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *=
dev)
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);
=20
-int mt76x02_mac_set_beacon(struct mt76x02_dev *dev,
-=09=09=09   struct sk_buff *skb)
+void mt76x02_mac_set_beacon(struct mt76x02_dev *dev,
+=09=09=09    struct sk_buff *skb)
 {
 =09int bcn_len =3D dev->beacon_ops->slot_size;
 =09int bcn_addr =3D MT_BEACON_BASE + (bcn_len * dev->beacon_data_count);
-=09int ret =3D 0;
-
-=09if (skb) {
-=09=09ret =3D mt76x02_write_beacon(dev, bcn_addr, skb);
-=09=09if (!ret)
-=09=09=09dev->beacon_data_count++;
-=09}
=20
+=09if (!mt76x02_write_beacon(dev, bcn_addr, skb))
+=09=09dev->beacon_data_count++;
 =09dev_kfree_skb(skb);
-=09return ret;
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
=20
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net=
/wireless/mediatek/mt76/mt76x02_mac.h
index f67f66f65ee0..5d6411ee44ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -201,7 +201,7 @@ void mt76x02_tx_complete_skb(struct mt76_dev *mdev, enu=
m mt76_txq_id qid,
=20
 void mt76x02_mac_cc_reset(struct mt76x02_dev *dev);
 void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *addr=
);
-int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, struct sk_buff *skb);
+void mt76x02_mac_set_beacon(struct mt76x02_dev *dev, struct sk_buff *skb);
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 =09=09=09=09   struct ieee80211_vif *vif, bool enable);
 void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev);
--=20
1.9.3

