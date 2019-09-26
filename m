Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12BBF7D3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfIZRrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:35 -0400
Received: from nbd.name ([46.4.11.11]:55234 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfIZRrf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VP9sH4pbWA/ASocaFLPEGyBs1Sa/hBMsH3MUXVYG5FA=; b=ddwvP2n7gKSHx+YzYF7M9ydKEH
        uTm66Ksu/dFoMeWdRdX2p44tX8mob9+rXbJq+Y/SI1oOMr5p/6qxR6A+9mmMxXfmgaIqRf8dCOpNy
        PWIGWRQEIKj2YoYmzWmZDh/Ua3JLrlCypoVoB8ehFgG31u7/w176zDVGgsdklPc0dL3s=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrZ-0000yc-8p
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:33 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B4EB869B6A84; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/15] mt76: mt7603: remove q_rx field from struct mt7603_dev
Date:   Thu, 26 Sep 2019 19:47:18 +0200
Message-Id: <20190926174732.42375-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is no longer used

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index fb10adca17f3..17176de4fb23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -118,8 +118,6 @@ struct mt7603_dev {
 
 	ktime_t ed_time;
 
-	struct mt76_queue q_rx;
-
 	spinlock_t ps_lock;
 
 	u8 mac_work_count;
-- 
2.17.0

