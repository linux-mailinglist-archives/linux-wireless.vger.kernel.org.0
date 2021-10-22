Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A914378C2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhJVOKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhJVOK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:10:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9CC061230
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:08:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a16so392260wrh.12
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcIju6DzSkQb8lPtGfhv6geUbqbkXSUeJwkouqW5dOg=;
        b=ERkb/YpnXtDEkKD2XO7i7AAFqhOaL2qeztPyTZaBXHBQOqfrTzI/nui+acwcKsVGYM
         DrCMfSOS2H6jmBZPbMhljhm7VOUfcDiZQiSJ5KJmpuJbKHjCGJP+icXqeIPSf1hcfB3W
         hCEpjPuEMS9RQE7E3gsXWtcPoVovCA84BgtA9H1vOp5crBwV/Ax7li6BOXv67c9PkW0e
         sbNlaWPgEHk9M6Y3wwjXlrtFE6AIsmqKOXaJPfod6Q/Pc3VafRGJqSLpHmRzO3AbEnCb
         eVqs+5FCe9ZkVbL1ckZAu3Xs+L2fqolYHAzf32Q4GJw5KMOUHMXln6ktmqxTN5hR2VW/
         CJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcIju6DzSkQb8lPtGfhv6geUbqbkXSUeJwkouqW5dOg=;
        b=RMTydHM+Y5j7aJ2zO2+NNtsgoz/0HAMCDBMJsmn6fgXAe8FFWi8p9/szSUp5SRumos
         Cao42EzTjihavFt6QyWAv/IyQOhj1DmIRgTuYEskmyUMxbmQU05YhV3FCElPeRuQk7IK
         5PuvpHsHvaCrblh8fUywnXc7fsikavHed2dE9fMih0r1cVAhtfIlxRyGfKxIS56paKVd
         X+XGb/Y6T3FUNbqUQlnVIamy3XyB1ZrbSocK6i/e9yY0Plp0SwicgUsKw/tyShzhsS1u
         lDePDiV9B1gag+h9892/YKnGjuFF/GUJQRSdKSz3/Uxxlbhp+OnwIdAV6pSYhjNBGlKG
         gtGw==
X-Gm-Message-State: AOAM533/RluM4h2wY5hj2B9vNWK3XN322VBZugsDubZ77SjERAfg1iVx
        /oHbMIZ8iCnWYAW41z+8rNQeYg==
X-Google-Smtp-Source: ABdhPJy0bp9NI6m8pcbDcIOThfPlWrveiyn18YnCjY3kdc58boYn0egfQKbkUFKsFTX9IqoNNGMcEA==
X-Received: by 2002:a05:6000:15c9:: with SMTP id y9mr46917wry.361.1634911689991;
        Fri, 22 Oct 2021 07:08:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y8sm3686444wrq.39.2021.10.22.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:08:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 1/1] Revert "wcn36xx: Enable firmware link monitoring"
Date:   Fri, 22 Oct 2021 15:10:08 +0100
Message-Id: <20211022141008.2846454-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
References: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.

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

