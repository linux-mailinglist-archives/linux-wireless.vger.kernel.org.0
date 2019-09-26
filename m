Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1023BEE02
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfIZJFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 05:05:31 -0400
Received: from nbd.name ([46.4.11.11]:53296 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfIZJFb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oLhuyy/DtavGkEfRLPcjnd5dK1Vu/owMwFxBjpIOBos=; b=OIQu9R3FrGeaPvRJBmP5TFouK+
        zedSflQCX7S3tpjcX4IjB4yOyiiIrEkRhGbk5hmyrRIeYmPy0ZZipMm8sj72YpAJvRC6T5XYcgwuN
        vTvM0gjRTtzrjh4kY6Za6r/sQGZ8OOsFyBjv08EshvUuKop+6ohN8j6PZ/YL2br/mMXA=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDPiL-0008Sp-MC
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 11:05:29 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 3B5E06997D47; Thu, 26 Sep 2019 11:05:23 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: use cancel_delayed_work_sync in mt76_rx_aggr_shutdown
Date:   Thu, 26 Sep 2019 11:05:23 +0200
Message-Id: <20190926090523.68392-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926090523.68392-1-nbd@nbd.name>
References: <20190926090523.68392-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The workqueue item needs to be fully shut down before the struct can be
freed.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 8f3d36a15e17..2276fd4e9ec3 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -257,7 +257,7 @@ static void mt76_rx_aggr_shutdown(struct mt76_dev *dev, struct mt76_rx_tid *tid)
 	u8 size = tid->size;
 	int i;
 
-	cancel_delayed_work(&tid->reorder_work);
+	cancel_delayed_work_sync(&tid->reorder_work);
 
 	spin_lock_bh(&tid->lock);
 
-- 
2.17.0

