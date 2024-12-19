Return-Path: <linux-wireless+bounces-16568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088F9F72A1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A75B169736
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A024C62E;
	Thu, 19 Dec 2024 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd4jYWKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2F13B58B;
	Thu, 19 Dec 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575703; cv=none; b=UGaGzSwHaQ7V9GKxTuX2UZiSKX8HAg2haomMGud2R6M/+mqxKHtXLWbsk0DnLNQLd5L60PPBlr9703Kbo897iGwrFvmizWk8uXHDM7szDMqXws4DT6Q6A6PnvIo/nBr3B5WpSarRrQktQB4mdHm5XgEr5pcY4Vtx4a6qT9hJULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575703; c=relaxed/simple;
	bh=Q/OzGJuA13XAM54QEDmg31aplMOMUc0jAFVuTy4gpzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e7YSUmlMhUrWhewMN4mwqWAyRhxJpu1uRPmIgNzgu5yjvvAfkBDCM7c7RdnOvZhOcMJbya1m2NB8E0cyW/Z0gqSrOe7McwJPV9omauyQUVYESs5oOBfEkxC4mm33fLd1lzmoeiCus9x9jIJLIYvu4kKBn6E0YTfcURx4BQEMxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd4jYWKT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso419422b3a.1;
        Wed, 18 Dec 2024 18:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575701; x=1735180501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewYmRGbtjw/u5CZQB/fGCIYq/IkhzVppRPs0v4hq1mw=;
        b=Dd4jYWKT1owgTKqPTtWtJcnBCpqCcM4bwF+QknS5OOGmOlfedmgts0z0+QBGS/mhVB
         zgJ6GUxxDYg/6Za75upu/2OWNrpCXeS/NA8LGHb9Cx9+ZsP6+0P47azzREt3pv+fIXJj
         50FrofGMFcaG3wWALehqOBejQ9JS86+Crp7JH0mMxJml0ClrVeSLt5gfZh3fFxVB9OMF
         BO/BqK8Me1URDH++MgZPNGn7y+nwiU0dQFnwlGDU6fQhDrUZOOAPAUBmOZwoP6jXsvw1
         LxhRj1HIxKsoutRUeaPXl562JbqJwI1TczTXpe2lUGeG5rJXhjvH8+vk3SGtvt3EZipP
         GkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575701; x=1735180501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewYmRGbtjw/u5CZQB/fGCIYq/IkhzVppRPs0v4hq1mw=;
        b=IdP8WixiQwh7tukM0qL3tlr4rVI2I+uQhqZNneC2/eszBQ9eUamSslxQuyOaeCLVc/
         EABgX+0CFBU4NH7aT5hP6v43+ryvw1ZIunhIAJELOVsXLSHw2o6hoXdj/K6hWbQbMb7h
         KS3OsprCDCcbk4GkjVJyOlhOoTcDdwJPzSPKh712J13HhYoW0a9KCYppwMH7HbetyAmo
         JuF2ryoLsFJI9NUSNHk0wibACzL37QsZNyIBr0zIYCURMILr6V5irmFAm0hZFvZRV+p7
         IO2KqLFIs6/ib3VVuTyq6l43hz1TNhjWYCrzjcnn5Tae1sB4lBKt3mWsJoEKjptiIta9
         kNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhvw7DWWOeO+Ch9LaiWlv14NRNbrBKtp2sUHgaajFJgtrcY4pS0A6/mKcPSkBiA8TpAiRyVt4/R6vKJuBQJJs=@vger.kernel.org, AJvYcCW1S04GxCBnOYR+487ZCcmIOEhHMuPR8seMnvndSr8knLcj5Tqu2iN7ZtQe6g5uVVQiVIdQnbUcMi9odrg=@vger.kernel.org, AJvYcCXdFCiWC2V7arcjoGZTp4JyoYHtIAGYS/6BhRkk6uCT6NcVWwyQsSoDwonMhgl8z2l4XccKA3zyBv2WrFlRJM7s2d1I6UaL@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3SCAank/G6Za7UzMHImBMLllxUvgVDqY5Ygh3lR38/lTMhGN
	bgRHWN5Et4qDILnMAHF1zrJvaDvoKLMux/bayr+GETFt33SXJj64
X-Gm-Gg: ASbGnculq4QTDqIlb38vvasE93KPSk+8M8F+MzyA1pl8Qx4wT7YfT1Z6I8/o9MTgfm3
	QyH6NaO6K1eN8B5SAeIzh5rLOYaKe5p7NGyCSGacsRhNXeBKjNxRj5IPVPgpOgaKvdjYnmoHwsZ
	rJ9PbxINj+oRuC1srtY1mnQ279403XSxnIkR/g7W3NAPDvwHfLBDJPfpzpRzsoRozISnCyM7erQ
	g6ly2Yv9TB8gVNIUvxM4efGLKe1guv6YenqMZcHIi3k0WxaOYjGjGNgqA1yOz4KW+GImWGZ8gYH
	TUjnr/0=
X-Google-Smtp-Source: AGHT+IGkt8eWE3wh1dURnDDolV6IzXf9MexDfJ0kaeAEgc6DDmy7cFDTyCLLAMMKibF6E7v5iDX6cg==
X-Received: by 2002:aa7:9316:0:b0:724:ed8f:4d35 with SMTP id d2e1a72fcca58-72a8d2e0557mr8641134b3a.26.1734575700792;
        Wed, 18 Dec 2024 18:35:00 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.34.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:00 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	pmladek@suse.com,
	kvalo@kernel.org,
	bp@alien8.de,
	andriy.shevchenko@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v2 0/5] Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:47 +0800
Message-Id: <20241219023452.69907-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

v1->v2:
- Don't add "%pTN" (Petr, Kalle, Borislav, Andy, Linus)

v1: https://lore.kernel.org/all/20241213054610.55843-1-laoar.shao@gmail.com/

Yafang Shao (5):
  kernel: Remove get_task_comm() and print task comm directly
  arch: Remove get_task_comm() and print task comm directly
  net: Remove get_task_comm() and print task comm directly
  security: Remove get_task_comm() and print task comm directly
  drivers: Remove get_task_comm() and print task comm directly

 arch/arc/kernel/unaligned.c                         |  5 ++---
 arch/x86/kernel/vm86_32.c                           |  5 ++---
 drivers/accel/habanalabs/common/context.c           |  3 +--
 drivers/accel/habanalabs/common/habanalabs_ioctl.c  | 11 +++--------
 drivers/gpu/drm/i915/display/intel_display_driver.c |  6 ++----
 drivers/gpu/drm/nouveau/nouveau_chan.c              |  4 +---
 drivers/gpu/drm/nouveau/nouveau_drm.c               |  5 ++---
 drivers/tty/tty_io.c                                |  3 +--
 kernel/capability.c                                 |  8 ++------
 kernel/futex/waitwake.c                             |  3 +--
 net/wireless/wext-core.c                            |  4 +---
 security/yama/yama_lsm.c                            |  4 +---
 12 files changed, 19 insertions(+), 42 deletions(-)

-- 
2.43.5


