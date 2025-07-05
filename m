Return-Path: <linux-wireless+bounces-24843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226CAFA177
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8D31696C4
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AB215175;
	Sat,  5 Jul 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E283GAgH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B721771C
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744299; cv=none; b=idwwKIP8gQ3wBjFORnOD1SxfCcCYECRAWLve3QxBh4iOX7qK8H9peSG+wricXrsQI8AElKIlR8J+paRw7pqx/WH4z0Z2Ygw4QQW/cJcrToi1nM/eRrL5t6Tz+9cv7WxICbXQ0I7v4R78SbVP17kolrXsMGsHpSdFiCDxSFrkv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744299; c=relaxed/simple;
	bh=SMGANkOT5htXBS5L3W4HfpLOikm5L1pKDd1Nnqw4qFU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gJIFn89HyxwAL5pnSfP9LVZp0yueJ7PQOPdi/chol1V+nk+PhnYeRDvLBAmqEDlRaIfWMX41zt2gMU2spzInJmTw/+Yx9kn9sn6IKg5CbNysHxVyrBXvg4jkAGHPwRhJzKKLFky3HElFlHGvqz2EGtnXkJwgsBqZL0qSCCls29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E283GAgH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ab112dea41so958179f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744296; x=1752349096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6XTrQzPXqusi3NZWzuEPxXGVBNIjCvQWQfphbUjY6I=;
        b=E283GAgHcKcwEoONTHaBvbcfQE41xJCNIRTJlThFbSU46HX8k87T9Ffd6jpeZfxb0r
         kc6GEswcQzTZyGvtaGrVMOKr1PEun/dzrR7q5gSLDNejbGjkEghZbMJhC09NkETZVh7q
         rzI5ojr0keW+9f0GFoRohbGdQV7KFSw1SSg3tM+KTi+lB51/ri/YKnqxc+wl0XfSttVo
         91Hj6+V/VwiYp9IH83+GFrC749NqwJV6pVJ8o4lEB2HWL/5wuha44+KVcqwNlWr9OeAN
         gAbGR0uJhqCNHQ+g+d7Btl2EivBEd6tqSqV8M55o+RiDVVv4b9CtfJOXKDh6v//KiSA9
         z4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744296; x=1752349096;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6XTrQzPXqusi3NZWzuEPxXGVBNIjCvQWQfphbUjY6I=;
        b=vF/G48QzxjfBLU9g8HVPgoA0cyjIIucRlHQguAwrFD9QVOXAmNoT3O4vypd/7AUY85
         6baDqqKUFO5rO5csHBrA9VgBy3TSjpbh/aF7aoZ4tFhJHRu/Dhn7tvR+/jYO9rv9yROt
         e0KD0fXAcI1SwBOpNFkpQBXf4UupnFg6GYJM/Y2E562o+4cxaUwh7EYN7A8ssTa0BI8u
         06mKJ31+Qjm9JpyjLZ1IWgPIXerGQpc5t/7dsu79SMXfnbfjRWOrapirKhY6sfOW2Hbu
         sL0eze3WXRWHsr2oJcv4nhaktrEZQCwgV8/58GvAnBkqJ5VBXlO7X3F1MDmvJBI+P03G
         oSgQ==
X-Gm-Message-State: AOJu0YwiBEFdGRd8zOuhI0jr3fhKsTeno5BwNYE8JEhoTZUDFT5PCzk7
	VSl1VcHzGdYBnYRXflxwfKjLH11l5Lu2jOjRy19rT5LavBZPlhq9LMXlNKLOfg==
X-Gm-Gg: ASbGnctc1eDf059ZZ5jBsjFE90WpLeoZhurQWSzJL//V2pZe0P3nIezT1QH4S+h8duw
	wAHnLXtC4RBVKrnrnK7rq+p2Y/uph+qxoNDYZtP8ZBoHRvppSm4D6WGr/6yP+eQbRKfQhOy/Jna
	bti9+6WHGniHZQwh/QOZRfWYgOZegeX14Sm4UyTQBPDYJW2QnCHrrJ8+7Kkk0VwiL7ARBv774LB
	IfiGHPvj3ynCwVW+823lWqGFlnJuhnsystTinIGXM1DbLejz+KEYol+FlaPowLb/aelIeTv9Zuf
	qLS0EhBvZGCEI4uOSriLTc1QNo6848JX/qOsYKzIdy2e7JvO/+vnCOGF64XipfRYhxx0SQGOajC
	OMPC+
X-Google-Smtp-Source: AGHT+IGk8u6KCQiFwr7HYhSm7kLdddu4EMHWM5WqODcX5vjmwGsbXK6xC4r1iqhhn7Fd4T/XPnL/uQ==
X-Received: by 2002:a5d:5d0c:0:b0:3a5:2ed2:118e with SMTP id ffacd0b85a97d-3b49aa081famr2466858f8f.9.1751744296196;
        Sat, 05 Jul 2025 12:38:16 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a409sm5732604f8f.70.2025.07.05.12.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:38:15 -0700 (PDT)
Message-ID: <7224021b-4fb5-44bc-aeb1-3a6fd3625f2a@gmail.com>
Date: Sat, 5 Jul 2025 22:38:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 3/6] wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Language: en-US
In-Reply-To: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8852BU.

In this case the same parameters are used for USB 2 and USB 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 85b6849db798..50eed21371a5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -66,6 +66,19 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_dle_mem rtw8852b_dle_mem_usb3[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size25,
+			   &rtw89_mac_size.ple_size33, &rtw89_mac_size.wde_qt25,
+			   &rtw89_mac_size.wde_qt25, &rtw89_mac_size.ple_qt74,
+			   &rtw89_mac_size.ple_qt75},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const u32 rtw8852b_h2c_regs[RTW89_H2CREG_MAX] = {
 	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
 	R_AX_H2CREG_DATA3
@@ -834,7 +847,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie, NULL, NULL},
-	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8852b_dle_mem_pcie,
+				   rtw8852b_dle_mem_usb3,
+				   rtw8852b_dle_mem_usb3,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.49.0


