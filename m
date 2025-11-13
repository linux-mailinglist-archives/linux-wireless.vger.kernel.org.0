Return-Path: <linux-wireless+bounces-28920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF528C58E76
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA733506A15
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA5357A37;
	Thu, 13 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YixzqTrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AC3587A9
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049654; cv=none; b=JpO+6EPrBpYReAEvetxOKXpSUWshL7UElhNPg+9/PZRZg7ksv1Y5PqWW4+dm2Hz4GD3/ahEP4Idl/NsuQ3HsL696S3Deto6DwLgviTyPegaIz7DdtMYzCNAC8YnL92kcNZAokTYVn961hFnv/F204ZEWB2KtSBu9vXemvS/5rCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049654; c=relaxed/simple;
	bh=6Wmz0w28rqLi7irIOJSMbni7pKwlVDgHYwe5FMEfE44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzWf2EbOYGWUj6yZRyGLGbp/ciGZ3h1VwhsETwZfPDhjPSmxKcI8a/luILlb+7MeWpIoJxNkbhdqKGu6bb6FRts4mAFLX1AguYa1VJlMAoy+uR/hZXwa+7dXI6Iiplv95V8vRiFLAeNNrTA1AoFftnOCM6yK3OOBK2lUAgpwixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YixzqTrR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1583866a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049651; x=1763654451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0efUvnW3GMsirNYsN0z07zn/Oqcuhmed27sVsOeyKC4=;
        b=YixzqTrRhxU6H4bTQoP78/ot3Rd8AnXwGVt4Ow8leH8Sm5uJcWDbTNpX6MCwyq9+wd
         E8Xq2tkirChTaAE/zkeZVaf4l9NdRWi5RaAX97PKlueVe5CJPVWHmFr2GuTLHNcwgjVx
         4CELWU0BuFCZSwCkwPmIJVe2HenyYuuX0Awoyw1/jIUhrWJGHOP6xo2KVvjVa0I/4WoT
         BsJ/4dfdGPnhIPiVCj30o+z6jDbrvCIFG/0G51rR/b/DFD9xeja7dEQBTnVg2gxbStQA
         UA2KnkiJjTlJ0rdtCnxbZz3zxOtIz0AvLgbPfwoLZuONbh0fwEAyQNPECWEpLCw3a2xI
         SfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049651; x=1763654451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0efUvnW3GMsirNYsN0z07zn/Oqcuhmed27sVsOeyKC4=;
        b=qv3vuiB+JOcYft1AYlMT2oUcU/dtIsnjPtMy80ASVjKwWNJ5FmwtDd8IkXOAenVRKy
         hM7f3YKpkdIQPVtQ0cBBHyMe7cBSy6X2m+iTVRg7RlSVoGbPfejudIV2fdwtzWHP/D6I
         6OEnn0uspcUO5grcySvhsGsTEFuBpHwmRMLQelqc/yuZ5yJo3RJRWwOjOPZMpP9F+y9Q
         tU4F8E2Eu06u5yElrF+PfVAzrx2Hkxpa/bkQiCcvEziS1XCu08xKHtiVgdcFZpXZuKib
         sXYXGDyL5IRHAcYGOV33dEJv8+ZickSZo9cQk2CIhng1cNQ58TRheyHuBdkMOsBcpz57
         nDsA==
X-Forwarded-Encrypted: i=1; AJvYcCWVED7/hCH0HSQtncAxNT1uIDJgYOPc016Rj1//7IEd9PhkxDuJklpFghwEL6LDrj/HuTYHR66ymP5BrKpiYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PRD1LeFi58kPldd/DzGPSxZf6MHbYQR11BGpXXxo3W8Mbnvb
	9ECkp6lodyOwnJ6NmsAf0EFZLbMuaWoNgsHy5elyaB7iDWgpDxGa/beMlIB+rib6+Ac=
X-Gm-Gg: ASbGncvMshEM2JZHFREQYMGx/t6U6hM4o/AKQ5mAhFzaM5TYbau1/4oletmG+zWCMb/
	bQfVsShrcunl6AtkRp1uY0Q4yNyaJnb1og0mftCNAQhfgTdGOsn8Ar5wO0hGr/E1+uuenaqOsaq
	D3yEpiX/wufdg4Me6Z00v7xBdtg4WUy2GL+wgJssfqNruimMiW6caPsOPEMWMXbqUcPz4L2muRw
	HwhBqm4ApHvKGHaUWebnEcgDlg+GzE5cA3Q97EEtC4W4ZrSL2E8y/OMvoo2Zqa/ljKR2ulVajdI
	vy4a85k9UbF85Ft/w+5UZ5aw/ZnHeEGuZ1TzFiTxRkaesnjyjIKtlTgh6WLZo40WNEyX6YRV3pr
	H02mF2u6sdzZ/WQd4LM1KQHQufhcUyn3iW5fAC1alSzNeYO+2lZYzYqFiOingzE+I2c5tHLH0Vm
	HhcXo=
X-Google-Smtp-Source: AGHT+IHZ/2oxuZtYuT82Lm1zSTq2FAnEZ2rkLS2NxmDXzfnqzCNWyEKaV1Egj/Adc4f35fmvH0TWSQ==
X-Received: by 2002:a17:907:d0a:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b7331aec498mr811149066b.55.1763049649244;
        Thu, 13 Nov 2025 08:00:49 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81275sm191424166b.13.2025.11.13.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:00:48 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] wifi: qtnfmac: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:00:35 +0100
Message-ID: <20251113160035.376524-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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
 drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..38af6cdc2843 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -714,7 +714,8 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
-	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI", WQ_HIGHPRI, 0);
+	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI",
+					       WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!bus->hprio_workqueue) {
 		pr_err("failed to alloc high prio workqueue\n");
 		ret = -ENOMEM;
-- 
2.51.1


