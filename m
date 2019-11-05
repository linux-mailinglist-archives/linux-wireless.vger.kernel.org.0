Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84679EFA51
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfKEKAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 05:00:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22122 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387690AbfKEKAk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 05:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572948039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gRmTVkC/EATQcgpsiF+EOL29OKGjoVjlrTnOdAXcDsA=;
        b=FiDB77c2buPeL8yNx+c2u0iPSwF1gjrtnqGC6XWyWHvm4d8QqCl+rkBSGsbvRO6wlbl4QP
        CvY5AOxbj8GdvAsBk/rtzgtN62yb4e2WBy+DmSL9+OnqrlV00iH/MT6vZkLcuUvnlKd717
        z5Nent2rM0Ggi/Pnkfa8+WwIUtLMz3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-DybqqlN2MFmLwsGpywghnQ-1; Tue, 05 Nov 2019 05:00:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FBF800C73;
        Tue,  5 Nov 2019 10:00:34 +0000 (UTC)
Received: from localhost (unknown [10.40.205.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A89961001B00;
        Tue,  5 Nov 2019 10:00:33 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH v2] Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"
Date:   Tue,  5 Nov 2019 11:00:32 +0100
Message-Id: <20191105100032.28556-1-sgruszka@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: DybqqlN2MFmLwsGpywghnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.

Since commit 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skb=
s")
is no longer necessary to disable HW encryption for MT7630E.

Disabling HW encryption helped previously because somehow fragmented
skb's are not created if mac80211 encrypt frames, so buffer unmap bug
of non-linear skbs was not triggered. Now since this bug is properly
fixed by commit 7bd0650be63c ("mt76: dma: fix buffer unmap with
non-linear skbs") , we can enable HW encryption back.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
v2: fix commit references

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
@@ -80,7 +67,7 @@ static const struct ieee80211_ops mt76x0e_ops =3D {
 =09.configure_filter =3D mt76x02_configure_filter,
 =09.bss_info_changed =3D mt76x02_bss_info_changed,
 =09.sta_state =3D mt76_sta_state,
-=09.set_key =3D mt76x0e_set_key,
+=09.set_key =3D mt76x02_set_key,
 =09.conf_tx =3D mt76x02_conf_tx,
 =09.sw_scan_start =3D mt76_sw_scan,
 =09.sw_scan_complete =3D mt76x02_sw_scan_complete,
--=20
2.20.1

