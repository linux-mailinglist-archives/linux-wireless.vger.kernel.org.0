Return-Path: <linux-wireless+bounces-28923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FFEC58B5A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 787B0358F8F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70E3254BC;
	Thu, 13 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yinl5a6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9412F83B5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049978; cv=none; b=RBc6xQvxcKBkiCfM2+kmqi8NCUx4bU97/9ia4MNG/cGanr3XkmtPDV1q7h9owtsdyhKmd1PiBZe4AtRRB7CUaxpq3OKDYC6+FSngGkybt8uaj1cHyXNG56e2d8Dmzr0K8DIj35RVUDJCWsGT2ESZnzk5AqHL53ds1LPOQmPvyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049978; c=relaxed/simple;
	bh=b3j/Wc2OtToDhvUSwLsZ2/Rbg5MWETd3kh7hoUyLCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhDDw+Gzs+g1HuoRp5nYFLJdLbo/PriuFVqoUsAmSIfg5QuOMjGvd4im1LyPeRk5T3HovmccHfdKNx5ASRaC88fi8kukggpTFDAxH7m4AwrLoQLlywdXprUk1ockVBVzWxbchiVaI+KDhtZ5JYKQjBT7EotEQwP9TdlXXdYjwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yinl5a6g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso9805465e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049975; x=1763654775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpDVepX3vNSmI1FdDJpGJYu0mEkDdjVxk0Pg0gfi31Y=;
        b=Yinl5a6gSY2eO6MLnKyBW7Hun4Dx5rxl/RufZ2cR9Msl6eDU16Y99NiZwEYodT4zsw
         9DHA/graBfUXPSeDbgA1zV5J5YgDJO+Blh21WjHSX8Ads7KfuqyL/DNTnl6dkg+vojM7
         xxaYAPnodNVKjDCDevpfNvhV3CZqIXVhUVBGDPu+3lP8HuwSPbCX6yWomkFKMN1pvKaq
         h05KEzGBqjRw1sNRLPQi3PLn2KZFfedd8zH2kIIxfMx6e6lElEv0BOV9KbSr2oNj+chY
         IMcMrl5vJbTaZ9wUffls5n1DBJy0yUBThqZ34ng8DbvWtJPj0wg09rxb57DMFxGrfvyz
         u1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049975; x=1763654775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpDVepX3vNSmI1FdDJpGJYu0mEkDdjVxk0Pg0gfi31Y=;
        b=DBjx4W/jyQzdfm5Uu5Hr+TZ1oUT9ZTDkePnz2cHQUM4fcDbjR1XrWpVx0ti2zhwK0R
         Y3b45/fjt5b09oxW6WcyrC0u5f9/OmdxqD2vXwXWicV1gyYvxztVEIkTSBX3EZ9Gg5if
         ApHWOhFGIqmtmAGL/lkQr7S6NF/dN4OQLJ7RYj+XkDFEtO5HDgYihoHfXtNuqyuWrkfP
         X/zjC8uMzH2EonTA3JLTSYhgp39iMYuwG8grMoHEhSn2E18cstAyqogsj1kWP/fjR9cs
         Kwql/VCvakDZD51D8LsZNld2PQ5MaXvJLgWO8+xgvw+MIwx9y2wXPxVYmp/MZfLUEswk
         YbAw==
X-Forwarded-Encrypted: i=1; AJvYcCVe7ZtdJEMTX8XH0kc2ux//t77e9FxEgFrqPsRTwbtqCSBbmv6KEAnDyGte4dYsBRE6CL+yRQjHexG0dLpMHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDCiSogtJ6t8AepKuoxtf1IlUIkq5UQqUKwuRpCoQ9iuto5KV
	iOb6l7y6egHML7Z+tkWsqh6Fzdc/gMJQk9Ucu4j5FwLS1G6KExdeXcJyZJmk+AU6sBI=
X-Gm-Gg: ASbGncvxcovLCaAEWYMfSxtgIiespAL4YdA951s3rSVwRw7C3cO+bxS71vXEWk+FTx4
	GPzZ5uTdVJ0xoyUFHNHk0a82Jbgz1w3FAwlr5bBqtzHm2PJxpxCQlXV1YfZ/NaWh7kP5jgI1kPs
	slvWi9H3JpmQQ3ZSqHfMhnVUVXnmagX3hO5sFdkzH9JRoAO0rNh2kHIcGm1Nc+gha5NmDblMa3z
	77ITMrJXh9ZPFSyDDlDY59VO1yHTaCfgavofG3TSGxxSKOFmac6/Um0Cew+xAevPX8mtPMIADXZ
	HfYrmmIWH1SufA9An9nUFqSr9HJOiu+DVTHfgNrUzX+0DwMO281z4C5wmEvacCajWjJ6t46SFWx
	2bS/5QWRPzCtSzQXFs8EUA6p9nrtbM5CM8M0znDFoD8wCTaw522MVqGrRZYnRjauE/fQ4iGzsnu
	8+1hFCWCYVr0P2C4qkUjYaqsL5
X-Google-Smtp-Source: AGHT+IHTIqN3sACYJ8L+s+DSf5fK5S59AG1bon4iPbb6kvAdV+dUJTAIosw5brBjEKYuiUfzpCW4SA==
X-Received: by 2002:a05:600c:3b1a:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-477870c4f26mr71238165e9.21.1763049975028;
        Thu, 13 Nov 2025 08:06:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:14 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 2/2] wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:06:05 +0100
Message-ID: <20251113160605.381777-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113160605.381777-1-marco.crivellari@suse.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3b5126ffc81a..db60e142268d 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -965,7 +965,8 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_PERCPU,
+				       0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
-- 
2.51.1


