Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA42724283C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHLK2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLK2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:34 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39FDC06174A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ROV+Mmwrunla8FUF7FdUe+KAnCCON0UW4hMeD+Wuz2Y=; b=OE1y/tQnq1Yzu0s49g25o7+WDC
        1TOQmepxoK6v10vYZnv+e9Tgn3wB2qxeiVBcRDVInzgHRQpt0Be5X0f2nhMRIaDUsttRIzhv+cBLu
        TVu+EKGK+VTLoXuh10kv+SpDc0fxOSyYxVqESfWpQ7OZwolvmEtTbaUfamEC48Au1T9Q=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzk-0002U3-Ht
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] mt76: mt7615: remove mtxq->agg_ssn assignment
Date:   Wed, 12 Aug 2020 12:28:28 +0200
Message-Id: <20200812102831.11991-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812102831.11991-1-nbd@nbd.name>
References: <20200812102831.11991-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not used anywhere for this driver

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9972853f4a29..bdade416934c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -818,7 +818,6 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_START:
 		ssn = mt7615_mac_get_sta_tid_sn(dev, msta->wcid.idx, tid);
 		params->ssn = ssn;
-		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
-- 
2.28.0

