Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3843925B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhJYJbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJYJbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 05:31:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C5C061767
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:28:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 71-20020a1c014a000000b0032cafd23b1dso4881604wmb.4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rQNWlf4wNQOqVerP6U4kFygwmmwAyb6RoFKtfexlzQ=;
        b=J3nZxcvXvGlij6iSelsEoadjVyySCb028xHESl/j2SV/muVSTw+B+P/7vuVbMejU+k
         tIqB+QIZJ2rmzRWgpWV6drpFY/DOVNrvVXJ2pkv1+1MBMGPx6YP+WPt5QvE/YrYbPjY0
         w4tMHkYZYovxPry0s/8we8fpkwk1AiOSNicJfDYHtuw0ru7FWyDlnfSOftzadEiN9XGj
         n6NYN+mDp97vooQ4CD5QNacEXtMBguhmIrB/fIyaaPuR2P3bpZcKa6DerQSR8cxWj6Xe
         SBhU7wvSH9Vo3qXWlgTPVhplMLjHoBAxEyKMLAxnXY1k8DdpHjQjJmaWNHnrlKw/H5uZ
         0fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rQNWlf4wNQOqVerP6U4kFygwmmwAyb6RoFKtfexlzQ=;
        b=ZUB37qsliQt4ZrD0IEQcj5o4FF7sAzptqKg715+soMrrtu6Nvwcp+bJGPyCcHBXRoE
         xFGb2ahuno9dVXdEjqjlW9iYwWYzxuXC8Dww0eRm/36X7bTwXsOgGQME8eVJXXQKBI53
         Tf5oVaBfFaogDeHSeyfqCM6PtMYq+lmwVZ/4wVyPg2+VidxzhhHuaGH1OlL9No+xlnZw
         BCUvroH3ocDzGk1029Gt8dau/P1Zi/EONApZc5B4kt1uMBNyQvvXGo2xs9B9YXK/FMa1
         f8V7gwxf0jNRdr4ECrXyNYThYTndGJtDPVgAe2L351GilaFdWM1DPXlrdY3xVK1lyszM
         kEkA==
X-Gm-Message-State: AOAM531iZ+hYZYZakQvwli56w0QRhqwJUbE/Bqy8Zo4cz3BBzMElCGTZ
        hjuTOlGtXCd4ohD5g3wq4boWcQ==
X-Google-Smtp-Source: ABdhPJyPZWvbtm/DFkyTCq+0Y1o6E22bnRLLg53u6r4g3t4ZK7MQOfrkxyjZkiBWAhSkzvx3QTW+OA==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr1629440wmq.34.1635154125688;
        Mon, 25 Oct 2021 02:28:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z135sm20858853wmc.45.2021.10.25.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:28:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 1/1] Revert "wcn36xx: Enable firmware link monitoring"
Date:   Mon, 25 Oct 2021 10:30:37 +0100
Message-Id: <20211025093037.3966022-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025093037.3966022-1-bryan.odonoghue@linaro.org>
References: <20211025093037.3966022-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware link offload monitoring can be made to work in 3/4 cases by
switching on firmware feature bit WLANACTIVE_OFFLOAD

- Secure power-save on
- Secure power-save off
- Open power-save on

However, with an open AP if we switch off power-saving - thus never
entering Beacon Mode Power Save - BMPS, firmware never forwards loss
of beacon upwards.

We had hoped that WLANACTIVE_OFFLOAD and some fixes for sequence numbers
would unblock this but, it hasn't and further investigation is required.

Its possible to have a complete set of Secure power-save on/off and Open
power-save on/off provided we use Linux' link monitoring mechanism.

While we debug the Open AP failure we need to fix upstream.

This reverts commit c973fdad79f6eaf247d48b5fc77733e989eb01e1.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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

