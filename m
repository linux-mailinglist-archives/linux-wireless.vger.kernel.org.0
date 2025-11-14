Return-Path: <linux-wireless+bounces-28973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC0C5CAC8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D06A0342D33
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AEB3054F5;
	Fri, 14 Nov 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B7f75HON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D0309EE1
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117020; cv=none; b=irgDX3g6vRxIUFxNq+hazbhzdNxAAy7cvMrcBCljWpc/Ljl/NYvekQcbk6l3xsq5U1St/Yphj0VJOXr8tMxdi3hix7o1TDZWlY0yvuugdtWxjjos6ggpNE1YhAuOgJfH7r6rSk/ObXQ23e/mn4kXa3GWBRobIA5FRGaQC8xqb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117020; c=relaxed/simple;
	bh=nh1PjSXmB6B5wtOYvpg8YXOYhC88B0dma/uCjVOY03g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYZtMrXRosYVQ3XDVnQJNZh9gPDA12DTj015J93DnMaCEPPYIu6MTSh1HRBrFPWlKPktg1ParAGpuAUY9ogIzhH4v0X4xtxtTuGVMx8Da/q4mzsBPAj9Mlw1l7KrQ3qIwma4r9UhMeLBYyX7r0tMYwcb4hoxWMcn0KjZyRUxK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B7f75HON; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b714b1290aeso272983566b.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763117017; x=1763721817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qnf43euh50xAz5oC9jatLweC4/+OTf4gXUuEO+dc9E=;
        b=B7f75HONJ6VnZW4s2yOYllQVbukKpNLUckRdQABeI6xoEQvr3rLiWvyfvgMa2l+fMQ
         yfxdZVM3tepPcv/ejP2Zftn6kxrPrwO06WlblqEd7QVWGBHKpgpGCbdDS2rXIUfDPrLP
         +iclhiUucnUeSYeWWBo50TwXsgXEBfqTlK8iWkmaeTKICTnhYJGEGKF+6k/hkD6qSW1n
         cqQk9AvNOJWiY/0lXvGPDAlgkOIOlDsYxIPtmcZ4riYGbno9sK8sCrDqtdR5/U2Ni/Wt
         HuElEdlB8+F1WRTO9ruEMxF7PrlnQaXDvHr3n8+sRsi/UlzgnImur6TDNDcIQjJUEYUH
         Kh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117017; x=1763721817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qnf43euh50xAz5oC9jatLweC4/+OTf4gXUuEO+dc9E=;
        b=cTOhB/wos3s8m8/6uHK/fg4+9tpqUpbqzZtLhAZdtYQDumTt7fFVrkiYSmuKzyuZyw
         gJwm0iOODxchhFeCQBM7VDLJX62AJFW7ftxpCigoAgjDbBZhxVLa/N0iEanz/Jmp3twA
         jj7T+qTYAMF8Vv6wsS04RVV/+rJVwaKCw1d3dQ+7wbefySGTec6M9YdmKpwaCvGVF48A
         M58N7mf7h/yCd6Y23cfjFIORut8jir1Xqc+CPTEVPmnqnsNACYp1DsgrPd6nf8/Ucgts
         GpSOmCVuoEvcOCUlpB6YB3WSoZZi7lbUGsJgdt6sqqUQ/Do0lA/ghz3gVEuVatgHfxnz
         dl9w==
X-Forwarded-Encrypted: i=1; AJvYcCVY7N2/mxlwDyvQi6MhwYLxcMDAbhCHJV5ZKd25SPF/UZBLke73o7SX7pKyx8t/zehPUpRA5V3syDFugHXYAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AnuPkpDo4UxcUK0hQfRCVaD3ruhKFbvyVz2ahuTSwNB4ZRJ0
	c2aeGpACRPdKWs6OrKSrgdouzAVopphNxHhHRIFW+GinJIoCT75z6SjNhpD9KwaU3+4=
X-Gm-Gg: ASbGncttXZn0TLyA5GzdXHPa9uUe9Vj0zhuvTNBYKMFOHvElEGjLe1VKABvPdI/NESP
	4xTt3azedzKUlqXc6di60bY3LiqXnXkZ2UCQMDnbY8rmKQBF0+nf3V7pm+RpS93FzetOd2j8AuP
	or9JyAuOZdc92lkpvWf66hZb03ekVx7oY9sQR99IIwv8fz97SxWYSs/zdvdVlVhoolfpAArqj0e
	lTuW3t/SjpwEffW4EQkay+kuA3aM1FG9bUi3z8zJM4tgtuT5rPlXYLU3Wek4Wlj2nsOwxzLo1cc
	sODWZe/rBlSXG/3yK6tsOeCKIWp8U6jq+ftREk+i60mGpVSsT6lQ0Yk7mhIydKqYvOGcgic6A/4
	9JcGel99Qj3nJQTtCKn+i8tI56r5XcmR3dPUKWMBK+Q7lyQiHOnVe55tWYmjVv7gpVJwxYNpKzO
	JtI9RJqnaF4Z9ejw==
X-Google-Smtp-Source: AGHT+IHMVj7O3E/KnHZI4uDJ5+oTdAiz5D+VVC1LG6ki9E2djSVIrRZEi/GgjbF6gY3JvKH3pseNvg==
X-Received: by 2002:a17:907:2d25:b0:b73:4b56:7a37 with SMTP id a640c23a62f3a-b73678eacabmr241701066b.30.1763117016492;
        Fri, 14 Nov 2025 02:43:36 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad43dfsm360561666b.20.2025.11.14.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:43:36 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] wifi: mt76: replace use of system_wq with system_percpu_wq
Date: Fri, 14 Nov 2025 11:43:25 +0100
Message-ID: <20251114104325.116471-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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
For more details see the Link tag below.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
----
Changs in v2:
- improved commit log
- rebased on v6.18-rc5
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index b9098a7331b1..95764b82da39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -343,7 +343,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index d7d5afe365ed..e33ab4849e8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -420,7 +420,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
-- 
2.51.1


