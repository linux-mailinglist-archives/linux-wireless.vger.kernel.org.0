Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D955409E93
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbhIMUy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbhIMUyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 16:54:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D4C061760
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:53:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so10020608pfc.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f90knbbhtSScT8ar0jqF08SQUZmsRray7TeEETy/L9c=;
        b=TLgwdSKTYs4IaAyBBMpkY+P28NYma3r1phTKbQrF7ns68EYCnG/diFKdtFOwdJ2R8D
         xT9nmLrmtnmDk54bafY9N3Zxttn4/3BZoudzEIvLFqtXIRDtgTzSPdOu0VCzfb3Skjyo
         8K1CUuIokwBsacA+2mLbS6MBqCyLa4zgJLpQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f90knbbhtSScT8ar0jqF08SQUZmsRray7TeEETy/L9c=;
        b=48WKIC8SBlbqPxs8Z0/+A3PJIBYRnLyS9nwCgH9rBfazMmFhH+ZyIMIaqZ/drtgt+Z
         QYXMhSNyrVMhrfSQPmm0Shxhoib88adCw0VK/CJ5+1NtRjjNZ9tdpn9sRhLAfzArudFZ
         tTC+guRgEV3hmkjgwAIsI6Gf1ZgV23nB6blQtdGsUq6tB0XUfJfd4iAcxRIXgo18MH/s
         11C2lCQQimMALO3EBNPigIyX5Px16fsMYVJarYLjU3vAI7SFqehH9OyHpr3hBJUd7nEa
         mZgNrsOMJqRgnwiEZrDQ63k/f5Khr4ZBnrN3WWy+b7iOhju5jAponHLjjGX4sL2BN7cr
         UX+Q==
X-Gm-Message-State: AOAM530VvqbwhLo1pFo1+xk/TZejY+dp0Lqk3+Z3qzTwSDjUtGLSeIj4
        juB9Wz07g+lmeHN/XoXlaVKDPw==
X-Google-Smtp-Source: ABdhPJxAl/mPXt91YwawfAofyXkkfN2pdLltwPNS+6qxwL3ENdYmXvUidco0XR00ILeLkAlx8X+QJg==
X-Received: by 2002:a63:f817:: with SMTP id n23mr12417256pgh.250.1631566395792;
        Mon, 13 Sep 2021 13:53:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:cd18:482a:6391:201b])
        by smtp.gmail.com with ESMTPSA id n11sm7702188pjh.23.2021.09.13.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:53:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Youghandhar Chintala <youghand@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ath10k: Don't always treat modem stop events as crashes
Date:   Mon, 13 Sep 2021 13:53:13 -0700
Message-Id: <20210913205313.3420049-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When rebooting on sc7180 Trogdor devices I see the following crash from
the wifi driver.

 ath10k_snoc 18800000.wifi: firmware crashed! (guid 83493570-29a2-4e98-a83e-70048c47669c)

This is because a modem stop event looks just like a firmware crash to
the driver, the qmi connection is closed in both cases. Use the qcom ssr
notifier block to stop treating the qmi connection close event as a
firmware crash signal when the modem hasn't actually crashed. See
ath10k_qmi_event_server_exit() for more details.

This silences the crash message seen during every reboot.

Fixes: 3f14b73c3843 ("ath10k: Enable MSA region dump support for WCN3990")
Cc: Youghandhar Chintala <youghand@codeaurora.org>
Cc: Abhishek Kumar <kuabhs@chromium.org>
Tested-By: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes since v1 (https://lore.kernel.org/r/20210905210400.1157870-1-swboyd@chromium.org):
 * Push error message into function instead of checking at callsite

 drivers/net/wireless/ath/ath10k/snoc.c | 77 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/snoc.h |  4 ++
 2 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index ea00fbb15601..965136261aef 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of_address.h>
 #include <linux/iommu.h>
 
@@ -1477,6 +1478,74 @@ void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
 	mutex_unlock(&ar->dump_mutex);
 }
 
+static int ath10k_snoc_modem_notify(struct notifier_block *nb, unsigned long action,
+				    void *data)
+{
+	struct ath10k_snoc *ar_snoc = container_of(nb, struct ath10k_snoc, nb);
+	struct ath10k *ar = ar_snoc->ar;
+	struct qcom_ssr_notify_data *notify_data = data;
+
+	switch (action) {
+	case QCOM_SSR_BEFORE_POWERUP:
+		ath10k_dbg(ar, ATH10K_DBG_SNOC, "received modem starting event\n");
+		clear_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
+		break;
+
+	case QCOM_SSR_AFTER_POWERUP:
+		ath10k_dbg(ar, ATH10K_DBG_SNOC, "received modem running event\n");
+		break;
+
+	case QCOM_SSR_BEFORE_SHUTDOWN:
+		ath10k_dbg(ar, ATH10K_DBG_SNOC, "received modem %s event\n",
+			   notify_data->crashed ? "crashed" : "stopping");
+		if (!notify_data->crashed)
+			set_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
+		else
+			clear_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
+		break;
+
+	case QCOM_SSR_AFTER_SHUTDOWN:
+		ath10k_dbg(ar, ATH10K_DBG_SNOC, "received modem offline event\n");
+		break;
+
+	default:
+		ath10k_err(ar, "received unrecognized event %lu\n", action);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ath10k_modem_init(struct ath10k *ar)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	void *notifier;
+	int ret;
+
+	ar_snoc->nb.notifier_call = ath10k_snoc_modem_notify;
+
+	notifier = qcom_register_ssr_notifier("mpss", &ar_snoc->nb);
+	if (IS_ERR(notifier)) {
+		ret = PTR_ERR(notifier);
+		ath10k_err(ar, "failed to initialize modem notifier: %d\n", ret);
+		return ret;
+	}
+
+	ar_snoc->notifier = notifier;
+
+	return 0;
+}
+
+static void ath10k_modem_deinit(struct ath10k *ar)
+{
+	int ret;
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+
+	ret = qcom_unregister_ssr_notifier(ar_snoc->notifier, &ar_snoc->nb);
+	if (ret)
+		ath10k_err(ar, "error %d unregistering notifier\n", ret);
+}
+
 static int ath10k_setup_msa_resources(struct ath10k *ar, u32 msa_size)
 {
 	struct device *dev = ar->dev;
@@ -1740,10 +1809,17 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_fw_deinit;
 	}
 
+	ret = ath10k_modem_init(ar);
+	if (ret)
+		goto err_qmi_deinit;
+
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc probe\n");
 
 	return 0;
 
+err_qmi_deinit:
+	ath10k_qmi_deinit(ar);
+
 err_fw_deinit:
 	ath10k_fw_deinit(ar);
 
@@ -1771,6 +1847,7 @@ static int ath10k_snoc_free_resources(struct ath10k *ar)
 	ath10k_fw_deinit(ar);
 	ath10k_snoc_free_irq(ar);
 	ath10k_snoc_release_resource(ar);
+	ath10k_modem_deinit(ar);
 	ath10k_qmi_deinit(ar);
 	ath10k_core_destroy(ar);
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 5095d1893681..d986edc772f8 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -6,6 +6,8 @@
 #ifndef _SNOC_H_
 #define _SNOC_H_
 
+#include <linux/notifier.h>
+
 #include "hw.h"
 #include "ce.h"
 #include "qmi.h"
@@ -75,6 +77,8 @@ struct ath10k_snoc {
 	struct clk_bulk_data *clks;
 	size_t num_clks;
 	struct ath10k_qmi *qmi;
+	struct notifier_block nb;
+	void *notifier;
 	unsigned long flags;
 	bool xo_cal_supported;
 	u32 xo_cal_data;

base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
https://chromeos.dev

