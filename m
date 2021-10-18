Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D053432A2C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhJRXRl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXRk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5DC061745
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so726003wma.4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBnRHV9rerfqg5IbeiF/8rK0T34zBtjkpRvTdqdQUlc=;
        b=aFg91Sh9YmPW83M7zi+C8pWgz62P6/sn5LKCIc9U7zuatO2d5tXhdcNnFqrVmF5+kD
         MqFLmWBOxaq4QZLDqitIM+SY+FSUnT9wMdAADtwfMpVcJ69bTwjVWZMek+sw/yUTsUe3
         y7NIksZ2WyGbJxBQmmkvIUTjLA17fNheH9OKFf0j28dprpaGdNkEdFUJJntMlRASQlMz
         OnvIfli9ErvH5YbHqmnM2pXqY3sLMgJ6QRC9j+BLygiz8XxaVkc2riPJIX2EjYVdIe55
         SgXLXHiY173sCqYAWfUiZFZAdjiXyvbPfwlTRo1e0zuwRGqb5Wi1fTMlhKt/9+9Dof+t
         fgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBnRHV9rerfqg5IbeiF/8rK0T34zBtjkpRvTdqdQUlc=;
        b=Bsph8JaqvlG4cdEuNEmeBIqW3O0iu/0pxCnax8AyCAfgb6KTjTnmM4IEAdQvPyJei6
         2W+YdSa+h9NZJ3yDgGiC0uNtmRqb1KTbe42yMeid7uPosFWWEv5hzoSRh2N8/D3tY8AL
         Tn4qy5qfLpAwARBLY7s1aoZzudY/tkXK8EDuXAiG+qL7P9Wn/IBipUKkEtNWgFRcrie7
         VrsldWF/IXH4HL+/mKARq+wh2klzXOILhu6OS6I3TxYprr2wNZ56ghuay1vHfTMTOgcN
         7YMX0evo/mELkvWtizUncc8vRG/JcChqH8Yhmq7W7C7B3sMv8ZGHmP1c2lt3AT75sk4p
         stNw==
X-Gm-Message-State: AOAM533YaQCKolEKyY2Rnspo1oxtdERludRphygmO1v8dDmEHQdicyL2
        rG0KvB4LZuU3RhC9D3KVgqqa7A==
X-Google-Smtp-Source: ABdhPJzHs4xBg3zLrJIi0UafgxAzeqptHLVqONWwzsnBe6ieVbS2qxISzEYujUv7rfwt1BSRyo3wLQ==
X-Received: by 2002:a1c:5417:: with SMTP id i23mr2014312wmb.17.1634598927213;
        Mon, 18 Oct 2021 16:15:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 3/5] wcn36xx: Release DMA channel descriptor allocations
Date:   Tue, 19 Oct 2021 00:17:20 +0100
Message-Id: <20211018231722.873525-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When unloading the driver we are not releasing the DMA descriptors which we
previously allocated.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index b832afedde76a..30f4484b336c3 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1084,4 +1084,9 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_l_ch);
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_h_ch);
+
+	wcn36xx_dxe_deinit_descs(wcn->dev, &wcn->dxe_tx_l_ch);
+	wcn36xx_dxe_deinit_descs(wcn->dev, &wcn->dxe_tx_h_ch);
+	wcn36xx_dxe_deinit_descs(wcn->dev, &wcn->dxe_rx_l_ch);
+	wcn36xx_dxe_deinit_descs(wcn->dev, &wcn->dxe_rx_h_ch);
 }
-- 
2.33.0

