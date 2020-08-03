Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967FB239DAB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHCDLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHCDK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6D7C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so22235851wrc.7
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIUGdWACF4QakLBskliO4hK5XoeTeWQ0rH1gMULYYzI=;
        b=lSTTisHejqVgyFob6lCGtFivdaianmepW5eZaT6gi1E2MbVZQaOGuCmFzmbLabm/Z5
         1ppcUw3IuXK7aV4iKRD/Oka64Wa8H3Hxi/U77Y6gVD/gLXouuRd8Wdb/5I6BeC8c3gFI
         pFRK0ev/7k5fvfuytKklk5PkQNPm8l9d9LijrosGuEHkmizSOlMr1rxWBj2cP43QE7YG
         m966+jQ7qB4kCwImb0WLvzCJfkt1MhwVNrpodoeSLgptg51aURO/xsU5OT8kktkIbv++
         yANVItMY57yfKJ8oRrax9bHJEMwo+GRdK+1lBxIptez9WfYEyj/i761zCtkQ2e0zHUdJ
         edcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIUGdWACF4QakLBskliO4hK5XoeTeWQ0rH1gMULYYzI=;
        b=oVF9vEq07nTr5KxRySH5Ck8O7PzcSoW8NmBXfMB+VYy3bA1kfjMh/xFQBKvMB2fVMN
         HafuEaL0/+6yB9neswO8+rsyBOgbZZPUv59avjIi+mtk4YSZyY9H8u0Pt8f2mlP64zy7
         eE7vTOMX5cJwZ1DnyRbKUbXYRJMX146bNPID9qX1VbnoG2cMbn7U5OUbq6bl+2yGRdlf
         2HkJqKBsLwcDspChdDHQhoTTZp9T8WrCsWcU+f4Gcs2PxCTGPA5KLRMxC0LJtzMndara
         1yFiTx+sfVW4OPLSSKFI0RGKemB3rWI5vZFqt+MbiiDTt6Efrce4KaxAd4pUDgssShx+
         jYdw==
X-Gm-Message-State: AOAM533sgAV9aW3dzOlPKOLUUKiLL3SJ+Ale0Po+E9jJqX5W9UAVE+bW
        nYW3exWIYqZn25w6T2I0/cOK/w==
X-Google-Smtp-Source: ABdhPJxHU1IeOqNxGvkDWP6pWvMA0B5HjdJSqUNB4GLSN42IsCkHdDygX32C5ja4Z2+eeZxEM1NjGQ==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr12968808wrr.151.1596424257705;
        Sun, 02 Aug 2020 20:10:57 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 10/36] wcn36xx: Use V1 data structure to store supported rates
Date:   Mon,  3 Aug 2020 04:11:06 +0100
Message-Id: <20200803031132.1427063-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 661742cba1c0..a4e45114991b 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -241,9 +241,10 @@ static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
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
index 821c4ce61afd..c3615704b543 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -168,7 +168,7 @@ struct wcn36xx_sta {
 	u8 bss_dpu_desc_index;
 	bool is_data_encrypted;
 	/* Rates */
-	struct wcn36xx_hal_supported_rates supported_rates;
+	struct wcn36xx_hal_supported_rates_v1 supported_rates;
 
 	spinlock_t ampdu_lock;		/* protects next two fields */
 	enum wcn36xx_ampdu_state ampdu_state[16];
-- 
2.27.0

