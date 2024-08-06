Return-Path: <linux-wireless+bounces-11001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9C948B2A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EDC284BAD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4E165EE7;
	Tue,  6 Aug 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i72j+7C7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C63C092
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932559; cv=none; b=PMCrtRDBpTJAFiZGvP31Ec5Y5x9iQ7/TEEOb/8CWl/9M9bhBZzzLN2YYJ1r5FUMJwD2bKh2B8tgLrSWDoP77oBJ01a28b6dU3uJt1soD9DP/prvOJvmmfP7SLGwdcagfxjWueCvnPqXguzGZjg9SgneEbGhumjStIjM2rPSJiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932559; c=relaxed/simple;
	bh=GTpAWV4ApIg7yGok0wzenzu2VbsZtgsQcK1WYAmdsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvcRkN7iyDh8UFx6UEA2zYQurT2A2ynW3WzCU2zw/2UvA/Rc0vkdJ0Z22yK5Tsj1SA5uYMp/SE/rKXw8vnyJcwTHFPuB816oVqUETLYDMQb5b6qsEklBhnGG339kiiGVxbWt3SyvXwDQqqSthLz0Iknj2dGBKFM/GDvbNyTI2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i72j+7C7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so2207145e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722932556; x=1723537356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TABjTBid2DNrSgPvWpxEh2ECcXbtvV+a9CI8B8A/6Iw=;
        b=i72j+7C7G6mDewlg5z7MiPKFy/aDpph4hh6nvM6xmVHPlIyBADRD7axyv4AzLMaTCJ
         Mr8loJoCU9iHvzWZTObdRa7T5+Cmq9hOOpTvl7HoV4NcrMSzBdXD0O3V+FAoCa2GAdWH
         4KCJabmt+Vtyyq86hpIZZ14VHS0sRk0iUj0wHVo3zEolv9iMvzzaNG9mQtutg8g77V9+
         uPULlM5ue6JNYuMINpNB73HgZ1nOaXqCCE5hCdb5E8DPOkcEZVvnTwNcFNJAQk2jmkM+
         g9ydubpaRdSsEnMO24scxHdW+b8o3fwvMXb8XKM/S4lx2DZRW9Emjs1hC9AHUUE4p0YX
         uqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722932556; x=1723537356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TABjTBid2DNrSgPvWpxEh2ECcXbtvV+a9CI8B8A/6Iw=;
        b=XZu5M3i94Z6NoH0aQjTst1avVvWUbVpfVBL4hpuJiIDZU+oVlRpG+dsL6blvssw3Vs
         d6GojxC0ynPmJKq5BfQ4GUFuxzueJF8wdvNWgfLN5Y3SE9dWRgeRBvZ44Pw+ybBflL2T
         T5t0O/SFCPaWA8hRYS4rnoF3etgQe0TUlAAcerT4hJbgm6DcijzUheBIpsLZHNhvmahB
         RtRXGCWKfkbhezs1OQmHuykgo9ICdvo6Lqf8Dz4LGsKdiixTXDHWKfbuSLKfEjKnYjn0
         tYSty76T8M3SndfJJbuXL9INwkdvgeL45jkjIJluZ5YW4tLtypTQfp4i8D5+o13Jr1l/
         Ic+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5VL+LdMSRH5GQDoGphiZpT+p1AUmkCISvgnPZ2G+X5E+XCGN5AWORFkKiAzfqBJmh1WmubRVInIyCjLanBM5Ep09MUD3KgE6Rl4lSFc4=
X-Gm-Message-State: AOJu0Yy6/dM2vKth4SLmbPglnMxkwx2J/EtQ0v3XjGr/Sa2GJAckKYN6
	b4+rUPNezFnOhVjOaQ1+WiEr9bURes9R4rtIQVP+sTW6Zc+GhuQC
X-Google-Smtp-Source: AGHT+IHye0AGe3vOvEktxujZ5aHGEOW7B12XXSwJbcsQsI4ZHh6flJf1T7YJsAuwJE4ocu3enUh/7Q==
X-Received: by 2002:a05:600c:4f0f:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-428e6af7070mr91252455e9.4.1722932555716;
        Tue, 06 Aug 2024 01:22:35 -0700 (PDT)
Received: from morpheus.home.roving-it.com.com (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::1c8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4282babaa39sm227321355e9.27.2024.08.06.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:22:35 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: add missing rtl8192cu USB IDs
Date: Tue,  6 Aug 2024 09:22:31 +0100
Message-ID: <20240806082233.3837436-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtl8xxxu has all the rtl8192cu USB IDs except for the
following 3 so add them to the untested section so they
can be used with the rtl8xxxu as the rtl8192cu are well
supported.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 043fa364e701..7891c988dd5f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8110,6 +8110,12 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x817f, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x819a, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8754, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x817c, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 /* Tested by Larry Finger */
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0x7811, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
-- 
2.45.2


