Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DA688B4F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 01:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjBCACh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Feb 2023 19:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjBCAC2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Feb 2023 19:02:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C91834A2
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 16:02:27 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2795733pjp.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Feb 2023 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/uoZPK/zWO0yibS8CdCNbFUWtgKpQlxSjVcWvpZrkc=;
        b=Nu8867/F4vDAB9fNuH6rMWSRYVKaUfSWT7KA3ap7k5g623WXFwtXGy5XWgnXj9MVup
         qHN/p3SbK0kn5xI7zocwHsFxgZdMZ6ZccPIZ03bCNv9C4/GUYhEe6vVQK8yifNI1P9UD
         UDHR6pTZUh4ExAFbkqj0Y+ln4pfa8RTMBPRhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/uoZPK/zWO0yibS8CdCNbFUWtgKpQlxSjVcWvpZrkc=;
        b=LAZp+4FhGj36Q7ljFlXserDBpnyUXn7V62fDgQdt2N2OWpYR5Z1jqIPxN+ohkHg0ob
         okId3QIhUHqXxNKroSmp739mo9ygBEV5cRlVsNipieaPqf/Vt4RIIBDUOTACGNmozyME
         K93FFeT0EyAZgdQb/fm7NGLNyGhh+0m9Q3us7qijJfgXag8JtvIW0vw2CWHEKlvUHCP+
         SSKOa+14KjmhD0gpfi5e4zn/FXtME7vUEKDdMfgomKW+PER30z0nzs0R+D+Q0w7w5lIv
         zEQbhBWN3oVPFVoAP5dMF9BVb2WykFHwUYwlmDVDWFZrHaWTeDjE9CzvUYyxWpzrBfss
         TIAg==
X-Gm-Message-State: AO0yUKWSF2VD76IKij8sTdo8Ccp1PDOSX7HiuiVDUTDLsFwQz0KNYUXy
        n9QJNpCpI3j2EwY2H1dWqTr22w==
X-Google-Smtp-Source: AK7set/kzdkl0NIss0rGuyaBJv2SZPrgJMbP54clf2ry9p5GePxKjRGFVo07vZpBPElS/WlbO8mQhg==
X-Received: by 2002:a17:90b:4d84:b0:22b:e7a8:d4d0 with SMTP id oj4-20020a17090b4d8400b0022be7a8d4d0mr8470470pjb.25.1675382546272;
        Thu, 02 Feb 2023 16:02:26 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090ae00b00b00227223c58ecsm414601pjy.42.2023.02.02.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:02:25 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@kernel.org
Cc:     kuabhs@chromium.org, davem@davemloft.net,
        ath10k@lists.infradead.org, quic_mpubbise@quicinc.com,
        netdev@vger.kernel.org, kuba@kernel.org,
        linux-wireless@vger.kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2] ath10k: snoc: enable threaded napi on WCN3990
Date:   Fri,  3 Feb 2023 00:01:40 +0000
Message-Id: <20230203000116.v2.1.I5bb9c164a2d2025655dee810b983e01ecd81c14e@changeid>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NAPI poll can be done in threaded context along with soft irq
context. Threaded context can be scheduled efficiently, thus
creating less of bottleneck during Rx processing. This patch is
to enable threaded NAPI on ath10k driver.

Based on testing, it was observed that on WCN3990, the CPU0 reaches
100% utilization when napi runs in softirq context. At the same
time the other CPUs are at low consumption percentage. This
does not allow device to reach its maximum throughput potential.
After enabling threaded napi, CPU load is balanced across all CPUs
and following improvments were observed:
- UDP_RX increase by ~22-25%
- TCP_RX increase by ~15%

Here are some of the additional raw data with and without threaded napi:
==================================================
udp_rx(Without threaded NAPI)
435.98+-5.16 : Channel 44
439.06+-0.66 : Channel 157

udp_rx(With threaded NAPI)
509.73+-41.03 : Channel 44
549.97+-7.62 : Channel 157
===================================================
udp_tx(Without threaded NAPI)
461.31+-0.69  : Channel 44
461.46+-0.78 : Channel 157

udp_tx(With threaded NAPI)
459.20+-0.77 : Channel 44
459.78+-1.08 : Channel 157
===================================================
tcp_rx(Without threaded NAPI)
472.63+-2.35 : Channel 44
469.29+-6.31 : Channel 157

tcp_rx(With threaded NAPI)
498.49+-2.44 : Channel 44
541.14+-40.65 : Channel 157
===================================================
tcp_tx(Without threaded NAPI)
317.34+-2.37 : Channel 44
317.01+-2.56 : Channel 157

tcp_tx(With threaded NAPI)
371.34+-2.36 : Channel 44
376.95+-9.40 : Channel 157
===================================================

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

Changes in v2:
- Removed the hw param checks to add dev_set_threaded() to snoc.c
- Added some more test data in the commit message.

 drivers/net/wireless/ath/ath10k/snoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index cfcb759a87de..0f6d2f67ff6b 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -927,6 +927,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
+	dev_set_threaded(&ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
-- 
2.39.1.519.gcb327c4b5f-goog

