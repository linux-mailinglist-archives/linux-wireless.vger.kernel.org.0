Return-Path: <linux-wireless+bounces-31701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO8+AgtCi2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:34:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571D11BF14
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34327305CA91
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21193803E3;
	Tue, 10 Feb 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LT3W4/rl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD236B05B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734041; cv=none; b=Fo9pKXOwowpUBZPXm0DN85Ax9UrtxFqKJ9WtcEigq/y7g7w13RxQDlao4r2br6lZMz1EjHNHtvUaPADGYi8TCjXGtzWEgjWLaRUKYEG3dN9r4ENcoSgRUDlcnWHNgNPu3vZUKvPjTP/bZrAUYazCpjnl8q/OChMkFF8MXBxtkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734041; c=relaxed/simple;
	bh=Wlm8oyIRqWO6b8b5AG7aC9bFYh24ep+yd+J5r7l0ZuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbnsaxlYlzD9oA+6RKlcZYve94A8ulwIOjF0fKhFLwSYGMcO4KK4QE2dDR+d/ujH7LRchabxOJgaxzeFa9KAcvgF1YGXcHOidbpc8rm3cA19oJxLee2pqOU/GvsqcMqGDeSCmjzsYHh49Y1mAQdS/HD2c9RwBfINmAXF1b9M3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LT3W4/rl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43770c94dfaso973171f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770734039; x=1771338839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iStm+JloDf5Hvq/3VIp9y1mrTCpbEIULugoCNyu96NE=;
        b=LT3W4/rlYWqfJCxcRZjTI9dwKMAC2+dW8NWEqXad0GlknzSHtehmeYmFPDm+gFRZq6
         ZlsU4+FkQMsBJvHj83VOIRZ5wpU42zUSs6hvd12mWWjJxUsVWF/wRlFP6ryFd4NsJZLX
         DaSa8Gbvin08WBEgVRueB7vnbvOKBj6AWMSpbKQs696bsZ5Us0eCse8+rRXcCbDH+amT
         mh1gIbxxl29TNVCxqPd0SVQAlb0WceNozP7V54VHuU3uOiI1csQ+k0mTjXXEK5Ghpj6Q
         vnvKjtBFSODp4rZM11q0Fpx1ajNVUCSNO85Ifp1pOCBujSeO+UNfXcQ0tDJqytPypF9D
         pyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734039; x=1771338839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iStm+JloDf5Hvq/3VIp9y1mrTCpbEIULugoCNyu96NE=;
        b=mxlGkwLtXNbjfckXDISmgoTz2H4j98tmeGbG2DiDIyOON6rzE1zLYky3tdhy3CLiB5
         lmtf72TLTx9McckYpT/klkpDgeTaNMtdST9qncWcpvrm9N3ZQPnChsUYTwS19Qs+Cwoa
         VlbGegP44RC1k8FfbOOXxLIqrJXWoQjDqNNTo0/vVinYYv9I+F/7M9brK73jH2aVAqsq
         x1H0ngiakiPUcKIaAR1hNqrcX/hUKbtstkOq+IYKx80CRV+ITNgDYJADhTxmcDefwhik
         vOVcSNZFqQoEx47SNjXIznqPTh9uCrDHXab5WlsClvDb1oUqjoDBymsCquk4kgr778N3
         uIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhx/AfCiXJpYbKHHBzj6MuvuuXyTtAZ2+LmDIO8b6bNayjXV3YTaAUCHDd5T+UdIXR7SiJ5fsGrxtUHayaGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfd2BQ6xqqDsktm+lgqiV1RwCM1MlNAr7dsOUVliAIzLQvVmq
	2JOa/H6dJ6TswtS5HkYOy/WSsVKREllnnMWZy7pLaI7+Re1u+sw56xJtDfBNzZG0BuA=
X-Gm-Gg: AZuq6aIjuwfpJ1w43pzbdWkNOtctqjs8OuyKWCuIbQwbFv3u6Rq0CJMmT9eeHARyUSZ
	BP5AdWFtFbblYpAll0uRRsUStejGRQYGB6n9/end8ILQfXIgrT77nNoB1apLnrbNsEw1l3V0s3z
	DQ9mf6jjc1kV5JkxqxJFDaLwfLsdsSApb9D/gZ7ypsM35v9yMEn6dY1QYuuWmMNobjqsAQgJvU5
	sBdPum5UnipOot1iTRtODZQNrIGYXu3zzkdVAcME/X+QetggdjgMxdyn5ULrmMn6IBzAkSI0LJ2
	U0JgKp4BloMaHFJ7j9UsBd2kRUb13h52U637fxgiwUiZ4Svypn7pMOy903I0NEHok3jf9dLp9oS
	uWsywue41+fRkgHJCPbDE1kMS3s13oquB1Sg36oilWMZi0Zhh/3MzIrqz8Fl45jKy5VWODTD1Hc
	XmjWLHSOPnq6iBI70wvNaFxt8J
X-Received: by 2002:a05:6000:2210:b0:435:dbc4:3af0 with SMTP id ffacd0b85a97d-43629340a63mr21854240f8f.14.1770734038406;
        Tue, 10 Feb 2026 06:33:58 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm18265323f8f.14.2026.02.10.06.33.57
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
Subject: [PATCH v3 2/3] wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
Date: Tue, 10 Feb 2026 15:33:31 +0100
Message-ID: <20260210143332.206146-3-marco.crivellari@suse.com>
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
	TAGGED_FROM(0.00)[bounces-31701-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 6571D11BF14
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
2.52.0


