Return-Path: <linux-wireless+bounces-30608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F0D0B685
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA363027A41
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202522BEC23;
	Fri,  9 Jan 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dZOXBsno"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC330CDA1
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977611; cv=none; b=IEl9jpSv6UCZb66VtEeN6proNvia6KWtPna58o89pnHSGwHpy0l7m3BtHn6rDf5skUe16HQDlAiSNohbUzby8a9YCxcbecYPCHhCh9TwlUXa5KqxNyEM62k2a5JpcnZqA42A59looYSNT1t5unfIw6EB54eX/t+tduFIa8KABco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977611; c=relaxed/simple;
	bh=MmddueNfTMUBIbfpJyLTr3pGG/BXOcI09PCs0qbBs+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/AEpzJCWHQ8d1cvvfOc63ZkGKC6LSIbFt/o/oBkGJDN6qEJB0xpYXF3cYLLdaUewpoiXqYYJ1xD3EXo8LdSUgwqYyJUwUJdQY/mtouo3w9Wel/hOAxnjNeZbqiZiZaeV81YmR6a0LwWALwaNjEATL39zbcJN6j78lRyEKOmlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dZOXBsno; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632d9326so27310985e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767977607; x=1768582407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WloaT2v9gh8n/VPG6g9ssDCLsyB8cU+se1H57FlbJk=;
        b=dZOXBsnoV6rSamJESumjkPY11Um9YQzodXmVJ2Pk6xWD5YXF6XKdwjf0io+7PZexi3
         iUzaCBbZ/q7G+b6BnBAfZ6M8+6Tl2amiTDJFh0NnqihlfYcZaKeU758DpilHxRXd6tYd
         WNC8SJ82tPK7iUPBiuCYPQjYkNzsohSQ5W+oKURFkDyv3nn9PqV7vBO2LSvlJOBfPl2t
         EVXvxjrB98vwtfjObzf0ybvREFQRr6FzsWGXlrizKu0aZBilTNUxZRLi6npawsTguaMP
         0WecdQ6X5e8K2FgyH4OLybAVr2zAz/Dt/iz2+n5KamsHArQtZK/TEMfVFPvx9hyI1urj
         Y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977607; x=1768582407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WloaT2v9gh8n/VPG6g9ssDCLsyB8cU+se1H57FlbJk=;
        b=Ouwp+shXyN41I2KAdz/LNyKodjWm72mtwBKugg1nthEqSe+bPoiQda4qoorF1Ye92I
         msKOvK+SeXBljrnsRtI75Um9I4gTuEYbo5DZveHHgkpAWpNH4BlJ5GSkAR3NII0/m9Vv
         o7qsmN76wc0leGIzwqPl700kDgTfISWJ6YUByXKJ9EnJZ0ux+ctEKTAiAlZPjbjbgSXZ
         mNgWZkzKQTtLCD1YSABtcj+Isjkg/ncZWkF8PH0jOGV085uugiRJt+wcgKa5iNue+z/z
         kZr2RTBBxELT/CG0625fgKbv+XaEvw1qwZ9Zn8+XzS6/igj0XnhPq1hvSIf2fuLPALKp
         f2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh5dBpve7vy5HaDbSXluBUnAMpjkPnCc0iugbVBWsNYEs0vsZHHLpds8Vk1qg626tXh9ab3dgWdWmIyuKXUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7DjxvrY1gw5MNXPd2cJ2HpSjNaz4l63hQN6YZeLr0D3m4vKAq
	KqXF+0JvR7XwKOR6E3du+sfg0JAFBOkuo/tnaVEUPHxC9b0BE+9BeCSyMDLvfi+wktVIKn1f+Xo
	igSec
X-Gm-Gg: AY/fxX75hOMquivV6iDPyBX0/uold9jraxnAGiS1oU2AOpnRwZU+ZaPOKk/DdAP5/FZ
	wQlLMlqzGbNuS3syIHMY0SdTv9u36cqsqykcbhI6/sTatvPDbcRkSt/ho9S0YK7vMs8CfC8w09r
	1GV9kIA3kvztjq4AYR+SbDaAmR12OhQgv5fdyuVpfwiIHFUl88S6BZj2fEClJqbyNQe0FilxPQM
	kpa2+YwGc06109ynYqvagFfDQ39PwOkJhaBUy+nTozjFOG2PYizD58GhnVkd4UlTP4N6x0CQwIY
	lrHiBheMKA9DN6D89cRBMToZUdHL7TC1AGJ3tJRgKATNzn1hEUimYIYL0K8Escll/Ixn3mJx4Be
	n3y1/1BZqcDy6M8+K1ElSikfH59hwJM8eAh2RgaDMwPGpPwmpUpej/r9euONCOu1ZQXpg6C01SO
	pZs9z3r1Ej08M7Bw==
X-Google-Smtp-Source: AGHT+IGqm9RyV+AGmXODuvhswo8tFC/C4kDTh1xG1EfXzS3X1KhEtx+wWgb5mXHDY/1cczVlLhWvOA==
X-Received: by 2002:a05:600c:c0c7:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-47d84b33bd7mr107936865e9.22.1767977607251;
        Fri, 09 Jan 2026 08:53:27 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm214200835e9.11.2026.01.09.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:53:27 -0800 (PST)
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
Subject: [PATCH v2] wifi: qtnfmac: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  9 Jan 2026 17:53:20 +0100
Message-ID: <20260109165320.318094-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- improved commit log

- rebased on v6.19-rc4

 drivers/net/wireless/quantenna/qtnfmac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 825b05dd3271..f5bde9e8fd15 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -714,7 +714,7 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
-	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI", WQ_HIGHPRI, 0);
+	bus->hprio_workqueue = alloc_workqueue("QTNF_HPRI", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!bus->hprio_workqueue) {
 		pr_err("failed to alloc high prio workqueue\n");
 		ret = -ENOMEM;
-- 
2.52.0


