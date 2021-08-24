Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4147C3F5BFC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhHXKXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236216AbhHXKXx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 713F0610FB;
        Tue, 24 Aug 2021 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800589;
        bh=ncrzn/5H60qTGHUANZ6GtGlCNLN89Q5Zd/SNaZ/a35g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mo7SBsoyvK3tQ0Ch4nvWlZj/uulN8UuwfmiAPad5Jswa0HIu8WeO1kI+z5hHWQp+F
         9Kc4anmeo4J/8ZqwPvCkO8btfW0TaqzGLKa/knmk/zRgUwHpbt0JN/bV7bhDdi0A4v
         QricAjek3gjN7XM+ZLggs05i0+sKJrczq8JTMSL8Hs/Eqlkq8IIalaIXiEjgoJ4cZL
         El/Dl8oQQuFxiIr2JM8JqtF0HFbvKg4wckWZ5JHhvcSvYr2wscvsfmX6OF3kA6E802
         1xHjWyZFdgKXmDj/v287cKSQMOS5QIN9ms2FxN1q2SVsQt+uTJcSX6xHvS1qlLvqZ3
         ISmzCajEmYhFg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 7/9] mt76: connac: enable hw amsdu @ 6GHz
Date:   Tue, 24 Aug 2021 12:22:25 +0200
Message-Id: <e197219ab1ef0198059f13cadeb7bb6b1473225b.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to enable 6GHz band for mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3b9c4180f954..10198c0c065b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -766,7 +766,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	if (!is_mt7921(dev))
 		return;
 
-	if (sta->ht_cap.ht_supported)
+	if (sta->ht_cap.ht_supported || sta->he_cap.has_he)
 		mt76_connac_mcu_sta_amsdu_tlv(skb, sta, vif);
 
 	/* starec he */
-- 
2.31.1

