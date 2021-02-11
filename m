Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A595C3186EF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBKJTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 04:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhBKJM3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 04:12:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AE7260230;
        Thu, 11 Feb 2021 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613034704;
        bh=KSkB8+5Av7i//eI1gaHzYK/t/JWChGWDMMfyA8oqHI4=;
        h=From:To:Cc:Subject:Date:From;
        b=M/OnrVcy65DK05CmLLr8EY7nh99eDiPg6Av64JnjYq6c3LY6XV6u2k1hK6trxOrZO
         MfxZS7qsrbDLS4p0PPO5h8eQ0bjTuJfP6a7ZhlI6BXvtAXCvh6EoVGxCzuLRu8tKXY
         86ZAgwB2uMG6SFfprIYesI6HZH5GMOUfTN83aCmrzhTCKwFyVP3hpTUBFqAA7mCa1n
         qeWVuFuq7xNTUovx8YTrRenTSUqaP/tWIndpqiSeDJWDaGcTMJ5ynVZKPnoxCoxWgG
         xKrXDEPI+Z4FlEKD5wMshIHvRRJvlkNU5l2EYcEhiyNtOdBbDn2Hk3K7NjvlqdhTGm
         kp5NctDg8rM1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, shayne.chen@mediatek.com,
        dan.carpenter@oracle.com, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix uninitialized variable in mt7915_tm_set_tx_cont()
Date:   Thu, 11 Feb 2021 10:11:29 +0100
Message-Id: <44ad7cca29f159aa2ae721b8f7a2d1b5ab540b31.1613034563.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set MT_PHY_TYPE_OFDM as default value for mode variable in
mt7915_tm_set_tx_cont routine in order to proper initialize it even
for default case.

Fixes: 3f0caa3cbf94: "mt76: mt7915: add support for continuous tx in testmode"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 7fb2170a9561..a76af0701179 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -569,9 +569,6 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	case MT76_TM_TX_MODE_CCK:
 		mode = MT_PHY_TYPE_CCK;
 		break;
-	case MT76_TM_TX_MODE_OFDM:
-		mode = MT_PHY_TYPE_OFDM;
-		break;
 	case MT76_TM_TX_MODE_HT:
 		mode = MT_PHY_TYPE_HT;
 		break;
@@ -590,7 +587,9 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	case MT76_TM_TX_MODE_HE_MU:
 		mode = MT_PHY_TYPE_HE_MU;
 		break;
+	case MT76_TM_TX_MODE_OFDM:
 	default:
+		mode = MT_PHY_TYPE_OFDM;
 		break;
 	}
 
-- 
2.29.2

