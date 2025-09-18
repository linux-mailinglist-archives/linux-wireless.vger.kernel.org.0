Return-Path: <linux-wireless+bounces-27333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE45B58D3B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 06:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180D9522A17
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 04:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D31265CC9;
	Tue, 16 Sep 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldcgaDct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A42DCF46
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998116; cv=none; b=WiD7/Xl5ZCVe07VMpLdG5QvYXWDHV03hbsai82ahNE05LQXhiAa0JlUKyq/OXsntwmhSO24O9nma0VKTRgzHYYgwTWN4K3Afo8C9qPHbOkfyFlPBcQJFhtp5EFMQLKoxhAts2p89lK9Am63JNgZOIGKvbkB0TKO/VCYPaGmXnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998116; c=relaxed/simple;
	bh=ivk1kCPJFe/BzZPF72WSq3DpdkZ7hkdmk3r9ydq31tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbiyj+BOIgQOEFJb0qEBi53kH82qjw6ja+Te3d8mxJQMWwVSJek0MmC7X4Y8gIeb+XU5dtD2+zd/b7wa5LAMxyLx1XOVThGD7HlE45XHxCGXP/yh/y8AXfnXosH6eA9KTSvNVVYEy3Sv367PCqOHXuuZBtShTULuqF8QjMHjJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldcgaDct; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf6058aso65567225ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998114; x=1758602914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=ldcgaDctXOfgSLf64W5XTkXL3DEk6cNTh/hZtEwwAoIMEXJ7nBBWetX01vNPBw3b9W
         jZDo/ihzinvGc71TxgSzbCWg1MkINwXVj+isFkr0JB682qWP40CLk9GcO4jjh8/pDWu7
         KuRU9hXBGyaKtbD3e/8dqL4Vb9A8A1Cl1Ci87LIjq6sFmpY+k+tnzg67+pGgYhPjGDUQ
         ++nwCK/Qi6G1Yem5BVlYpjZZKxqRdvGMMs6FpSW/SQlCGwMbnWL0p7yJ4CdB+XR1KlBY
         zgLgJHEOAdHxuTL+O/NFH4O8mWv/mnq4ZzNT2O8rhaM3p0qyK/3C9A2C2JE/av0S2fQt
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998114; x=1758602914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=gLdc7QqGJJtj6RJudQ1xK3t2WJrkB/N2c1Rbfbk1E3eySwjlFQvt3m2XJMjmUTz8Ft
         GfeaRCIeMbhvTc/xdQMxW5aF/ra4DWzklFG700AynvnSAo4e0ztRIEQql5ZrtilVN0K9
         GRH/JIso/KP5Mcwi8nDBk5jd69nkXLCAeYHtuvXRFmRTW4exv8NF/3eFs+B9y6GwOd6X
         cNnJR+m1H5dDeJiAJNS9cp/PGTstQbBJpUYcw+HySEbh4HsSUTwvBubcmBeHcA4bJro4
         le65ghYUku1+jwHAPek/zZVSMtRGEnsXeaSdoBaxyQ6hgZfZJgFm6RgFwKPrypWxseCJ
         vyLg==
X-Forwarded-Encrypted: i=1; AJvYcCWSJOl4dpqM/o8bn+1h/DQeboIkfzIh5+s/jtJ+kgy5eJnxQuvPIR9NfDd+TS8pWxDS6c6OFnIxc8sEhxGi1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzotmvbSisr+50CVjCoL+ppuOotW352NoxgUHJKmst/MZz0MO++
	3OM03zbPiDYNFtsxQ65QgGOU8DQ/ZEr+eb3rB257TMStL7i1i/J55iIY
X-Gm-Gg: ASbGnctJfAdxx1Di1/B9LZl7PW9K1E0vmIqMT39bhY0kZ7t7vm2Ewpmr2LIU8d7ZXuE
	q5g7J/rQSINrg7xI2FMazFzUfCXBlW6YPkpjwZUHSyRxylLuni+RM3udn0eA1mtRi1GclrCJ01u
	7Om1pf3q9jfuYNTq807+92crSHaUoPjdMKxvnmg/KpTrSxBmfCgTxwYaCk0YWXxKCZClC/ixfYD
	FBUuKRsKbhLMNIHPGZ8qGL/wZz2wuGpD2+JR7VtLYYyXYlyROI63EpmWKwq+OXUHWorGcO6QA/J
	10KEtZA2RdEIzOJUbEhoLCze+WtTgEkYUNU6tUK5SFh1fuCHxcneXkgmh0nPwoM7ZcsAkr9cJlD
	h5vm0Un5ZrN+uUzabiAukURtU8gchjHqrHpZPDeg=
X-Google-Smtp-Source: AGHT+IF+n/WS6RKuYlQuLpfTYPIbA2M/p4imTXrTMvTksxJg/G6gJFeTxjjE/2igpzRcFyrC5Ibdeg==
X-Received: by 2002:a17:903:3585:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-25d2771f4admr137080665ad.61.1757998113981;
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 03/14] fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:24 +0800
Message-Id: <20250916044735.2316171-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
-- 
2.34.1


