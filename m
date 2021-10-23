Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA74382A2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJWJdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhJWJdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:33:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582EC061764
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:31:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so4928560wrh.8
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1LrwkQbP7sfpbqmLQsN5x9L0zIaxQSZaDDdmvb0AGY=;
        b=Td9EvgVGNfw4Rexw8QhgZjfcmpmZT+W5YQTaiF1kwKI7BxMXlKDCPn+nj2TAmalzQQ
         aCr7qnoRQVo/SuJbJJ03WlNvrTkNr00iGUc/tE60tqnjwxVFEP48Y3Tf3vNUrZ2YivOZ
         SLh1u9FykYjGzplMyCxFNJ7w+bjjLS3IGSoTJzwnj7hbSIrboaEUsbROeCBfo4g7mlx4
         I1otzajm+rsNb1VYPI2Tkn5Yiy6oFQm7sQcLkCC4PiNcjHI6EbcFqtAMI0y2aKe9nyPn
         UVzv3rvwJWNVv1AqNubWUp6c1xmYlnSdIXOVkpwdicngfCcw9N3v9ykd6OUy28i+FPw/
         4jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1LrwkQbP7sfpbqmLQsN5x9L0zIaxQSZaDDdmvb0AGY=;
        b=Uidk5gd16ojhejRiOnM5rp1ggFIs3c5nR5hF+gayTWJwX3zrqbK9ahqcgW3Vokxkb1
         BeCNNhuPk4Astm2svwAkdLgyivLdlgU9bOw7ReDwBJCWcID5M7NTMgjBon23DiYfzzzQ
         H23PeZXlOUCzii6xGOOfOJN4q5g8F8+FiKqJ9s92rf3X7MN2NIqs0cwxan8wqBGf6V4u
         QRecJA5yBp1hXY2LVQCrgIM9O7+UhzZFaLOupkQ6rxvDamVtttOshCkzXaepeh5mICbd
         s0LVQUFFRjsrhwPK4JqyX4Ob71XrS3+oZWD6DnUpXAoTYF+7OnpsruOb6bY6itAPY+9f
         9nKg==
X-Gm-Message-State: AOAM531K643zXrDCCLqnKpAkWf8BHSLp+atRZgqXuORfLq5GgWHNDTj+
        YDaa0AR2zfy+OVAUAQ/UgxL5Cw==
X-Google-Smtp-Source: ABdhPJyLMGWXtcZ8ocYlnImCsPZ9glpMG6+61Ir6RqUMli1caJpftd9uCRDk2xaTH2Anev5AeMlKBg==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr6548968wri.243.1634981459204;
        Sat, 23 Oct 2021 02:30:59 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t12sm11456977wmq.44.2021.10.23.02.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 02:30:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/1] Revert "wcn36xx: Enable firmware link monitoring"
Date:   Sat, 23 Oct 2021 10:32:57 +0100
Message-Id: <20211023093257.2849565-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211023093257.2849565-1-bryan.odonoghue@linaro.org>
References: <20211023093257.2849565-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.

Fixes: c973fdad79f6 ("wcn36xx: Enable firmware link monitoring")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index dd8810fd76a3d..fd8b2753da7dd 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1334,7 +1334,6 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
-	ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
 
 	wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 		BIT(NL80211_IFTYPE_AP) |
-- 
2.33.0

