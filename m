Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88B2104E3B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 09:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUImm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 03:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKUImm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 03:42:42 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAF72067D;
        Thu, 21 Nov 2019 08:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574325762;
        bh=TjDly7rJ4rsenFzgdabrl619NmgwMKuDIaX7jj0eRqg=;
        h=From:To:Cc:Subject:Date:From;
        b=Gqrux0hpZh4AVD7SEDKv5gn58Ao2EDWUuCAjlr9xN82fk1IeoLb0UlHTgjy2A9Pvq
         HP8B+QoDkCYZvtHTQ+rgaHcHisbqjRjkScbGej1VpeQI2SaYEm+3TzcnhJh7MRX/q6
         88B7UpsIZg6aEc4t+eXLMY7cWGN1kTijn44xm5vI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7603: reset STA_CCA counter setting the channel
Date:   Thu, 21 Nov 2019 10:42:13 +0200
Message-Id: <f3a74a766b8e9e58baa7b7060d22c38267f9667f.1574324940.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reset MT_MIB_STAT_CCA after channel switch since it is used to track busy
time starting from 'commit dcff8d4dc301 ("mt76: mt7603: switch to a
different counter for survey busy time")'

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 189e900f8a74..0d309c8f46e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -187,7 +187,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt76_clear(dev, MT_MIB_CTL, MT_MIB_CTL_READ_CLR_DIS);
 	mt76_set(dev, MT_MIB_CTL,
 		 MT_MIB_CTL_CCA_NAV_TX | MT_MIB_CTL_PSCCA_TIME);
-	mt76_rr(dev, MT_MIB_STAT_PSCCA);
+	mt76_rr(dev, MT_MIB_STAT_CCA);
 	mt7603_cca_stats_reset(dev);
 
 	dev->mt76.survey_time = ktime_get_boottime();
-- 
2.21.0

