Return-Path: <linux-wireless+bounces-16571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C974D9F72B2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14751169B85
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947378F52;
	Thu, 19 Dec 2024 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9YcoqVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C91632FB;
	Thu, 19 Dec 2024 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575718; cv=none; b=Wu6Pzcw4UU7omxk4ShhmBUepeXgNh6zOoimecdLFIRF6W6BZ0riu0nmmTgCU47iebjZNGZvAbU2iz2L5D/X1QM/ndstwHiue17Y3egUnc+hFyTd7NFhPX/tCDv24xiuB2G559qdkieOi1vNfEydfB5o4HUjq1wcrB6aefS7s/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575718; c=relaxed/simple;
	bh=hl37Iql5X8gsZ29nKhRpHi4iYM29ft8c5jBgwm122Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8YvravP4EVR6S+zA9FQ3FWwRU5r5yWBOOTLc3xWfhSHlP+xr5w/JuAt/7yMFR+GMVGWdb86tXE/W+q1S9n0HIDamE/MJKhFfBsjwDyqihr5RES1NrBl+Tpdcm1VjOZDflTXFg5IsNdko0zFMp+D0Xqtz1JFcJ1uU47eU5vJZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9YcoqVi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728ea1573c0so290412b3a.0;
        Wed, 18 Dec 2024 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575715; x=1735180515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz5f2fkK5TyUEN5/ypHLYKDvnfLQ33CHwDb71kc+wK0=;
        b=D9YcoqVifeRF547x1sGReun43yMOm4BG159+fwQ394JoK7Yr6ZUWWNAoKMTwjUlVnF
         w6LE4pz8gADn8g2d2XO444JG/DV9A8hgikB7wcqSYSH0zzPpCG1cLlMBkM+SXIXi1Xs1
         Zh+nR2j7yloKhjxmX8cBNM6n8gdv2iVmmaYhXi+TaHqG4y4g+8doq8v2sZ7yyaJylhPp
         VISYnHq4K2npH9JygxVau257XGhj4y5YVBukqRtuJekxYj43j2FL6cVYd7Udl4j3jgFY
         t82rYJh4WJOvkWC9piCCP3XHqtU+HFHTyXZJ0wqyv5XcT5L3a3G4KQJBDF7z4hwCWiZZ
         x9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575715; x=1735180515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz5f2fkK5TyUEN5/ypHLYKDvnfLQ33CHwDb71kc+wK0=;
        b=b1jHMLBn5MSD8iq0znw8E7rdPpv3ExI8270CseOHfe0I8F4WYuVqokoJzQbWmI5wo2
         306PEL7Kl3oEvBQMQaQImL+QcWrWevch2dYHXz6LsDtgj3Ew8/TnbJ54/byEtAuwKzwB
         566Gdgqm43MW+fH0v8ouXhfQJ/K2KFKoX1UNzkd8IYPV5srUtkVghnrxg7Q6ZAqSdVS+
         QgPtO4BckDhz6EA84pRMEY5SPQHNW1OXRhXeRIeTxh0BvjlXTd5pp2fwByIhGNClttST
         bpczjsZpyojsTz0mz38UIi9BCJZFoWqdgOxOCZmfVOhPBdSqFhH1e7qfSYG6kSuzoCaU
         4fxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV03CVNJMgxo3UpSUtWX15rPQT0voluV8gkSeQrfjwr4Dg4K3UxB6v0XVJOmi/sDJeQxgW8rS85lvRm1SE=@vger.kernel.org, AJvYcCWkX4MKapVRL5NkvTE8TjJ9HG73YdIvBRBOUBVq8UeDmC8TaZM7ydXUsonPw+QkYxiYwgekjV7ZQuXkVrOUgng=@vger.kernel.org, AJvYcCXx9eX7sbdQXCSeTA1hzhV9wwt/kA4Z0aIBYypQiHdCBSh5Lgj5ITf3oqKBxdspLSh3PYG4cVop3MulUigIMX+W0SFqIuXv@vger.kernel.org
X-Gm-Message-State: AOJu0Yymygv8Mu2FX1Eb7R3BLllhYu7VmXBNxIw+5Odkzo313az33Bt/
	sTh+9sej7GdhiZkvFHfB6V4YQ6CGOta4GUKj6k7paa/GHQ+rZ3Tg
X-Gm-Gg: ASbGncuWVn2VQEg2HjSlNPxg1U8zQmr+EQqJDaEh9lT7U1a4JxP9WZe3eJSEcQGjD+5
	ZpIa0UyaDeStKyAuRWu6QoeaDYn647F6FAs9isCMq9NpVqKCAIOzJR8g6sF1UL8Dvjkp1uACIvR
	JlE8lRhS0IFjz4ziSUkzEYXRa9+nYZCQAuhJE0VYmjihaRfXzcmrkGu8965xUFRZb7BMu/z1dch
	j0SHyO5bGNZPOUyYVz09g9WZN6TLDZ6d5xf9TCUTY6hxlZH3AOZbXq5TZCnp+l6ZLYPoLSz4uaU
	uqanrvI=
X-Google-Smtp-Source: AGHT+IE+5BVERtvEj0uFGUNd3NBBPkGat0lwCNqupmyw0FAX2xvKE0cJmTowKcGod/Hmj9SrgliLyA==
X-Received: by 2002:a05:6a20:a11f:b0:1e0:c0fa:e088 with SMTP id adf61e73a8af0-1e5b4810ff0mr7532504637.18.1734575715510;
        Wed, 18 Dec 2024 18:35:15 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.35.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:15 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	pmladek@suse.com,
	kvalo@kernel.org,
	bp@alien8.de,
	andriy.shevchenko@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 3/5] net: Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:50 +0800
Message-Id: <20241219023452.69907-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241219023452.69907-1-laoar.shao@gmail.com>
References: <20241219023452.69907-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 net/wireless/wext-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 3bb04b05c5ce..bea70eb6f034 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -640,10 +640,8 @@ EXPORT_SYMBOL(wireless_send_event);
 #ifdef CONFIG_CFG80211_WEXT
 static void wireless_warn_cfg80211_wext(void)
 {
-	char name[sizeof(current->comm)];
-
 	pr_warn_once("warning: `%s' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211\n",
-		     get_task_comm(name, current));
+		     current->comm);
 }
 #endif
 
-- 
2.43.5


