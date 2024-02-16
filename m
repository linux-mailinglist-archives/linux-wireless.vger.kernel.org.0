Return-Path: <linux-wireless+bounces-3706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04D85872E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B861C25253
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DD145336;
	Fri, 16 Feb 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0H0mj5jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088B151CCF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115614; cv=none; b=YQWFCf5LLi2SIklZcPBdtH4UxuxYCTrDPCRjdExX+4aQYpCpdj9vlYGDxMTJVd6c0rCMgrW28WU+cEMpYZYcbDbU0k3FSLs9vRQ1GqdoGLRJEuP34v+G7w5WNKwzFfSC+9L0DAGijhJkCJHudTyrM+mmt7C9dpyRHKcfsXM9/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115614; c=relaxed/simple;
	bh=ItVOWrm+zmPgwU0jiuXsWbAoFc6imFhaKj9fNGvBoW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNxDKTJlvXg3c5cekoVAim2F0yqVfqYQv4K1GeZuI+ocK7Qj6/iYOpZrsBKgzxXRpEsdaUn5GEUV2/88o3bse9VbWUadHMtF7VGU3M9mS6hvTNoK12TjSUt4gqeuDjHNoTJ+gv5u0EnxBl5pdcJD6nP8Zqw0w+EFN8X3HIfCjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0H0mj5jr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41258904302so174395e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115610; x=1708720410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=0H0mj5jr4OKi3HUByCC09hQ4mHsGgmT/ol2rT5sRBJo4LXMsR509dnLVPQj88to99o
         IvqXfP2wG1BMwPRHq9dOyb5uujUUvdqwYww2Ol+fK5o9d0SD6VzxvwVyXRX/UGtD3jXZ
         GU/wPJDv2XuKlHN7RGhU+1dL8pJo7zo4od3kKv8e2Ln2UAuVJK7Lbnw6GIYyo9RN1D/x
         f/48r2Iv0iIrjniwH/1YwJ5PnazRK64E7v5y/huSURRtDQihH2H9SzQGZXPPjP1pTUF1
         A8+pS7wbNNt9pofbY8fr6k0026ZmPd68kOn4wYRIXruRmkBFGxaW4TE2kXqzPfZIllRD
         RFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115610; x=1708720410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=sf0uTpSgvl6SJ8gXh5YKtvak7As8YMP+uyVzw7tuVrOrsOfLEqTqp7lO3I6BZX02nc
         ewMfsZ/+w4zQSh/Qj32EFgv7+f1Ge2dO/9cKt6AETWcOhW4JtAHtal8AGnublx8WKkm5
         ovL0joFEvLgwJpybfj0HFPId4WA5CpDDwSDZ/6eM6YqsWxIuvx0poWqbr4v6XX6iDxth
         0UVU78tWouFKWnybdhvywoyRlIDYIe/lBLjRb6ekO9qPNsFhji1X/C/H23x3eqEzQnlH
         MO54XUve/XnTa8ElXkQZOKLJITcLZiCTTK35TSTZl3Tp77SusjU1oII40gErCMw4AX0M
         2mcw==
X-Forwarded-Encrypted: i=1; AJvYcCWeEmslawJfSO0Nn3Jv7zwsdgvNyT0YFJPRMo9JRiYQXJOZ52Pd9hWZIQylJip9MjuZwsB2pIYp+d7T3QIMnDib2S41JVl0vynBwKLOihI=
X-Gm-Message-State: AOJu0YwYxtpikyF9jag0diQ9WwgaQYN1Qt0ctZCVEz7HqYUZPtoBRPir
	aB1Qxz4LpT0dk92nWedUARAip13WtprM1b+AWS1aT7qA3UEw4JKD5egmq10nXbM=
X-Google-Smtp-Source: AGHT+IEIxZ+2uB3UEcdhGVTyTJDaWzytlIE0jDJvcLHgbNngP62RD3/E1pF6wGg8FGrlRiGNZ99JNg==
X-Received: by 2002:a05:600c:3c8a:b0:411:9508:e237 with SMTP id bg10-20020a05600c3c8a00b004119508e237mr4998629wmb.19.1708115610266;
        Fri, 16 Feb 2024 12:33:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 12/18] PCI/pwrctl: create platform devices for child OF nodes of the port node
Date: Fri, 16 Feb 2024 21:32:09 +0100
Message-Id: <20240216203215.40870-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 ++++++++-
 drivers/pci/remove.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..17ab41094c4e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
-	if (pci_is_bridge(dev))
+	if (pci_is_bridge(dev)) {
 		of_pci_make_dev_node(dev);
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..fc9db2805888 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_platform_depopulate(&dev->dev);
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.40.1


