Return-Path: <linux-wireless+bounces-31702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMKoLxxCi2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:35:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD811BF1C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCCBA3063759
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797ED3806C5;
	Tue, 10 Feb 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TS7onxQh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992D37FF69
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734042; cv=none; b=nt8FAT9znbSOyu94XA/zZ9+gd+MYM5epkbzlpCrYdKqQ9KyDCz42BD4thcI8Ak5+gbOZ+VPOdxJ2gjQuCTz3Mx6PXZyYpjTeop/hAgtYACeTbhDjZ33zP2J2to0Trx7MzIkrhVLTTdD5/+XgucG57inqG4tMaoTG28jVII/+CQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734042; c=relaxed/simple;
	bh=oVuH5Ql/WxNQ4kFSCzjsMlgfORIIPZkOqPjx7D+6+88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prh+zM9Un9gGhNrzl2jJXAMxvbwrGAUQiBEeHoTJUdJIl5VQiQTWRinXM+6UUH9VC8KfVnGEdYa+k8Ozj27Fv5lFsl678QvgTMink47tvSjBaT7bj0sOXgrgwd2uz+/opOWc1f6rklgB0rh0L8J5oj6C0MM0V8KDerHbfS0pwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TS7onxQh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801bc32725so31945475e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770734039; x=1771338839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZucUQndu/p6rPTTHz/msQccYgtmt2/K9BAyl4/uUXJM=;
        b=TS7onxQh3hN9fma8A9zuUnmLcE0mP073DfuqqqGBqmbUWkP9U8oOVGffBwAfqYnUVH
         mn+J80VY7xP1UVv1yOQwW1Eiv1GXeVhYSLSnyuMGIcYbu7eILs54ve73GXhkkniDkJWv
         Q1MMk6Rpz2ddw20vy24jkEqbPLUivCsqBClKzgFFsvRc2Ap3ZqaWzH8npk5/ahZS8KNZ
         Rh/vFu6eSaMjRtbwd+q1o440hp8HCyuTVsjNWcgIYDqZjnEjCUerPrpDI0g3rAhwguJE
         9qmFRc6pggdbpXpCQy3ObFnrAECE3I+40D1S/wyJMqiMCnACXJ1QaqMNHGEsD5Jmb6AS
         QXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734039; x=1771338839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZucUQndu/p6rPTTHz/msQccYgtmt2/K9BAyl4/uUXJM=;
        b=TeDYoYvor8cIpd/h0Y99P/KB4q826NX90B4V015QWjGDT7cMO/mdjHO2xK9l7+LcQI
         bqSvCahvXnN5pxI/AzIZ4x15SDevrh0uX04xCLIJaXkPw68VlVYLfd6PMoBALKAUYRty
         nFDH/pgdsXt3TzKAR9+PYgPpEYloxnvINHf1zzcs9yEdx7+choaz4vKPIz89nnWboOEy
         0bBT3jIDHfimoRcTK8w9Y0Sv/UqBxBI68dIxGhPZZidjFnOCuS/OVldZRmEU5dapnk4k
         n/unfz9WKQTubqkLJcWMQdln0QyQ5Oi8aXPJecm8ic/nyoJ4es6v7YjgENh1W4iUtNxN
         LYlg==
X-Forwarded-Encrypted: i=1; AJvYcCUst4vsHeaYYXOPWlix8dw4V8UTUa83TYUcOAd1gTX+DJT4k5sBoq1CHZh50l+UpldXpMUOm6jkj3/v11VXOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySuqwr/M+HktfJgV6NC0y8+WWhBldlF2AqhVFVwXdIn25Tqmcl
	0HBt6ilISL2vmMelVtXd7TwAjQCR1XtL5bUp+ZQTwB+uFvEAZf6cxFv6xLZ6OHntY40=
X-Gm-Gg: AZuq6aK6iTs2DK31eZ+xckjfnA0U9S1wkzd0PXtSEQShFx1/IKqAfF0hex1VrzNxKmA
	soi7w1RfyDSaHPJKZxmJosEQOwyrEKmJYcv9Bn7IpR5Sn819pNyksvwmYuQttimXzIc6HcmQStA
	hqJ2QceOo3NpA/B1zNKo+UaXsHY0Ool5fL2+KhYNskWu3okPfCsSAsyj2YQG/lsSUItWZssSqbe
	xTzl0Kdt+oUeaxdjhCu9qGo1Jvt+0jH3gBdy7Mk0mGe4r8C0AQjHL6E0wnEE33K/HMoJTBwaig2
	HxEFWAiBLd2OpXXTUnyhPJHI3ayjrNVSymiUi6OyFfmdtirZfA7MFEYCbWg8PhycZrY5ugVwbHA
	QFIv8tlpdGBVPCl7APlbc44sWHJSv7wHQrKgVhWKXAE1tKY6jdoYMzvPYt+aTOtGRYxGS4wgQoy
	x9WX2FxqN36b1s0Z8NLc9iqYTy
X-Received: by 2002:a05:600c:5253:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-4832021cdcamr203766685e9.30.1770734039244;
        Tue, 10 Feb 2026 06:33:59 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm18265323f8f.14.2026.02.10.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:33:58 -0800 (PST)
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
Subject: [PATCH v3 3/3] wifi: iwlwifi: mvm: replace use of system_wq with system_percpu_wq
Date: Tue, 10 Feb 2026 15:33:32 +0100
Message-ID: <20260210143332.206146-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210143332.206146-1-marco.crivellari@suse.com>
References: <20260210143332.206146-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31702-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com,sipsolutions.net];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20AD811BF1C
X-Rspamd-Action: no action

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
2.52.0


