Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F492A2901
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgKBLYg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgKBLYc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668ADC061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so9018662wmg.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=rK8Q/Uw4o4vzZuZdZ4a12AEzk+lH+7EMxb54ZjsaAzO2IyN8XQEqgOTbJNrVYWL1L5
         ZkmoSKvRdZjYgs1bVoUA+X27NSr/6z87bnkv+D58Y5RuHVFmgEUlXj00C7pfl1pgphUu
         cnYgt02K8T05rU3Z5Ya7jJ3ll+owAkkvavLKgUOi3+YWOcM1uqaMqDqpIsgzt6muQBgT
         VyAAa6axy4+Z66UDH9TqnxBdULJDxxEPuAzTkOvKIh1pF6T+EbCD4tvuom+pmOwNMbJX
         gyzqGuVLLFqK87T+sivKlZ+PNxP/2Oe5kkAOWMytK/XAOLqqKvq/amZzhBjHo/v65v+d
         8j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=My80LrUZ3r7z5bAU05pKSBcH17QwGhZZXacS9ZeKqpZ5O5h1rdlDo56zuH2cbEPNMG
         ZpiNmPtK2FW48yCvYy0FKNl3djofQEdjr+76KJ5XdIgSPuT8KVU03EoPCDQEFuMa6Y+d
         Yv8uCGInSe9UdGSNEOAOrnAZx7khM8N+KrDSiqeIOBXXlCkcvHhRZCk3Zzff4mQQeAx1
         r+FMU+e2UG8W3C43pIPFtyXOCcB/GvBla9RcFdyWVATgB0l7mREzI+rBaKuxq+tTguki
         o1jFpzcmPreUNF6H7ncshW7BbuUBzZTcP23kbQtFMEvfXgyOlphtvCZuBytNkd7Ps4FU
         912A==
X-Gm-Message-State: AOAM531MpcTx660viKoGAsJWp9gLD/lKrYljuAUq0nFGxxjwf37lgm/g
        AQ7+ghUd9NOspaYuH8/yyQzBlw==
X-Google-Smtp-Source: ABdhPJwA91tKEgsgkd8SoO0bfyTHukOwzFNhDYUGhZwKs8yhHtgnKh2ZKkGWfJBeLjvEurPjz+sxPw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr16833456wmh.46.1604316270170;
        Mon, 02 Nov 2020 03:24:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 10/41] ath9k: ar9330_1p1_initvals: Remove unused const variable 'ar9331_common_tx_gain_offset1_1'
Date:   Mon,  2 Nov 2020 11:23:39 +0000
Message-Id: <20201102112410.1049272-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h:1013:18: warning: ‘ar9331_common_tx_gain_offset1_1’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
index 29479afbc4f10..3e783fc13553b 100644
--- a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
@@ -1010,11 +1010,4 @@ static const u32 ar9331_common_rx_gain_1p1[][2] = {
 	{0x0000a1fc, 0x00000296},
 };
 
-static const u32 ar9331_common_tx_gain_offset1_1[][1] = {
-	{0x00000000},
-	{0x00000003},
-	{0x00000000},
-	{0x00000000},
-};
-
 #endif /* INITVALS_9330_1P1_H */
-- 
2.25.1

