Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549DFEDBD9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 10:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKDJqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 04:46:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27787 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfKDJqc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 04:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572860790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4mxrygt7nG4pUjmfSCWQSSoFHgntNktxJXFvCNIsPfo=;
        b=d1zFyahEndomKFquGyUZ+ytqIAIQYO/URAAC2Htv8HoQ0HTUnmnah6f4gpoFV6/SvPV00x
        LFYegsHxRKqzkyvg6RgUf+Y7DNiZ6q+F/dMm3I2mJvRbFNcCUmRJ64MA1QMrOvg9GD/9mT
        DgU3ciZbznLLwNEWMAE3yvGLg3SbOZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-UjW6oQ0yNOi5r14WFTrIfQ-1; Mon, 04 Nov 2019 04:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F7F1800D53;
        Mon,  4 Nov 2019 09:46:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2C926085E;
        Mon,  4 Nov 2019 09:46:22 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"
Date:   Mon,  4 Nov 2019 10:46:20 +0100
Message-Id: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UjW6oQ0yNOi5r14WFTrIfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.

Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
is no longer necessary to disable HW encryption for MT7630E.

Disabling HW encryption helped previously because somehow fragmented
skb's are not created if mac80211 encrypt frames, so buffer unmap bug
of non-linear skbs was not triggered. Now since this bug if properly
fixed by 7bd0650be63c , we can enable HW encryption back.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/=
wireless/mediatek/mt76/mt76x0/pci.c
index 7705e55aa3d1..f84a7df296ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -51,19 +51,6 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
 =09mt76x0e_stop_hw(dev);
 }
=20
-static int
-mt76x0e_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-=09=09struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-=09=09struct ieee80211_key_conf *key)
-{
-=09struct mt76x02_dev *dev =3D hw->priv;
-
-=09if (is_mt7630(dev))
-=09=09return -EOPNOTSUPP;
-
-=09return mt76x02_set_key(hw, cmd, vif, sta, key);
-}
-
 static void
 mt76x0e_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 =09      u32 queues, bool drop)
@@ -80,7 +67,7 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
 =09.configure_filter =3D mt76x02_configure_filter,
 =09.bss_info_changed =3D mt76x02_bss_info_changed,
 =09.sta_state =3D mt76_sta_state,
-=09.set_key =3D mt76x0e_set_key,
+=09.set_key =3D mt76x02_set_key,
 =09.conf_tx =3D mt76x02_conf_tx,
 =09.sw_scan_start =3D mt76_sw_scan,
 =09.sw_scan_complete =3D mt76x02_sw_scan_complete,
--=20
1.9.3

