Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD10666E7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfGLGUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 02:20:48 -0400
Received: from nbd.name ([46.4.11.11]:33142 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGLGUr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 02:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JE+/VAawot01kSJmz9PUrzUg3MB64OvpCpOfFaOzMCY=; b=RqhAoK8BiBFoEo1sBEqk7tCi+I
        UYtSU8C2KgjfD3ODjrjCwfhO0RhzvA4hb9Ytu3KHUk4HEOfkZBoyeQovpeFGpaGdgSyfQumYWkZ90
        D5WLCOz1gaIVUT3dv+3FcFwfuaW7xH6F7mUp0pE6ZLLdElfSBiMGO1mjtSelTJgSdZXw=;
Received: from p54ae9abd.dip0.t-ipconnect.de ([84.174.154.189] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hlovG-0003ra-96
        for linux-wireless@vger.kernel.org; Fri, 12 Jul 2019 08:20:46 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id A1F4461C52AD; Fri, 12 Jul 2019 08:20:45 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7603: fix invalid fallback rates
Date:   Fri, 12 Jul 2019 08:20:45 +0200
Message-Id: <20190712062045.85109-4-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190712062045.85109-1-nbd@nbd.name>
References: <20190712062045.85109-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only decrement the rate index on duplicate rates if it is not already 0

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 40db1cbc832d..81fb4276e742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -639,6 +639,9 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			    IEEE80211_TX_RC_40_MHZ_WIDTH)
 				continue;
 
+			if (!rates[i].idx)
+				continue;
+
 			rates[i].idx--;
 		}
 
-- 
2.17.0

