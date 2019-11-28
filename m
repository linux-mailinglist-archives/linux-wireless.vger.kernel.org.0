Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82D10C5B3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 10:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1JLc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 04:11:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbfK1JLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574932291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GC+Rpi0+7haKRyux1VVNWV9iwMw7ntTkVBeOIhm/+jM=;
        b=cb5ZNjSc1ZXomLD/Mtz2luplaUCjG4v7+G7bYGRk6yY/ZJZolQjCa/XnanOJUTMWqM7dLS
        wRVsnCLkWELtxPfchReBbu+W2CIvXm4jKjzYWNGzGtUZQbn+m9mDMis9nFBIUylh96m5Qz
        NaEdwI6zrbjNo4SggEy7RXIYPA42uPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-nV5Ck8WvMxiE-AbBxi9ifA-1; Thu, 28 Nov 2019 04:11:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D65780183D;
        Thu, 28 Nov 2019 09:11:28 +0000 (UTC)
Received: from localhost (ovpn-205-99.brq.redhat.com [10.40.205.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE5DE5D6C8;
        Thu, 28 Nov 2019 09:11:26 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH 1/2] rt2x00: implement reconfig_complete
Date:   Thu, 28 Nov 2019 10:11:23 +0100
Message-Id: <20191128091124.15806-1-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nV5Ck8WvMxiE-AbBxi9ifA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 has .reconfig_complete that can be used as indicator of
HW restart end. This will allow to configure keys/IV differently
for HW restart and normal configuration.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 ++
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 11 -----------
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 20 ++++++++++++++++++++
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2800pci.c
index a23c26574002..3868c07672bd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -311,6 +311,7 @@ static const struct ieee80211_ops rt2800pci_mac80211_op=
s =3D {
 =09.get_survey=09=09=3D rt2800_get_survey,
 =09.get_ringparam=09=09=3D rt2x00mac_get_ringparam,
 =09.tx_frames_pending=09=3D rt2x00mac_tx_frames_pending,
+=09.reconfig_complete=09=3D rt2x00mac_reconfig_complete,
 };
=20
 static const struct rt2800_ops rt2800pci_rt2800_ops =3D {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2800soc.c
index 7b931bb96a9e..bbfe1425c0ee 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -156,6 +156,7 @@ static const struct ieee80211_ops rt2800soc_mac80211_op=
s =3D {
 =09.get_survey=09=09=3D rt2800_get_survey,
 =09.get_ringparam=09=09=3D rt2x00mac_get_ringparam,
 =09.tx_frames_pending=09=3D rt2x00mac_tx_frames_pending,
+=09.reconfig_complete=09=3D rt2x00mac_reconfig_complete,
 };
=20
 static const struct rt2800_ops rt2800soc_rt2800_ops =3D {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2800usb.c
index 0dfb55c69b73..4cc64fe481a7 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -654,6 +654,7 @@ static const struct ieee80211_ops rt2800usb_mac80211_op=
s =3D {
 =09.get_survey=09=09=3D rt2800_get_survey,
 =09.get_ringparam=09=09=3D rt2x00mac_get_ringparam,
 =09.tx_frames_pending=09=3D rt2x00mac_tx_frames_pending,
+=09.reconfig_complete=09=3D rt2x00mac_reconfig_complete,
 };
=20
 static const struct rt2800_ops rt2800usb_rt2800_ops =3D {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wire=
less/ralink/rt2x00/rt2x00.h
index a90a518b40d3..ea8a34ecae14 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1439,6 +1439,8 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
 =09=09  struct sk_buff *skb);
 int rt2x00mac_start(struct ieee80211_hw *hw);
 void rt2x00mac_stop(struct ieee80211_hw *hw);
+void rt2x00mac_reconfig_complete(struct ieee80211_hw *hw,
+=09=09=09=09 enum ieee80211_reconfig_type reconfig_type);
 int rt2x00mac_add_interface(struct ieee80211_hw *hw,
 =09=09=09    struct ieee80211_vif *vif);
 void rt2x00mac_remove_interface(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2x00dev.c
index c3eab767bc21..7f9e43a4f805 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1255,16 +1255,6 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 {
 =09int retval =3D 0;
=20
-=09if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags)) {
-=09=09/*
-=09=09 * This is special case for ieee80211_restart_hw(), otherwise
-=09=09 * mac80211 never call start() two times in row without stop();
-=09=09 */
-=09=09set_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
-=09=09rt2x00dev->ops->lib->pre_reset_hw(rt2x00dev);
-=09=09rt2x00lib_stop(rt2x00dev);
-=09}
-
 =09/*
 =09 * If this is the first interface which is added,
 =09 * we should load the firmware now.
@@ -1292,7 +1282,6 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 =09set_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags);
=20
 out:
-=09clear_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
 =09return retval;
 }
=20
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2x00mac.c
index beb20c5faf5f..32efbc8e9f92 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -165,6 +165,15 @@ int rt2x00mac_start(struct ieee80211_hw *hw)
 =09if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 =09=09return 0;
=20
+=09if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags)) {
+=09=09/*
+=09=09 * This is special case for ieee80211_restart_hw(), otherwise
+=09=09 * mac80211 never call start() two times in row without stop();
+=09=09 */
+=09=09set_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
+=09=09rt2x00dev->ops->lib->pre_reset_hw(rt2x00dev);
+=09=09rt2x00lib_stop(rt2x00dev);
+=09}
 =09return rt2x00lib_start(rt2x00dev);
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_start);
@@ -180,6 +189,17 @@ void rt2x00mac_stop(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(rt2x00mac_stop);
=20
+void
+rt2x00mac_reconfig_complete(struct ieee80211_hw *hw,
+=09=09=09    enum ieee80211_reconfig_type reconfig_type)
+{
+=09struct rt2x00_dev *rt2x00dev =3D hw->priv;
+
+=09if (reconfig_type =3D=3D IEEE80211_RECONFIG_TYPE_RESTART)
+=09=09clear_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
+}
+EXPORT_SYMBOL_GPL(rt2x00mac_reconfig_complete);
+
 int rt2x00mac_add_interface(struct ieee80211_hw *hw,
 =09=09=09    struct ieee80211_vif *vif)
 {
--=20
2.13.5

