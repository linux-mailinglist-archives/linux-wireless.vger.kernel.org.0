Return-Path: <linux-wireless+bounces-16345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85429F044C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A3C1883254
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E7188CA9;
	Fri, 13 Dec 2024 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1HfTxq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F076F30F;
	Fri, 13 Dec 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068806; cv=none; b=j2cpSkHHfqqBpPFwZ24UEzEXJadGfdT86bE8b4SMuAtRay5k+/55kLDQPFnXGKkDCylfcM45OFTlBLPFk/HUTvhZ0isTxW/XNvFR/3GBpDxHEfDa/jdqq8hKbzE4kgX7OQZyZn7NBZi+hG728XUB/qIQa4jrWZwQeRgdWvEX+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068806; c=relaxed/simple;
	bh=OVgnmW0ca8umO0SwlloJBit9jW9fr1tJz+XCXh2DFpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hXqWAcNABztAicFdVGnxFeqkUkKHBEy6UjOLKoKbj+YPiWQ/vwSc/ptgKLb+rjpsSaP+UJ+O/oN5Q5JgHzm/mwW8YOI9HT/SyKx4yI2JHbJxOdwi0WusjKamPaOUJ890lOTRD156IVqghlPScPAPwCVceCGzD/Xu9Se5+cnCivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1HfTxq0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166360285dso13105605ad.1;
        Thu, 12 Dec 2024 21:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068804; x=1734673604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nDBDHl8OkOEbonP7/O/xeWGAuqOftf+4IMvf+gS1cw=;
        b=B1HfTxq0+rQmmgtwHYUt/XOzBHFvqABhw1opYXP3S318Z83/WUjXiKRyx/MC2WgKUe
         Ht8NqVHSyAmFQXpx95NZeLd6wWZPGNMLz4S3e/TpwHXfzB1WsLydFGVhxRD/3Box1vxL
         J6YBbQn5c7ogbLJYN9yV28uLzTg9r9vtJiyeY965CWy7GUnfCyq2j6XqZVC9GqwLOJ90
         2iESoWNys7Hx3V2+ZVray82kYb9OXakt5JZDDNFNxJGxxgbF8tU6zrt8UO1o7i5IRcL+
         Q+EWmA9nWafD1RNMS3ZCtY3D9lgwGX214QeDbT/dAxk0TftOJril+VsnU++goFlTkzLu
         K5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068804; x=1734673604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nDBDHl8OkOEbonP7/O/xeWGAuqOftf+4IMvf+gS1cw=;
        b=aRYSeY5NYqTL4xr7JddyKx2QiAJXddBuCkUwrVrjR053Xh2xkbwP0EiNRWuaquI6aI
         +u97ZIUJ7mzG8OZFrYRRVIXCxKBZpPvbvexgWkdxl13yq6O0JhwQzN+hQEiMfiZnm+hM
         lhNjjX37hBv9DwZPCGPzIPNg1F63w++hqEFEkD9BuRwl416GVSeVe6wc3hfeWk+jqzRH
         3Iokl9OBp/tCCCZzwQdVJbPW7tWQdZKSCehdjxCMwmhGtC2TX/6Aa9CPVJUDc0i61LVb
         Wv2/Qul8Brzls13G5HTiN6EInOIP4gfJvffAw+Dp3CT7gW5IfTJ7tBbmbMLiuxzCwmof
         P6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpbHy1dzPZAT5SqBnnrTDrw/8sA4S597u3tfU6Nqkr6SsjzDqUs7bhuS210dRtKxxJloDGMCGIjSQFpcJzMQ=@vger.kernel.org, AJvYcCWb6wxWccetYJ4mGdA2QpB6HsAHoBJrAQAZ4TVWjFFOz3bMO5KpyDBueKjymlbHRRTPbc5ydZZkhRSMa8c/N8rIydSz2c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rk9pFWnQk92mPELiSzIFil09YMhktJe4DfN1mQLOfoLBxmhh
	2K54jG2rvXkk4eobyRcz2W7E0IjhwAeSkJ0pigl8OPiEsSRWZsKt
X-Gm-Gg: ASbGncvsGOrkMyn31TtCLZJScpER3MgtA0MR+JfFJ+rDhZeRYSRqtBFJNU3p8zQ+bEJ
	vpd2szD/0irCMzbj5tGmpwTZNsBBLgdhxJQPO84cYgUJylHBjTZR8YVW9XvU06vYbzSOHW+2HsH
	zKvY+PRLEodxdG75q+btzVAC/88uNCVzHjDEJtoFtm36nbD/oqHYN+SAeZydEE3RLnpwRHWrtrU
	IKFjmaJCeHVHMbLqpttt18oXd6mlrWh1jNL7PddKZu6p5nuP4A+ZvCv8DYZ6+UZGRYJ4BYnXFZ2
	keFT9b0=
X-Google-Smtp-Source: AGHT+IHVKByQs8aQw9nFW65MyCdke95tovLrIe/teYLFc9u83Eik6guIs9oKZyvf6Ts5Rmy4R5h3SA==
X-Received: by 2002:a17:902:ccd2:b0:216:26f1:530b with SMTP id d9443c01a7336-21892a70579mr20915305ad.51.1734068803702;
        Thu, 12 Dec 2024 21:46:43 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:46:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/7] vsprintf: Add %pTN to print Task Name 
Date: Fri, 13 Dec 2024 13:46:03 +0800
Message-Id: <20241213054610.55843-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, it can be printed
directly. This patch introduces a new vsnprintf format specifier, %pTN, to
print a task's name. In this specifier, p represents the task pointer, T
stands for "Task," and N denotes "Name." With this abstraction, users no
longer need to manually retrieve the task name for printing purposes.

In this patchset, all instances of get_task_comm() used for printing the
task name have been replaced with the new %pTN specifier. The raw uses of
'xyz->comm' for printouts will be addressed in a subsequent patch.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/bpf/CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com 

Yafang Shao (7):
  vsprintf: Add %pTN to print task name
  kernel: Replace get_task_comm() with %pTN
  arch: Replace get_task_comm() with %pTN
  net: Replace get_task_comm() with %pTN
  security: Replace get_task_comm() with %pTN
  drivers: Repace get_task_comm() with %pTN
  fs: Use %pTN to print task name

 arch/arc/kernel/unaligned.c                    |  9 ++++-----
 arch/x86/kernel/vm86_32.c                      |  5 ++---
 drivers/accel/habanalabs/common/context.c      |  5 ++---
 .../accel/habanalabs/common/habanalabs_ioctl.c | 15 +++++----------
 .../drm/i915/display/intel_display_driver.c    | 10 ++++------
 drivers/gpu/drm/nouveau/nouveau_chan.c         |  4 +---
 drivers/gpu/drm/nouveau/nouveau_drm.c          |  7 +++----
 drivers/tty/tty_io.c                           |  5 ++---
 fs/ocfs2/cluster/netdebug.c                    |  5 ++---
 kernel/capability.c                            | 12 ++++--------
 kernel/futex/waitwake.c                        |  5 ++---
 lib/vsprintf.c                                 | 18 ++++++++++++++++++
 net/wireless/wext-core.c                       |  6 ++----
 scripts/checkpatch.pl                          |  6 ++++--
 security/yama/yama_lsm.c                       |  6 ++----
 15 files changed, 57 insertions(+), 61 deletions(-)

-- 
2.43.5


