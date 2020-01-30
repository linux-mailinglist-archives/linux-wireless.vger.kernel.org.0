Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED43E14DD0A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA3OrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:21 -0500
Received: from nbd.name ([46.4.11.11]:57436 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbgA3OrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ci2+yLRC9bCl/s0DAnobhkMXxgRS4JGfz83ZB6J6U5o=; b=AdVNtuArrL0ZfQ88mKOiROO8lW
        fEFMc77UTl6s5u/4p9CfYtWsMMBR22iGYB5wFUt/CTyVEfXGXLuhxzVTSICj5Zhph8qak8zCAkICy
        mFyP0zOybfWIenQX1pU85awmMSX1B+W3Hj7LBMiUweEafsQLN4gqnDBlIbYMgJVNf1l8=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6F-0001VM-Kd
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EC04F7AE468C; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 14/15] mt76: mt7615: disable DBDC on MT7622
Date:   Thu, 30 Jan 2020 15:47:17 +0100
Message-Id: <20200130144718.14298-14-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is only supported on MT7615

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 79b177ac4261..2f6ad2b24464 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -383,6 +383,9 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	struct mt76_phy *mphy;
 	int ret;
 
+	if (!is_mt7615(&dev->mt76))
+		return -EOPNOTSUPP;
+
 	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 		return -EINVAL;
 
-- 
2.24.0

