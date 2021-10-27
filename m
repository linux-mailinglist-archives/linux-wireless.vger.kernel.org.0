Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A58043D774
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 01:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhJ0X0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 19:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhJ0XZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 19:25:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E7C061745
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 16:23:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so6748697wrd.13
        for <linux-wireless@vger.kernel.org>; Wed, 27 Oct 2021 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1kzwP0JYJEJZtRxZX6aGDTnXu7MfQJRi7LeHOrAvTM=;
        b=L6OkokghhCoD7PH2pbu4qrnD1/JZBiFujSS4Me9HOY68fZDOkoF53enf+xZiurYxyt
         Cjw4CdK+lXZAOfkPbDKWUisC4E/pOebsGzuaGAABkPzW1PAdvBFP7MAsXyMmygtEG8LI
         EfCDfcm0s0s1L0eh2aD3IlFNttKObqOoD/KwedlJYfCBwEBr/ukPqbE1l+4FP+RDeqqB
         SRKKg3nmCX93AkvOV5cp5Ld7sh/WLJhdsjPkZbZAmzcktXiY+P6Hx3EKP56Ys9eqTJJX
         VEZRIbhaH5vjG+w6RYSQKB/bnzyLDTXwWCPsppKMkyWlgyGve9Qby5PGIqcTjZ1vR0hb
         yIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1kzwP0JYJEJZtRxZX6aGDTnXu7MfQJRi7LeHOrAvTM=;
        b=nsPNsi6EdxtilJRyA8RYnDI6ODFEq/xs9nUatsk70BVaYR5sPfnPJ20Sab2/JQRX0F
         yJpm3RRjB1oakWqtxkOuq6fmcwGpNPdgInZu6tvunYFoaKuiD6Ns6zQOmI7PMUjzrrkj
         QTh7yTeArUOJfrgWXeAMA8WyCb1t5aFtUpRknEFd7lHKkUk8sAxLPYDe+WeUtjZp6+mK
         +W1p7fchzN+O8JJ+PWz99M6vCuWEozfVbkzoQGQ/8bm5jNQAq96XGAhyJvIlSARh6TtZ
         oUjttaZuPo2Lf//ha/dy4XVpSdXB9EOO9IxyvZsKLr/fewLV2MFKZPTSt8py55rJd4tT
         eShQ==
X-Gm-Message-State: AOAM532z4mf2bqUoNv3d/NmOY6Pox2XUCp+wCoAPLubwVQGmFquzr4Cq
        yCgNnvOc6a5vQ7Ydl0oS9gJd/qiM2lCVig==
X-Google-Smtp-Source: ABdhPJzzQOJXPQuyD2scAWy3q9+bqCDpU37w7gjHiBQag+DdVWqKeoZWpbmK1/19r9nG46yaBo5IJg==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr867656wri.226.1635377010436;
        Wed, 27 Oct 2021 16:23:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o17sm4937435wmq.11.2021.10.27.16.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:23:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com, bryan.odonoghue@linaro.org
Subject: [PATCH] wcn36xx: Indicate beacon not connection loss on MISSED_BEACON_IND
Date:   Thu, 28 Oct 2021 00:25:29 +0100
Message-Id: <20211027232529.657764-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware can trigger a missed beacon indication, this is not the same as a
lost signal.

Flag to Linux the missed beacon and let the WiFi stack decide for itself if
the link is up or down by sending its own probe to determine this.

We should only be signalling the link is lost when the firmware indicates

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 599cb220b150e..aee4123035d71 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2647,7 +2647,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct wcn36xx *wcn,
 			wcn36xx_dbg(WCN36XX_DBG_HAL, "beacon missed bss_index %d\n",
 				    tmp->bss_index);
 			vif = wcn36xx_priv_to_vif(tmp);
-			ieee80211_connection_loss(vif);
+			ieee80211_beacon_loss(vif);
 		}
 		return 0;
 	}
@@ -2662,7 +2662,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct wcn36xx *wcn,
 			wcn36xx_dbg(WCN36XX_DBG_HAL, "beacon missed bss_index %d\n",
 				    rsp->bss_index);
 			vif = wcn36xx_priv_to_vif(tmp);
-			ieee80211_connection_loss(vif);
+			ieee80211_beacon_loss(vif);
 			return 0;
 		}
 	}
-- 
2.33.0

