Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734B813BDDB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAOK7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:32 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2EC24671;
        Wed, 15 Jan 2020 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085971;
        bh=KPvMfbHN4N/+eFAT444r6kcLAq5VvaVtjfVXdXKa9kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mput6exWl8FXq4DVeMaoWuhlA3Urv+wZVqGrPYnHpSe4T6AvQMUb245Mwz2x85LH2
         h/LGS6G9Ufij1X0Y5wY9IKtuv19ZNkeJZMAgHbcpYkTFPE8y8QPXX/6QNrMeC4LL3C
         F82+8BCGOxUvZG7S4W1DtlDg/HGc2CPwv5agWgUI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 01/18] mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
Date:   Wed, 15 Jan 2020 11:58:41 +0100
Message-Id: <38032d76987e6fe16a69e0ce209e87a1b702a636.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New devices (e.g. mt7663u) do not rely on stats workqueue to load tx
statistics but will be reported by the firmware. Check tx_status_data
pointer in mt76u_tx_tasklet in order to reuse tx tasklet for new devices

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 22dacf040123..fbc4c0bb0102 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -708,7 +708,8 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		mt76_txq_schedule(&dev->phy, i);
 
-		if (!test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		if (dev->drv->tx_status_data &&
+		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
 			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
-- 
2.21.1

