Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4578B403A96
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhIHN3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhIHN3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 09:29:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D6FC061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 06:28:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b6so3284899wrh.10
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgoOn36K+S6nh4/mfR/A8ymiirWfbLzHv33YEgx+ZwQ=;
        b=kzoNXbvINYZXDC4r87cRVjjosqo7iqankbMTHHbpRtvbV+7drf0IQbEoyagmQ9/rCs
         5AldCUjXP6CnKHLA7h8Xmos2ad51IUY/r0QPUzRpbfT3KevLK/4KycUHftXkuz121Vpi
         dT+kOPjhWB23j3F0ql6Z5rnny5Rw7LoSIM4vbgOVyijbzMT7+f25mvH9juER5OMJk/m3
         XnEmrvhY6hgBsI4k/ktSJ3rZA3MMck34W8zyRe7dI0mRUE12qbtCUGZ3QEi5OUfJ7mKu
         rBlZNzqGisxoyzA9//mQRu841P7G7EFJ0IhJMq/N+VtJbfxko4NQhGEOdXMivnRhDATP
         aMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgoOn36K+S6nh4/mfR/A8ymiirWfbLzHv33YEgx+ZwQ=;
        b=qB5bqGhS8LZm6CnaSmNHjWCjFQrxrtA1hNQppHLAKiwRQQedPZqXMycTRo/nhcDkLF
         W6wBUVubQMSNcZXT0pXBWQeuNB955PX0weN+EXNW9vvXmkq1/sahpC8wdKtOLAJjMIrq
         c0AWvrxXKK+fTnlFMmkOhWv8pySas/jXO6olo8dvv0iIB5j3YJM8E6O7z3WUBlPr1CTA
         Trya+LXB6onGE3KiyxYpRV8dw+igUSmm0RmJ8ZZ1yiND6hyN3+vNtOCHjGX0PK3TyjsJ
         WaH6T+o9kPKZB+D75uxGYNFuGcGOlBNm+QmvFTyutSQNE1B1uB0Bp+D+EsVv9Rw48Odv
         sIYw==
X-Gm-Message-State: AOAM531U7ISLOHII8Dm2tFd3wJHKbtoPeV+6B/MJBs94L3aSeQ6T3ySC
        R1orpVx0zSQh20AvTsWW0xhCvZsaEdCuJw==
X-Google-Smtp-Source: ABdhPJzeRqxhjYHP7D8J+bdY3omWt/B9GvWNyrU3P4fxrskdrWc+5N/bpur5oY+bqGO+dXbyOVCaqw==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr4240602wrn.294.1631107708394;
        Wed, 08 Sep 2021 06:28:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u25sm2136139wmj.10.2021.09.08.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:28:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 2/2] wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to pass two's complement
Date:   Wed,  8 Sep 2021 14:30:19 +0100
Message-Id: <20210908133019.2408092-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
References: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Qcom documents suggest passing of negative values to the dump command.
Currently we convert from string to u32 not s32, so we cannot pass a two's
complement value to the firmware in this way.

There is in fact only one parameter which takes a two's complement value
<tigger threshold> in the antenna diversity switch command.

Downstream:
iwpriv wlan0 dump 71 3 <schedule period> <trigger threshold> <hysteresis>

Upstream:
echo "71 3 50 -60 3" > /sys/kernel/debug/ieee80211/phy0/wcn36xx/dump

Meaning enable Antenna Diveristy Switching every 50 beacons if the signal
quality is -60db or worse and a hysteresis of 3 db or better to switch from
one antenna to another.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/debug.c b/drivers/net/wireless/ath/wcn36xx/debug.c
index 389b5e7129a6..6af306ae41ad 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.c
+++ b/drivers/net/wireless/ath/wcn36xx/debug.c
@@ -120,7 +120,7 @@ static ssize_t write_file_dump(struct file *file,
 		if (begin == NULL)
 			break;
 
-		if (kstrtou32(begin, 0, &arg[i]) != 0)
+		if (kstrtos32(begin, 0, &arg[i]) != 0)
 			break;
 	}
 
-- 
2.33.0

