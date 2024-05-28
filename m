Return-Path: <linux-wireless+bounces-8234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144C8D244D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 21:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB4E28A1A6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66767187354;
	Tue, 28 May 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IHeNNx2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A7181CF6
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923057; cv=none; b=Hm3iOZFtlosmYQtD2f/zf4cQlQpV0dMVT+hPdWNZFDugZWytKDK1ZNQ1IlyMMA0uQBkffHPZhthM4bGmZbbNnaa9kqUrQEXE3Xx6CXcea81vRp1xaw18ElBJxayQOex1ZvCqGxrnr8Cydd5RCGxJ5zYIzZXCTdxGakm+j2QWzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923057; c=relaxed/simple;
	bh=Skor7xEGEh3YcJ5UBApdq5xrdz4KCiu9TqBrmMget58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFV2k/R+uScHulz3KL2DA4GrtA4Ax91YK0aQIq6Vd9Up4HQGw3XdwXRPafOPDTKkRYDIQkDFYCMkyO2KaRPrpC5/Ky0OkUNbVAumLLeAfzQZHEDkdZbm9ZE01mTsOt5TuS1zfcx0dtlqFT5WkGOkb5uM45SIKKfLB5D1TtFCH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IHeNNx2v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso9382895e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923051; x=1717527851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ytTEWiXKbIuQ8DpZG6ZoIYYrAybeCYmHd6/M4lW1Rs=;
        b=IHeNNx2vEwBEPGywqD6Ug6c/wA20A1aq8R04/NvX9bxRoEyIOLKATK+qb2x5PJBZQW
         y7j6CLtNF3vbdc/+CJL7LXzvwddoWuAliHngpiQ2KhwnPe3jKLTRxPYmVBXBuagzLO3y
         vDjg0EHEfUlk6b/RhPbSEz8DCNvJUaAqaNQOaLiNWGogyS9a/LM0jr9dz1RH61M6/Wm3
         Dxs9dYZA18l9SG9c9I99B3RrMWB/9ML1u3jcQGx31i77rb2prRQCf8Lko5qL53ABJ+KP
         m5FSVX1RmFL3qrSU7zAmhZd6RDqyZmii9wCNRszB4H/sZpvKf2PfReRYys3OLQNJ/ahG
         3OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923051; x=1717527851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ytTEWiXKbIuQ8DpZG6ZoIYYrAybeCYmHd6/M4lW1Rs=;
        b=d0YiqZdiQi2tjQ5n0opAYz8IMbLIRY7nddT4O8lSHnspnDSB5MUuoqPk9xeyITjE1y
         npNL6cQ0JGYAVfCuziAhvWKsw32K+ehCzRkAGPAUWL7Q28eFOontHqaJkt1SCTmLJxI+
         pgz6qWdh0+ZbyUtcx+9XLlbY+sCzSnu36vTZ5bOwxdqrb5ePA/ntnXUHn91Kk0+3S3la
         U3k+yesCdVCZx4o2sTRZkz7b1bxxe04vMW9cONenMb+p6TkZUqvMVq/XsIOJRYeJboJz
         +OV3+bwQtn9pQEI/38pvj1/DvIJqx+ZUM2dV+qz26a2wLzoaHZfzozEf3MMgd+Z0pr+M
         Ud0g==
X-Forwarded-Encrypted: i=1; AJvYcCWvAxMBetoAfZqk96u2nBcZ8civSZC/qPRu1kdHDVLVaUuh5DUbLbDLalOcjRa6YnmmS3NIdnZoOrGuqn/UYG2m1dpYqlyEBAilgRcsdfM=
X-Gm-Message-State: AOJu0Ywg11kIRe9NyXksN1Yf/jm9npBAkPF3amLPmG+Nj4HX98sNhA/S
	qXUJbspvBixQhrHj55DWwcUesHG69D6sCq633+o3onolNExAE7hBftH5XYBQMHI=
X-Google-Smtp-Source: AGHT+IGr9Ojgwytm4iX9gfeC7HKGDwhCWclljkq1atIIKWkwjLAAGni1lUy44ltShGgL2ph8z+vsKQ==
X-Received: by 2002:a05:600c:3646:b0:418:f991:713f with SMTP id 5b1f17b1804b1-421089ffb20mr103408325e9.23.1716923050945;
        Tue, 28 May 2024 12:04:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:25 +0200
Subject: [PATCH v8 17/17] Bluetooth: qca: use the power sequencer for
 QCA6390
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-17-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Avu9/iVEa5ctX7rSEGjhhAJegGiSsgTxVFrmV4sVK2k=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqRYDzteYvAvkaLJmNfsrKlAel2gGnpKi/5k
 H2AxTd99D2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqkQAKCRARpy6gFHHX
 ckx9D/sF6bFK+4+MkxmVs/T0n/IO5FL1tM3ik55oKT13+sSCJ4etW/LbZ5eF91APL859kZG3Y6W
 aFAaNVzjgQTfd/2Q+bdlYL+X9emJuU0T7CXKFlN/N2HrbLlQT9AXmeC4FOi3biUJQK4LOyyDetH
 ojSyoma/VJrnHuurJaQOl80ddoFm5gfzDPJvGzvqwbLTPLLtj1jiwOBhDtMIcPhnFrwueBx9UO3
 0mCe4phl3MBCwVXmAfnsptIIOSJfilhDsFBdQrHCjqwoBcx+anp9JSJZqfjgEr5ahSNdF4R2bTN
 UBOPXXy9xT0LF+knaYZmBYhqglZ+3VRgdLhCsZm9ffXWTB1Q870+0/dbQCo/ny+7lserGXAXNw3
 z9TJDLJTlOiBiFGdpckN/3ewdubjN8H5JUcDLp/YdaFA3mFZzlDtMzlsmHulkqwPScyE8TTm4VD
 SNcmx60s52eJ43l2F5+keL0lTvd9gDdsDA/RZOspWAcBiibzNVTl24eV24FslRKfGV2Sw0rPuKy
 3U1FMSrCoUNY1Hv6Tolz1jvLmUxbHQJhGngh0qcq1QPhqF95guvxrjzM8CxlguFHCq9Da+tbOyv
 hxD4fuyfxGNL8/BKI4Tnpm5PbytBKdCT8UyZMGhabSscZmYqkeInoWiGFptllVdWGU4qH/HMDTh
 QySNU7YTsh9KDsw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the pwrseq subsystem's consumer API to run the power-up sequence for
the Bluetooth module of the QCA6390 package.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 74 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 384a2bbbf303..de4f88d835cb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/mutex.h>
@@ -214,6 +215,7 @@ struct qca_power {
 	struct regulator_bulk_data *vreg_bulk;
 	int num_vregs;
 	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 };
 
 struct qca_serdev {
@@ -1684,6 +1686,27 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	return wakeup;
 }
 
+static int qca_port_reopen(struct hci_uart *hu)
+{
+	int ret;
+
+	/* Now the device is in ready state to communicate with host.
+	 * To sync host with device we need to reopen port.
+	 * Without this, we will have RTS and CTS synchronization
+	 * issues.
+	 */
+	serdev_device_close(hu->serdev);
+	ret = serdev_device_open(hu->serdev);
+	if (ret) {
+		bt_dev_err(hu->hdev, "failed to open port");
+		return ret;
+	}
+
+	hci_uart_set_flow_control(hu, false);
+
+	return 0;
+}
+
 static int qca_regulator_init(struct hci_uart *hu)
 {
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
@@ -1752,21 +1775,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 		break;
 	}
 
-	/* Now the device is in ready state to communicate with host.
-	 * To sync host with device we need to reopen port.
-	 * Without this, we will have RTS and CTS synchronization
-	 * issues.
-	 */
-	serdev_device_close(hu->serdev);
-	ret = serdev_device_open(hu->serdev);
-	if (ret) {
-		bt_dev_err(hu->hdev, "failed to open port");
-		return ret;
-	}
-
-	hci_uart_set_flow_control(hu, false);
-
-	return 0;
+	return qca_port_reopen(hu);
 }
 
 static int qca_power_on(struct hci_dev *hdev)
@@ -1794,6 +1803,17 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_regulator_init(hu);
 		break;
 
+	case QCA_QCA6390:
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		ret = pwrseq_power_on(qcadev->bt_power->pwrseq);
+		if (ret)
+			return ret;
+
+		ret = qca_port_reopen(hu);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
@@ -2168,6 +2188,10 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		}
 		break;
 
+	case QCA_QCA6390:
+		pwrseq_power_off(qcadev->bt_power->pwrseq);
+		break;
+
 	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
@@ -2309,12 +2333,25 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
 		if (!qcadev->bt_power)
 			return -ENOMEM;
+		break;
+	default:
+		break;
+	}
 
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
@@ -2360,6 +2397,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 		break;
 
+	case QCA_QCA6390:
+		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
+							   "bluetooth");
+		if (IS_ERR(qcadev->bt_power->pwrseq))
+			return PTR_ERR(qcadev->bt_power->pwrseq);
+		fallthrough;
+
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);

-- 
2.43.0


