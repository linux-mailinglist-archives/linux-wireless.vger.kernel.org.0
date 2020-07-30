Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDE2330BC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG3LJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3LJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 07:09:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60356C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:09:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so23937970wro.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/DhgxnH5WfBH2hYybEl9iDSMfSqU98CakpV78w/xJE=;
        b=y1dxP5nIcz+aRNfTOMHFpVmPNh2aNNZ3LKFuec+rmNKUr020AhzmHZdSDjFT8I78c6
         jYoImuI2nHnOQ3UQc9CBwOqeOrM7WJd+AQovazT8NWQmhp427BKbTuDzkR2lvQGTfltT
         KOBje+lpmFhu/Wo9ZYREwSTewCQ2i8Fqs5KOIvMWClgFjwqoxth2RmeXnG6dRzFoHIR9
         CC6xzVO98gtYsj8Br7pEZAmWcXj6eW35VO9cKVPelWM+NP8ZRm+YZgoQ4lUN3W/FCcyd
         QTxOFwcDDv3qskv4wR6ck49Ate19JmSoP2VcZxbcNT0lUA599MkqkeoCJ717hYPDYBsz
         3VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/DhgxnH5WfBH2hYybEl9iDSMfSqU98CakpV78w/xJE=;
        b=pRWHEMZX3xy956b5KmOXii35kQaIZTvkuC3TI8UnoNuIhw5suEwp5m61m0HGd8pjHa
         IXAX7L+N3DNEUe1M2rvKCWJXcqdOVo0zq0bDISGr7JQ9EU/Hz78NvNrdpFk55WgP0yoa
         hJFcdb94VD/fbjLhRFpYBTasCber4RcOuT1aboJR+c+PLD0bnm/3ibf1oVH8HKCxIfsU
         YrepYwsuqtFEA04E//jYlGk4TnM5xYKChbBfUNZ2b38FM7CHiwrkydZRPlCMJu4RqO62
         uVLd+fRomhjECU5wxYwY42D4ILZclhaqPRDylBynJiGKmyl+hrxZXKR1Lph/7szNzMC1
         2COA==
X-Gm-Message-State: AOAM5338hUxV910wW07TtZBCCvv64KyI0Lad/CtinzgBfokhLnRTzLKh
        6ixAIMmrB1GDQZT6C/pdxCufBg==
X-Google-Smtp-Source: ABdhPJwV2SBB6DChjc7TnOEdu9kgVMdCw58SeAi6O+6kSIkgAMzQ+TLq2KoGYT5UDYCUdWdHfgmTBQ==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr2386469wrn.356.1596107342119;
        Thu, 30 Jul 2020 04:09:02 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b129sm8645758wmb.29.2020.07.30.04.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 04:09:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, loic.poulain@linaro.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH] wcn36xx: Set operational channel to 0 on disassociation
Date:   Thu, 30 Jul 2020 12:09:47 +0100
Message-Id: <20200730110947.57979-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After a disassociated event we need to make sure we reset the operational
channel so that subsequent channel scans will not exclude the channel we
were using.

Doing a software scan on a wcn3680 showed that if we disassociated from an
AP we would never see it re-appear in a scan - unless we shifted the AP to
a different channel.

Setting the operational channel to zero on disassociation ensures that this
situation will not arise in the wild.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index fb8978a3c11e..4681d085b683 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -908,6 +908,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 						bss_conf->bssid,
 						vif->addr,
 						WCN36XX_HAL_LINK_IDLE_STATE);
+			wcn36xx_smd_switch_channel(wcn, vif, 0);
 		}
 	}
 
-- 
2.27.0

