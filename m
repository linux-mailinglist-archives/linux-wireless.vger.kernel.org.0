Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928EE1B4987
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDVQEz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgDVQEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F1C03C1AA
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gRPWckED+SPZ+xqwCJzxVsC1UHMbNeClY5C7b0uddsA=; b=e0uPA1NikEA0rfuLttVSKRecgD
        2SYo2uT0uUbjl4Lvl+3bX3LAcHE7vy7nNNhVEfDWLP+qXuR0nV9nGk08+tJ+yuhEnPK93xZxKTBNX
        VFfdzBeFPbNu3dHEVsfYFw4/xFp/tikSfRuP/eoTiez7tjoz9und9Lr0Xrn3WA4eAzz0=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-00054n-5F
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:39 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 97DBA8419629; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/9] mt76: mt7615: do not adjust MAC timings if the device is not running
Date:   Wed, 22 Apr 2020 18:04:35 +0200
Message-Id: <20200422160437.99466-7-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoids register writes and MAC start/stop when the hardware isn't ready for it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 88cbf5ffa290..89aed6d67de0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -119,6 +119,9 @@ void mt7615_mac_set_timing(struct mt7615_phy *phy)
 	int sifs, offset;
 	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
 
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
 	if (is_5ghz)
 		sifs = 16;
 	else
-- 
2.24.0

