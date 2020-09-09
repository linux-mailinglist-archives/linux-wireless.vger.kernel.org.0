Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74B2630A6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgIIPgN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgIIPfK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F1C0613ED
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so2716773wmh.4
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=Xi/gaK17S7A1P2TqeadY6OnuOBv2ko5+M3uMj9PoGSNOgZUW5DvaG0y24kHMGiqz7v
         +17c2FzRk0CUO6m5FYrb6K75lbtW+5wP+asoLHVbYg4lemsIBIgLiioQq+cb3NJ3E11V
         d1yxfZe/rHr9vjnh6QvufcfaUJI9P18H8Edac/FgaJ7sIg0P+6PrhWi2aW5I7VWeKHCe
         dU5kfU3U0wH1HWnikYLo45mk6D1O5VfH7cdWIlsuqKr0CsfXBb5AIiKo4UpzMISF2XfQ
         fWj8AbM+BycP6RTHPrxGSgX157+PtFIPbebOM9flbJeXtujxSZFG05ihSA0f1g3T5/Sl
         wF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=akooimqAeVN6HoPZkUvdfaxJPy0St7isyG6v1zTHbnJAn6nw9+R3YX61NB9MjTI0cW
         cck1fsxzJyyBVUdBNeU2vtY24gaeS+qwOK3Ppw88wxWbjLYu0l+f97vEgzkZOdMyZUP+
         zR50QbZ7hWd30JC6lstowym0iBqfXuWvZtBDPPaSYtoGM00ES9NkO0/3FNbKkQ40Xo2P
         Sm9GZE1dyD2EsEy3hPDJFmrhzS1ZyONise9OrAEzfPGLPZns1Zh4TF0OwUWCzJ3ID1ou
         ci2RES3uk1FyzkF6urrDz9ww2luUP+8R4Bx2V/gotsoGQTx0qpngQuKUxdPGGG5RNYdD
         /pww==
X-Gm-Message-State: AOAM533L2775dOitH203mLfWW2hiE8o01zTYfm6DJenxpBqPimTn/V+S
        WzG2fV8+ASNrEQVleJVy1/ixLQ==
X-Google-Smtp-Source: ABdhPJxTqvtrc1zOFoAyYWpNxD2EB5RfVxZAvA2eOM0s/z1Vd91w17JVPlYYXC01QiJHRQtIR4403Q==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr4298855wmb.95.1599665708121;
        Wed, 09 Sep 2020 08:35:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c4sm4922120wrp.85.2020.09.09.08.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/2] wcn36xx: Use V1 data structure to store supported rates
Date:   Wed,  9 Sep 2020 16:35:54 +0100
Message-Id: <20200909153554.2904762-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153554.2904762-1-bryan.odonoghue@linaro.org>
References: <20200909153554.2904762-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch converts the internal data structure used to store data-rates
from version 0 to version 1.

This allows us to extend out the internal storage to represent VHT
parameters.

Using the extended version 1 data-structure allows us to avoid a whole raft
of version 1 specific fixup functions.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c     | 5 +++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 55aaaeb78b14..d5ca9907af86 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -242,9 +242,10 @@ static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		sta_params->aid = sta_priv->aid;
 		wcn36xx_smd_set_sta_ht_params(sta, sta_params);
 		memcpy(&sta_params->supported_rates, &sta_priv->supported_rates,
-			sizeof(sta_priv->supported_rates));
+			sizeof(struct wcn36xx_hal_supported_rates));
 	} else {
-		wcn36xx_set_default_rates(&sta_params->supported_rates);
+		wcn36xx_set_default_rates((struct wcn36xx_hal_supported_rates *)
+					  &sta_params->supported_rates);
 		wcn36xx_smd_set_sta_default_ht_params(sta_params);
 	}
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 342ca0ae7e28..d7d349de20e6 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -169,7 +169,7 @@ struct wcn36xx_sta {
 	u8 bss_dpu_desc_index;
 	bool is_data_encrypted;
 	/* Rates */
-	struct wcn36xx_hal_supported_rates supported_rates;
+	struct wcn36xx_hal_supported_rates_v1 supported_rates;
 
 	spinlock_t ampdu_lock;		/* protects next two fields */
 	enum wcn36xx_ampdu_state ampdu_state[16];
-- 
2.27.0

