Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBFBF7D4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfIZRrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:36 -0400
Received: from nbd.name ([46.4.11.11]:55252 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfIZRrf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PvJmqELckz4IoFVxF4Ox7VfJ9eUWIlIXqpWHK3OsEMM=; b=Jn8pQesNzv6Lt7seZdLrcZQnv6
        34J/xN/ZUZk/xzBN4D/Ma2siO/b8QGfrmJPsRcd7DVz90JVYX+b5pv/sm+nowcM0xgp7Esi4R+JLT
        1YrWxOvIHxP4QGf4RAxhFfz6pmgh66s1VhFNpHrbhvmbishJ3Tr9vyrHUUysQJT/9Cqg=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yw-Ih
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B836C69B6A8D; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/15] mt76: mt7603: switch to a different counter for survey busy time
Date:   Thu, 26 Sep 2019 19:47:24 +0200
Message-Id: <20190926174732.42375-7-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT_MIB_STAT_PSCCA only counts rx CCA busy time, which does not include
tx time. MT_MIB_STAT_CCA counts full busy time, including Rx, Tx and NAV

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index caa1456adc50..8e6568d4505b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1578,7 +1578,7 @@ void mt7603_update_channel(struct mt76_dev *mdev)
 		return;
 
 	state = mdev->chan_state;
-	busy = mt76_rr(dev, MT_MIB_STAT_PSCCA);
+	busy = mt76_rr(dev, MT_MIB_STAT_CCA);
 
 	spin_lock_bh(&dev->mt76.cc_lock);
 	cur_time = ktime_get_boottime();
-- 
2.17.0

