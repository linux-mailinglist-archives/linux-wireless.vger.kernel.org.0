Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04CB8BA72
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2019 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfHMNgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Aug 2019 09:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbfHMNgp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Aug 2019 09:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 272418E58C;
        Tue, 13 Aug 2019 13:36:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 702C26E6F0;
        Tue, 13 Aug 2019 13:36:42 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
Date:   Tue, 13 Aug 2019 15:36:40 +0200
Message-Id: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 13 Aug 2019 13:36:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
I can observe firmware hangs on MT7630E on station mode: tx stop
functioning after minor activity (rx keep working) and on module
unload device fail to stop with messages:

[ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
[ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop

Loading module again results in failure to associate with AP.
Only machine power off / power on cycle can make device work again.

It's unclear why commit 41634aa8d6db causes the problem, but it is
related to HW encryption. Since issue is a firmware hang, that is super
hard to debug, just disable HW encryption as fix for the issue.

Fixes: 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 4585e1b756c2..6117e6ca08cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -62,6 +62,19 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
 	mt76x0e_stop_hw(dev);
 }
 
+static int
+mt76x0e_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+		struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		struct ieee80211_key_conf *key)
+{
+	struct mt76x02_dev *dev = hw->priv;
+
+	if (is_mt7630(dev))
+		return -EOPNOTSUPP;
+
+	return mt76x02_set_key(hw, cmd, vif, sta, key);
+}
+
 static void
 mt76x0e_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	      u32 queues, bool drop)
@@ -78,7 +91,7 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
 	.configure_filter = mt76x02_configure_filter,
 	.bss_info_changed = mt76x02_bss_info_changed,
 	.sta_state = mt76_sta_state,
-	.set_key = mt76x02_set_key,
+	.set_key = mt76x0e_set_key,
 	.conf_tx = mt76x02_conf_tx,
 	.sw_scan_start = mt76x02_sw_scan,
 	.sw_scan_complete = mt76x02_sw_scan_complete,
-- 
1.9.3

