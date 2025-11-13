Return-Path: <linux-wireless+bounces-28929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D72C58E93
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F6ED50495E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5935A15C;
	Thu, 13 Nov 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZo/K8MG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649612F5316
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050844; cv=none; b=U6VSgQSkeLVFzSaTecy+se7pWAlqQlNj9mhQIcg6MB/z0/pgNECBUg0c8sdAFwjUBpGxX5SQiOg+v9eqZbhaFJiOlLjcZ6B8ZrMYoXT+hZ/f/Qyqhbg/rawG+Xk/O5QO0uK3qh+uvqi6tPrE6Wk6G9dVCYN7POqHTEO3nib5NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050844; c=relaxed/simple;
	bh=5Q6+jx694R5FD9t9uLYyFN92bEi8X+fGwEsS2Iy+wf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9r67R9Yj9OYO2nRhthZguZLXeLV03Ix2J/1n4ceQs8irZhRNgVvJS0QfcsM9c6E8iiPnYfLvcYRlmNO4U9hupQp96f7uIV24nlbVu3mkUKjA3NmrkwgrlELc+2G0MyocPXokkaW/x9599eTKs8hKtUZJ+p8+HfEz0K7uifxdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZo/K8MG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775895d69cso5931705e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050841; x=1763655641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UILebnM/hGlC/4mGqUQsEbI9oK9lCHY4NHYgMXAAz80=;
        b=RZo/K8MGI65fLtPI3dbFS/as2t2IzBrpZBk9bA9CTjTogy//zgteyPMznbwN7Z4EdZ
         /1mqVNKHdbm2lGJwsQ0WInQzZsWUoTXXaE/awhFYb0KGG9BA6EI4QL5dAGp8bymXlREh
         jhLpWE43KzmIPZ16NHpJ1pFGCQpg030GMbybUOq5JH6frQTKllvyzky/56tayxdsdAqQ
         rL0a+QUo4nb8BzCTEDiHjvwEeMUKsQYeTowb4KKh+yIvxFjw3vo7B694BCFW+A6eXDPm
         vjqwvZFVmlC3aB7X/hoCgDYhBBnl5iNAqWTNa0aTOedviHo2iaCC6MVK5yNV3YDh9/Io
         Ggfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050841; x=1763655641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UILebnM/hGlC/4mGqUQsEbI9oK9lCHY4NHYgMXAAz80=;
        b=mCOtGri2pHnlEmQq7pHLcx/zdePZ+bxZp3BVs8QNcl9fjx5W269VPK3H9/ZZYMWbkQ
         ie2ScbZnWWIRWJjCR7kTMzowvJ59dF1BSJ2lPg+wwPhWa4FpvQt5fcjp4mNSgP0yNYW0
         L3l1iRc2hqWkBXxoNXkv+VwrXMm9YBB7rP80SnzTwITzgjOIYsE7vhi1dJy3xl0+bi3t
         ZlkqHz02hyscfoVQ1WHe3z8Who3lvfUZL0KMktL6NHJcJb/46X1gZkoWnCMxRnXhS6vl
         yJw5C8EY7uqpd6QlODYCWw96OmbhkE60hJ2FxiruiTchqQ9GWoR57PlRY67uyfiM9Y1s
         RpNw==
X-Forwarded-Encrypted: i=1; AJvYcCWA+UOTnxMY3x0q5OrP4DtoY4k3zNG7nqwmbH52mW1a8R4S3xage8G9rIZFaPL+lIvWEOxPRFUqDmqhnL/5LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQExCuGoHq1c//vKAx+Cs6RYqPs68QSOUJru2fI9STJcogUldl
	Zy2HNbk7nbSHpacHydpkZV0vmQOCVVghrnEkfM7iMeSzNHW3ydzn/6dm5GKiT0ITKZk=
X-Gm-Gg: ASbGncu8lMwCeVxv4HZwlc6kQi0F2/pXfwht/frzwOZzGsXjsXjySEMDjAj/PADqbjR
	erVhHud575oLrWc3prPEhy3TPpvZk5XLGHJc7hjdw0b8w/u7WPrT26gGcN340ppQPWYv6fWJmYB
	sxd6XBxHU84viI5UYel7TRGfhLdrYhGgvLLL9nUtK/ZdvR4uAL7NWsOQqCcqTxTfPujytQS+VJ2
	qhtS2Cihtn0CJa4yo/yw2m2VwBxXmHLgYi/HDIRoDuT0zqX3ZZ0w8Ido1Qkyq00HSs9MQ0vBLnt
	4mSD3b+yP8uKNgzmLKJbEaTkEIkoX9wyBTzzeOnAko7Hiv1koHftf1WxUHzhVoXyreKa6WJQJcd
	IVGaQrNcW2BqQUvuXY2hdqDf7i7AZQSwjziXR/KDje+VUpOcYy8Kwx/z4bl2aYqzt6pz7ecY3ZO
	8dpjd7+nhXoknBRIAi2QajZChd
X-Google-Smtp-Source: AGHT+IGRGVhomNJJ/A5Jk/utPwPfv4ER6SuTf9w33S/DWCwxgGisxtoZnw3vVDZc2FooeR+k4EqTPA==
X-Received: by 2002:a05:600c:4503:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4778fea8b8dmr350895e9.22.1763050840655;
        Thu, 13 Nov 2025 08:20:40 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm4680578f8f.39.2025.11.13.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:20:40 -0800 (PST)
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
Subject: [PATCH 1/3] ath6kl: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:20:30 +0100
Message-ID: <20251113162032.394804-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113162032.394804-1-marco.crivellari@suse.com>
References: <20251113162032.394804-1-marco.crivellari@suse.com>
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


