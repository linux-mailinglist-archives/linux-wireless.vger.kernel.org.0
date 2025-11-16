Return-Path: <linux-wireless+bounces-29009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ECCC61EFC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C313B31BF
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E155260565;
	Sun, 16 Nov 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chl0m7EV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F95246797
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763336652; cv=none; b=BZ4ox3HdqdFF6/Rr4GX5YwebMNMMqHHE3DZ5IwzjGJhiZEWpMe3+0yxwiPQ/QXTt22N+Yve2Yz3ibwj3vlBY0Mj2LJ7oZ5dud1n53B5QwSHl9p1jLSQeMkgtErUA8YEaLzN6TFe9EuvRN/QZOYi5TWEgK9Fq6XdBFfoTFWSTr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763336652; c=relaxed/simple;
	bh=e6Jqqs51GmXFma3BXMCSN7zuiLIiVazG+29/lwjUcrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsxrY9g2Et613gG74nt6WzK2EiPVhHJiSKZL8VS+wbE9HGk5lfx6zmCy1XimVWy+hL84zmcjtkY7t8o0TARDRGik+nLpbpDUwarrvH9gWz0p8dGkFFswDDuE9khu/jszGsnMqKHQwIo7vxh4wEqw7WSmFnnM95VpPjRyewrmi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chl0m7EV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso4043738a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763336650; x=1763941450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjlKSqjiaymVZrb03FPP6sjpuIMSxxmcvbBtS830Xvs=;
        b=chl0m7EVVrSa8Q3UN3N3cjNzw37HlqngaJXyz5RrnT7jthFgvvRyP6iH8/tQKZXVXA
         6BJSnxc0hx8YVXVtczUzaGLGP4u4LqEq3fnflJq6SSRciNcyZx1yipQz+Zw8xbJ7sUwZ
         BLe6ffwIqnh3tk5Eb10ZrYZdC1VfWG5mfmqmGf1VUwMjNQRI1MgjPlAz/e5mVHJkrxZw
         d3QRP9x7Ij9j+3wLFu7CuR6WKFlO04Wfi3JgBThoxrJRGvJP9xa1ur0/ur4P4s4X9+rZ
         4A7wSuAMPVrA7jGkymh3z5JN5FMTCK6ZVnmeCaYmtJcp8925/BC7RL8ndP4Q344D4VFM
         9kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763336650; x=1763941450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjlKSqjiaymVZrb03FPP6sjpuIMSxxmcvbBtS830Xvs=;
        b=FLOq1yBxRGz+JO+4lSLBx8p92Skf3xGZHWwpR8qlT/TLVEjGjsiadtfoKjttDK2Hrs
         r9Woo0hWIW1KkDMvWEctqMj6q0YgtaOVXnbdiJk2Rg3+OZGjmmlUguLhmcbq/UCcMc0D
         72rM9HiRRFwDgg8Js02OVriqujTVaeJzQIx6vEDZWTAIu2Ol4tGcZVRYn3sDulKrm3zE
         d2J3AvaOCqvrh3OqpeW/JP7B4MeWhpdBN9Qh8Ca8I8wwLuwjTq1B9DFh21ueYJHlLPvm
         vqT/RU2xmHTv71b1iPJIQCIWUO/kmdGKSiiknhehRHMpb6rybbe89H1CHEnU0oVdPEzn
         DgiQ==
X-Gm-Message-State: AOJu0YyAlRR8KV9uBeIgIxLCv+YCD6TOG9s6IuEmJpLlG/Dkt0LXEQbs
	JXFpDiEmCshzdcfDdKKy6JRswPGMMSrOO3qQPlZdftCJGlSLOB9X7PhH1CZDMEEm
X-Gm-Gg: ASbGncsodp/UYNnEtkrEGOi2HNjen3HbU2CUjUdYAVDMnaxk70y+fDszXEc1XLkTFdy
	wHC7i0ZqWpeHc+EuO0XmtGcePidvp/10f55vbDJK8a8/tjuKhki2QDiyz6WEPNOnmg8EPUBiNMH
	wwR4PayO3x5MUNozkhxSqViXWmELCuo8DVQc8VGTdr2LRZGhdkfuvU3mknxrCz0OFJL2l9yOodE
	JeTttt7fY9JNcYFGCTY0H7PGo1xyzx90HqOhbaOL5+aASOOxKvI0XEjMCawSJRpmSFLAp2TdzzI
	CrXS18kNZk5TX04KJ8XyioJDIIKuaqIXgGzKqyHe24v4Jfk4auWoassAIKxPA9MXQwrT8oFjuOP
	9Fl5vTJuJ+2j8fGG3Oef00/mCqWw7G9U08koMd1dYne3uA29OklKrBlZDBkRWxDeaiNc=
X-Google-Smtp-Source: AGHT+IFFyXx50EfC2jQXNz8n+oABVZWu7i6G07AZBQhWYa+R4Q9p3xbt9EYiQO+ulIl40XoP85o5iA==
X-Received: by 2002:a17:90b:4e8f:b0:343:85eb:4fc7 with SMTP id 98e67ed59e1d1-343eab1ebc2mr16587330a91.6.1763336650016;
        Sun, 16 Nov 2025 15:44:10 -0800 (PST)
Received: from BM5220 ([49.215.217.121])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm10306790a12.19.2025.11.16.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 15:44:09 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU
Date: Mon, 17 Nov 2025 07:44:03 +0800
Message-ID: <20251116234403.8803-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 0bda:b831 for RTL8831BU-based adapters that use this default ID.

Tested with TOTOLINK X900USM in station mode very briefly.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 04e1ab13b..58bc41158 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -14,6 +14,8 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 };
 
 static const struct usb_device_id rtw_8851bu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb831, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	/* D-Link AX9U rev. A1 */
-- 
2.51.2


