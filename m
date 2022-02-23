Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40884C1CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiBWTx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 14:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiBWTx5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 14:53:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606EA4C40A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h15so28907573edv.7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9OZIeykIiE3sXspI6sjMcDzTKi3GkRBFh+BSrQc8CQ=;
        b=U8IQyRTO3wWi739wEaQbNopQ2TkkZ7vhbIwpcN26ZA90qCe4Tgitb4BGCmKN7pyaUy
         2fQ/BRNvW2/zMXzQllU/IusvYBZ9AEt6kbanKJZyn+dptHet28OSpnzxcTVA4XkySvAT
         qwD71sUT/1VDqZ/Hm1hpFnHpy5lEo5+L6ZJIVKOcy9XS5OJeooBsSkWjBlEbXiUpbSXA
         dzcGLU6RnemN1t0uRmDIoMbCw7xpCqOV92GRzuXWR31PvUbV2AXGRY1Pit92r2q/TkTN
         /39CWo53dcRwfuXee8IQa/XkEHnR5GBE13etRSQIGPpm4LNnXHrTm6jy/s/EqBUvVDr5
         vR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9OZIeykIiE3sXspI6sjMcDzTKi3GkRBFh+BSrQc8CQ=;
        b=wOol9RtQVJAVUorBj040KYkYXLAkCqI1ezYEMfqPmqSGpAuqGix4dLmSsGlRAlBzpa
         8zZmeoZvUh5ImBNWZujCj5zN0QkMDwB+ZhNFm6L9fh+UE+p5LndmalxUcljGl+MyEl5Y
         enUPyTDc8UKqIMlBOE3cKD2+aM918Z9o0SyfR0wLJWlhqiEdwsHHcgLY23yygJshVq+L
         8LmG611XtglPSdo4NjLH+Ez0cnY+pfyKWx0Fqp2sTIUKtxAsHVzAFYM0/R7c+NYaxIHi
         eQJWfgRL/IyzCRtF7Q3wbq1+6p3MNGNICtLArvsK4Hr4pUcGh7w8YLm4INZlzX7N7dxd
         upaA==
X-Gm-Message-State: AOAM530w24Wd9IfGs5BxFTnRDvZktRoCoZ1c9T8Z/iAHR4TuoIk5e4In
        pkAhI3NLJMvbsL6Mc8XeTU8=
X-Google-Smtp-Source: ABdhPJzksR1wvTR0XJIJH0ybB/P+SjwbspaGf24/pVL38dYASkGod9Y6hn1O0/82S2Q1yA8W2WUbnw==
X-Received: by 2002:a05:6402:11d0:b0:412:cbf3:d87d with SMTP id j16-20020a05640211d000b00412cbf3d87dmr1012359edw.300.1645646006793;
        Wed, 23 Feb 2022 11:53:26 -0800 (PST)
Received: from debian64.daheim (p5b0d779b.dip0.t-ipconnect.de. [91.13.119.155])
        by smtp.gmail.com with ESMTPSA id 23sm232416ejf.215.2022.02.23.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:53:24 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nMxhU-001Rgx-11;
        Wed, 23 Feb 2022 20:53:24 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-firmware@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>
Subject: [PATCH v2 4/5] ath10k: QCA99X0 hw2.0: replace board.bin, add updated board-2.bin
Date:   Wed, 23 Feb 2022 20:53:22 +0100
Message-Id: <da7d9cff16246c5c8dc003248a0ec4832606b1c6.1645645875.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <623e92dfaae9117e59c9ff9c9d1189295072d034.1645645875.git.chunkeey@gmail.com>
References: <2ce6ca92f529aca13984db205ed38fa0fa6d436f.1645645875.git.chunkeey@gmail.com> <63972ee8daa620c57eda5eb89221ecfeb55f46af.1645645875.git.chunkeey@gmail.com> <623e92dfaae9117e59c9ff9c9d1189295072d034.1645645875.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
<https://github.com/kvalo/ath10k-firmware/tree/master/QCA99X0/hw2.0>

Includes the following changes:
e404444 ath10k-firmware: QCA9980 hw2.0: add ASRock G10 specific BDFs
e5a557c QCA99X0 hw2.0: remove obsolete board files
2d85666 QCA99X0 hw2.0: add board-2.bin

WHENCE updated accordingly.

Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2: sent to linux-wireless + ath10k mailing list too (Valo)
---
 WHENCE                           |   2 +-
 ath10k/QCA99X0/hw2.0/board-2.bin | Bin 0 -> 157680 bytes
 ath10k/QCA99X0/hw2.0/board.bin   | Bin 12064 -> 0 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 ath10k/QCA99X0/hw2.0/board-2.bin
 delete mode 100644 ath10k/QCA99X0/hw2.0/board.bin

diff --git a/WHENCE b/WHENCE
index ae33372..c91c3da 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3585,7 +3585,7 @@ Licence: ath10k/QCA9377/hw1.0/notice_ath10k_firmware-5.txt
 File: ath10k/QCA9377/hw1.0/firmware-sdio-5.bin
 Version: WLAN.TF.1.1.1-00061-QCATFSWPZ-1
 Licence: ath10k/QCA9377/hw1.0/notice_ath10k_firmware-sdio-5.txt
-File: ath10k/QCA99X0/hw2.0/board.bin
+File: ath10k/QCA99X0/hw2.0/board-2.bin
 File: ath10k/QCA99X0/hw2.0/firmware-5.bin
 Version: 10.4.1.00030-1
 Licence: ath10k/QCA99X0/hw2.0/notice_ath10k_firmware-5.txt
diff --git a/ath10k/QCA99X0/hw2.0/board-2.bin b/ath10k/QCA99X0/hw2.0/board-2.bin
new file mode 100644
index 0000000000000000000000000000000000000000..dd6a095788a310e16742608b8ecb2dcc4a5c7c59
GIT binary patch
literal 157680
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
PtPm4|y-Cs9KmPv*BkZZ?

literal 0
HcmV?d00001

diff --git a/ath10k/QCA99X0/hw2.0/board.bin b/ath10k/QCA99X0/hw2.0/board.bin
deleted file mode 100644
index 7e3131ef48a646605e0969ec894997b97d2a9581..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 12064
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
ZlOh&5hz{>q97G3W2hqXUL0m42e*r=0cGv&_

-- 
2.35.1

