Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158021A786
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfEKKSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 06:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfEKKSW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 06:18:22 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395032146F;
        Sat, 11 May 2019 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569902;
        bh=T3BeGIptBzq2b6f5ZHqirDgDDMqJwCJZntMup+LH5/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfACHb9cHZyCxFuw4SKrjYEG8TgCxkmybLAJD0XxjAP+DEE0kqsWaBFrpaUxCc4JI
         yMIOpc/22RvarBgMXrtprgE97whzIcHnKsu5JimdyzIcBbpdfKHrYjmiObhViCX3dQ
         v/v53qjkyRLXh6xHVFTlynEuk3BwLtYdDybH2sBw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 2/4] mt76: mt76x2u: remove mt76x02_edcca_init in mt76x2u_set_channel
Date:   Sat, 11 May 2019 12:17:52 +0200
Message-Id: <e43e1e880751af77694f86d73a013c711ad40523.1557567465.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557567465.git.lorenzo@kernel.org>
References: <cover.1557567465.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt76x02_edcca_init in mt76x2u_set_channel since it is already
run by mt76x2u_phy_channel_calibrate performing channel calibration

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 6657693edc3e..3351b736603d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -59,7 +59,6 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	err = mt76x2u_phy_set_channel(dev, chandef);
 
 	mt76x2_mac_resume(dev);
-	mt76x02_edcca_init(dev);
 
 	dev->beacon_ops->pre_tbtt_enable(dev, true);
 
-- 
2.20.1

