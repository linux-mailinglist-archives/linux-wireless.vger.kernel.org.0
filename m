Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FF47A193
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhLSRlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51296 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLSRlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27A59B80D42
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B861BC36AE8;
        Sun, 19 Dec 2021 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935659;
        bh=FQ0J0EPHlUGG7WlQvSQBhY4NNDN6WDEdSYVSFJwhhvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFMCmG8TWc1NCiCScHqCannjbvUnIAAz2QySdMx8OL1Hl8Yw1b0Odw1WTYU22+9xE
         pPzNuauJj/vSQQdXgn/ZIlYCIbfW6/pcLlwrKRh71oJlrByVIWeCxLYFIKbUMupNY4
         tGMPR1/L02D0++JEQYE1eUORkrfkPJnzoJQzi38iyzPx52uxjBxbhUpHwLS8vwk5tA
         xMAZWxHAMUKen1Rz9K4O5m2DrXn0xD985V5NUg/ZWo3Fd/5H2Pr2bWH6bodNZm4z/J
         j2clFitJlV0WNoNJkiASJyn1igs04rJ4wFZ+odY9FZww3m10GfOhfAyDo9c4bxagr6
         nSviv0qYW7VQw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 2/9] mt76: connac: fix broadcast muar_idx in alloc_sta_req
Date:   Sun, 19 Dec 2021 18:40:07 +0100
Message-Id: <fe60489b1aea76a7f3f61b2f42431ba424ceb9a1.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set muar_idx for broadcast wcid to 0xe in mt76_connac_mcu_alloc_sta_req
routine.

Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5664f119447b..b150c7f2f005 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -271,7 +271,7 @@ mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 {
 	struct sta_req_hdr hdr = {
 		.bss_idx = mvif->idx,
-		.muar_idx = wcid ? mvif->omac_idx : 0,
+		.muar_idx = wcid && wcid->sta ? mvif->omac_idx : 0xe,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
-- 
2.33.1

