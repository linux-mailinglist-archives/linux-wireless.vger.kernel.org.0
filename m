Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD491B6A7C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgDXAtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgDXAtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A6C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so8182269lje.10
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kg1MYGykeGuf+7Gz3LdVBhQeks/GyQjLKM5JDMAttCM=;
        b=C+J3ouXSWVgccWyf9TxWafuiNHh/gYr9hRY2jo6Y0uACWCSxH8EpqRteAdvzlG/EAy
         IBHsM2fwGxg8sUx+HKyDwRHFe9DdiuLR9LlbSy1IR5KSmNhBaCiMXQ++cF8eltDM4d7g
         p2a10haqFonJAgne3PHA1o0PksPR6zuG9E9bR3kOQcF6/I3BIYh0CUHJ99VxWQT7O+aB
         NRm8i7mgnzkgbwkkeW12m7m7iujDx2UdePo6Lqj2sHzULYsg79R4TQ519sNFKIYCsXu+
         CxpQT/OMhQ8qqxK/tcna5q1zrD75SXpYLM+Kn+hKbCsv4GjhE7U3E8Ol75AYRv4V7ZAu
         PbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kg1MYGykeGuf+7Gz3LdVBhQeks/GyQjLKM5JDMAttCM=;
        b=UsiEq9BjrsewFAMhoUVkLuPeskG5X1jNNYitH+WwIX09NVLK/Mx5OIqMf2MdAA0NDr
         tqgBMEPmc/4Cc7SpgAuRBJ+Et2MxwDOINrE9okSsm1J8O15xsGhicvj+BTxabfs393p1
         weHKJKLAoXHxitdGdbvhSWyh4ue95DxqQdcujfZxJCUtAXC+9Hd1z7I7TcgbZeyImhH6
         K20SGCuwW5vgIT0DO9rfoWFEn7W1NeNvSqEwYb6mZ27m7TbR6Hx5dzpdvanC8Oe8yJ/Y
         V5U+BmkDr+F3zr2/x2x1D2e4ALJWaW10HT/7KzZhRJlVO7VOthTpFO8n3qsd7Y5ZgVu5
         AhWw==
X-Gm-Message-State: AGi0PubqwO7ugUliBoq3VH4byCv/zTXwmMClmouZCV6at11X3NNlviD5
        tJ8sLE2xpHHSACCLvkZNqR8Hk8Q5
X-Google-Smtp-Source: APiQypIets4EKKLv624XORnpouUh0Fc0YKXq5VGdiirMQrqutGIr0UISbwIekMOTQ73o0snMdFK1Pg==
X-Received: by 2002:a2e:571a:: with SMTP id l26mr4020399ljb.12.1587689379660;
        Thu, 23 Apr 2020 17:49:39 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:39 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] ath9k: interleaved NF calibration on AR9002
Date:   Fri, 24 Apr 2020 03:49:21 +0300
Message-Id: <20200424004923.17129-5-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NF calibration and other elements of long calibration are usually faster
than ADCs & I/Q calibrations due to independence of receiption of the
OFDM signal. Moreover sometime I/Q calibration can not be completed at
all without preceding NF calibration. This is due to AGC, which has a
habit to block a weak signal without regular NF calibration. Thus, we do
not need to deferr the long calibration forever.

So, if the long calibration is requested, then deferr the ADCs & I/Q
calibration(s) and run the longcal (the NF calibration in particular) to
obtain fresh noise data.

Run tested with AR9220.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index ad8db7720993..68188f500949 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -680,8 +680,12 @@ static int ar9002_hw_calibrate(struct ath_hw *ah, struct ath9k_channel *chan,
 			return 0;
 
 		ah->cal_list_curr = currCal = currCal->calNext;
-		if (currCal->calState == CAL_WAITING)
-			ath9k_hw_reset_calibration(ah, currCal);
+		percal_pending = currCal->calState == CAL_WAITING;
+	}
+
+	/* Do not start a next calibration if the longcal is in action */
+	if (percal_pending && !nfcal && !longcal) {
+		ath9k_hw_reset_calibration(ah, currCal);
 
 		return 0;
 	}
-- 
2.24.1

