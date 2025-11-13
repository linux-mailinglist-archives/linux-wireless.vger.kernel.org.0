Return-Path: <linux-wireless+bounces-28930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C42C591CD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932825005D8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CCB35E550;
	Thu, 13 Nov 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O0D4aLIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB1320CDB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050845; cv=none; b=Rstwb95Ft1S298hzx7/zPyhvGrTlqCF1FA02hiLBf8dKeFKF6b1ePc65SMy8i7/27ZH3Cthu0l7RJcYl7/u1oueJRINICS7Sr5m3KApvA+LXyE9je4ozj8uA/8Fv0OhgqZZ10sCTqu4tLqK4LE4Crt1gGbOdtNDUeydqy5HEvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050845; c=relaxed/simple;
	bh=i6/Tdijqg6TUvObXhkp4KVAh++KkLe0kXSMy/xdGERI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldBte/+FWggQrp9xAdGbeazaoHijlzWY/qxfwjGjWhOxwUEX4ZiiuuSdcFKu9U5WVnxVzcq3eTpqYZfjti9oRUTq1RisWV2eCcf9zV0omiEtDF65Hg324vdRchx9z0P40AVEo71GjUH9hLfyTsNVW/OZT2oNbIFnGY5IG6L0QLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O0D4aLIf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso718773f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050841; x=1763655641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=O0D4aLIf/UaQdPm2VCJAXRIL3cu/2OQn1lBmnglCQiivVKn623jASzoRhAxXBGGMGt
         7uwOtFnZi3oqqyp8TZBXA7Qb2v1DmhUZfM2JZgitJpg+CTnJjx/T2jXJWq1wRaBlOJls
         SkNAjfIB7eJADfmw5PfJCuOv3C4wQg+fX28zdnKj+IbPebSq//hH0txTuVzfsupV2JT5
         z6cDFPsLuUBNwB8PoIzZrdTe+c6eL2/Jfc24gqXJaCG4dziObjnePAXf7PWeV6VrxI4C
         lrsSTJv/ZJz9E2mPXJSPZ/D273+bUGv+7HpKXfR4xEJ40tQ5zd80TcpJbV56/9iJ0uyd
         vzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050841; x=1763655641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=qN0c32iykmziGfwYJOhqJLCbE1vxsLTF9o1O8GIHWWgUgymkeahfXIYBNH/XVVGwcN
         1/R/kV8Xt/rhh1y5G2xYMDkAyjQMX3hl6163GaR1AACDRLqcut0ON3XgsREp6YR0r2Ib
         GoLhqIQt9TgNYGAGwOBkSNuOGxo2NhwgHIc9ULSAA3xWgGBI8Se9t3m5MT/2fvITpZ3J
         yg5z/ajccSXdBrXj+BC5nei81pA3lXlJqbeRoptc3NmKwznpQXDGN4gl3pG+7SeX0nxL
         epI4RyMOOtAEkWcG4906mtI+VLhhTUNAIMk/mpKOjpynZEKxO3EjuGVx0XGfCVckNANq
         vHwg==
X-Forwarded-Encrypted: i=1; AJvYcCWUKPY+NyEpmu2QxgstQ9bNddDX05Ivak7VlIOuOg4c4e5yrE4/Bs7EZxxoY2wwGq75Rm7epzcRBvy/z2V3Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPUysxWX76LgMtBhnz4o/C+NsdlXxcQE1E2+KBsBK4D0vZ5QX
	R/d3HdoAeAUH2NiH4Su24D5T0rWrVR74iPfIOdmNFMb6duKCYoPIzz4rGBftL6xAAtoi2nE2UT/
	evxmh
X-Gm-Gg: ASbGncs0y0I12/6rsKax4e2mpoMjUt/LLq6IjJQgaMLZxTk5PVOVMWjBZbwT5FXZi+z
	OMObId1yhPakg8LO3BZY1gFZThLyrhEBWqcat4j6gHPgHZ4iA9C/38YdogsSxV8SAzBsxPpwzQJ
	0rF3lHgMY9ltLux45qYZPMJw0LK21Z7ShkcMbEd4vLAukFIjPqX3byYhYFHiC+mCuxXRVkzmArV
	MNyB6zOvGkja9x07Zhq09AKOZMaVm09h2c10CgfBAmYsSfBN05At25Nq3VRn0eLRNOhVTFjS53+
	J8wrb7IshkYGu8lCmAJ4BDg0jZhLnwcHcAdYGLulhKj2NyYTBM6ECOZpGHhuaugB+de9dK4RKHK
	nr0eIgLgDm1XLeGExfBGWdZJ+xAtVDo5kMikL5459KM89e2a35XfngY74/8pQ6Lx3++iWNpgoE5
	YBthj2n4wQSQ5MSZwE3+daY1FG
X-Google-Smtp-Source: AGHT+IEH+HU7u61di1BKdqfvk0CUEv39L7QRlysFz6Oai91cpdnHTr8tvifetLi7Z4ylnUEyUxZNew==
X-Received: by 2002:a05:6000:2489:b0:429:c851:69b8 with SMTP id ffacd0b85a97d-42b4bda848amr6728334f8f.31.1763050841497;
        Thu, 13 Nov 2025 08:20:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm4680578f8f.39.2025.11.13.08.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:20:41 -0800 (PST)
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
Subject: [PATCH 2/3] cw1200: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:20:31 +0100
Message-ID: <20251113162032.394804-3-marco.crivellari@suse.com>
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


