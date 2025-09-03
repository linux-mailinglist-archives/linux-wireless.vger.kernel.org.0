Return-Path: <linux-wireless+bounces-26981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E22B42CCA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 00:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5051BC222C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 22:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58E2C21F9;
	Wed,  3 Sep 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr+Wltjs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525527FD62
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938670; cv=none; b=bXLxjsGlyt+stJ5v8YewseD5JSBHg1GCCJAHAtmxJz6tF8gXGX6wyHWmGP9Hq7nnVYxLZyM+Je63hDDW5W/0KDt4bYew3/TQCOx4AZ9s71wTI97ZzqrqCqUyuGVIFN0vwfuyfZyBd7XBlMHcNMjYIud1UvW4GUYTJDpOMEh5C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938670; c=relaxed/simple;
	bh=Ohwq0knkVNfNucj1bHfXO5VLLviIUAQhR+EsaaidwbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mASez0KKhnPvnCmeFfOR/EEKzWpP4dWOq496YKXvpYBEke7sQwRRQ0gQTOk6kEvfSj+39nQ99NUgLuycQ5hE60Zk2oxImre6ikB5RclbNaX4zuRNNuRzN/cx/dEVnGhUtzN/smPT/UT16i3ZCfilnxCfhUb6ozQ8tOKxHaR0CXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr+Wltjs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-248d5074ff7so10576735ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756938668; x=1757543468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi33+M4/IV9G8bDA0vd556NIjfeucLG3pAXLQTaaSn4=;
        b=gr+WltjsZ6cEi3yopnPcwSamNjeVHA2mHz1CE5ws/kwkR2Mc49/bNBB8ae4pNmCLma
         AgCLWl7wbKnPwHVB2DScUy8m5XxuWxzfguw8G8LKkrhOFvCGs6v9vGNrGiskoNj7Sg7V
         TYCZrvTiffisTsMn/GHmOrnKH9lrOfWehKuE+M5URLpOrKQaeqqi5jnOOfp/c/KTZdK0
         +Ao57HGaPamKG5SG459vCFZWVRQGDseKFybcTXF6Bp9b572mEN7t5K8SFMUuo4Am6Vps
         CqY4uRn8wwzmYOm1d3RQLIpRAbulwe7ijNwBD5gs+xp9xDnOkjxYSDDeo8G2JCzPrj2R
         eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756938668; x=1757543468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi33+M4/IV9G8bDA0vd556NIjfeucLG3pAXLQTaaSn4=;
        b=C9zIARXIj7igpMP6PZP2nRH4EBkz/Fh5ztCGNuONxuQ0mhEW3JgSXdRbWj7VkICOiq
         AGV/HUBLlQfBGu0wPx5x2YZzo4szJjR4tczD8cegD71nkfTR5i8U9r+N0guL8OBjTKM3
         E3uxNFcqi7cx3ApF/L6a9KCPgmBy9QfMTDEfrG5ehpMXEUSO/Eggv5NM9Uglb7V5YKH6
         sSw8qqDmUcGEZsi/zWh4BUqC0J3zVqczFfapAQCSRb23sienHWd233DntloGorRPRl2O
         KbeoMb6/NG63EjyngTzt4klh8/pVuH/6/CwK5LBTm5xYyAlUrDqyHCVtySyWHMI8eXEo
         VJ3Q==
X-Gm-Message-State: AOJu0YyWCULfD3ecP0lMvf4RodhX1hXld3mVul6c+yOzRI5dRtxdXw6j
	fPHj0JTbj/7gmGh0//X5wEJ4sCIeGstm2R7zEv3Mi7MnDzeLas2Fn6/gnyL/8w==
X-Gm-Gg: ASbGncuhqorTlCiCblV2lhiFIcaeic+hvnuBH3aUQ+s3N42u56eKwCwecf12y8hXqB/
	bGEA3+Zl69A2PFK3NYBOCYEldzwPhPJ/orXQuN9CPiNEqryWO8UEosRhBJR9q5UWOhuNVQzPaH9
	bR6g8VhsaYNcLLjts0Mpzli1HgBlxBSGc7EPPwl9EdRRSf5U9ZsWtPp7SxKydQb7aCUhiIa3aAw
	57yWLikIVm9juYrY6q0wtjDNmAhHqkVfyeVW+8C46DYCloVIhr0cuo3UZbwxgPu/f88bhgtMoBS
	gsGnajATBTvQSqnTvcsoY0cPbDK31ENkt56e1dQebm8OHxAcvbcL1bPw58oOSqMr8Qv7y40DBkB
	glJtvJisVu6HpyqT9E8CxncFQw3ueATBu3lZIP4nm92omAWFFyLQtx8XRXxjkrh4=
X-Google-Smtp-Source: AGHT+IHEufHe3pbL9VRGxB58o1ro/fL9IX1EsrngAAeQm8NsSl2f6HmVfG2FwPIZXQXb6NTcnHnRFg==
X-Received: by 2002:a17:903:3804:b0:235:f091:11e5 with SMTP id d9443c01a7336-249449037ecmr201642875ad.10.1756938667705;
        Wed, 03 Sep 2025 15:31:07 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24b0a4514f8sm65236665ad.143.2025.09.03.15.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:31:07 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1
Date: Thu,  4 Sep 2025 06:31:00 +0800
Message-ID: <20250903223100.3031-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2001:3327 for D-Link AX18U rev. A1 which is a RTL8832BU-based
Wi-Fi adapter.

Link: https://github.com/morrownr/rtw89/pull/17
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index b315cb997..0694272f7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -30,6 +30,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0100, 0xff, 0xff, 0xff),
-- 
2.51.0


