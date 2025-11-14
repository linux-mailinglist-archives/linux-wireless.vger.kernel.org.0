Return-Path: <linux-wireless+bounces-28972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7BC5CA74
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 579EB356344
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB67313E2F;
	Fri, 14 Nov 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eh857Imx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49F31329A
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116695; cv=none; b=a7y+nIrvFxxu/nMoSqgsANNjebk1Jt9n25w6bcvrquOV8ObutzJdiIfnRMNTMR0dopMLil0As7Q9Ngog8XmRNdYVCBAMuYXwNOZXLlDBMFYa7TEf8g0SqO8DzKgW9oqwrdgK6uFqGAI9MimsDK63KvO07moN5cqAdc0N4iqotNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116695; c=relaxed/simple;
	bh=Omv8cFP4mpHW6K2oGUX0F0bCz6EyewF5K/eBoLp0jT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP5P4pKIl1mHWjsk2mr5fWZU2iXBus/nCFM0rQMa0g2/fMDcN2LWfhw+40652+P1bcAUMJTcRveY7FfWh1eZ4oVjrccGUHsXsKCE8AtGmyUDfA5c3RfUiPfJWBSyqBUEy7CHim5SiilLzw4ClCu7xbG5blpT7ZfK66D+TijUQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eh857Imx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b733707e0b5so271328166b.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763116691; x=1763721491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hwkF84KT6SY9+0UvheCyAefRzQC9daOKw7dQCB2jUo=;
        b=eh857Imx6MKvD33iI4uzjCcbA+pe9x3updc98UUQNhcnTf4TyCjffqVRAy+4+3H5QR
         VngluHJLRdMHfjs78HYu2D3uxkkmf2b2WymFvxA6tKtRPoIj2CPByd8Xyxrx8Dxkqh37
         U2tHij3UQZIjmEZdyMViEEolpfx7YuVIWvGILStgFg7+Eipg9dCrVMCxHVUIlqQn1KQ/
         dsug/OuuDbh4iE2id/4h8gdC6WDVBZASiBXCKOQL8bydqDBdcHmEAu68WGO/deYD2f0r
         UE0cf+P0XbMRMNxrFnQM3DtjQPTht0FIpHQh3Y2wG+gaKbq3CwIuFKsA6k4eOcfw+mrD
         v/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116691; x=1763721491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hwkF84KT6SY9+0UvheCyAefRzQC9daOKw7dQCB2jUo=;
        b=bGpIfHXxCmadDi0rFJ6sMkDx0tRCPJMPB0LndN+x6O1DlNmt814U7TuBAW34y5Xifb
         UziKYR/30Fpcn0AxaCJuth8QajAqoTjHHc06Tco+2P7Am0andOnqnVJzNCEuLy34IWBf
         zob2nC2qc9f0PURyXNltgIATxvvEbYIX2MRlkct3heaoIPHWy8eH8Xe/8czPBUo33Cxm
         Lj0OpGvKwu3UuSqtvJT3qkkiho1l/9Gt0jS0zmsnTuL84htEn8NEmm+TOi8YtRHGg0ux
         LCmxsjuT2AnW01Sa0sefSwo9CipVOm01wchzu8yv+YmxRkz4/cTeqpWFPrU3x0pytTg8
         u2pA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ubq0qTJRBAwuGIT8uHNfJ3D7gGiihAPLodALUNDLIiCfhNcF+Uh8hNLFAqp7zlhpj0OaJ9tbFxnt3sKLKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwltEuZ7uxSznJjh5jRp0xMrfd9PJYcm2q2RGILLKrUE1z2v5GS
	pHs0yloV1iKHtcNw1qkbMluPjykpi9ydFneNuFlh8W2RQ0xbv6HnnNy3q6yQlo8jmy+91gnKoxP
	Wxm9p
X-Gm-Gg: ASbGncsOP03lnB8/vexO0qg/9K4sjnmfUcUvRRWdKlCcJ/mLJnbBg/yUw6GuzcMQuiU
	WSE9hhoyG+3SI6VVkn6UGwLeHvLA9MuxA8lpYXwMEFtzPPDkjALu19HYnIk0yZisf1/QUAvUj0d
	JEQmX+nX6UaWHNwJuWZG5aR3zxciuNXITthETPFKaxeyv0oAncUhLxKtD4qy4KgmY3wBHh2xJkp
	znwZfFwMSeLjQv4pXu4qnl7NXXGLs3ikFlTLJ/hOLFhxKJ94H/OQdkco9EfoSgYqI/kJlH04etY
	nd8tnE/cAZSHxtia4ZO9d9I5YD0Rv8xMmbg+qzFwKNxp+HsssBWFnuejbcIQT8zxZUkji9c6YWB
	R2NmDWtkfjL9AKGeh00BirJhe5JtXWxpII/ZdjXZeFDssMe60CBhx1v7q264M2PGiKLm+GBoBeJ
	zYMv8=
X-Google-Smtp-Source: AGHT+IEQ4X5N/34ADNzJOud5XLBIlRdsUu7pIF8k5Vj560EHHofIwcFbpni7zYGLrK63oHkEmpHxMA==
X-Received: by 2002:a17:906:f59c:b0:b73:53ab:cfa1 with SMTP id a640c23a62f3a-b736780c005mr250356766b.17.1763116691438;
        Fri, 14 Nov 2025 02:38:11 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm360276766b.37.2025.11.14.02.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:38:11 -0800 (PST)
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
Subject: [PATCH 3/3] wifi: iwlwifi: nvm: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 14 Nov 2025 11:37:57 +0100
Message-ID: <20251114103757.111652-4-marco.crivellari@suse.com>
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
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 36379b738de1..0df31639fa5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -234,7 +234,7 @@ void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	 * Also convert TU to msec.
 	 */
 	delay = TU_TO_MS(vif->bss_conf.dtim_period * vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 
 	iwl_mvm_tdls_update_cs_state(mvm, IWL_MVM_TDLS_SW_ACTIVE);
@@ -548,7 +548,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 	 */
 	delay = 2 * TU_TO_MS(vif->bss_conf.dtim_period *
 			     vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 	return 0;
 }
@@ -659,6 +659,6 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 	/* register a timeout in case we don't succeed in switching */
 	delay = vif->bss_conf.dtim_period * vif->bss_conf.beacon_int *
 		1024 / 1000;
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 }
-- 
2.51.1


