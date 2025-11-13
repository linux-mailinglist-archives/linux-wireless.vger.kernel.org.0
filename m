Return-Path: <linux-wireless+bounces-28927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD3C58CEF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95B804FB6E5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6513A35C1B4;
	Thu, 13 Nov 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fofcCtYu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73D35C191
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050381; cv=none; b=lbVLr+4cfiV94A08K+UcQQ1WQY3bR59uiYx+G49jgNTzDl4hhqe8EQHmmk7YDLUvoDkho4EGdSPLkMZhrH74NIsuLWv+RxYBjGqBe2qfS3Zo1jnxtv93eZWURylb7JKhgI4kxwB6bicggE578qSEGlJxCvaEGiJaRKuWrh5oO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050381; c=relaxed/simple;
	bh=i6/Tdijqg6TUvObXhkp4KVAh++KkLe0kXSMy/xdGERI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWrceyePHcE+XMlWX7uTwAXstXef2sGLMFD4qM3QSlIYCi0Dm9c6IPKzzy7jILl1PJh0z0rj+FzC5BlIr/xVa3oI1ivWubirtBVlDxefo5M5jWi33xiNwVA/rR7EWAGMaxs3bi/p66pRdIvDKu1JzmQbghADs5pnWl0B/svMh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fofcCtYu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4774f41628bso11548925e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050377; x=1763655177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=fofcCtYu+DIHPIz/4L9a4+0o6Be0uh3jygGeeBaTZhohoJYHvMdCUA752g7JlCBM+m
         +8OIePTusMBvY+kw3n6RdpXFyEyWgatB9lPs2X4ezutCnBvlpUzJwbcyoC6+872jwb4W
         cGCpKAk/HSFakqjt2tKBaccU1Tj6VDVwooXJwPX8+r9Ya9weGpi8rTgB8txiVrTFDQCG
         RRkIs4HZS5ihcRvZDm5DIsS2Foh7cwYhUNgmzc2YeRqEKRun91OHXiXpri5qZI6PhRF/
         rWC336cxHewKJ9MNzLR8aHtX89Vyb9MSUdkQ9binBDaabBAugu39qofr+CHhAKL6w7ai
         am2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050377; x=1763655177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=b8lXZ5AD4TivUdRu8h1OEiUpQtKkBJGmdLvSrvzS/8QaaIX1/a0f28bTfthHW+Oa7y
         lf7yN19lBGPwP1kF44pAviR1rBV6AtP8jeupQXN2NetbwhC6AFTYwI0JjIaiv7vOgbuv
         vlUBx4ZX2sUiSo0z4cUzGkdxpMswFhvyZT3H+Ype9w8SOX80gVhwiDHwfk7gR5PaDGQ8
         rXxUDx2vgwgkdPQT70TLkuoKXkX6QLfEcYbZN4HCJcZWiZD7g/XboMYAQv+qCDB8CMvO
         1nBtl/lQ739RkV7sN/gEhUnV3Zux9i/UGP9o2/eADPu6gW58EuVEBx9d0bppCdRGs8D2
         /dJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI/kqnOYOtGqU68jS4yo9EFvudzImAfeePHT5fJzWUuaYKyiPBzTtc0GIZ+9t8gW/sXLpTAXrf9OJnLCu5wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGIlifO4Mb1E/Dm/lsu5Dsd/i2OG9bw92kqEc3VCe/EIiXxol
	JK6/2YO7Zb2Fv5AidmoslMkSQjAAUwWz5XK545aS6J+nKYBOSgtLK2Cls1Yxurvxk/8=
X-Gm-Gg: ASbGncsmdZrn8TOVzEhfveVB60iST1XF0s5Vf/1rgF7gAHzR81ZTcfvFhNXbOJZwj11
	P4qA0hLTs3zrpSfhPPiVZ4CWp6yXfcoxzzw8LDePwmPgFycDrbdJCB7YyfGC9XaJFgMcOY+JefJ
	hcNTHqy5/mktjn5zAwr8KsaiUDbwq4w0gc1mTDLOSoGjRKOwbm1vMlGSl2/REbzS87fFpL4qVam
	XZxJvRp2p0PzhkKEVjZSpx9sFwa1+pnFPL0yzvhou7mjs/1tlE727TtO6YHxERfmt8d4oz3o88y
	tekNtuzeVKgFOAQkHfh9zqQEy4tDZWAd+onRCNj4VndOwxLHmvCPfPj+TN023v1uI0usFHztn8F
	si32msIGMJyuRCqvg9RwEsMdDk8Rqqd9NXzqUkPJB+SCXISDr0NtyQn8GBuh8txYUC5A8a0BfyI
	eHtJH2jLjkpmAwauEukEUiIY+R
X-Google-Smtp-Source: AGHT+IENmaUAtcIakh8Mn4zUT3IzBfIjhSaHtJtleCx6qYleuptiYERekZkAHB4z2rUrdoiGfSHzcg==
X-Received: by 2002:a05:600c:2e0c:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-4778bd3c9d3mr22882215e9.20.1763050377491;
        Thu, 13 Nov 2025 08:12:57 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850000sm41700085e9.4.2025.11.13.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:12:57 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 2/2] cw1200: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:12:48 +0100
Message-ID: <20251113161248.387964-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113161248.387964-1-marco.crivellari@suse.com>
References: <20251113161248.387964-1-marco.crivellari@suse.com>
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
 drivers/net/wireless/st/cw1200/bh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..bdf7132c5849 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -54,8 +54,9 @@ int cw1200_register_bh(struct cw1200_common *priv)
 	int err = 0;
 	/* Realtime workqueue */
 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI
-				| WQ_CPU_INTENSIVE, 1);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI |
+				WQ_CPU_INTENSIVE | WQ_PERCPU,
+				1);
 
 	if (!priv->bh_workqueue)
 		return -ENOMEM;
-- 
2.51.1


