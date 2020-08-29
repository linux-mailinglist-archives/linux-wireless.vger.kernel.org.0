Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E16256467
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH2Dib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgH2DiM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B0C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so899272wrw.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x14bAIQMwOQ/wd1IM8KwbT5bU9D+bQ8R4vcYDwgbN5g=;
        b=vvG6htBBheLhm1ujXdXNj0loUhvt/Xo9DHfkOqPTTdzFQBlyza61Q/FdBGhBCfB0bF
         SYVFOMH1wVjVtek7wzr+jY326+atNrg1iRqvnX1TAGjKvczHgR+tQoce/DuHvbaPXYHq
         B6TghRyXDsKUnLvgopI4f1UA/KYsof9ZK9awUTqL+kUT9bRgbBol1aiz+SGHts230k/l
         N3CBORCoutU435tD5Z/GBOaNHq8dPWj8sQWIXvq+67S9n+XEgZVsvjF3+mSxr6NQDYz1
         BD8GkP1zF1C5aNmniy7J51RsceFN5sccwGPighaL68EF5Ur+M2iFEk8mQ11JVamU4xxq
         jXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x14bAIQMwOQ/wd1IM8KwbT5bU9D+bQ8R4vcYDwgbN5g=;
        b=XWQPiI5nWewA1pYdOt1WlqthEG9YDTA278YZfWfOfk7VMktadOF33CM61UK3ZuJ/dc
         s0JgsVDZQsjRqOYGtw8Q3c2dD0WSj4eseV2ctRM4wkkMTQ2rf9thgMkxrRXWVkSS+Qgz
         c/6xXVADrIANQ1qTbRlhlnQio/+VjFxeri561Wi5O6xTLnE9TuGVKN7sYOAFvSVUbkT4
         bESDwerFM20Xr3xLSu0ZAzcP18TG7NfIzlCQc7NqAqrEh18auqMUZ0nJoylbak4h5Ej8
         klK8h2OqrzGiyXKWouzl82Jlbx4VnPgA3ja9Od2clOtWXHq/qPALY8HGA4mxR8GaHBeU
         D+qg==
X-Gm-Message-State: AOAM53295dcRGcFJYZXRFBbJFhehVoNmzIBaKsXPrNRXFrxiy/KrOPDO
        g91wULY5G7D11RfWMO4QfpFnxQ==
X-Google-Smtp-Source: ABdhPJxwkDLVtqN/iBaXw4DPjHIyTobXpAOhuarJbOUpVb+lyxlGylUVpwEDwwOkRzggVojKgfTHFw==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr1700858wrs.126.1598672290496;
        Fri, 28 Aug 2020 20:38:10 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 07/10] wcn36xx: Add 802.11ac HAL param bitfields
Date:   Sat, 29 Aug 2020 04:38:43 +0100
Message-Id: <20200829033846.2167619-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch enumerates four previously unused bits in
wcn36xx_hal_config_sta_params_v1 describing

- HT LDPC enable
- VHT LDPC enable
- VHT TX BF enable
- VHT MU Beamformee enable

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 30476f857d23..c7661fb50c10 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1515,7 +1515,11 @@ struct wcn36xx_hal_config_sta_params_v1 {
 	u8 p2p;
 
 	/* Reserved to align next field on a dword boundary */
-	u8 reserved;
+	u8 ht_ldpc_enabled:1;
+	u8 vht_ldpc_enabled:1;
+	u8 vht_tx_bf_enabled:1;
+	u8 vht_tx_mu_beamformee_capable:1;
+	u8 reserved:4;
 
 	/* These rates are the intersection of peer and self capabilities. */
 	struct wcn36xx_hal_supported_rates supported_rates;
-- 
2.27.0

