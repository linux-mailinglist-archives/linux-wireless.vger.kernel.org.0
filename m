Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467AE1A3292
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDIKg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 06:36:57 -0400
Received: from nbd.name ([46.4.11.11]:34556 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIKg4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 06:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JlhNHtPeBjLZ+eJpgD7FEJqdMiM2F9SJec30IYVInV0=; b=PxY638O1z5N/UdxlWr3OXr1WMN
        vaK/I4h0xibeutGxBJCMaVNw+WcyqYHd4xoJCO2AjMXXsrN8muebqmzpFxX0FioiXA9auCAi5gMtD
        X5E81jxDCjLDWFZFXvJqeRCEnagmp0EjzuSFBMEjKlCJle6WfWqUBIfgAnfR9iTtHlpk=;
Received: from p54ae91d1.dip0.t-ipconnect.de ([84.174.145.209] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jMUYK-0006wk-5l
        for linux-wireless@vger.kernel.org; Thu, 09 Apr 2020 12:36:56 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id C3926828F03C; Thu,  9 Apr 2020 12:36:55 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] mt76: mt7615: set hw scan limits only for firmware with offload support
Date:   Thu,  9 Apr 2020 12:36:55 +0200
Message-Id: <20200409103655.94536-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200409103655.94536-1-nbd@nbd.name>
References: <20200409103655.94536-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

They do not apply to software scan

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 7f3683205b8e..96b7c6284833 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -145,10 +145,19 @@ static void mt7615_init_work(struct work_struct *work)
 	mt7615_mcu_del_wtbl_all(dev);
 
 	if (!mt7615_firmware_offload(dev)) {
+		struct wiphy *wiphy = mt76_hw(dev)->wiphy;
+
 		dev->ops->hw_scan = NULL;
 		dev->ops->cancel_hw_scan = NULL;
 		dev->ops->sched_scan_start = NULL;
 		dev->ops->sched_scan_stop = NULL;
+
+		wiphy->max_sched_scan_plan_interval = 0;
+		wiphy->max_sched_scan_ie_len = 0;
+		wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+		wiphy->max_sched_scan_ssids = 0;
+		wiphy->max_match_sets = 0;
+		wiphy->max_sched_scan_reqs = 0;
 	}
 }
 
-- 
2.24.0

