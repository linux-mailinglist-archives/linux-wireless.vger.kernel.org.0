Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34B2649B8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIJQ37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgIJQ1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D05C061388
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so7087643wrx.7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pR28QrbC3Qp/45XzrsEFlxa09WTW2fIfPYIJsPSPstM=;
        b=Ua8RLmZgvHhFmZ7X1U1eUnc9H1y9XGsxdUX52vubpBKKQ/tq640o7R4nwioVeGX9EL
         EE0FNjwkhycEkBmFOfiBJkHRaQDb2NoqF7C34jwJS70y58dqqL7OBOOMERNC5bSWNNvi
         xal5a6VF09k68OOT0GmXd8qvcttfqeYhBxUKaj4m4kdu1mSIXf550Hb2K6wz5+iUT2Kg
         151PfcbyUjXQvmyJmCYiqh0UDZ9Q2xxzFk8Lcs7tnopXH/yg8zZ/hQ4QCPAGHX4uXgX1
         gmvRGbM4opuQ9Z5Zx1XQpycqBah6c+f8PYJfqVA6vbvmZd2BifOTMHeUkDYm6Ra8FT4n
         6YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pR28QrbC3Qp/45XzrsEFlxa09WTW2fIfPYIJsPSPstM=;
        b=PVEBySOZihMDR3+0bcjt6RX3skxDBfVB5AuehzFVBQs/+6wm9Spdp86/nrBOV2wOjF
         mSAODXdTbZwQd3+buGOavqszV1LRfZGUVmcA9SXfQk42CcsKRkC5NuUGpaAOFC33uk6k
         rqvX44bUa0vB1JL7XpDtGDRwlv2tCPPsVnLpCROQJXikhTRhbDRVME3Lnz+3K6SFX36k
         jQtnVnsCBAZ59OHh6//eCUYafQyV6iuoci8wQqo5U/q3OUDmevnYI//GO/TZa+EYoj85
         3gilh8a2J6AQ9lUco6VdNAVxtDEnOUhl9pccsJWPSB8T+1iyMdPlIixdel0MKHvBprpE
         UF0w==
X-Gm-Message-State: AOAM530QL2X4/0z7UfE92Rq6avFjLYFGlbIcm7UJ55wyMk05LhLGgW57
        fpUjejc6p7SM5oD+GdPdPNlYrvXwDth9wQ==
X-Google-Smtp-Source: ABdhPJzUKhP/eKVKo2svyWOtoB8nwj5NruHqHuQ5DfDlqwpSfAwn8nIolQb8kXQyMN3R+p95hOKg1g==
X-Received: by 2002:adf:f70d:: with SMTP id r13mr9716075wrp.317.1599750424162;
        Thu, 10 Sep 2020 08:07:04 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m3sm7597315wrs.83.2020.09.10.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 4/4] wcn36xx: Latch VHT specific BSS parameters to firmware
Date:   Thu, 10 Sep 2020 16:07:47 +0100
Message-Id: <20200910150747.2179122-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150747.2179122-1-bryan.odonoghue@linaro.org>
References: <20200910150747.2179122-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit makes use of wcn36xx_smd_set_bss_vht_params() to extract VHT
parameters from the 80211_sta structure and latch appropriate bits in the
bss_params_v1 structure for transmission to the wcnss firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 57523a66a8ee..dde43a2b0d81 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1702,6 +1702,8 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
 	bss->max_tx_power = bss_v0.max_tx_power;
 
+	wcn36xx_smd_set_bss_vht_params(vif, sta_80211, bss);
+
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

