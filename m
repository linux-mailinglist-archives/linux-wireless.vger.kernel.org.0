Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A835C98C74
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfHVHdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 03:33:07 -0400
Received: from nbd.name ([46.4.11.11]:48308 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfHVHdH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 03:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VqjATVpTyEqs1ltrFyg6uxwkwpjsBGN9OkEqaHYMft8=; b=Lvtw+OSdjudHIAZS898qb4zeC2
        7V8/0QmqxmkmGAeUv1kLsrBTLpMwuG8gt/Dhn43CXCDQkcGuNfmXHRXBjpWugUAbhh5LDCdctDD7m
        7rNDSIQ/c7zeIyEa+3CipCoyI125XtfZXzu0BUyGXtcjD2QsnL+BvPHF55Ow8+nuZKSE=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0hak-0002gu-0Y
        for linux-wireless@vger.kernel.org; Thu, 22 Aug 2019 09:33:06 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 7494663FD13C; Thu, 22 Aug 2019 09:33:05 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: stop rx aggregation on station removal
Date:   Thu, 22 Aug 2019 09:33:05 +0200
Message-Id: <20190822073305.37840-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190822073305.37840-1-nbd@nbd.name>
References: <20190822073305.37840-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes use-after-free issues on forced station removal during hardware restart
on MT76x02

Fixes: aee5b8cf2477 ("mt76: implement A-MPDU rx reordering in the driver code")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index aeb535204c4d..32ddbf088817 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -708,6 +708,9 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	rcu_assign_pointer(dev->wcid[idx], NULL);
 	synchronize_rcu();
 
+	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
+		mt76_rx_aggr_stop(dev, wcid, i);
+
 	if (dev->drv->sta_remove)
 		dev->drv->sta_remove(dev, vif, sta);
 
-- 
2.17.0

