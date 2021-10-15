Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB142F1FB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhJONRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbhJONRy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED402C061570
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k7so26308005wrd.13
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPQUXx6r43e3Va6Xi24ZwKwKL/BEA8D/kNRa5oz8574=;
        b=G296r4PIby4v3IZVzR/9IYrP/h0gNhSuQaY3Khm2sxUIAxlok1520KstWLMF8qgJLF
         /+ypUIMdu3Ay64kqhzg+U/9O7sdxnY8JMzYeoZPcqlvQ4F/j4UVIq3Gj8LQ5jj2ln4Hn
         AA4K68Tsce4m7t0AW+Dg3fMUmrpJpH5pINJJSxu/r4N9DbHPJQ5tlI48oFamsHs4welh
         6waWm+FGs/eOGyiqG7727UwWG7WgTFZNS6iB1IYDj2n9YGP+gDCVfzaZQmHx/1PM+ipE
         nueGq0ZKGhVMxRXKe1En13C6RF3pA9lENdw8dAgkyREf/wfeqPUnC8Kd+PjJsqQarhQJ
         SFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPQUXx6r43e3Va6Xi24ZwKwKL/BEA8D/kNRa5oz8574=;
        b=49t411GdW2NCyWeXchooM8AN75yjxBFNUz7D08nIYGQL+4+0xzjEhmokh1ijH4dDAh
         nvrrIchQ/WeFsl2PEzzYT5cynvrYnkdnKiwY27xlEJdZbLmLxTju9GgzzE3RKvWWI2Ia
         fhgw05aiKaOpj6GVdX0CFMMrlzdzgENb92TvS7J4wWIYK6zYLcN73xMHWGBL1B2IEJjd
         bGR/SZeAT6QJVZ7JHyO8ov0axF97a+/WmXjc/uidnp/nrXQ3/Ogyxzi7qjHdCF4Pv3Tm
         puN5Jm6ChCrYd6SAt27AHEJnoinueY8T1ITmzCweQCrcqk0MtP1pvMUzkFs4ER67nJd5
         0byw==
X-Gm-Message-State: AOAM532OQ2PWE0rwTnF88hJh2JEEZ5PevzjHBbZDBbgt8y+o2Qlrnfoq
        MIW2/VCKZYPWbxNtwhDQ1PeDlQ==
X-Google-Smtp-Source: ABdhPJx7iWWPoAjQJ2UOkAUCJeMYJaXpGKIo7gybDGCdqY2vs5t7gyHE4hb1EefyZCIT5mGX8iQ3Vw==
X-Received: by 2002:adf:b31d:: with SMTP id j29mr14267046wrd.429.1634303746417;
        Fri, 15 Oct 2021 06:15:46 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e8sm7091716wrg.48.2021.10.15.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:15:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 3/4] wcn36xx: Release DMA channel descriptor allocations
Date:   Fri, 15 Oct 2021 14:17:40 +0100
Message-Id: <20211015131741.2455824-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
References: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When doing a stop callback we are not releasing the DMA descriptors which we
previously allocated.

The start and stop callbacks can happen incrementally depending on usage.
Failure to release the DMA descriptors leads to a reallocation of the DMA
descriptors leaking more and more memory over time.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 13e9a274fa26a..e89002502869a 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1037,4 +1037,9 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
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

