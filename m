Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3EA19C1A9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgDBNHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388403AbgDBNHo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:44 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC4020678;
        Thu,  2 Apr 2020 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832863;
        bh=da75WNCyElUBj5uGiEqZob3llwVigdpNXgm0uTRUh+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHNS7aBPuON3nVqcsz2YAA6n6zHDLnAmq+9XaiNr6inUUaQVLkQ4AGvND4gZHUI3Y
         SbdN4uF+A4nJ9YCRKaVy0tKmn7wvcfCLDo/wbI+/wbQcRmsP8ECNkLWJDtIqqN3LHS
         jhtuVhp/bYUnfFgg36L9Wld1PwfwXqjXzgOIPQ+Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 04/12] mt76: mt7663: disable RDD commands
Date:   Thu,  2 Apr 2020 15:06:34 +0200
Message-Id: <20da56fe7d926dbcf8e4309a530a8b77602fbb75.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disable dfs RDD mcu commands for mt7663 driver since they are not
currently supported by the 7663 firmware

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ec6ef6c3478e..7be06ece1658 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2036,6 +2036,9 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int err;
 
+	if (is_mt7663(&dev->mt76))
+		return 0;
+
 	if (dev->mt76.region == NL80211_DFS_UNSET) {
 		phy->dfs_state = -1;
 		if (phy->rdd_state)
-- 
2.25.1

