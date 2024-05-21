Return-Path: <linux-wireless+bounces-7884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35C8CAB13
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FC11C21619
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50771B3B;
	Tue, 21 May 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHQYHGVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E76D1D2
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284734; cv=none; b=jom0tBn5CR+tIz6x70ECJp/xFQmpv6a1KY+QnIhXXRexfflrKBpuHBw1ew8LNFTCSRxVOfVMboXXvswgTR4Ds+Tw/XJ518SWFG3mfhsDuBThrGxeuTWL7BdFBzR087loDzz0pCjxpa6agz7cYd1dVz98Gn42CC5EsHOz32eE7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284734; c=relaxed/simple;
	bh=AFSw8YT67751JMyLAp98IxGcZ029778ZqkawJ08x+oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyAy7VT2hbKQO9RkFvIwK9qitL8yy6q2BxD2kkxXBi1/rsalYY4EFK+iOCNaq/+DQ3GYASzweQKwQJdojuGe63T8SVX4czD7D/jpKmyfAApWsQ0OwYFHs79WefoF04tLBxg7t2+BZoWvMUl5tvNmZM9piTnwtUvNNsGoxyNFH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHQYHGVT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e576057c2bso75678991fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284729; x=1716889529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLwvRgxzyiUA9P6PtePLoWn9ddMKovViLDQnxnmP0yc=;
        b=UHQYHGVTxD+a0xllDLHfv+mjDIiMtUYRcRuWaNcN0FpQISogQsj1xnK9exUl53AJja
         2b/U8N2HAK0B0T9FJYr+f0K9XHrnJ/MI2UZ/miRKsw+4bMuIK2YxItG2r+V5R4L4J3P3
         EiQ74O2/mV5NPQb9gHLdvJyX8K1XKF+7MuODedLLixRKx3USX2ojcOCfGsZ6eqTX0oc3
         cHXNnggXMDaWl8BEYvH2IUxjNKD58sV9lv8eMIdi1wT50mJIm8MFm0w4JIoeGxT6tnfx
         JqZpnKN/Bri54ISOcBQvR628vyoXCVTqndYI2gw62nGjUOeDN5qf/SmlYPl+rdWEXy1N
         pvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284729; x=1716889529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLwvRgxzyiUA9P6PtePLoWn9ddMKovViLDQnxnmP0yc=;
        b=MgKBcCCEttFvwIZY7Fs0/EUvdG4TlmuVZ9ogUnLOWbRrunrbZ5Wf08obbUfJZZ8L0D
         1Q+KlVcTzO3opBUfYVVhBfr2+tJPzgw8zFUDvqK+RU2ARymW7AjgdruDCXap/nsb1CD+
         1P6wonT5Ls3cL8VG//+tQjycZaFV3CA55upvqj3OqZEHgls7liRa2jUqQKvoqeQ1WEOv
         4CH+Wkgf2bAuuCsm0JKXp0GypJ+kCL+ppAE6Pcbuk/fHKOcLPsA/rdZYZ0wIc+cVOtqp
         P1v75r4hXHOlkKQc6TuuoUObWcacgkJlE5Qx2PkbHWCcqtRfNcCJAOi2rgkwA9h5KHA6
         Z2iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ux05BdBWTH0Kn2bK3fvYAqHc30NH0JtAv9a1IzCU6rhgmIWkmtMqn3lGkox9hZz0ucuayB9KjCpqE/3FJdDUKip41m75aMFuDrf7/FQ=
X-Gm-Message-State: AOJu0Yw69dm5xRX1vyCVsc++0LgpKCqdVm4uEUdWgbJKuES+Yj/f1Vja
	j7nw7cOSEkhzAfBXXPQCmASn6Gqr2349/VkRb0qWuOSR1O6uVJSx3ZNL4L7A8Do=
X-Google-Smtp-Source: AGHT+IExtDU6eIGB/UhDwLpmGYGgqx7TmTkOXGGasOHtt5sJNIu6PQ+k6KYptjQOq6OpY/8WUsN8QQ==
X-Received: by 2002:a2e:9695:0:b0:2e0:5d7:a3a6 with SMTP id 38308e7fff4ca-2e51fc3442emr243223051fa.9.1716284728901;
        Tue, 21 May 2024 02:45:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:25 +0300
Subject: [PATCH 05/12] remoteproc: qcom_q6v5_mss: make use of
 QCOM_FW_HELPER
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-5-99a6d32b1e5e@linaro.org>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
In-Reply-To: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AFSw8YT67751JMyLAp98IxGcZ029778ZqkawJ08x+oE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG0zGZpQHNbMeZOkJjcXVkAZVQriNGdtlZlml
 aDk9k8/t46JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtMwAKCRCLPIo+Aiko
 1Y7MB/sF+zRUmPQMKrXtX/YPgZdL4G5zOYWUCFIaS8soYxJVFrHzuqv0vhRVzxEImWBeTTRvwqt
 oyFljUHjrrmdVPkyPdR4rZHkPlu5DJoo4Opb+RkTwQFsyDgRbNXCzy1/ylM3ZsYRemWxxw8biMF
 UyES8aYOjeEVQWjNU+4PaSDxKJAu+tAGlT5v2qfDUqW8Yq4v+5kgCM4xRmNwWJsVwOm+gApLFGe
 96dhfzWg6RBWsMrZ4lwGQLu5J8SYBJw0skYCMJvVsOZ/7WoYSdJ0UBcs/3butIUAyA5rLGsEx/w
 KlzDyJbnHl9KGtCug8ov3LoHbBXw8RoDT5NRiiImki+2AKQw
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make the driver use qcom_fw_helper to autodetect the path to the
calibration data file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_mss.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..884e1e69bbb6 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -202,6 +202,7 @@ config QCOM_Q6V5_MSS
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select MFD_SYSCON
+	select QCOM_FW_HELPER
 	select QCOM_MDT_LOADER
 	select QCOM_PIL_INFO
 	select QCOM_Q6V5_COMMON
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index eeaae2505352..1ccd5bb92952 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -26,6 +26,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/fw_helper.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 
@@ -1990,8 +1991,13 @@ static int q6v5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mba_image = qcom_get_board_fw(mba_image);
+	if (!mba_image)
+		return -ENOMEM;
+
 	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
 				 mba_image, sizeof(*qproc));
+	kfree(mba_image);
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -2011,6 +2017,10 @@ static int q6v5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	qproc->hexagon_mdt_image = devm_qcom_get_board_fw(&pdev->dev, qproc->hexagon_mdt_image);
+	if (!qproc->hexagon_mdt_image)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, qproc);
 
 	qproc->has_qaccept_regs = desc->has_qaccept_regs;

-- 
2.39.2


