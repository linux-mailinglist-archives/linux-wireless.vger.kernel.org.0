Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADE4D8F1A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 22:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiCNVzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiCNVy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 17:54:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D235266
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 14:53:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so21784273edu.10
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nlDmleCWlPyxEiFZ9UL9nqrSJw2NZiKtyYgJO1iLVw=;
        b=NJSHvitCF55xFNO/tX7+S933eZgG6cVJzA2CxouUrgPptinFdz7Pc4OiRlrCBS0GvZ
         LpFpqOh7c8zW8ysdMtt5nWhfw64pmcDnKSh83KOto/Tj1a76dnbynbcb8OV56rP/J2JV
         aOV48sUYEDToyt4hWDRfYXrooR0QZQtbkWvODfz74fVM7htQHvFMS/Xf27Fp9x0Mvjiw
         CCy0kHX74KelKc+8SXw8iCkcnWFlNWLMwW4y3FMXPmEAKs1JMf5d1nCodljbJ+u90A1R
         ZnjMxYifZj1SNFz8q7wjR95WHsOaOHfmRw3v6WmtiGXeX9FL990qlKGlQunxK7Mzl0h1
         OIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nlDmleCWlPyxEiFZ9UL9nqrSJw2NZiKtyYgJO1iLVw=;
        b=ilGbsD0H36TgfNZNEP7GLgtCTMO5rxvOBBaE3jqbN0EwoYo8uZI9FTNr0BlvR7K+oj
         sQf9fLV533aLzi7gZ999P4OheVhe4+wQTDIefZwLRu2q2CLj2lwrd91V4nSyrcFrxgoq
         meHmcuR+cVAG+H5qBjo7lKMAm0QkgC3l2kJJ0KZ+QVxxXYvIL54RN5PVwzfamgaVCquJ
         2l6mJkvutJ+L+FYb2NWRpXitW58+VKMX7uX4JI3KARH1lUUgnyLysB0gU0nQSovqy2h5
         14MrzxY4WVcfb1XKEy1AaVe8orAy2shxMvKSmSfULXhCPJkZchgOVCB6SqNW+qqfoUzm
         OzAg==
X-Gm-Message-State: AOAM532LCLA8BmbXxNYexhcvGMW/BQ6muWrmtQINP864yIVgIJ2G8hz5
        PsJOTgat0yUcRQJvfgCmMg8=
X-Google-Smtp-Source: ABdhPJyYVhIRlF6SxJJz3RXNhqtQ23bxQ2+bgaWyxYoZNhPMEiCOO/iIeNZMq7NKl//+XahYC3eyFg==
X-Received: by 2002:a05:6402:6c3:b0:415:ffc9:3a09 with SMTP id n3-20020a05640206c300b00415ffc93a09mr22660635edy.403.1647294825811;
        Mon, 14 Mar 2022 14:53:45 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id qa44-20020a17090786ac00b006dbe1ca23casm1088434ejc.45.2022.03.14.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:53:45 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] ath11k: acquire ab->base_lock in unassign when finding the peer by addr
Date:   Mon, 14 Mar 2022 22:52:53 +0100
Message-Id: <20220314215253.92658-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
held when calling that function in order to protect the list. All
callers except ath11k_mac_op_unassign_vif_chanctx have that lock
acquired when calling ath11k_peer_find_by_addr. That lock is also not
transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
The solution is to acquire the lock when calling
ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.

Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d5ec92..5db2333478a2 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7077,9 +7077,15 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	WARN_ON(!arvif->is_started);
 
 	if (ab->hw_params.vdev_start_delay &&
-	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR &&
-	    ath11k_peer_find_by_addr(ab, ar->mac_addr))
-		ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
+	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		struct ath11k_peer *peer;
+
+		spin_lock_bh(&ab->base_lock);
+		peer = ath11k_peer_find_by_addr(ab, ar->mac_addr);
+		spin_unlock_bh(&ab->base_lock);
+		if (peer)
+			ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
+	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath11k_mac_monitor_stop(ar);
-- 
2.35.1

