Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7F264FA9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIJTrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbgIJPEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED95C0617AA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so380104wmk.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=vSDGDst8DcY4fX3LcPTgzEiZyU07n0y66ZY8g3HrAnCmDBT/VdRdCCrdsFh4jhQNzT
         jf5hndZuiHGe0yQnWKCjYq4+wyEG8I0Fm48uvm/N1ul6WMZzBdZjDAjhUHaKD3spbmRz
         ZwGaE3FfejvkewLaKKjyZsdeZgiAclreWQwp/dmJwpIV6RnMWRbyH/ykDdB4IjVN0K/h
         Yx/AWWH5MKPirp2UqUrQH15DH4Uws9RtE3MWlChTtIiQQe1aLCL4S4qZytCYqOmNENL3
         Ma0ANLF+R3bY9RToAXIR84dGSiMejKpiXsy60V9HSsFqUAIUxem37wmqGvvSeFB3pZnD
         88HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=STJ7nOPzSR54EADhRA90ECZ++b08u1QXlVawrEVBOjBSajc6sW2cNYbcfPwgnFbGGu
         8qDZIRMvFdOeyaTEy+39PxOWR0cnAPWQFKTEU+OOqRazHvRNGvQCCQ2gQkDcPDqSnRFB
         rfMV6z0DaDYfc5cUjwynWyceSvN3C2ShiSnqFyusBLAOeLL0BJgMN6mfRXW5SQ47vwXc
         0ZoVN+55eDEy786e6U0Y7xsPz/epANXYMVi1BBb8drsYctTJ6z8GjODtVPeHyHFqKMPc
         TvOmlrn7VFz2hRKhp4Q00ZMsKXtiAkjdbFZGVhTsslXYVBMdHdTwWHE5AMQ8xtpeDPdd
         Tzpg==
X-Gm-Message-State: AOAM533Yko6brcuvPojNsox5aOzQvn9MpjbVcUZa3qBRQv8dE9sGJoat
        IDFeE/197yFhmThjDad0/PiaVg==
X-Google-Smtp-Source: ABdhPJxBELC+xFOxC4UazE1oHhzDFO6NqcaITjlLQ1T4zFD7Mj9CLmGAA1URqDVCk+ZyuiubwT89XA==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr408880wmf.1.1599750249622;
        Thu, 10 Sep 2020 08:04:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q186sm4075754wma.45.2020.09.10.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:04:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/2] wcn36xx: Use V1 data structure to store supported rates
Date:   Thu, 10 Sep 2020 16:04:50 +0100
Message-Id: <20200910150450.2178784-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150450.2178784-1-bryan.odonoghue@linaro.org>
References: <20200910150450.2178784-1-bryan.odonoghue@linaro.org>
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

