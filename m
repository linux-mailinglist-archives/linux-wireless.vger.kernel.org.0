Return-Path: <linux-wireless+bounces-28971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B69C5CA0E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4378B3B0630
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB931354C;
	Fri, 14 Nov 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KQEnSPv+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571953128C9
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116694; cv=none; b=uZ6/ueD/ddVVcE/djRLKWV1b1izbi4rAkyXIK2gtXFMEDKFwZXr2RACCAhSzSbwYLwxHbte/YZyiNQC0mpCW2J1qayDxZenXBUXAS0ENSOYFGiAtM/U9lkefZtk+h5qTbuIdihvMC5c55E+bfkp3ZLEiOGht+LrncOaa5+w3/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116694; c=relaxed/simple;
	bh=9MCZFQdIdpPoPVRYxQ4ee4NJjMXh0QukZRSBL2NMN2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSjthZGu9FTWOp6bMm30pJHpe3H2rOADSa0aPM7K9ylwr58dWKNE1AwE+A2B/SIM3+dC5kelLdtvIBd3naBq74DH4mOtvUanO0vYQMWBRcnqSFy/BRfFJprxAUxPwPssVRIwtsx92gYX30QPU7c7exhouJdJEoWWp+CX3XPa2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQEnSPv+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d402422c2so282380866b.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763116691; x=1763721491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5ZP6OcD4+SPY9iT09PIyYrTMYvEjHAazYaW78zQpYg=;
        b=KQEnSPv+LNa1dh+YwmKedRxtEal22N0SEKUg/fd0yEkCGS9YdmS0yNSy7y3raqg1jG
         xg1UhF7GGNwjCPDm+CYbYi2l6MMM28hlQmvt+LfciaW5alNIsU5AD6CazCz4Bt1TkkM6
         FFZQHmaDyyM5LWkahdLwWAALZsV9n0NxOH6uLaPkrneFdWUvqJFZiuuTKBmaTa9yjIQs
         Mve8aMU8FwKG9Q3NxWKp5dt5Pf9JSTfjPB1Xi/UYo4TAqOcPrK8EDm5aJ8ZQClqFHHmn
         dTSw/k1p+yfRh1Wd04t+goi2wcnpIXmjVxqNi+Elssl+Kc2l4QgHKOdvc+TcOsNXrn/g
         19AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116691; x=1763721491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5ZP6OcD4+SPY9iT09PIyYrTMYvEjHAazYaW78zQpYg=;
        b=JV22zn9WRVAT43GmUlUTVTVsNRbrDe1DuYpGiWOHRifY5rN3Hru0Ozdh1Vu3eQXVgu
         DLP2k3mFXKflmpk+Efq+2gqSCr3FnjCm9wfhyKCI4mBUbyeHgFBrmZOhtCl1kcdHBxr0
         QPBEgf9Qr1rU7X4iQlLtlrMuDbH1mhY/vAej5leD4Q6OXe1CdA+xEuyBPF/owXEFyrKn
         7X1rLPdRbmQHfmviRPJyQ8ga89klIHl4dP9oV3pDbHoadhW2CgLDLwJ4kaPI/+W7et2z
         SyV4xld+BOGsXJdb1+Tvl/jJ4LVGL1+Whyz6Ai11NKVqOR9TFlDXcEBMwfOwglWkanZq
         RUHA==
X-Forwarded-Encrypted: i=1; AJvYcCWSeXTFDpmcEZo4xLXbwV2doVjxKf5qD0cKQY6FORGUnqvx8EWGXEgXZzkokBkhR8EZqYkv9kDkeHqvMvZDjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxh57pN+NADFdHu/h0XKR09z6s/p0rkPpkyv5VJzY57/WhF5FV
	jR8/dTBjICqx/9itz7SQLkdCJYvEo+BW/EKVZyQSdLkz5UewsrME5ecdxdGbbLCvMW7sv1BRKO3
	kBOvw
X-Gm-Gg: ASbGnctYENhFLv5R6oKsDtBNUzGQxRudlK4zAlsrx9PVsoqYfA8ho7SVIq4k3QlUq0k
	nDXHyRrnjfTxF1rW+wezLSIWgqFfRcf17X/8lcm7YNQOu98iSNWtW35eXvQwKrQFKzLvChjC3B6
	lP102oExkSdWX3QeDdOLAVTFP6FTzQeFZZzBSqyfMRhjqnX94xUhelFg557VqzKQ8H7IOIypE96
	V4floJq/wmDNbNK5z3asLPtulVm0LOWr6VICB5UBKupM5vJ9xBrC466cGfoqOZxmyLfho/1ZfBw
	zWKx94rVrWkuxS+AydJ86zdkh0NPU2B3c7qQ8LZEN7P0HqzP1RN/aOVJAMH0Zw7KYUn7QNtbUvh
	18vuahkf1rN6MDUqSqKDdTB4kFS9tFA78GpAXcdnoqSwZIn+HTub25QCUZHVafU9QKp5wi4dDmJ
	uD1Os=
X-Google-Smtp-Source: AGHT+IFRdjqyvXJVH5Taiz7ujNsJphBunp3Hl9PQ3wpAGwRX4d7m4/fO5u7UoCzhlm8hkgbwp6Ls5A==
X-Received: by 2002:a17:907:7207:b0:b73:7325:112d with SMTP id a640c23a62f3a-b73732513dbmr63891366b.35.1763116689415;
        Fri, 14 Nov 2025 02:38:09 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm360276766b.37.2025.11.14.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:38:09 -0800 (PST)
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
Subject: [PATCH 2/3] wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 14 Nov 2025 11:37:56 +0100
Message-ID: <20251114103757.111652-3-marco.crivellari@suse.com>
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
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2ce55859641c..e5f31b82339a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2933,7 +2933,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	queue_delayed_work(system_unbound_wq, &wk_data->wk,
+	queue_delayed_work(system_dfl_wq, &wk_data->wk,
 			   usecs_to_jiffies(delay));
 
 	return 0;
@@ -3237,7 +3237,7 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
 	else
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &fwrt->dump.wks[idx].wk,
 				   usecs_to_jiffies(delay));
 
-- 
2.51.1


