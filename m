Return-Path: <linux-wireless+bounces-27668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1BBA2FA5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870E617DEDD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDF296BC4;
	Fri, 26 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzIehHGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF100286D46
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875938; cv=none; b=Y6wqzP0oxZ6R5ENdImdH6zUspRe6i+fETMXi5aexLyHRPmplllPmbPkie/t5KnxTZhtYPUxeB66NI26dSaWLhRR+sUSUyqEXzNmxlthBA+BFwjlnkdTebtliEgrPOFyi+jMBVq/FMqTPB1UvFuXmHk/jUDqaFMgm9Pr40W8qquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875938; c=relaxed/simple;
	bh=0vV/6+DW2cm01keT91jsIqu23jaeYIORdbfiyr4Va/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3NwJb+9XsZJrS7MDTA6zinwMgXN7VQmiCHvvACQENHJP2qd7kGIM+bR4EOwB6Sk+XCnk0BufLYc/OVipcCtSb5eN8SoXF5ypiQ5tBKFWCz2GeDPnq2suZHHz0zyMcJApxtIVJlHS+4wgMf9VqJ+nrj43gakEXd2TSFytX8B1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzIehHGV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso11302975e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758875935; x=1759480735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMLjDEzqq5Jujc77cy2DJvSmyYzyNsCtcN0IOCmmWBk=;
        b=bzIehHGVYTnS/4oBGB6504Effgd0Q9aFf0HBb4eNhRldLuC2nGn3zKwi2wyVhY3bxz
         brt5XTVoVKgb2swSKLhRv0UF/wWs+A/ymssTZUT1tkmTOZj5idRqBXNBUaPDICSoJ5Pk
         EjvGHSU0PzQK55pEumKxsYOtuPOrjCZAVkCr6E2m/hO4D0PepHuJbXc0dxLgHBMbSg51
         7t1V39dPg6XfsL2/Q18Wykia7m6ynbjKjFtQFfcJKSNjUtnv1CXdBZX7nYjn/M94XTS1
         IKzRc+/DCSN5A4mZKI7YVujJNNA3czd0tgsGSZz7LA1UQBu254km+dtnqbUNc94I0yhQ
         hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875935; x=1759480735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMLjDEzqq5Jujc77cy2DJvSmyYzyNsCtcN0IOCmmWBk=;
        b=sOTgmVbmBZ6QMGT2ECD4TDWuzbCziBNMI8tY3Nm+smp7T6RWBQg9wpYy0w6L9elA89
         E15BsJd3DL52ld8xlBcrDv54rXK7/dviz7fWwQODBP8If+xQm6BLsZCO8vKj8kOaz1A6
         zr460vshDFWD578MJ6mO1SF8GGcOxd6DDvLlAuKTfs/3DEOq8DC9pa1N+0CXdHiuMa+S
         Bswk1kpF+tUWcP8/NRFLCb8zs6GYldyNAgMBz0RLUF6RlBgHWuERCSi43m74QU5lESW8
         h3FidjVW4EyzK9OILfEgQD3CEjC+m3jP1yh3/zNrUxOrZULuEs07Z7qrw1sGiVphRX6e
         dd0g==
X-Forwarded-Encrypted: i=1; AJvYcCVnUfXK2RTVl5fpGaaCB1iB0R/CtwNQO/zlxgZ8i5H+nX4E9n2ZWSgXBJKN2mkaYVIuL9CZldC2LqISEraSag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEHHRPsSZElovro6Ava5MKkMWrARIwYggIJq801nwJqqyM9Ha
	7ZW4Yk1Ghezq1aRv8jGRzUSzxO+Y1thsQ/ld9vu25cC2S2MPds4NTfgiM2pRDkVt8ik=
X-Gm-Gg: ASbGnctiYGJZVVr1va6QEfxdNksPPVPFuG7Msi4338EJtG3XEpAVS2Jg63Vz0vQQr0y
	+ZqBTzkwIXEcCDI4Xb11349cBB3+8lL023VKC43bwGKjyIWuQAxS8dmTJw2aT9yz3gu2mtL+hWv
	Ygk0/JmlSyKV8bE6pSMDhVXbzIgcL0KsOLpCwTbS4rO6IPSHGWWLD9YJybB62EWQkSrT/eK7wTJ
	Scd4rfbkIlFsPRAWfgLV4lV8Py5qYUJMjwEajjdZTPduzArO5uDda3ju0i9MBjyVXKdfdAdqZtq
	jbWCi4or25lgxld9VY0D53vFcyn8E8IRVaKgez/xkCv5ieWmYlAyCBoFGJqEzwJaR56kTyVzuDB
	OG968afHa9ijv1sbQ+bq+2JDn5UPpECCYUqnar/9OWgMUBxi5dvtVx2oocQ==
X-Google-Smtp-Source: AGHT+IFzU7cESuwoaHKhg8/LeRn2b2knH40I8N65Uuh8v9isvS50hDXLZ33MPrWkvtH6PlDOOjts+w==
X-Received: by 2002:a05:600c:1d07:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-46e329eb016mr60669885e9.20.1758875935242;
        Fri, 26 Sep 2025 01:38:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be363esm65702575e9.15.2025.09.26.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:38:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] wifi: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 26 Sep 2025 10:38:40 +0200
Message-ID: <20250926083841.74621-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926083841.74621-1-marco.crivellari@suse.com>
References: <20250926083841.74621-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/wireless/core.c  | 4 ++--
 net/wireless/sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 797f9f2004a6..93b8e18ca630 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -428,7 +428,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	if (wk) {
 		list_del_init(&wk->entry);
 		if (!list_empty(&rdev->wiphy_work_list))
-			queue_work(system_unbound_wq, work);
+			queue_work(system_dfl_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
 		trace_wiphy_work_run(&rdev->wiphy, wk);
@@ -1698,7 +1698,7 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 62f26618f674..8d142856e385 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -137,7 +137,7 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	rdev->suspended = false;
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.51.0


