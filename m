Return-Path: <linux-wireless+bounces-21545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D9A89A56
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A596A3AAE1C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DCB29292F;
	Tue, 15 Apr 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfScdZQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981D268FE6;
	Tue, 15 Apr 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713095; cv=none; b=VdtV/BYLZYxpf45b8ledet9CfLVPSk1ReKmlMGCGTV0lNxqcpexDNde4+CmHWlsC4VxI1NjKm32K67Xhg18gr5Ku7SqMdcZNDvDEXTcOiNjewXmRU/N0EhpDzeNpIGv3rwWDfwOMZGPCqpjpekLEhBKIDimY4lMi2Q7ZkOn8pmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713095; c=relaxed/simple;
	bh=5n/PJQmuDXSeQ0rjb8XfqeeQUvXxTS3QeCYmBdjqMTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2HAqKRuJowtX5dJGmeN2EIa+CP9jisKOtomgAm5ZTJ11OQuWonNbTwVXemR4hk6AmuASYblEg6UtI32xvWzMSLAk/A3k1QJPJEGuSgTOiCRODLe7NsV8xIjMmgwWJJNzXsrGASNd/FTJAIqZOdMsFeAwWZKsVd/nOFfNvRbzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfScdZQx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2279915e06eso56522695ad.1;
        Tue, 15 Apr 2025 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744713093; x=1745317893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlPDWoBZiUvXIfFNgp+DEQ14ewWbVxvdQiGjuAiFZ6s=;
        b=AfScdZQxJ+qA7gB3LpHQ0eFqGkBtPmZ9+izYTssf3nedr4a4rQnESEFh+jLbJ2H79F
         vgoZ5Zsr7KJbsyA9OW/eeLtnbEOHFvRI5NipiriPTk94YxsRkvSvP/cHUWf/Jnc+yg8u
         Wmv1VLSXqoBvmEZPQ0GggRiuF0SCAMESA7AIXvBpRSx3qHb0IfTuBg7MhRvDMUZWTKSk
         +8Bn/HuIQQfC25T9IgFncsDuuFBeGpEj05Wtbj1zKTqMpKY/GjsSKkQy7fkUA6zWM9Ja
         Z/vEg9vCQtfUkIS97ZXuH9cE0OSCVYv+I160sNEKyj9H3ZSYgMZ61dcVGwf8hc0CK1Ym
         cHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713093; x=1745317893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlPDWoBZiUvXIfFNgp+DEQ14ewWbVxvdQiGjuAiFZ6s=;
        b=CIEN57z4KnvxEk7RHrSW/BjkhAC1d9MLToYZMAGUlht6DortmUsH34/edVpevDVHgE
         deVUBW2eyPAQIMgrNeYcIoyh7+5SmRv2npsISTF4VRk/MyjXnMz6sJPys3y+m3i8VgNa
         1kWRZT9JMDZNWs3H1lI8OcS5IONsxUheelQiHIsFC9seBWTh6jnMlWw/afep6c6rgABc
         aUAvMQU4fSbdYU6gqzfomXc8ng6S9E3WDdB5F0fwok2IfBYlZdrWcMtTKxtEd4Kid8tN
         MSB2fbxdxtMJIbEowgYE8MzEwd3+TGs7TRryGb25htI/Aw+UkILEyGvCBWNU+rKrtnAv
         1Owg==
X-Gm-Message-State: AOJu0YzjqDBKSN/odHpq0fbf4jlCJ+9CwL76w1eZI6AmjJ9PJ4xpaUFQ
	c3AMUxhS/dgnNX6j2cy28wy39lyrn7325Tr2QWe4MJxfBlkt98O/XD5Z7I9g
X-Gm-Gg: ASbGncuhKjjuUtMSoEaJbWKsFXaFx8laoWay5+yg4UqsJRgmyB6Dk6M6ZPZKFBI2REq
	/m6tEAioxwDdta1suFf9EhvbkC1jwp5iRJkLEegNLZTE4V2ZISoQhuzrEBBo4leEWwHpUarOIWf
	6WPwllON03Hu8hHgrKAIk+OiHbtR195+4AhcMtuaXHc7Qaz9joVMY2vwtO/ZGXoxaivX9D2qyck
	FieKsmVyYQj40bWFB9W079jGSOlBOp5qbv2ba4mmvDK8Yu+AP/K39AjOpKLJGj4mg/gUF2z61KQ
	+s/gXYpoNXEqSUKvONwRpOLY+v6JnM4d0J58bkXyelI/paDrnjQPtlLmgvtAl5u8Al0YJx6NJ64
	GN0Zi7NJJgJsaU1Y=
X-Google-Smtp-Source: AGHT+IGmlKbce/FHnufAurD810I5kmTeQqOws0dbXnmxFUnhg6g7O+E4CJidsAvQwsk/2GbuPQCiuQ==
X-Received: by 2002:a17:902:d4c8:b0:223:6657:5008 with SMTP id d9443c01a7336-22bea4bd865mr192176525ad.24.1744713092503;
        Tue, 15 Apr 2025 03:31:32 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd21df771sm8158292b3a.76.2025.04.15.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:31:32 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH v2 6.6.y 2/2] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Tue, 15 Apr 2025 18:31:25 +0800
Message-ID: <20250415103125.15782-3-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415103125.15782-1-zenmchen@gmail.com>
References: <20250415103125.15782-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
[ Zenm: The rtw89 driver in recent kernel versions supports both Wi-Fi 6/6E
        and Wi-Fi 7, however the rtw89 driver in kernel 6.6 supports 
        Wi-Fi 6/6E only, so remove the unnecessary code for Wi-Fi 7 from
        the upstream patch to make it apply on 6.6.y. ]
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
   - Add a comment explaining why this patch differs from the upstream one.
---
 drivers/net/wireless/realtek/rtw89/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 7787159dd..30cc6e03c 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2482,6 +2482,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
-- 
2.49.0


