Return-Path: <linux-wireless+bounces-29164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47351C73690
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13348347DD4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC1E31985C;
	Thu, 20 Nov 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UjyDqvBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D6313266
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633348; cv=none; b=qhyzu4VIrgelT6BQELdNy+2RvxaBNtJheHa9X8yeJy5irZGvIWNTR2oGDHtTnLXOtrfQJmiJrJVdBMwrcJHdA+Qwf5tVr+XqrHCO70o3zOc8L+xVIo6Cq/7KBwq9RXkdUrGTgIsJCemlzFm1v3LRgSBFFxTZI9ZYKTjd3EkJuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633348; c=relaxed/simple;
	bh=X/JKlUt5u/ibr3k7wuxX8dN7slwRoJJxYGVtF5IBmEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzqgzyixK1YfNyh8rYFggl9DMoFUUljGN6YKeKanF75GQvDurvj60b+dskHr/iUS3VmUyfgYs1ny/vK5RYrQxow+3esujFgYO7WXJmAHyE+KBS6vfBYCHu76gG2l2lYMd8Z5OP1QYp4exF9sKG9JHURwDFzgTYDRKRkJItrZasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UjyDqvBy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779d47be12so5720865e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 02:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763633343; x=1764238143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf2YpkqM2/I7HDJBI/f9YBa/0EGb1rx3MAQ6o7tkLOU=;
        b=UjyDqvBy2BFjyp20RDC6T+r4eGgvxuz2XPy6flzHATdcd/aHy0pLVt4ppn65RKtps4
         XkiqH1NwS8pG31HnegHigM/tvZlMQ5KnwZ7R8DKb6bVd+hlwYjcWAoocovQLhikRJdBG
         tq+6GkcFDlLJqjPZhEZiYT/FCGu4XxL1TFkptlHHOb2UL62gf+892rlSG+JeQivj+u4S
         VTtnDiCUVWVK0m6+Hf9LP2Yae+fDmdpg7C3z0DnQXYavcQKDMtxTN9EsyhyDa5eNHmaA
         XkZK2Tl9Q2Ay7YgvtgNHQTBZ7OVMG+TLZQb5is1sbGrxOeXoRaIKi47cAeosSghuqxze
         YGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763633343; x=1764238143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jf2YpkqM2/I7HDJBI/f9YBa/0EGb1rx3MAQ6o7tkLOU=;
        b=DBaipNhcurlgW/VkyHH1YtsyUNKk5YWj4fXMf0bYnw5bcMtktR3P9uQi1C3oke+ivY
         arZ9ru9iNDcr/GxrzsEfmRIcVj3H1GpWjONVIkyVdEU/tohBmA/ooi6TydnFWp1iPtww
         D7m9HH16ntN30jqFYZSt7Rio4XkNezN37o+9kpp9cpB+Ygwd3ezXu8zvrqJuszaOuByP
         +48CBFpO0IBy++u+E9xO9zM9IX2zTtFWIM7ZN2W+OoIquzjrUrmD9SGETDPGc79TAACm
         RJaVV9MdxbiX1WwYsAZWkeUMEWQpmeW0S1l9gsLYk9XJmgHlOKQ6nDomsw9ScZ6LkQ46
         mjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb9mvB0FIaTaSmSNhlOQz25VlkxHVIxyDOcXZvsi7vg4O2fUdhSwbQnSj7xQFuPiT/WDC1mUSjBVOHmXOs1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8nGg0u8X9Z0wRxJ2IvU2V0mio8fLFXVwaZDSJNK/YZPIP9qv
	rDMW+4QEZ5wJFnaB2BIVEwLO29gC7jF4ltHJcZ4YBto5k5l8JpNqyb5aoPdsemfDF1Y=
X-Gm-Gg: ASbGncvN7d+ZQhi/yQZRNOm1uXw2llufJO8v2X9uMDtDRs1u/k8f9PDyj8eQcPQmlaV
	cm2XFglQhYg1RdTgzXtxU5mnYtBIKXsXL2P/JqIl5rA0J2inhZUKNTqxmN7EB67Jqk96sDFu9Vm
	T6Us7l2JY1RDE0aeYmoPSamFz9BxNgBMFY0WOeZaRze5prooSWRatgEsYldIVvvgP85OTBqMR7t
	YNqnhCqaILTBtNi+baD+Y2wH0dEcVWbmMaREtyQasvd56E15Gn9e7+rV6eJYDueBarVDGpZ6K6j
	iJEyMhT5wQXv+t1S2iVjQe8LaTjmrK6/qjSih4Bp7KCkACpCI2epG7J68eWGyeIXpJzDgHZ18R6
	uiRCUwapPTTobizXZKli1ir16xaaehR6d5upU6hDrASMTEup4LWSevZT6CsTaJw1BlWsfsU3QdX
	idRt0Tj1gKQc2qMYPjGZ5ER6+wxeXzSMM13u8=
X-Google-Smtp-Source: AGHT+IFzV3E9ELnxtGbCmBQWnZ7WZitC1fEbD87SPeFoF0dH/jgmn/ctLdiRvqDVsDquq+ZJZCaGGg==
X-Received: by 2002:a05:600c:1e86:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-477b9de50e0mr24594115e9.15.1763633342791;
        Thu, 20 Nov 2025 02:09:02 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm58914125e9.8.2025.11.20.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:09:02 -0800 (PST)
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
Subject: [PATCH v2 3/3] wifi: iwlwifi: nvm: replace use of system_wq with system_percpu_wq
Date: Thu, 20 Nov 2025 11:08:50 +0100
Message-ID: <20251120100850.66192-4-marco.crivellari@suse.com>
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


