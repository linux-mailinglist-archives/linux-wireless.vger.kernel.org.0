Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297B7AA6E7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjIVCL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIVCL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 22:11:29 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3D96197
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PPN73
        JPVs2zU8lbSZDzOTC1b0iLHfDA0FrJj6Yl6Zvo=; b=YKuBCfSvHcBWgRiV+Yq7U
        wIBWsEFGwH8qf+Idknyvs+Oi9Idy9Bob8zg41/7F6XLk/NeXBqTLVe1mgIjoZVg4
        0mHiTCdP74oyNEuQSfiHXhW1HldSn9fZKLAl8N95xNuGRQhwqaekivt4lbW3amYy
        qE6uOZg8c6khcvvcj1OJhg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wBnMzSe9wxl6Vb_Cg--.10083S4;
        Fri, 22 Sep 2023 10:10:46 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] ath12k: mhi: fix potential memory leak in ath12k_mhi_register()
Date:   Fri, 22 Sep 2023 10:10:36 +0800
Message-Id: <20230922021036.3604157-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnMzSe9wxl6Vb_Cg--.10083S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4UtF1Uuw1DKr47XFWUurg_yoW8XFy5pF
        4fWr47AryYyF4rWr4rtF1kJ3sxWa93JrWkCrZrG3WrCrn3Zr9xt3s8Aa4fXryakrWxGFWU
        uF4Utw4xX3Z8ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziGNtfUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRzyC2B9oNj+MQAAsa
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mhi_alloc_controller() allocates a memory space for mhi_ctrl. When some
errors occur, mhi_ctrl should be freed by mhi_free_controller() and set
ab_pci->mhi_ctrl = NULL.

We can fix it by calling mhi_free_controller() when the failure happens
and set ab_pci->mhi_ctrl = NULL in all of the places where we call
mhi_free_controller().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 42f1140baa4f..f83d3e09ae36 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -370,8 +370,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	ret = ath12k_mhi_get_msi(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to get msi for mhi\n");
-		mhi_free_controller(mhi_ctrl);
-		return ret;
+		goto free_controller;
 	}
 
 	mhi_ctrl->iova_start = 0;
@@ -388,11 +387,15 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	ret = mhi_register_controller(mhi_ctrl, ab->hw_params->mhi_config);
 	if (ret) {
 		ath12k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
-		mhi_free_controller(mhi_ctrl);
-		return ret;
+		goto free_controller;
 	}
 
 	return 0;
+
+free_controller:
+	mhi_free_controller(mhi_ctrl);
+	ab_pci->mhi_ctrl = NULL;
+	return ret;
 }
 
 void ath12k_mhi_unregister(struct ath12k_pci *ab_pci)
-- 
2.37.2

