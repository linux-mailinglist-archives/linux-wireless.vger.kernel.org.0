Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3415B46F5F
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFOKBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91A5C59451;
        Sat, 15 Jun 2019 10:01:07 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3254E5C269;
        Sat, 15 Jun 2019 10:01:07 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 4/7] rt2800: add pre_reset_hw callback
Date:   Sat, 15 Jun 2019 12:00:57 +0200
Message-Id: <20190615100100.29800-5-sgruszka@redhat.com>
In-Reply-To: <20190615100100.29800-1-sgruszka@redhat.com>
References: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 15 Jun 2019 10:01:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add routine to cleanup interfaces data before hw reset as
ieee80211_restart_hw() will do setup interfaces again.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 19 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  1 +
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  1 +
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  1 +
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  1 +
 6 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index d420d759a877..499e9afa0026 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1843,6 +1843,25 @@ int rt2800_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(rt2800_sta_remove);
 
+void rt2800_pre_reset_hw(struct rt2x00_dev *rt2x00dev)
+{
+	struct rt2800_drv_data *drv_data = rt2x00dev->drv_data;
+	struct data_queue *queue = rt2x00dev->bcn;
+	struct queue_entry *entry;
+	int i, wcid;
+
+	for (wcid = WCID_START; wcid < WCID_END; wcid++) {
+		drv_data->wcid_to_sta[wcid - WCID_START] = NULL;
+		__clear_bit(wcid - WCID_START, drv_data->sta_ids);
+	}
+
+	for (i = 0; i < queue->limit; i++) {
+		entry = &queue->entries[i];
+		clear_bit(ENTRY_BCN_ASSIGNED, &entry->flags);
+	}
+}
+EXPORT_SYMBOL_GPL(rt2800_pre_reset_hw);
+
 void rt2800_config_filter(struct rt2x00_dev *rt2x00dev,
 			  const unsigned int filter_flags)
 {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index f35f4e20d5aa..1139405c0ebb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -257,5 +257,6 @@ void rt2800_disable_wpdma(struct rt2x00_dev *rt2x00dev);
 void rt2800_get_txwi_rxwi_size(struct rt2x00_dev *rt2x00dev,
 			       unsigned short *txwi_size,
 			       unsigned short *rxwi_size);
+void rt2800_pre_reset_hw(struct rt2x00_dev *rt2x00dev);
 
 #endif /* RT2800LIB_H */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index df6345a92f72..a23c26574002 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -368,6 +368,7 @@ static const struct rt2x00lib_ops rt2800pci_rt2x00_ops = {
 	.config_erp		= rt2800_config_erp,
 	.config_ant		= rt2800_config_ant,
 	.config			= rt2800_config,
+	.pre_reset_hw		= rt2800_pre_reset_hw,
 };
 
 static const struct rt2x00_ops rt2800pci_ops = {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 1054ade65af2..7b931bb96a9e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -213,6 +213,7 @@ static const struct rt2x00lib_ops rt2800soc_rt2x00_ops = {
 	.config_erp		= rt2800_config_erp,
 	.config_ant		= rt2800_config_ant,
 	.config			= rt2800_config,
+	.pre_reset_hw		= rt2800_pre_reset_hw,
 };
 
 static const struct rt2x00_ops rt2800soc_ops = {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index da813dfa9a91..fdf0504b5f1d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -706,6 +706,7 @@ static const struct rt2x00lib_ops rt2800usb_rt2x00_ops = {
 	.config_erp		= rt2800_config_erp,
 	.config_ant		= rt2800_config_ant,
 	.config			= rt2800_config,
+	.pre_reset_hw		= rt2800_pre_reset_hw,
 };
 
 static void rt2800usb_queue_init(struct data_queue *queue)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 2b551dbe9844..dc6b79e4be3b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -616,6 +616,7 @@ struct rt2x00lib_ops {
 	void (*config) (struct rt2x00_dev *rt2x00dev,
 			struct rt2x00lib_conf *libconf,
 			const unsigned int changed_flags);
+	void (*pre_reset_hw) (struct rt2x00_dev *rt2x00dev);
 	int (*sta_add) (struct rt2x00_dev *rt2x00dev,
 			struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
-- 
2.20.1

