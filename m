Return-Path: <linux-wireless+bounces-28926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56CC58C80
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A7F4FADBF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E135C19C;
	Thu, 13 Nov 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VL22SRc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81C35C18C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050380; cv=none; b=dKAVGYSysSpticC8fkxu2DxHCRwA8NvNfqLQgf6/6iVtbLDek9yoWfN4zClmWRQDBC7pMkEYDQMdJjag5pyTMkla+njxV67ZCh6C6t67UMf4nvpx0WUWSCU4bhtY7m5urlQHNTKEZdkJgis3XBUiz0i0U+T4xAghmldad6ASDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050380; c=relaxed/simple;
	bh=5Q6+jx694R5FD9t9uLYyFN92bEi8X+fGwEsS2Iy+wf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4HfaDnOrJhXlNjU2N3yecMIxzlzGt5Yje3c7sSWGu9NR3lC/W7tLW1j4p9/OF1aOV50yScilF4E+YNdAB122Dj6MWIy0lUhhCDHcpGBr4ezodDtqBRXwN0AgwdGWRAT7LF6QLK20fL/66mDAdx+SNh4gf0kbGURIcrhwtblA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VL22SRc3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471191ac79dso11208605e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050377; x=1763655177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UILebnM/hGlC/4mGqUQsEbI9oK9lCHY4NHYgMXAAz80=;
        b=VL22SRc3bveXeWQP8al03YhU9Lk5cJmBFXv5JHgl1IMEvScRw5aRBCVTauEDu86uuo
         7R817BC3ym5O2md8nFsaoMjN0cUwMMxHPL/JM4b4fx0J2QsQqwhRWWx7rvAkcEI3HCHt
         6KHdaTBL4msEbYKem0vtQe9sGEXCai8Ahmf11qH4cF+oMYucntKtDAmgPSyP/i9HvJ6I
         DVl794A6S0HJA+QaUaDDK2Jmib5Gou5INKy4jwnl2UyS4HMvwaDcv+j2Y2a6Eq6xd1BI
         I5a+6wiYXaTOAxlAXGgVfdkhoHm6ITmVU5JoQvhpD+7cRk9xfDnPeF6Fw2dzPj/IA+TS
         U1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050377; x=1763655177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UILebnM/hGlC/4mGqUQsEbI9oK9lCHY4NHYgMXAAz80=;
        b=mzvi++poxsrvEnVUUJhcLTJFFen3lzPtP/ORFxMciuPJWAP0xDc4owj41Ss7CaIRd3
         DEycv0BsEV2C5rJqNvEywK5VV8Zjqf4VcKz+y6dW87wha7VR5Vrx6JZFCie+70t5Dxde
         ZEZDY8pxwXLVAMVG2uw1+OXx1JV1EQcgPAEXzKwJsqui/BF8utC8hANiY9AxYwKHHGal
         awY5dUC1/lTOHRjh9qYdNrDqj14mRJc3zqrr/4Vx2zzjfb1ICZEzZujS0WAhB6SI7/Tm
         vRlIxtbQhEWl7Ohxd0afzFKg0bckLhrEOkiUfSsnt+9Vn5s5dnLiAqw2wrYoY7YUogVC
         N4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11muh6p2byl2fquBWW0bGuMmB7UlKNx3hLH17I2ihSpG3UcE309Nfz4kvOzTbHO5mG7BIJMGJUrt914Pi0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YydTFkYHrtrpK9S0vmajFkmxG8zWaDOkB+AZq2luih72Z7dco2i
	OXsW2J/O566ai7E8WD7xuek7ktZUmIKbk6COatX8Z5sfmi8KjNhTpZJgUzshSfMYwvk=
X-Gm-Gg: ASbGncv93+X5zDpaMv2E412SYM28P8TP5zxgZLiGJSS4xMreBP0HKnbBC5ZMtMZ5RWy
	d5do+mgF0/XfqVYfG0q6MwCU+QPL+08mMOQ3l5BS2vW0OPWGHIpl4/coK7vyO95SWMoI/0IbpR8
	Z3jI/Cu05o48JES3bvzaG0O5uWe1lUSsuDJYeNyzmnUCQmqY4nXmPKeDS03vnEG/0THJxipmh0S
	acdhSLj/NUww9yK9vS+gHrA1x6Z8JOk5vo1yz9VJAhVV6W7u0dZTnXoiDxc3DMMQc5qZONmSG2W
	NiAaIt5U+AYYvfKTsNTlz3/hrLXYP+WbcAU1j+hO5XY08ZspzBZATyCuFJbLhzIbE+afukYifTT
	+6gA3wAaAfKEU4FrBcXeaFeZyeKJ5K/0ah16HjtlUwWqF7ZXV/MPb1K7E6GK/u2A2KaC06W7gUS
	1DZ9AD/wgZSL/HNSo48Vw4HUN0
X-Google-Smtp-Source: AGHT+IGZG84e2i3kH3kF6zGBbD+XTMkE/ONZxFyoZMwtpC/IQYVjSU8HZIKPCelinSkbwEjNjAMHSg==
X-Received: by 2002:a05:600c:c4a2:b0:471:21:554a with SMTP id 5b1f17b1804b1-4778fe5ee18mr462395e9.13.1763050376577;
        Thu, 13 Nov 2025 08:12:56 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850000sm41700085e9.4.2025.11.13.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:12:56 -0800 (PST)
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
Subject: [PATCH 1/2] ath6kl: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:12:47 +0100
Message-ID: <20251113161248.387964-2-marco.crivellari@suse.com>
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
 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 38bb501fc553..bfb21725d779 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	ar_usb = kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
 	if (ar_usb == NULL)
 		return NULL;
-	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
 	if (!ar_usb->wq) {
 		kfree(ar_usb);
 		return NULL;
-- 
2.51.1


