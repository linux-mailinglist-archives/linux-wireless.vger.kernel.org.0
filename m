Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589572A44E5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 13:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgKCMQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKCMQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 07:16:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD9C0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 04:16:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c9so10977646wml.5
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AShy5CksHbzK69i92p5sYeNn8BBNvAFd0gTiGBC/Zug=;
        b=l4BFAA8462o32Mgf8sVSRl5Vv1AO/3WXNalvKjz/b/2XB4tiRNC9OfKZE7q9Su3l7n
         QVTqba4MjV6Glg15ose2Gy+SZCoxmLPD8D5BtM3svuGPiXZrVaWE+BYHjbcrk5GEL+56
         DBn0hRiy3WISUPweElxC0xOmLWf6RM2YfBwYbq5wAIMMNZehFFPU1LXNMFfRy6Qr7BWm
         MoF9LyIZ/HpDcHuGs09ozk9w4iChTT1H2qtPTlUn1RBNpjS1NiqrmexGDpTBybAcg9B8
         6DCdquzx25tfseunExy6tdmy0use6Xtq+XZaOCuE1jK8hpsF09j3VChkdwG7ooR3Kk4O
         9DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AShy5CksHbzK69i92p5sYeNn8BBNvAFd0gTiGBC/Zug=;
        b=diWq+3amZg13JJUpRuOwLsndZay8IZEoIHx0/sVO9fUedZJgU3lnQeKI9dUkgjfuDA
         IGgqISRIfpB9O6P7K9rLXMJ+W1eD9H1qDagbc3WgCTf3qLz2nrZQ2Zy8UyzfxW0XmuAC
         mFhRYlD67TtEaFsbcDTpC8UW8kqwiBK0cABdYlz0guYRBPuahXbDPF42tDNWeipC4iFr
         8vXaL9a+V1J5Ym9UHF74Y4ZNS3XkPCXAshKJs2aD6KQFB5JtjBpby/vRlJrp2nXxw8SP
         euWj/d4oZBcLbXJKRb90OYDoZo702ZzED5sglaZWo8OYBsMGwhtQX3Ict8Pd13+L0MSP
         bIxg==
X-Gm-Message-State: AOAM532k2eRxI5IjedQoQq2CQLLFUFXHO2kqtZVS9rN4/wAIUOD6xa1q
        vTZcHikbXi9xeIRnM3hi1wolxg==
X-Google-Smtp-Source: ABdhPJySEylTt/qqYu7nBESC+WVXc8qzbpNuFo8iNJEX20kuhC7KpKOjonmSoruOxpE8+NhTuJyZdQ==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr3468638wmi.78.1604405798688;
        Tue, 03 Nov 2020 04:16:38 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z6sm2678210wmi.1.2020.11.03.04.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:16:38 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 0/3] wcn36xx: Firmware link monitor/keepalive offload
Date:   Tue,  3 Nov 2020 12:17:32 +0000
Message-Id: <20201103121735.291324-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2:
- Sets LINK_FAIL_TX_CNT to 1000 for all wcn36xx parts
- Uses wrapper function wcn36xx_enable_keep_alive_null_packet()
  around wcn36xx_smd_keep_alive_req()

Tested with:
'CNSS-PR-2-0-1-2-c1-74-130449-3' wcn3620
'CNSS-PR-2-0-1-2-c1-00083'       wcn3680

https://www.spinics.net/lists/linux-wireless/msg204844.html

V1:
This patchset enables various firmware offload features for

- Link keepalive
- Link monitoring

Keepalive is a necessary precursor for an upcoming series on
wake on wlan, since we need to inform the firmware to keep the link up in
suspend.

Testing shows that LINK_FAIL_TX_CNT is a link monitor enable field. Once
set to non-zero link monitoring becomes active. This series activates
CONNECTION_MONITOR after enabling LINK_FAIL_TX_CNT thus offloading link
monitoring to the firmware.

Bryan O'Donoghue (3):
  wcn36xx: Set LINK_FAIL_TX_CNT to 1000 on all wcn36xx
  wcn36xx: Enable firmware link monitoring
  wcn36xx: Enable firmware offloaded keepalive

 drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.28.0

