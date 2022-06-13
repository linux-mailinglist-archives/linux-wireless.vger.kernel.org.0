Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41F5487DF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiFMPBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242962AbiFMPBY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 11:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E78EA89F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 05:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3E560D57
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 12:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84587C34114;
        Mon, 13 Jun 2022 12:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655121818;
        bh=kTAkhvM3Lw7dZhEszrD3t69FD2AF6yt7tgJKDF9GWhs=;
        h=From:To:Cc:Subject:Date:From;
        b=m0LZU0dOxWud8YJuYayQwxcuPGJQ1DhbUiyOXjAn6as7TAyP/ItESNJLSrDVixhiU
         CJG4vuc9cvx4OGicDn5XBr2Qu1lCRCM1E3lyTMA14wRD06GjFIixZf60WyHPterpn+
         tNqW4Yw8qL/VFr4qyAA0jbU5hOTaBRby90zD6K8Kab1CZTKoK4KgeHbq7YKALfIKp2
         sSp3AtJJpf0eg2QB3sxg3Dt0Nfziad0EtGhcKibBaNCnuU0N1P/UcPKnTK8rdrMUwi
         YpOjsY94VAGG45J5D+iB+cvx39pzJfQsJW0QSXYWm0ETOKzd6ie/0qvBxQhreTTZfp
         NH9aEn9JZgxzw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: do not update pm stats in case of error
Date:   Mon, 13 Jun 2022 14:03:28 +0200
Message-Id: <84b00fe0e608523e52d2da385250997b5ff715c7.1655121764.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not update pm stats if mt7615_mcu_fw_pmctrl returns an error.

Fixes: abe912ae3cd42 ("mt76: mt7663: add awake and doze time accounting")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 52635fa430af..294a6f0e0136 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -338,10 +338,11 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	}
 
 	mt7622_trigger_hif_int(dev, false);
-
-	pm->stats.last_doze_event = jiffies;
-	pm->stats.awake_time += pm->stats.last_doze_event -
-				pm->stats.last_wake_event;
+	if (!err) {
+		pm->stats.last_doze_event = jiffies;
+		pm->stats.awake_time += pm->stats.last_doze_event -
+					pm->stats.last_wake_event;
+	}
 out:
 	mutex_unlock(&pm->mutex);
 
-- 
2.36.1

