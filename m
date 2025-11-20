Return-Path: <linux-wireless+bounces-29163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD061C7365A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52D8A4E63E6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6D30AAC7;
	Thu, 20 Nov 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SUk3XPi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17B30C62F
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633344; cv=none; b=m8JpFKVzP0PsxaphrsjyZw21znKQ2swEQooQqy3DF76WjQheyj2OG9HT/EsvTnKneNN5Y5TlNZdPCBWw5LmUbg1To2nbWtXe79CaghsioasgZVKd45XKsAXHkh5cpLJt1ioE5vXvMFfxaIP5meKPcoPkxQVuKK7IE3KwtaRcR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633344; c=relaxed/simple;
	bh=/8N040sL7rPu7Wx5gwPwnG6gvDg/R7HbWkLPyV+nN4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXDEbGyVz1w8KSLWEvRdyWvLJ++4xcrP2Oe+h47X/gKLRRbsLIxHiPhc+f8uiUzgyvmI2uMbdm/3+x2mcZ9qTrQD3RwVMGNpR2Tuo53L5Q4819f3p1Nc8gGQnMNCNn33kEPMlbDazX4DuMVljkopfqeQI9TWAaoL8SfQntT05pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SUk3XPi6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso6553795e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763633341; x=1764238141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2Z2zKDam18cJUZBw1LDcSpzrXjpY8Ue664QxwbMMbA=;
        b=SUk3XPi6fSADdHvtsDytSy9ANcO1DECszPowcplcgtrDlLufo3WkiPZF/tPzrLfu/o
         AEROVGfdQVRZZvA+Pj/i4vs+k2ACC97b8HCMgDQIkauSWWiPwPjSHYA6JGO+NwLEricl
         z7rg86Fw7K0bQnVu9tXSqSB957iiKU3NC2+hLA/5NPyeTQCUkkt2QEdDcb3AJClZrGo7
         uU71TMA2I/DAz6nbM1R+BF+H9DvVsbpAdMSVO+m+N2aEsDzSwx2x9LleFbqzJ0RFl8wG
         vhJRVXuKYfzfJFLkewWB7JrFAvjH2NykkNICsJxS1lUMamK+UVpKlfOo6v/2SuSbSH1W
         Mbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763633341; x=1764238141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2Z2zKDam18cJUZBw1LDcSpzrXjpY8Ue664QxwbMMbA=;
        b=R+7Th+bEJr9T7rvbtZniTKnlkV0OdlHzkaS9w1FJPdpA5Jl91chYp5gtECnjoA7J8/
         QpNqeDMcIPG4JXqr8iBN0BsL94ygpQgY8g91Sm2AgV1nZnOYRA7JLWdIBeS32YvbbcGf
         X92Sv2pk6HEeuNPT9GJrbvSnPp+lDn6Z+LezDdo5tS3/cIouwTs8fF79ppb3jNEr13Gu
         taKvkcoyV0gnUoLoVH8zsS0eyIFlj6AlF7RtLWRo7zCn04EeP/5bucJVWRFtnxhWiyXk
         z++/G3y5VLQHaUazAIclo+XQYCgwCJQVeRzedf5N8bsOVi7ceaaJlGNjL2QRS9iOpG+n
         pUkg==
X-Forwarded-Encrypted: i=1; AJvYcCWitvVoTy1nK/XRbyUn14ZlNaTmGqnbqxMCI8aF9c2qpSHgC60G5Pmh7EQNIpBnDPU7RNwoBrT8ZZSs3kZ1sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZT4RprGjib1xMEjvU24Osd1iWWdihgBuGowvUZ9al6/eewUZL
	e3P5wGsAzXsXIIC3csFkSrMLtZJrQvgaJYean/dMpZzyRJ13AG06Nu7Bjvwz82wSibo=
X-Gm-Gg: ASbGnctQJeJNUOkbRyS45/F52lKinzzLRyA8Poee6ZCddbm31p+R9wUh0gJsMNZlOYL
	3SYdFsgxSqjFy7wi/gPWWKmSULFtWYdmIua0POs33NNVLD+Kc3NZqbi8xqyoMTmt+VTMhIeeyK8
	niHPvngAcBeyJe19aYfgYMskB8J7Q1uiK4Y/gCHEmj4KFbwMG/wjEMhAPx+3hM+ZXjCMC47EGNJ
	ndTUH8tWhVIz0S3/j9dyIvY/Ehznl7BlJ2djM4ruHQKGR6zxze4H7mfesHBpzE50BUlFbDOifN+
	DAyn2rrHnaYGTnhSMgUIP6XdG68BOnWoBJGKe8AP1R8Oy/VfiYaRAd1898FYoAenslfYH5EVz32
	/Onp71z7/PPwQ3pC/VAGQUD/5MbSSM9Ghkw9yaza3Dx5K2/UN1yRSV2D5Wmf4aWXsiTt2o1S9QM
	C/otR3Knb2225KTZRqYSX0nrN5IbAO0/GJ5UlNxGmhN6li+A==
X-Google-Smtp-Source: AGHT+IH8y5nsETp0wITskAnlSqEKbT/59q1hioAqaZJu/x0N1AMgx+s16bl5UDd/clESSseXvKHmjw==
X-Received: by 2002:a05:600c:19ce:b0:477:abea:901c with SMTP id 5b1f17b1804b1-477b9dd6e45mr15162145e9.11.1763633340694;
        Thu, 20 Nov 2025 02:09:00 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm58914125e9.8.2025.11.20.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:09:00 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/3] wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 20 Nov 2025 11:08:48 +0100
Message-ID: <20251120100850.66192-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120100850.66192-1-marco.crivellari@suse.com>
References: <20251120100850.66192-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

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


