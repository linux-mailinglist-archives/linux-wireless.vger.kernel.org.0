Return-Path: <linux-wireless+bounces-7889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6E8CAB29
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EB2818CA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED778C6F;
	Tue, 21 May 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4ZSldht"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC556BFBC
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284736; cv=none; b=EFIASVRWiFnstGIDfutz5lj401+gcra6UbIwN+U07ibolBeqdO2yDrdn40YHA1nQ5lfJw1dgc92/HMvliNXzX82vOrNZKYJXfL3TyVpgDnahUdaDvRIr8CROU0wVRMKJncntN0M/S3SPClwvN3f0LTjSbtRrLQOCeaXX1N+WnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284736; c=relaxed/simple;
	bh=0EdhJdiexa04app1htF5yZNIe9fWs0XMN5UptBqZX9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StBIdmHmaaJGj1SkBcgUVizsdmjDUP+B/aebqa9evZCmwiT4rzj9eaB4ReYT+YXQ47O+46ZbbX3IXYlDuJ4cp3GVFwo4t8fywV1HPs6ZJdQH0Rr0clorPDY9Sq1ybtrpNUX4mJTmpDQAQyawSR7OK8mr0tckdZ50TayHhNFb2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4ZSldht; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e538a264f7so48628831fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284732; x=1716889532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjYD/nu8XaSwyIjsATzxMNejeBhx1zP8xP+ReawIdtI=;
        b=L4ZSldhtq84mu7ODLTq60hCMVbNseK04xEv30tGGe+QdLsD2oqk32arfUJKdKwmYYo
         zUQYPDCArK8q2xI1lzb1EVk7f1C3yv950tRlNVFA88Tri1xPG50V7ALpicovOb553Q5z
         DfWddAPQvFJzQNBYavebx3F97TSsN9lYC3ht53ul0VPb1ETbpd2cgnLW3nWGuJGSJTgY
         Pbrju9j91dbJU60+H0nQtjNHVcTVS9S1QhjgFaR72+BmIoyOLmWgwQ6pBiPimMsnFU5U
         ph2Q2uBOO3Lzk4Q+Y83QYf5A4rmZ+0eb6gXhitNwzvevbxp++APQj442s+RghjSVmYjZ
         uLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284732; x=1716889532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjYD/nu8XaSwyIjsATzxMNejeBhx1zP8xP+ReawIdtI=;
        b=D14OS/swIhLIcVZtYvo6QXft6Ie8FA1xGCsbfKets9rVqDfX+qqDgecpGZJ2zI2baD
         NEeLXu1XeEvOUYUT6+LeGsEp4R85RhIB2eHiiwyX8JMnWxC2TypVBRHkiuT+3aaDj8ej
         tWXv11b7QYhhLuttd1OPbAByVakeSnXW5OscNNmoTOSTBbLdqwR1PjbC9R42eP/Q8O9s
         Ocg5HMdbu8Tcq8f3unnu2r20l2ET/3/75/UUUsWdmisWylMUxObOXxQdILceC7Nnt/iE
         +1iOUWpZidPV3mJJXHq++khUrGx0HBeL9lcMI4sjhRYkQXmNF4Aarlta9dYWnXOhuATB
         Cm3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDEQTvXgOdVBAEhdzuAtHT7Vsrc8C9OJHIxL873d1xLdg6noOI3VygIWRWupQmB/flOP9m2mePh3CY5iIrXEZb2pndVYdtjFd/R/OPmyA=
X-Gm-Message-State: AOJu0YxzZ5JCnmQMHrYpJfTxYR10wQTv9uIPXTihndVPtUXtmoXi/rs8
	BYr565Gfq0WP4u48ky4vgxohYseba5muOXAxdclleuwKF4CXXH2yzpJh2fxKfp4=
X-Google-Smtp-Source: AGHT+IH8qzC3fWXUUcidqVlxrEGo8Kdak9/c49iTORJ9N4V8gMmWJwg35UouqTVH8QmBlj4MSRInLA==
X-Received: by 2002:a2e:9355:0:b0:2df:e0c4:8429 with SMTP id 38308e7fff4ca-2e51fd4afb7mr200777811fa.18.1716284732591;
        Tue, 21 May 2024 02:45:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:30 +0300
Subject: [PATCH 10/12] remoteproc: qcom_wcnss: make use of QCOM_FW_HELPER
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-10-99a6d32b1e5e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=690;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0EdhJdiexa04app1htF5yZNIe9fWs0XMN5UptBqZX9k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG00kykDINSyj07g80LnRrExtHt62TUsGroa3
 Z6F6OYOqsWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtNAAKCRCLPIo+Aiko
 1UBiCACZbvFD9mCBymBfZ6+3KEKZZ2J/FnpHuE6TjGdkMeNG5SRodLBYZyXVC4e5JS1pf+C3XbC
 gErxRfKXsyVINQ8MA87BhZ7QpUXd03DBZKEn8bwdlhNlOdIPcgmxm8lx0q8ufbmVNC1ftr3Q8LZ
 lG1UWkkCucAQ65LQ/u3VTGTr1qY8CW2RjguM3Y0drfu+nSCqRyab9vm1Jw5YZEHotkId6tSDVZj
 SuvwzzNCSQs0ND+Y1od4v+WRjSr34Fg9jctLq2aqO5f+DBG3JzcE1yi+1RDmvEroZu0vVmJ+GYy
 R7Z+jwB9aKX3zUKXW9f2Bwx9IACoxZd9JKsfd3QTmxv3sWr5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make the driver use qcom_fw_helper to autodetect the path to the
calibration data file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 7bb22fdb64e4..e0ffcaeca03d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -279,6 +279,7 @@ config QCOM_WCNSS_PIL
 	depends on QCOM_SMEM
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	select QCOM_FW_HELPER
 	select QCOM_MDT_LOADER
 	select QCOM_PIL_INFO
 	select QCOM_RPROC_COMMON

-- 
2.39.2


