Return-Path: <linux-wireless+bounces-24267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DCADFFB7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 10:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A60168654
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231925A63D;
	Thu, 19 Jun 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSN8V4Hv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A993085D7;
	Thu, 19 Jun 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321578; cv=none; b=gpH3szABGgQJ+DUgH1GTq/rkxJ3o6RTWMj0cMTfRCD1Dtn/nmDflniTKMAtK96H2nX4ltH4ARNSNrwy/E6QxBOkdGwxmWJwRexvx7FeJ5MCZrSUWP2934vObm4T7es1kOLL9MGoVh9hPwZLc93/v3mnxp7ryWXgylu3jXmc86y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321578; c=relaxed/simple;
	bh=joblJuM3YJrC3NH4fp8pNVtiViql4YenRSFoWywNdnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TmoEo0t3D3/iFMfF5nBffK27mYxNMm4IVIj2cJnyUmkvuXHlxRl/YTlVHioMgBUvHtJSFfo4FfxlYW+Kluha5vF3Eg9TabydEdYYc8nqoSXmW9i5R+XS0lXGw3kqehHoy9VqMz8nZcme1d3zkiDGXn4QZp2Ms8EZ99zsM6YzBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSN8V4Hv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so443597f8f.2;
        Thu, 19 Jun 2025 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750321574; x=1750926374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0QAsYOvosi5fcQ7ZHm7kVrA3Pm0vHCmDptHz6MIxTc=;
        b=mSN8V4HvSTq97dQSzbffC4r+QT+nJLi6UZmRrlEI1esD0WaiKfXw9x3lecyRIFmbJx
         mBCH72AORZjzsUgiEjqVgYb9tmxQEene9FTHZR0r5OZ3TwJYQwhz2mL+fZKAsDuSzHCw
         u6U5DZ6Y1jdv9/wqsH28f7hn1CyWea4RfdxL6JHtVqaecvZPJMC75eCHpTV7vWpN/qaU
         STgga3UUt5dzDtTweCTEFuDFtSOrxPQeIs2n9ayrfsZCh/VynS5UpoXOc6sADy/DQSJz
         uzIF/R5hSfE4KuClj4b42Ie8uenFuNfYB6HiL+BtCwIBTJMgID+1qd/q0sIwGFcIrgls
         QpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321574; x=1750926374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0QAsYOvosi5fcQ7ZHm7kVrA3Pm0vHCmDptHz6MIxTc=;
        b=vPs6RhtYeXeQ0x02icvj0cd6S63CGfDV6ObHBMuWdnjg493hY11qbysrulmFuVa45A
         TyENgTwPgkwiSKzcZBKSg9nm46TfAsWcJeBrKWFnbXh9BYCNUtwnGLTNyQedjOIbae30
         YIkQ/PK7tZFsa8hFv6luEt3kwPUd9iRaKqDzrLHd6DlKAe+VacEn0H2r6vh3loLH0xu5
         42Jen7p2wIiguEfqIGZGPxu7ObjxVDzisbOk0lkLADDLpIJqz56oixuoyCcHocRLWfeh
         onEj6PXmhtBVFrpvbOK4OIf5TMTYooifB6Xj2YoeA+TDMFY2wjSJavGRNqNWgpEsnTQU
         lk6A==
X-Forwarded-Encrypted: i=1; AJvYcCU98uNcdoUWDYv1fPj5Bcqwuit9PeOvtdNl6UQCpLxHcEAEWKhL427Ef1ImhnFXYX8PoQDHfU3qDf9dojqxuNU=@vger.kernel.org, AJvYcCWs06JISII6fnOIMvezt7q4JwbKlB/FtXVUgbdTwu7dBSbF2mwMQrJQO8N3d5rcN80CcdZPsYKC1BGP04k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycdCQ/jeFYS5faU0aOqbKK+T6SrxQ/PifjuPX8P7qeuSfG/nh
	Sj+YbtRa+Y42SMnDAiwxf8YMGuzq8lEuZYCuHjsJFVZx7WaLPl7oWokE
X-Gm-Gg: ASbGnct9ZyRwO66Ae4CsTn1dC+Rq9taM8/VZnc/8N7JrUGpM7NJ3JnL0uj3WbvvEbYa
	McnWI/QpdTtYGIBX6HYGLAjvqNyT5kRxVq+2cTDSTftoDleQWL64iSpTE97dD336ETwqIaOojl0
	ZwllRfdw2izYgpcwz8CY4GRov04GxrlqHgTfB+p9O4Sc6OFO2us8F3kJF4eS4kz+FvA3Q2iiDrw
	3rdIw+xM1Yx+XGU/+E2Q3QgU6/JY/JulWRJv6vcIvxYxcFbmnO7Owzi8a2q14Pn9VoW0dHpq6BH
	ozjXIaI7+O3P8CCAjtpSxqxl/beOiXi/NQAMjrljxux5KBk0F3NCJu9SknqX
X-Google-Smtp-Source: AGHT+IGWTFmrBJA8zRQdgBQJ3AummUbiD7FB3vTuifAlQScjEa7PD5GnrcF+/Dd8m8wX0HdejVRe9A==
X-Received: by 2002:a05:6000:4027:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3a572e8cd99mr17166579f8f.46.1750321574491;
        Thu, 19 Jun 2025 01:26:14 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453607d8971sm8605895e9.23.2025.06.19.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:26:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: brcmfmac: Make read-only array cfg_offset static const
Date: Thu, 19 Jun 2025 09:25:54 +0100
Message-ID: <20250619082554.1834654-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array cfg_offset on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 8f97562811d7..9747928a3650 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -654,17 +654,19 @@ brcmf_pcie_select_core(struct brcmf_pciedev_info *devinfo, u16 coreid)
 static void brcmf_pcie_reset_device(struct brcmf_pciedev_info *devinfo)
 {
 	struct brcmf_core *core;
-	u16 cfg_offset[] = { BRCMF_PCIE_CFGREG_STATUS_CMD,
-			     BRCMF_PCIE_CFGREG_PM_CSR,
-			     BRCMF_PCIE_CFGREG_MSI_CAP,
-			     BRCMF_PCIE_CFGREG_MSI_ADDR_L,
-			     BRCMF_PCIE_CFGREG_MSI_ADDR_H,
-			     BRCMF_PCIE_CFGREG_MSI_DATA,
-			     BRCMF_PCIE_CFGREG_LINK_STATUS_CTRL2,
-			     BRCMF_PCIE_CFGREG_RBAR_CTRL,
-			     BRCMF_PCIE_CFGREG_PML1_SUB_CTRL1,
-			     BRCMF_PCIE_CFGREG_REG_BAR2_CONFIG,
-			     BRCMF_PCIE_CFGREG_REG_BAR3_CONFIG };
+	static const u16 cfg_offset[] = {
+		BRCMF_PCIE_CFGREG_STATUS_CMD,
+		BRCMF_PCIE_CFGREG_PM_CSR,
+		BRCMF_PCIE_CFGREG_MSI_CAP,
+		BRCMF_PCIE_CFGREG_MSI_ADDR_L,
+		BRCMF_PCIE_CFGREG_MSI_ADDR_H,
+		BRCMF_PCIE_CFGREG_MSI_DATA,
+		BRCMF_PCIE_CFGREG_LINK_STATUS_CTRL2,
+		BRCMF_PCIE_CFGREG_RBAR_CTRL,
+		BRCMF_PCIE_CFGREG_PML1_SUB_CTRL1,
+		BRCMF_PCIE_CFGREG_REG_BAR2_CONFIG,
+		BRCMF_PCIE_CFGREG_REG_BAR3_CONFIG
+	};
 	u32 i;
 	u32 val;
 	u32 lsc;
-- 
2.49.0


