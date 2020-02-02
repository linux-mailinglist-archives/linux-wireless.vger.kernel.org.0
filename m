Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5514FECE
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2020 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBBSwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Feb 2020 13:52:11 -0500
Received: from nbd.name ([46.4.11.11]:35596 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgBBSwK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Feb 2020 13:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kMKV5qQfG2CPD4UECf2ZBo0z22WHo/dEbZn4eXpk0a4=; b=A+D6bU28Q/3a65k0hg45z+eBhe
        TnOK0ToT/vO94TBZ4VF493z4DaR8/oY4Qr93yKSIw6Z1qTPejBr2H/3I7lOG8sU6BwFEg9hWNaIuE
        SzlDnV58n21phbDqsYqX6c7fNIG4a9PbkvGiupSOgWyVpSEkTZuNbt379ztQqTXYTQ4k=;
Received: from [81.95.5.35] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iyKLp-0003HZ-HZ
        for linux-wireless@vger.kernel.org; Sun, 02 Feb 2020 19:52:09 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0D7B07B1886E; Sun,  2 Feb 2020 19:52:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: fix adding active monitor interfaces
Date:   Sun,  2 Feb 2020 19:52:07 +0100
Message-Id: <20200202185208.28026-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Treat them the same as AP iftype internally for MCU commands

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index fb4a8913f6b6..20184f6ffc62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -97,6 +97,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
 	int i;
 
 	switch (type) {
+	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_ADHOC:
-- 
2.24.0

