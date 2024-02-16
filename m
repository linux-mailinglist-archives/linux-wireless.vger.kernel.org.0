Return-Path: <linux-wireless+bounces-3704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D183185871A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4CF28908F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD361151CC1;
	Fri, 16 Feb 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dh/RVxIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A514F9C2
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115611; cv=none; b=WfwbhPJTh7qQow4pzhu0cVHB/P6RyCvC2Y+F31Tch3qmrvK5pJeqlAQBj/GrCydqBX9qH7y6F1RUfIpE3y8YFax0p+de7T1Zbgh3v2PSU4ZEtUNk3TDef4esVFpsZSrAFrcn+Fo8NeNlaDNFmnkyrkbA6M8hnbkWfBd7vfJR1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115611; c=relaxed/simple;
	bh=1MzVv0nSisKV/T8y8z+7k5GcP430Ri3hmser4aGxhTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KItovPraEyr9eVs8dJRFS+OkYWTGV32d83U+1ZE1m2kXYg1hVBhpQy+DNqy3F2OKn5P1ylAETd+5Td4eUureiBMrKcXFPwF44OyYgp/GT41ML317/c69RsrhQvMEJ63dDWNku2Y8boGMcL7KWhuJ40Li8BuMJBM4BeMtdkaftEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dh/RVxIT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d220ad10b3so6103761fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115607; x=1708720407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eErBIOjTQ5lnZfiQvyC9U9P7RJRdhki8x/CaBEW0suw=;
        b=dh/RVxITCtXQhFAY6jllUpH6ijZmzSl3oVgfciKAwSldS0aKth9QMGwJOlCO4EfBQ2
         WRDOESAwQsPgDwqk5uyyMJiclBn+cnAR9x7eOPzEZjIi5ojzpGoVM6ac18dW2K+pNdDv
         WmWv23ry3sVEaBIsaZ7CHDxdvi+lI3Dl5Md35UOVXjDtYzoSVn/JEVGexjNforZG20d/
         KKIsMec5L9Ua1UE115q6masiZyyaAqT3eQXZaz0Uj7MAcvM1hyrieLFRN6t2yScFTiwQ
         pBzOa5n3sRpP/HtksgKDyUM71kZjtjL4a4HNUYZRAHRYdzCemSftVAbwYLdk2BdWm5dy
         ZGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115607; x=1708720407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eErBIOjTQ5lnZfiQvyC9U9P7RJRdhki8x/CaBEW0suw=;
        b=GJzG4/UCks25Il7JdsXU9y1F5LYcZY7olneGUwSD1Va0Y3kXk8BkUymZ69dpjPy6kD
         AZzThll4YomViu5EDz3cdyOrEOYcximPEtEHmHrVvLGkVnzsvpIwcFABNDNxf6fwc9u4
         D3rmG5yBkg2ZQyTXlrMR2T3EJAvdYMrbA83BZScqb/5gZQNQJx+ryzwAqW/5BxrJCMtn
         2E5DFI1PlNi+ZrfZd9sD5896U9k57prMi2wTtE2aAii9INMG6B3Qa8RmB6A9tZmpMRhA
         3Oyzc5lBith0xuXy5jjFFJI5B3dhUPQgBmEqPS6zLXS5x8dAVfmfTsocqW/PjlScXOgG
         OnmA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pTGyYLzaDXxBGkNWmd9sOi9rugY86jnXHQ4YOAmFOmNLmyc1S2cfHgXb7WnR4wE6Gzvm3fiJ8qiOvfv29fTKokpMlDGbhy0TlZrocQY=
X-Gm-Message-State: AOJu0Yx11TkxtsoiCWF6hOwzDUe8xWtbeqZmMHBAL7dbWnznNXVpJ/tm
	wl74WfRqFVRdW6LW+UobP+iU/ickWHSPMMawL0EItCRAGHtcZHFxjN6UB6LCMS0=
X-Google-Smtp-Source: AGHT+IEGi5tv9AIVQSVPvOrOZQQ9v1N9yVfrGqntVvYxcBnIqc7VX5XHcJUa0nQEF7j51CNJg9AgoQ==
X-Received: by 2002:a05:651c:10c7:b0:2d2:1107:3a7 with SMTP id l7-20020a05651c10c700b002d2110703a7mr3197736ljn.8.1708115607005;
        Fri, 16 Feb 2024 12:33:27 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:26 -0800 (PST)
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
Subject: [PATCH v5 10/18] PCI: hold the rescan mutex when scanning for the first time
Date: Fri, 16 Feb 2024 21:32:07 +0100
Message-Id: <20240216203215.40870-11-brgl@bgdev.pl>
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

With the introduction of PCI device power control drivers that will be
able to trigger the port rescan when probing, we need to hold the rescan
mutex during the initial pci_host_probe() too or the two could get in
each other's way.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 467c16358f17..f8ba073ffc9b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3066,7 +3066,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	pci_lock_rescan_remove();
 	ret = pci_scan_root_bus_bridge(bridge);
+	pci_unlock_rescan_remove();
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
 		return ret;
-- 
2.40.1


