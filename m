Return-Path: <linux-wireless+bounces-8231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829278D2436
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 21:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE03B25383
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B11836CF;
	Tue, 28 May 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xLT42iQZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B618131D
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923054; cv=none; b=Mg+qsg+xD9YKNLNrZJPkTeVqWTI6OZkcvm1ynIWiNzsZydc35/FfwpG3DoiUlfH7rx/9J40YXpvkTXDmZwqwvnZIQJ0UOTK7Dn2JtUudOFkgT1tFvF/Dqzz6wXKYR2DYm+LHVF218vhj/5NeMu1/7ijcv5pyHuyWjuWTjHCq6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923054; c=relaxed/simple;
	bh=3r2pVqN/+sHLQ4OSYerfs9CNKSL3i2KwEG+Umh+aH7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RE7XLiu1bQ2sACBvLVC6PgS3Pf1PEMNNnR5AI4NL+YcNqgTODDiuxKiO9E6FD6t/gFxDut+ZXcERbKWjLsMicdf+jgRt2vW19AuG6y/ANbJ2EqDuqjBtKI6tO990JoMl2c09QkYosoD1ce65IInS1QJWnYcWZCJ962IqmCnxyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xLT42iQZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202ca70289so10060355e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923047; x=1717527847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIAqX/A7cyBOqcNtjCtgW6nW/To9B5cWPZdLS8273K0=;
        b=xLT42iQZqoKFX1HgSinFagmmF6KcjyBTeVFcZV/3bqqRJr/OJACcUahsd0daNn55aj
         j+h7YhkGtkD4qhEJiogkRQ3G5FAsO6/C3CriwP2KYKlDj7JvbSIRO3hhe2CkTSCj4Awp
         c9fCV79+x4kUJhppHrMhcqOKJlIJvb83EnaoNfZhngu7HI3xSsKO8watAxxosJmpoB3d
         zxO6XWy7XWyaEx6XleZ5QeT0NU9E9qcThBQQph48t4m5YH4B+NxhuU/gg5zBAbFgA0j6
         N3yjtLVW7TiGZ6E+wCIyCaJs6SiYsvgoId+pYEv9d4XKsst60GRWkL8Rj247uIWD8G6Z
         ZjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923047; x=1717527847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIAqX/A7cyBOqcNtjCtgW6nW/To9B5cWPZdLS8273K0=;
        b=hJBBvG0NQctQQUPCFYaem+ENRU9jOY2XNKMr6I8yjW+pGVkE65ff21KtPVZNf3aAXK
         4Gu/CisDZg8gLgP0F2XE9C4rYz1STSvzFQljUTNp4GwIJaJUvpoP3fQdrl3rnigUIKp8
         sNfNudu8yp0s4ETKhGXFQ0ObffPjtK/ZEyU0zUXHTZx7baU0pkm+rbyeR0PWDehEUrVs
         bGu7R9nmxHyhuhs3bCozZ/KrqCgSW/TcV4fyYRFvAr6RIKz8Iio+RO+XnuHM+yfLd9k0
         CTYay7mjt6/EQS78jbwvrmcs9SPW20KIv8loznPWvwMd3v89+uizOFVNXcFiij2LRlrz
         az9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHounMBLnhaoKlZc8YEE88aaMt0RgYGZ9YHVur/SVfPai6bGBjfmvLnVlQXffH4zp54QpPsHS0LMWoHFCkAOiYFmRFFQ9iHEiP0ke3aw8=
X-Gm-Message-State: AOJu0Yxt2pfhRmhFlOIn5rDsWqpCRFTuX7cP9xBXPmjBdi60wUNd17LB
	3PySun5QX3/+q39YfM+6SU5VTNCC6TgNuJ7+B8DVECCwnFxWu4PPGsPd+N74c7Q=
X-Google-Smtp-Source: AGHT+IHz0lkGSUV61P5eSq7TShjaoltPA0/QAdOG/j0o1z0ZCy0AcWo0waox12rHLA8DHj/vEX/Bzw==
X-Received: by 2002:a05:600c:46c4:b0:41a:e995:b924 with SMTP id 5b1f17b1804b1-42108a0b91dmr82051805e9.33.1716923046905;
        Tue, 28 May 2024 12:04:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:22 +0200
Subject: [PATCH v8 14/17] PCI/pwrctl: create platform devices for child OF
 nodes of the port node
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-14-d354d52b763c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JjTaqS3wTDZBLouvY0ZN3GdR/yNW7FaquCkQXG8PeWA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqQjRkZ9uZOgI/9NbVSvh6khAK880XtupTre
 fVqi1WIceiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqkAAKCRARpy6gFHHX
 cmNaEACVAeQ8jz+bWQVF+5dvErJuYBGMqjrtYZBxIdGU7EEGgixkfvwFd0AQFhVe8FqHHJWKs4M
 N06NxP7um7vj/xY0SfElsVbf+NXxYsM/OsZkE5qf3kbBQLhacRowt34vhWGfcUsx5+XxzhS7Rpp
 ZC/AmPx6sldLAcNvvUYEhb3WuryaMZO9/NLnNJN/zXoWSCAeQ4MkYMER3sGq/OCEL+BRb3yXK6L
 +A/foR6+Bv4ztyECvXpNXmtr9ObiJT+48LDRaVfwS45XtSUXzS5GHthSGZdDwT0A1ZtqcXIKKmY
 QSyNKVJtljr5mhnonYU/9zmEVtnqMieZAEtXNkgHGNaNeronuzQJX1sKQgB6Qndnq0YIM3asebV
 xNjkBK1Rh0jpTCyCmiZvkJjPIc5oImwGBOemuaCf52tUlJliwsQeVRHE0L1ZFz/F+XHu0wIYpPQ
 NTvkWV6EnUUhJnNGnFqu8fYCf/Fv8WNUhsV6dBrkdryH5PbhY2mXT6diVfTMtgqF20al/woinO6
 tOD/o3bSvczc/u8MisHsUmc/Ld9q5YcMsEIMHkZoj8HGHfVzuQEIaRoHV9uux0vxqEHswcwN6xG
 3nwdBlbptcXMcK3gE/GtdGmeQHOFv2XgC1fQBmKkzyGQfTERVXvRfFnKII7vGfrEBNhWiqtTKwe
 GoKcrXlo0l1BGgw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for introducing PCI device power control - a set of
library functions that will allow powering-up of PCI devices before
they're detected on the PCI bus - we need to populate the devices
defined on the device-tree.

We are reusing the platform bus as it provides us with all the
infrastructure we need to match the pwrctl drivers against the
compatibles from OF nodes.

These platform devices will be probed by the driver core and bound to
the PCI pwrctl drivers we'll introduce later.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 +++++++++
 drivers/pci/remove.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..3e3517567721 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -354,6 +355,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 
 	pci_dev_assign_added(dev, true);
+
+	if (pci_is_bridge(dev)) {
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..910387e5bdbf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -18,7 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-
+		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);

-- 
2.43.0


