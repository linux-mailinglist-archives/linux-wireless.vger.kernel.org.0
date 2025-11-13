Return-Path: <linux-wireless+bounces-28921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7206C58B7E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7036341F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F672F7AA7;
	Thu, 13 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KH/rsQ/9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94F2F39C3
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049976; cv=none; b=KyCa0AxvzZQ6mhCyg9E9KDwROixvrFoXUa5dgC1/bGPvPHL+NR/MbAanvmLYYKy6rK6YTfjVQJlZ8v1ywR8pbiNDftVJd8+xlAzVUTPus6TJ1e8tgVuuuIYWpHAq+/B3SS424C35iY43tgX83QQTva7hD0exMOJdLG6J6QYDmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049976; c=relaxed/simple;
	bh=ySzTp6pi22gxFAQkEOEnHW1mjXFsKHrGwJAZ6aBVIM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0G2nRVe4LLS9G3VxO98p71CAbDnp4IhvrsD5YdglixdlrNPEZE0wjkkRn8Es8bUxurNG7Rdls2rWLiVOvmFBHgfAHBy2BhlkylRvUff5W6pxwANbq4MdEZ/Ug4t0xuRHfDu88xnPdgOzPWiyv1zUIcyBnSUqAjBiqjEY/6wJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KH/rsQ/9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso8774135e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049973; x=1763654773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJTSNeHpbNYeJSkiw1k7wh3DxAjvslu6ruETjokGvEU=;
        b=KH/rsQ/9JwFovDZMem5xihtLa6qgDVkDrdVLzgO7zNBr8yBqS5a5B0/lX1dD3RBgxH
         QrC/24k4lSjbe5I/XhYSRy+QGKy93rFuw3W/pw6F3SAvF398KNTfRFTfElLD2AnEN4q0
         9Y/irrYITs5NcqJ1EmGyNQqjaE+VcTuklxuH+6Yzu80Rn2lFn1FdIqnlda/wbgVm365/
         hFy99iuRuh7ypikKYCyat03IExZQaiYQMKxu5blmZYplbp/rHE4Yr8mI0kepDDB0p+vO
         pvAmi16LGyAlcZpsxqPd3rnl1j6tC+eaMpNJrDoJHy9CFASnLrhAcNzrCjIqbmOJGi2b
         AKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049973; x=1763654773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJTSNeHpbNYeJSkiw1k7wh3DxAjvslu6ruETjokGvEU=;
        b=OVe8DS+MxAMlD2iN5gJcDbgxe5qRWwTVDY2+OhSIvVRKR6OEZx614EA2b64xYOdC65
         QkMvcv8zRmJue8YGE9sl8JpNvwaAAqt7FXvV00kiherHyKUzvzKkWtDVBqLupiF20L0l
         rAg+UjTFQ8KvdsYf3FxKVO4Bn+JIKmfmYOg/O2WnJVeDmELkC5/8+udXtYZEc2IDWyft
         shLxqnKfYBakBs2Ui835iPYuuYS8Kb5Q/92fJN9fYS5mzi6L9kBb4IrI2i3ThvMsefm6
         6S/Cf1h9OucAOBMVDU459dUPI9OeZecLq26/YM6MInMX9VlBk8ayeHdHjyvXFODYdoJw
         jDLA==
X-Forwarded-Encrypted: i=1; AJvYcCWob6DZTp7kAxoS1hhV1iTreevFMX/0o3iqFNVX8hiuI7z9WkrKRm7K8IyOM6LlQ5k65bFv15h9gz3IpleLLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ovME0O7EhoQmDq7K/xX3kfQlV2jno53S2uG2TcV6ZRYxEPfQ
	DgOc/BLoBvc3Ghj004C067z1dyRyMtEItaKkwAxdDmJsy6K0hocu/bbX9T9gHIRgLIQ=
X-Gm-Gg: ASbGnctSfVxQxsM0+BT/918rqropbYSRQvpqM3NKUzBlUMZQkn+fTOaSbxC1Zytoetf
	qBkiIkx+pNhONO+wNK6y3o6tT1chmH+QlEYrT9RBqv7mvdlIUl6z9jsaksbsPQDwmk1rCh8su4n
	w5sqas/dvphOXEySHQZt0/c0wyFjC7O3nYM/pfYlCBlbl/P0bm3wiCneu1BTPG3qe+49kzqVhPK
	MOO0jqP3SKOfW5oU73rjtWS+Z3mB62Cx5BGYarbyWuRX+wwsStfKG/YJOrbs8lTPh2ABro1/dT6
	/C3eQWfW92o+IDzjKGS8SkMCIHrNNqrh4BbWaZ60KToxYtm45DB7VuW0fPxHcf/txLYUmS+3T1U
	Ng78a1UbRUo3Ac7IPmtqLG0azhGCH07o2Aqsv27VVuS6Ig4j7VZ5Sp9m825k2uiX0cYVze2pYv9
	cD4mhchAgx+UpdoKqTgK73uLzG
X-Google-Smtp-Source: AGHT+IES6o5QI9qq7rl/O9nVOMD8tvOri3CtZBmED04pSrq5w2lpqdmqW7EGjKAH0of+B/G3lToLuA==
X-Received: by 2002:a05:600c:8b38:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477870b39e9mr70883325e9.31.1763049972718;
        Thu, 13 Nov 2025 08:06:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:11 -0800 (PST)
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
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Thu, 13 Nov 2025 17:06:03 +0100
Message-ID: <20251113160605.381777-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
  wifi: rtw88: add WQ_PERCPU to alloc_workqueue users

 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.51.1


