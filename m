Return-Path: <linux-wireless+bounces-28924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA98C58BE7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03964368329
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AC358D13;
	Thu, 13 Nov 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D8gB9AME"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF13587DC
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050116; cv=none; b=ADwkSHLvb9wPwFU9LRLWLaGp0PLCYyRVwQIB6s3hki4Sj1Fp4ih1NvucbOox3MpfCCJZRPkoYFAp+KqkHRsbD17qk1Sga6fIbN1HQ8yaxAje87+d5Kb6oS6kfGb3EZs3JtvDv92/zeH3jNSSq28gwuXh/qwtoSNzlcUCmY837Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050116; c=relaxed/simple;
	bh=GaysYy91tbo7Rzk5Oo+T5WhlW7RvlxlYoCLAx+Mxnys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDwKVZGBEsSSghfVMrUePdb+3sFDhYvcwMWBsGWa11o6Zojlv78S1ZfxTM8fHNmkOEXlXnTMl1ocAD4l6xGgmh1rdChq69L846fK5fb6+LgEvyheYYxXC2doyii4ofoTuJIAh95kICAnRorhRJoxECtWDePXCmrdWujGFN5ykPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D8gB9AME; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso7754635e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050112; x=1763654912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7APxJ+6Kt5ZjlFq80IvFZLaGiW4Zr97mkhbYhGA1FE=;
        b=D8gB9AME9ACIqNl0FZXQuAhwXcJMQ+ZkCIbbtsbu0CI5lXudL8TLg2UwH7ckDmOIdb
         pGsTlG4gxnb2t7mVZ4o627DBO7jLIVWEGPREvbCOSCEjG7ztagP3WalyXtvgYXE+5TAL
         AkoJW17CHNIr174OavM+4aTfAgH8SwwMC9oey94YkquP1+XuTYAFz3pbnCLUJVms+uTs
         96+FKj/W5SpnvIikXDMPO9T0MnnNvupiijZvZcOTSZG+xshJcA/ViuL37mCQUQjoxyQn
         PBLnPtSRL3D1svcgsgAbnB2iS0x5GTpJeeM5+HPIvneAbiExAtymu8wOjUrI3ycCBUYE
         y/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050112; x=1763654912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7APxJ+6Kt5ZjlFq80IvFZLaGiW4Zr97mkhbYhGA1FE=;
        b=cX5fathhGKuXYjmwerTLIaJZ0rtlDXoM/FAE5OMTpKugKD4nwiYWcgZVwXY5gcABOp
         5kOg9dVw6dhU6xw23EvV2eHoYq2HTe+AI4kc7b7qXeFilPMZlJlR74lE5GZypy8lLHdr
         QOwDQtlmTzVyxMVXfVo7Jg/dSiC7u3LZVSeTJUsH4hgGVFyIqXklUj+p5BTiQdw9247/
         SH+6DsPPvzVt6AQraHY8qOy+WPZ+12z0ReHZUNh1ap7XCnB+FkmLv2EL1lUHsztv7AjR
         Gl62lOZX9dDEmkaY7NBJOzIwqns/zRo+mTG/2+fD81J/JP+05CqsuNt92OUANF8NkDjL
         Qrsg==
X-Forwarded-Encrypted: i=1; AJvYcCXZl8H19boHCZjNeK+69L51qr1MJ414zvFAFToL90Apv4oPu4R8L2DRzl+YXBI3K2u+KtBT8ZT9hAwOUDHi+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZ9iKDoWwtfi3KhKyD6NEOZYQlmrHcVeu76YYQOSNS2KBLjwM
	KFZReVjgsR7jG579Xa7JLxZ9iU5DjrG0zwYRpe/xu63pOCo/kWW1xF8LuzBN7GYTnGg=
X-Gm-Gg: ASbGncuKz1o8ru45r/bZpY3+qGC0WjeKTveIu7KoaI+xa4Ukz9z8MGOtNeuxLbzUm8Q
	L5vJNbGAsioDsqCJGMid2SopWzfFyLLiNK91ChKjyDF/uVXDVesYa7uI9o5KP6qEMH5gyDb49Z3
	doSUMi7+jELFJdT5fWrL3VfkDnnI+Wl1D+K50B7+T50AqGvg2PnOfUMVBVrckQwRNDMbFbDjbwB
	R5IYu3tjcMwq6dKy7DXQ5nR1OCzLY4tjulNECebJO1jFdStE1f12+amUU4B0BULiyD126HvrCBu
	FU541vydrQpH7wH4faxk0bzjkHyZl+pUNwJ0GnAHLQh6krNB8HUwFn+82l+DiYx5g/QnwePTNk1
	XkLwgVbv/+ZqMnwpz/icd1dN8+zPYtKx54xVrzvVzU5Q/Kp6dzTdQLF2GtMwhRM1d93CzfUXKZ1
	DlrILGI9rt6S3xEyoi8OVXqD72
X-Google-Smtp-Source: AGHT+IG7IB1X5/m5Q5SADMGB90OCLYqu+sTZAOn8CJ1vZLQh6fP3A4bdbgQvQYNfniqXzk7gnOjiTQ==
X-Received: by 2002:a05:600c:4f06:b0:477:5c70:e15d with SMTP id 5b1f17b1804b1-4778fe01a08mr591385e9.0.1763050112533;
        Thu, 13 Nov 2025 08:08:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm108865325e9.5.2025.11.13.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:08:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jerome Pouiller <jerome.pouiller@silabs.com>
Subject: [PATCH] wifi: wfx: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:08:25 +0100
Message-ID: <20251113160825.383883-1-marco.crivellari@suse.com>
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
 drivers/net/wireless/silabs/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index a61128debbad..dda36e41eed1 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -364,7 +364,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->pdata.gpio_wakeup = NULL;
 	wdev->poll_irq = true;
 
-	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
+	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!wdev->bh_wq)
 		return -ENOMEM;
 
-- 
2.51.1


