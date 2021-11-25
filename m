Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6D45E0E8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhKYTVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKYTTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:19:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6DC061748
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i98gtlFag6EBVEig5DCw1Su1RL8bXIRTIBMSyH3RePo=; b=WVAK5+v/Mw8x1wQhJ10weosWO4
        9G/AJalaTbxf3RKB+j2CDUXL75ulP2EEvrB1R3w/jxA4bPp12pyT2QwjsgSFqNSEpLezGa0LKztTz
        ztWKiRA6/PpGRdkdGSn4qGMCJu6Iq8611sfjDqISUL26aeFNtdhV4odg4o2YYX7x7nxc=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqKEY-00022n-2w
        for linux-wireless@vger.kernel.org; Thu, 25 Nov 2021 20:16:38 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: clear sta powersave flag after notifying driver
Date:   Thu, 25 Nov 2021 20:14:35 +0100
Message-Id: <20211125191436.76952-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the driver has configured the hardware to drop packets for a sta that was
in powersave mode, then clearing the flag too early opens up a small race
window during which packets could be dropped on wakeup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index acf400fa8469..f11a2c6c3364 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1163,10 +1163,12 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 	if (ps)
 		set_bit(MT_WCID_FLAG_PS, &wcid->flags);
-	else
-		clear_bit(MT_WCID_FLAG_PS, &wcid->flags);
 
 	dev->drv->sta_ps(dev, sta, ps);
+
+	if (!ps)
+		clear_bit(MT_WCID_FLAG_PS, &wcid->flags);
+
 	ieee80211_sta_ps_transition(sta, ps);
 }
 
-- 
2.30.1

