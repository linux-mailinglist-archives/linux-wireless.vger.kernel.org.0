Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073EA1BF3D8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD3JLp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 05:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgD3JLp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 05:11:45 -0400
Received: from localhost.localdomain.com (unknown [151.48.130.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2824D2082E;
        Thu, 30 Apr 2020 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588237905;
        bh=qYKXVG525kcJYMIpXLoKjSYurQvdHvTSRuEfaeMk4yY=;
        h=From:To:Cc:Subject:Date:From;
        b=Y/ol0t36QSC6XGcwK/CbFwNLDMtMkN4wSRFp7MnS8h4QDE8y0bKxV+emA1jANVzBd
         DkKP/giRlPvc4oo66n1/Jk3Ckkaq4unbfUwk65x9j38YoWtoNICST0IgyYWNGlVJdq
         ofC4LX2hMBjuMqT5E23uwZhMHc0ROLfp8PBHIL1w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: add passive mode for hw scan
Date:   Thu, 30 Apr 2020 11:11:34 +0200
Message-Id: <db966b257f8e19d243bde38a0694a86375a6c9b2.1588237791.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for passive frequency scanning to mt7615_mcu_hw_scan

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 727a55abda69..6d536088f6c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2737,8 +2737,8 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
 	req->bss_idx = mvif->idx;
-	req->scan_type = 1;
-	req->probe_req_num = 2;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
 	req->version = 1;
 	req->channel_type = 4;
 
-- 
2.25.4

