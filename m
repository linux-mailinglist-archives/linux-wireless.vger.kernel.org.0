Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747284318AB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhJRMQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhJRMQk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09F2360FDA;
        Mon, 18 Oct 2021 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559269;
        bh=SwyXgGDCtRYEix8g35dCtJ5ugEmLWfLLF4/GxiAfUhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qx1+TnP4QQ+ndx525nJ7XII0GaEX7olzRmZtwgp8m4uy2PZMn6kfXWXvJLD5+EcUs
         jfIGTc7hSHjwUnfutWpATgnLW4prApaZL8VaqgEJtQnPEpFEnH+/D0RQ3i+57vL6w7
         i00OM22k9+nnhDWX+opX1+hwk1Swh9q6qnp5vdMpRPBqi0ldC/2faZ5Nloq9ZeXRmb
         5wsxZjyltnmtLFX3Q0xhMAlseBeAR+Cw/C0tZ9J2o38fPL2YuJkbi+zFcs0lUpr2Ib
         LqAB4e0Cm5tOX2HwrB+Qk9CQxwDkKo2lfop0g63qmaKEln20ct2+hKLK/5MChBXie5
         oK/FSIiT4XF8Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 09/10] mt76: mt7915: do not overwrite all mib counters in mt7915_get_stats
Date:   Mon, 18 Oct 2021 14:14:08 +0200
Message-Id: <adbdc6fae15ed6b62a97532e36ec6af16b2ed84e.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not overwrite all mib counters in mt7915_get_stats since they are
used for ethtool stats.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 13ef56205c98..b5b23c824233 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -816,7 +816,7 @@ mt7915_get_stats(struct ieee80211_hw *hw,
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
-	memset(mib, 0, sizeof(*mib));
+	memset(mib, 0, offsetof(struct mib_stats, ba_miss_cnt));
 
 	mutex_unlock(&dev->mt76.mutex);
 
-- 
2.31.1

