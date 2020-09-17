Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671EF26D4EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIQHlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQHlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 03:41:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ADBC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 00:41:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so684750pfi.4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:author;
        bh=FXDiiYkOrBBkVMM60XIvsHKuLK5wSyPpdEYR7aXyVeE=;
        b=iCw4GwLwH4XXyDXgc0qXrpwDfvZsPiJOvBqE4DHe9rNTw9dyeZdz73ZGAaYeJFhfAc
         5jBxJXFSncPIyRXCtdeFWzeXnTb9NyZEDSzN0E7DaOPWo5kyl0920tplCBronsYZeneR
         8jOUfjj5ef671oSxEfy3FiXQZ9FtXWywocHpg8liT1Rl8jvyJZ7NyWmcMGkI9K7NMbRz
         uKEVG8/DE88glop1q9AdGMTFU5fppJsVLWyZ27UGFTkbp3cS5UNMNcONYteUA/Lz+AVw
         YQ3JmUkIMUz175TX0Ff6jGGvDv3BsPDDtzRklvJrBKDA8iibWpfjGd/LaOHKQyLD5AkA
         tFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:author;
        bh=FXDiiYkOrBBkVMM60XIvsHKuLK5wSyPpdEYR7aXyVeE=;
        b=ETYMYrAbfRpzN2waK7dak4h5Dd9gdTVD3SCl7q/7FJFPuVKVveb7Fc5+CTivBtmDKA
         Mo7cOcAZWmK3H8uuVT2jowktwOzY8cVl2/4NGNEWjGvxW90cvE9ecc9+4kLZYuyet4yL
         UtU//ojlubAqaTsdyloVjEKj6P8icXAnM7GULqD/g10XRQKJtOlc7vIXs3oPa3edR6jO
         2qWVaC8QHNheHJfo3WozuRJ7paXaDH5nJj2eoJIeK5f8s/dg2UQNZykqDXkVDove/Wa1
         9WDGr6/Bp3Ysn55mpSusEXiKjo2EcG0QNaG+B67GB6elfZeHryJLFA9uj+3kxSdWKQgd
         ofwQ==
X-Gm-Message-State: AOAM533KKPhpNfDcuXJDBxmJfIeSvQ2FoKleLc648FfgSJOfKvwB+bRw
        j21Ob40IEsZZ7R04GsMzS/BZMg==
X-Google-Smtp-Source: ABdhPJzeq73boIofbBUIov5zoWTDDc1vmS133UThfzm7c+wWboFUL3yGWk8BGO8uBksiOtHwbMmvyA==
X-Received: by 2002:a63:4c57:: with SMTP id m23mr20910626pgl.77.1600328508312;
        Thu, 17 Sep 2020 00:41:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6803:6073:ddd6:7b70:6083:ecc4])
        by smtp.gmail.com with ESMTPSA id e27sm19365745pfj.62.2020.09.17.00.41.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:41:47 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        David S Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ath10k: qmi: Skip host capability request for Xiaomi Poco F1
Date:   Thu, 17 Sep 2020 13:11:41 +0530
Message-Id: <1600328501-8832-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Author: Amit Pundir <amit.pundir@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Workaround to get WiFi working on Xiaomi Poco F1 (sdm845)
phone. We get a non-fatal QMI_ERR_MALFORMED_MSG_V01 error
message in ath10k_qmi_host_cap_send_sync(), but we can still
bring up WiFi services successfully on AOSP if we ignore it.

We suspect either the host cap is not implemented or there
may be firmware specific issues. Firmware version is
QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1

qcom,snoc-host-cap-8bit-quirk didn't help. If I use this
quirk, then the host capability request does get accepted,
but we run into fatal "msa info req rejected" error and
WiFi interface doesn't come up.

Attempts are being made to debug the failure reasons but no
luck so far. Hence this device specific workaround instead
of checking for QMI_ERR_MALFORMED_MSG_V01 error message.
Tried ath10k/WCN3990/hw1.0/wlanmdsp.mbn from the upstream
linux-firmware project but it didn't help and neither did
building board-2.bin file from stock bdwlan* files.

This workaround will be removed once we have a viable fix.
Thanks to postmarketOS guys for catching this.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Device-tree for Xiaomi Poco F1(Beryllium) got merged in
qcom/arm64-for-5.10 last week
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=77809cf74a8c

 drivers/net/wireless/ath/ath10k/qmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 0dee1353d395..37c5350eb8b1 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -651,7 +651,8 @@ static int ath10k_qmi_host_cap_send_sync(struct ath10k_qmi *qmi)
 
 	/* older FW didn't support this request, which is not fatal */
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01 &&
-	    resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01) {
+	    resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01 &&
+	    !of_machine_is_compatible("xiaomi,beryllium")) { /* Xiaomi Poco F1 workaround */
 		ath10k_err(ar, "host capability request rejected: %d\n", resp.resp.error);
 		ret = -EINVAL;
 		goto out;
-- 
2.7.4

