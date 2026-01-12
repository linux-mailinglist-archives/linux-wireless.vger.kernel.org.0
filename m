Return-Path: <linux-wireless+bounces-30665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504BD10308
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBBB13017FBB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532891C84A2;
	Mon, 12 Jan 2026 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpGd5d9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2A3D3B3
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768178669; cv=none; b=W5yA5lBzgq2JlvxWhW+BTnHWtHJIVCeO1+BphI4PqHLwTyNxygPzoh+yZS65OB7cT7+bnVyLB+ECBDK9gDjZNh47HlaDmjoAxbbkhuU6MLQ3bEMdGw81HJNlbWgekQkqnU9T7RIKc6mh/NM/2H3bP2ynzTyP2wWrzhz7AOqz/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768178669; c=relaxed/simple;
	bh=ODr5i3vfucZuCqtEmGiXOSXeG5LjjItyk74AMCqQPmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/9ya5hcM4teMcWL/ZZJzUcTtL6TrNuxho/Ilqs5Xp2r6qUu85Pp95VVrrC+Fab035f2JOgW5Io/merVO8/TuEvTxyzCgR6mTfkeY9Rzj57kHU0Pf8iJh3A8V6zjyAqsFKuC4CkSp5LHt1udFzvjkgDaPnSHaqEZwp1/c4UgTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpGd5d9b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so3287952a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 16:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768178667; x=1768783467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+vOKjGa6IRbN4qIGD0Fi61enHSPje3UJOjGeUTLXa8=;
        b=ZpGd5d9bhek3Vmem5YQUgHnAVnh7VwT7ysfoFH30Bro5L1TgW4KKBG7yVVEqT3eb71
         Zzbf9fR8FgJNnXJg4SavehgAecjN3hcaaoRRT7yVn/2UZ8DH8XJpLhGBR/yepMaZTBUM
         1s+WdIZLonQBMPJCjDHRPd750EPNcdBrisLH2oLedMarhRPKD4mjgsw1vjsWG5PjWx2U
         e0h8BiCU/1BYpMH8ebnEXii72tI325US4POzA+qM5zVGEirqTVNhZ+eEbKpKTDCCHppn
         ulNqEVWPsR1PyRqOpQEe4C5T9iTbQ4NEV0Fqkq9IvXgOkoWslGY7vrUgCOg0ytq3exjG
         qYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768178667; x=1768783467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+vOKjGa6IRbN4qIGD0Fi61enHSPje3UJOjGeUTLXa8=;
        b=QwrF1iiSrMQeRaq585lfUqgx+Us9YMeR0dPD4ho4xf6+57Rl/OFg/kwz1E0qQ4q0Pv
         mwU1vPo3QkQyRs/5OVrAQ0CBzkVkkHfyAX8VyHVGaZkoCj3bpjlQz0G2xHsGBBjITlRN
         Zy91zJvA7CVDN1vAuFqzxjdEi5oARdh5SgCxGBsiD5AbWMgSXNr5GBH31+6xBV1MLClD
         850KIsttYZx3/5G6LQm7fF11wtljuKg/SG8wiawsjdPChckebcnb8pq5YjW8hVgBcXru
         Iz00wNkkaM/u+OUmcqfB8efwInsHlGgZ+6F4M7+qi8nSm0xFysKSXGpouE8+mqbz0lku
         H4ug==
X-Gm-Message-State: AOJu0YzqQKezLU7rv0c6YHM6Ciy5fDye2kuTcqRxiA3sMbMiwnuUO+RT
	2YArW/Bq2djhKRdxIG2Km2tBHPI1qsWcnezlHtfAa5KbY4ZDRLdJR7zS2HrBAuKk
X-Gm-Gg: AY/fxX6Hob07wjpVNRTKLUQhtAF2OP722R7ui2A6mfZ45CyCTMaY3SIAyfe7ZdVfr7Z
	m4bhwsnGHxOHPH02YwkXOJj4XLUjF+nkV/bNWT/3W4zr7BpewlHg4K4GS6f8YDLiMljqK0t2f48
	6u6SIwuQ+osmFjaK8AVHqfDDIvqWyvPk7Tj/LQJgfzNVzh0vx7Bmaft3WCxFTI8je1zisf1rlUo
	YIueiHNld3fvvxNjUGFxJMMeDddSpIfXUy4gXzoevSAXLc6PCkYkSsj+13V4kiG0AMtj8uxCBKq
	6LyubDPrKErszevHcgcZLFi/vFuP/SosLFyO5vGRpG+nwFyXTvSfTkoYfLlvR5T2I8KbAF4aMXw
	pqSqzCZ/i2oTbTJ8Ro/A9pULxTNyZhj8RIm9mKMfGJiTQnzXPMIPmnjnofLllig2eFV1dk8O4Rb
	VX8SGUiU73ek0FBeky7HxO3i0IWRDBYqlc3Jm6l+5EJg==
X-Google-Smtp-Source: AGHT+IEaeopz6FnA+Sg9AhYIFBbqMyrTLEc2+o9AwoeX8EdVd5Dd+uSdaXp1BwWgmO6jAN8IpETR6Q==
X-Received: by 2002:a17:90b:3802:b0:34a:b8fc:f1d1 with SMTP id 98e67ed59e1d1-34f68c02410mr15704682a91.24.1768178666768;
        Sun, 11 Jan 2026 16:44:26 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34f5fa7820fsm15631771a91.2.2026.01.11.16.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 16:44:26 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
Date: Mon, 12 Jan 2026 08:43:58 +0800
Message-ID: <20260112004358.5516-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID 0db0:f0c8 to the table to support an additional RTL8832BU
adapter: MSI AX1800 Nano (GUAX18N).

Compile tested only.

Link: https://github.com/morrownr/rtl8852bu-20250826/pull/2
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 980d17ef6..84cd3ec97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -54,6 +54,8 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x6931, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0xf0c8, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3327, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6121, 0xff, 0xff, 0xff),
-- 
2.52.0


