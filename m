Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF521F9F34
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgFOSNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOSNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 14:13:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B22C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H+fjjF4iCcOi2oeAxkN0QnSmNHQEzDlpM7g6tMwh0+g=; b=QRLE3u3c44rIItfE1JGR+Bb8Am
        nW/triYQxjR4ZaDb0Jz5A71o2lrHoyVoKa41o+U4gV7F9zt8OKISemcV2oJirwWpCyrMqpcpxTkAF
        F+yd+wMqp09KEvianxXKP3bgAf4lRO519UfGi2VLpgBu353TVfERbmPy7mLL5ZSMevuw=;
Received: from p4ff13772.dip0.t-ipconnect.de ([79.241.55.114] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jktc7-0005ix-6a; Mon, 15 Jun 2020 20:13:43 +0200
Received: by maeck.local (Postfix, from userid 501)
        id DCAE88E1E16C; Mon, 15 Jun 2020 20:13:41 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.8] mt76: mt76x02: do not access uninitialized NAPI structs
Date:   Mon, 15 Jun 2020 20:13:41 +0200
Message-Id: <20200615181341.81871-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes a crash on MMIO devices when running into the watchdog reset

Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index cbbe986655fe..5fda6e7b120c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -456,8 +456,9 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	tasklet_disable(&dev->mt76.tx_tasklet);
 	napi_disable(&dev->mt76.tx_napi);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++)
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_disable(&dev->mt76.napi[i]);
+	}
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -515,7 +516,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++) {
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
-- 
2.24.0

