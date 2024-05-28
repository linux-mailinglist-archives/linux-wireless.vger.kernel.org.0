Return-Path: <linux-wireless+bounces-8229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275E8D2426
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904901F27666
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B58181BB5;
	Tue, 28 May 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R38BqZDh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452C180A84
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923051; cv=none; b=XqUttFZs+rBUL/YyoMN/PocQG05d24axFnqu9B0rDVqqy++QH5NxCrJ5p8rb/nhqMnaeUsJ3yJ/ptKE9aIRWRZqIo5zTVYgjyPak6YSgLv9pw+Iyp/iifV2qSpY94mBcov3qKVt6hT9VbmU07vQa/2Di5lqhf8dk7LL36mTLAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923051; c=relaxed/simple;
	bh=oGqCjZoMtSrCwf8xbipdg0QeegidLEYbNGeloSkNMkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G24gO6HISLJi5LI4p9VuV7o1wVpLEjqiaBjfW+mZNsHe29YYSssO78ZHLiPxGgyDZBZ6AEFtNmyCJun/rg4CGici1GnIRNdgctvHIMEsKHWfheSS7PBTHX8Py2nvyo+SK3G0T3LARtCClA3DUXvX8z0kqENiqdLmyxgmB7LOJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R38BqZDh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420180b59b7so10227365e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923044; x=1717527844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFU0fFDLXBVTpEVhQ1putOMYxJzP0S29Lv1LacuJjZ8=;
        b=R38BqZDhYNvR2rKNSmV0hLmvuMnuSYa1+tsiCVZyA63IxmjdJzuvLuqQuFtzLNn+XE
         wEcngCulIRJz1lVeu0uMvJFkv0qngFax3d9huS2AsegvZ9yuPjYKvhUzNtK2jNWv1aCh
         Tm35LZsDIce8vGMRm6JyYZjD0YQRk48MeqgQuX+eEe02UlrEwt+oMMfuTNc5VL9KlfX0
         xoIFM/zUreqABkUuMexDadEtMHymoD8YleZ7VmyOo0CDl5GXG8c3UDouIBbqAylMdrwd
         8Iv47hoF7h+whHEwp+CqNie1vidWQoWhgG0vSYEPiiuD6NWtDGchZMkaQ7PCpar4HP2o
         FkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923044; x=1717527844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFU0fFDLXBVTpEVhQ1putOMYxJzP0S29Lv1LacuJjZ8=;
        b=qcN2Sxp6zXl9FFaPB3VX8+h7Dad3irY/DMXaUVskS5P6kQsnowuj5lhTDniBGtnC73
         RHgi1BqA10PNN5VwMDY4UqrDb+nbmUtV0jI2u69Sy3sAEGF9Tn3SzosnyLULLaKGLBPD
         Gg95ryox5x8CePCI6EJh+yzAZQ8cPN+IdEFxKwwqJPKEq3/LX+FcbQ3ELJHfXjdJ7QnX
         CXEuG5SbAnhTqjlK+6VQklTcb8nfRcbEhBudLuCx47sWzD4Wmpqwmz3akVXCI9Qz69h8
         z3Wm7Lx+tFOsGgeYShSgRCyh6eYdmQCEnEHUUeSc4jC9qYHEoeH1f/RDeB47zdDj6G4X
         4RtA==
X-Forwarded-Encrypted: i=1; AJvYcCXvHWjleEoi5jJNfjbGerJwhLf3sZcVSmve5m2+aPevp0PIlcIr1hppFr9/r0YSNqS2uje/g9OHqnocxlqG0mg7FSusT2o/E6x40Qg23eQ=
X-Gm-Message-State: AOJu0YwM7Zp3dG+E8Y9a5XcpiSOyIvGFW9+JltF0m+j1sDe08XSs6/1f
	rWPkQn8etNkeu6Nog05hdIDjfQ89nLQuM6u0OjpNUH7b19en2HxfxuBhPo6lzj8=
X-Google-Smtp-Source: AGHT+IG6B6kXReUvfOK7G13iUYw63mXLE+oQ5Xs7Zu/A92odTJ2Gt2f1pgs9Npx0RVH6n2yeZy3ueQ==
X-Received: by 2002:a05:600c:5719:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421089e97bcmr91269195e9.21.1716923044209;
        Tue, 28 May 2024 12:04:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:20 +0200
Subject: [PATCH v8 12/17] PCI: hold the rescan mutex when scanning for the
 first time
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-12-d354d52b763c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kuyJTCA9fdYhUGDXvoePXqDSaNb9NruStgSbf5wa/1E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqP/eY7rIuS/eQw4O3UlON8rwdGRoMGUP7rz
 yzNVdBe65WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjwAKCRARpy6gFHHX
 cvKjD/9WKJ6xrPFHjBRP7ktzwHOQmaTfICHaHJtV3PV0foF3NVt3xBjv/3MfTIoDHxKL/27sUbX
 AX0c1HDDrhyg+xUEwP3Ldeoi+bmJKHTPpBgTuLU0F9ax8+nQsFBoHyOQwaIFebtMFB0f8GE+xA0
 jsxo/VePbSMksuxs1v066MNDPpVjKPx/BS6ZmdWbZU/Fhw/PA83vcPyKHyS+gSwR+/a6naEoIDG
 /r4rQ1fIQMD+/LMFzTJYgTkk5dh96SRuGfQ0HgYSfbWr42EdZUbFyMDhgUiqQceMOBwexPlqd0J
 BOASeFIGFOYM7lyG+0RBjDGGbtg9P3D8EF5EbrI5IMHMJGEPlOdEEHydvZ3irbtN/FdyTQcps60
 W3h5F7J/GEci3w5eTef3u2+nLFBD7+v/IzE/U+e/ISniyUz+HOqEMZ2cfKGAqvzBXOFxzAONnzI
 GUn45522td18GWGJ2IQq6PWkohJhco7ANiMaK/pwgGkemTt34e2f56iqSkaw2hhTnzrI1oaIP7K
 SsLgff5wn0FMZqpU/xOqN1gUJ6dCL9fQiFa32Acmjqlhp9qs/MVZY6ri19ncKXCEPITAp6Qv/Rm
 AK96m/GOCFcx5h2BnodJx318PL5gOmyFiDLn7oaEdmqmPq2rpC9akype843qdeE5gZ0F8jt0z/I
 Tu7x3hngIac7MMA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the introduction of PCI device power control drivers that will be
able to trigger the port rescan when probing, we need to hold the rescan
mutex during the initial pci_host_probe() too or the two could get in
each other's way.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..604fc96b1098 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3072,7 +3072,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	pci_lock_rescan_remove();
 	ret = pci_scan_root_bus_bridge(bridge);
+	pci_unlock_rescan_remove();
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
 		return ret;

-- 
2.43.0


