Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB928396F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgJEPWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 11:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJEPWg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 11:22:36 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4FFE20774;
        Mon,  5 Oct 2020 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601911355;
        bh=Y+xmcvLQl8la+bFRA4zZcWjFYNeHbUhN3n2dLq5K2GY=;
        h=From:To:Cc:Subject:Date:From;
        b=oBhHLh3KhVzA8tvptAq0tj9Py0XgYwSB3O9+3s6kkeHrenyZAD4VZeJQSSopolQxz
         IvG8u2gWkzATDe3HRoi1ZA5vigTfSa4Iys/0j5k+zax8rqAoBYABSaAtjluSwKrpb2
         wqPTSM2PAdcMi/9PPjg1Dzh4CsOhlCUpAYQPK4pk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663s: fix a possible ple quota underflow
Date:   Mon,  5 Oct 2020 17:22:23 +0200
Message-Id: <e074d0fbefd983a5283700d5e424f2503403608a.1601911100.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly account current consumed ple quota in mt7663s_tx_pick_quota
routine and avoid possible underflow.

Fixes: 6ef2d665f64d ("mt76: mt7663s: split mt7663s_tx_update_sched in mt7663s_tx_{pick,update}_quota")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index a4969380c860..77377c208064 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -180,7 +180,7 @@ static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 			return -EBUSY;
 	} else {
 		if (sdio->sched.pse_data_quota < *pse_size + pse_sz ||
-		    sdio->sched.ple_data_quota < *ple_size)
+		    sdio->sched.ple_data_quota < *ple_size + 1)
 			return -EBUSY;
 
 		*ple_size = *ple_size + 1;
-- 
2.26.2

