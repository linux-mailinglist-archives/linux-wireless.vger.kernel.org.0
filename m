Return-Path: <linux-wireless+bounces-26914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C6B3F28D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6726420302B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5B23B0;
	Tue,  2 Sep 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceOioex+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511228E0F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756782150; cv=none; b=i4L1EXyC7Jnims/C7pPjjyhXNnwWJZLTmtiW0IZuyWAOf8f4wEd6WG4/Tz7SudAvvAX3t6bcIm1ItBQy2A0AkkTbvbcQ2/SmTTGJeJ0CtAXYbG4K6RND96oicSwn/2IqJ5tPCxb/MwRQ/c8uyt7RTGYxe26gKd5GKMjVhQaX7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756782150; c=relaxed/simple;
	bh=TKqqDtchVHEKFXMnGzLG5Qy7RbLJtS9CFdS7U5PliDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTxkn/dEszP5mzfqY1Okg6BpmQtukDxpDpTn9XfGb7cPU4b+1HSgt010Oj8nIPKL+EE+cA2P+O7+ZlNI6KmgiPsMLhqq+G4dPwaJ4FdKE9G7ZFsMW0vk22uBqvFHuURH2IgOWKJekqC7z23eftLt4nr0XK16CeULVH6eYVUvbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceOioex+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772627dd50aso1136750b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756782148; x=1757386948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3v+IkLs+1uT7erk5RQVWa16231czpzj2WO82fF4qOGo=;
        b=ceOioex+Q1iDulU11ybJognarDYQxW+Y8JQCeLqjcnrKG5U0SKH2SXv3yJY7279xE9
         XVTVkowFg/lok1pWIr+0SRceXle/6qVWX/3SBIc35FiEgsjoAcCyKXQEqEzfv/A/bxFK
         HWl72uBiMxZlZFsA/+q5feKBJc9S00/Om2bzQu3GDJhrCsHjMd34a/uMXodIItIckTc7
         7qQorMugnm9fHtIl9AxhfWqlZg3xlKJvxl032OK0JpVf2HLHAhSbK0DikD+y4U/tCxjv
         nZQlOM7wuPsFqbE/0ABtX7Ys5XPp7Ogh2RmLvklUFgYJ+rCG/MyJl0D3zdvHQ+Vi0D04
         G3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756782148; x=1757386948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v+IkLs+1uT7erk5RQVWa16231czpzj2WO82fF4qOGo=;
        b=AT8OK6tN7fNycJeJeTOZdtyjJ1jLFy2OsoUxBSQa1+ZOtzacPRH80HRl1SSfrgOGaG
         y97XmhG27jXbbrrNbRlmAjYUlTZ/loqGf3auK7AcWMlke6oPetyLM2T8ay7RX32pUh+d
         w5MGePh33lHa8RqjSRL4Qs57m6rjnHk/rwa3Yo5ts8mgcf9F5Jf2mTn1y6WhMFutP2q4
         sRiUUQ9BEX6zE2k2UrsSvxe9vhpTCI+br9GkkP5fsmIwGzd2NYYfx1/Fk0Lv+KFzuTKt
         5Yh+CPejCjEUPJA5dNCwbJo5K4+7uCcty0AMPHspHjH4O+PkM7uSXNvYVJ0vkhAC/WrR
         9Sfw==
X-Gm-Message-State: AOJu0YzVsu5S5Y6eZrmBVVuTYD/dHGElnESkjU8yWuAIbtJZo//Vpd+P
	tz0UYQvehmq0Vovtp/vwp5qoVc4nvkGfSCt1njqUxpzhddc5B5njvXfQgkwYTw==
X-Gm-Gg: ASbGncsPfvStsT0zDd7kHXs+QRZfE61uIiFviVHlZ4bbWDGotHsVyuI6NNiPKJl/Wyu
	lbEdAbPO6sOXpVDzuG9yW9qKeeTeV7sqAYFa+QYuc2S1eevUVNFlkTblmvSldBV0gbd4yr3B1p6
	WBaz2vXLxkGHSOkwfPqBuUP0quWxOpPF71JaH984nyhZUSd0rEmMcf46MRge7AgSQ/6PskiwPzT
	GKAWwAdu0Qy8ErtxHJFqz/l1C6x5MT2ixOentLD49kJk4n58U1t5MgODCd1NLLEoOdYHaqfo1gQ
	6EDa7GP3MrPlVbfMzV/Adf3k+eJ3+v1BHYa+I3l9rmrsRj+2dwazlArixvN5eR/EZplE/ePusuz
	essXB7iN4oanh5Zf757JKvfd6YWmrjVgYI4HAZFC/OStE1xGCjiqyZkg7V+fWq4U=
X-Google-Smtp-Source: AGHT+IHz6HMowenoJTRTosb7gfTh2q0ZLOWhnXefbehRUD/XUmtI30FgsZ1/7GsSGtGMt6uiCyt2GQ==
X-Received: by 2002:a17:903:22c3:b0:246:cfc4:9a34 with SMTP id d9443c01a7336-2493eff61c8mr132018945ad.26.1756782148005;
        Mon, 01 Sep 2025 20:02:28 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24905da1879sm117468615ad.87.2025.09.01.20.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:02:27 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com,
	usbwifi2024@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
Date: Tue,  2 Sep 2025 11:02:07 +0800
Message-ID: <20250902030207.1968706-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
Wi-Fi adapter.

Only managed mode and AP mode are tested and it works in both.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Although it works, but it disconnects occasionally and Bitterblue is working on it.

https://github.com/morrownr/rtw89/issues/11
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index c3722547c..510d124a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -19,6 +19,9 @@ static const struct usb_device_id rtw_8851bu_id_table[] = {
 	/* TP-Link Archer TX10UB Nano */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* D-Link AX9U rev. A1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	/* Edimax EW-7611UXB */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xe611, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
-- 
2.51.0


