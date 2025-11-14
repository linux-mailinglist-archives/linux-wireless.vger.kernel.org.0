Return-Path: <linux-wireless+bounces-28970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F97C5CA5F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12B234E2E5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810913128D8;
	Fri, 14 Nov 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A1tWvzPh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DE30B53D
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116692; cv=none; b=U+on0F9P+XGOMJir+qCW7rBtaOvYJVpIJCH0+Gmpje2h2cEiD55UlzlIF9ORQAouPvx+8UrnE5PBk0BkwcPGG5jLmiwPEbK7fkt/r0VOmd/6S5xY7tq9qbRWCrtf8jPlOzJpnQ+5KEBDjyN5D+hNYrk9fVYnNgOp4CRIOFiu6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116692; c=relaxed/simple;
	bh=5N0QWIM855WrbNzIgR9y9CFEsZ3+HDi4+UUYklbwiXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jREhPobijRLK3oqb487AfgR8x5wm7FmDvnhiU6z4GfLNYE7Ey1PS2IpSuAfDp/8Dgpui82GoLWM/v0TijskaPkuA+iBv/Pjn/qvL0y54oATkcP+hPGR/UUgpJ9OITCda+HwmqiFNavBV39wzI6mmUqV8OCk37BrF/ZpbGiWb9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A1tWvzPh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736fca06ceso47323666b.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763116688; x=1763721488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZQeO4tCAoTTOVTIamMOILGNRgViJn2iCP7o6r9P+OQ=;
        b=A1tWvzPhA9itSr4vu+dB0F7TABsdWWxk3c2efMYBeGtivyPb6JVyTDw7uEqHxcYChf
         jc5z+skcvmwLzLUEL/YM9GAYS7VqCGaW4hILsZ/12BjowwKcidJEy1u/pit9Qz/AzJMW
         fcYe624Zj0+t4LxEHFRraFFAp3wN7/2B6+qvryLnUr7dXqoOxkGxpcY09xWA2WBWn+Ba
         CWTy1tL70rLaYdMaLupBpbgY9WmI9I9JwRKkmhzrh98zk6Xo6FAF269yDxrU9BJmY7NP
         oX7FiIkxlzkOU/+Yp8J1mWgCvr280QVcvMjemmykqUGxUQB4XkywP/mHNxnQBsyuOyZL
         9LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116688; x=1763721488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZQeO4tCAoTTOVTIamMOILGNRgViJn2iCP7o6r9P+OQ=;
        b=rI54HFSMynBBM/TsY7IZHOqpteorSIkmLbXT2Yaz2i3EboG8Nihaq5J176jzBho6fX
         aQ4BVQVu16wVb7yu4YOzQua8DWxD5JmAALqaB6P0KAf7P8AV8wS3kB+YreBpJnxd9rYl
         FyMST/z3/YV12+Yd1na0s6MyuygJ0u7hcJBFkNi3w2+0G1xyevfDPI10xFsg+a03W20B
         qdLaflT2EIquX5XNxZkFIlEdREYYtkzHtsoUNpvx6xk6aE5PhAC1kXzqNqmNFI2jYt2v
         mM0pTVdYTHbpSg/hs1qFG7wwR1+H9e/v+ZI/0TRmLP6gcNMW4PA+p5kgTAAZyoO721MY
         R7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZMkYbHHSHgf43ETZi8DbJlVA4RgRF9PL2qIljeVtrxBO3AR/qCM7ZXX14+mAp4ZnVgv0oVInJUSRfGWz2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VRF+IRy6uzo/zTDMz0j3Hh1cYNZz7L4y0RvPaMd6lgUj4acU
	CCVXxKVq00iEzt+ShXH09d/kDEVNNKW3q8uAgHgy2VhAg4q/UE2F/WfOPBGUlv7t9FE=
X-Gm-Gg: ASbGncsBybe8dZskR4375FbQy0Yu5rq4iUe3JobPT4RDP7DbqPDc7ROwlyukQdYcspb
	vCBzH0cLvlPw0yJj99SQ0VufAT1IPzeDVRzaV8IYhwIsUIynvmHEPpo3NiH6ZDD/KAOwKpprf4W
	XjEVkSqhMdfh/6Y04M/ljTFSNdQNMFoKi8h5T9Pn60qTO7uZAFBBbTaIHwSVbeAz1BSTZwfWA7S
	Dcn/MHqTA3zVjszn0UortszgeujXve/vqiB+8tePPOQWyQzm5iVi+c28vMuS0Jwjwmd3PqjxF7j
	Dm+Fi+FKPnc/Wumjce+AVLd5B55eiMZ1sOZqIxfQKNygqbPfqxm030mGhWu8ydwRbEEEgIdgLbj
	sc45ioZbFUPtY5ezaHscIQVaLJl6vKWJ1DZTR077IwCwgqeQdgsVa79DGc0OkSnJAnJ/fDFVfWP
	qujVg=
X-Google-Smtp-Source: AGHT+IFYKPqmITf/TNs8l5G58wFo9RnbBALHIHEhL9F/8pJF50PgLI/r5y09hTRdiyFf6G/b1aiJmQ==
X-Received: by 2002:a17:907:d09:b0:b3f:cc6d:e0a8 with SMTP id a640c23a62f3a-b736786e693mr196119066b.17.1763116688579;
        Fri, 14 Nov 2025 02:38:08 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm360276766b.37.2025.11.14.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:38:08 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/3] wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 14 Nov 2025 11:37:55 +0100
Message-ID: <20251114103757.111652-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114103757.111652-1-marco.crivellari@suse.com>
References: <20251114103757.111652-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as
part of a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a0cc5d7745e8..7e84074e1a3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1092,7 +1092,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_delayed_work(system_unbound_wq, &trans->restart.wk, 0);
+	queue_delayed_work(system_dfl_wq, &trans->restart.wk, 0);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
-- 
2.51.1


