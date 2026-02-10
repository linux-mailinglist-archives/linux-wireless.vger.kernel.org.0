Return-Path: <linux-wireless+bounces-31699-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDpQD9NBi2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31699-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:33:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162911BEF7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CEA23013D5B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD92DECA8;
	Tue, 10 Feb 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xsrlyv/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA22B8AB
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734032; cv=none; b=Z8ZBlqXT7B4Iz/+Cg2olZx7VxRJMCeE/biWyWFkToG1f33yqBMu3CVk3Y6ktzhRegCSqSGgRNZOkfIqPLFMI1IRpdRPL/4LUpxLO9+F6A91+lxsF4gw7fo25mM5sjPfCYOp2V2qSX76QLyaocIQjvUtkBOAE7bPWXt9Uj7qYW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734032; c=relaxed/simple;
	bh=wcCQQZgfUf8/LYbgv3mZy6Plfj0gLATysGwplnqs62k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC7trXPuk1J8JwKQnavdfYciB1HAAMOq85gJS/PVlAjqrzyecCyxn3qsTDexYQYLzPpoKchsx5f4eHsEIHl7xSQlEwraRqFIk7a7eZfDXAc3aDLtmWt8iaLZUt04FaRI5jXy/UNfTl+dPGvbFIF0hw4+Hy5ufx/hvXFKm+LlOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xsrlyv/J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436309f1ad7so2743355f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770734029; x=1771338829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kplIjn4dF3J0IHV7D4b8N2dtG1YTdjm/lTb/P7a40E=;
        b=Xsrlyv/JtjQC6ikeZkmjx6tCjyJ/QZ+/E1FPDpYPAQjlH33sbpcRh0CLxyxg/I5Xsw
         LP9lTKv/8mM0jcT7v4hYByWBU71WaCX7N5+6HaT52YGjFn13I43k3MJq18KvM6aht7G+
         88MbmgaxMHzk+75/cUJObwGjiRmVZxm5hqPN3mp7LAhZdtUpPX9bqJMUf8enq2hpSWKe
         s4KzYGPhd8IYaC22/P09My+HejuedDxQD6UCCZovatBAVCy6MnOMedlTwUL41RUnnBmq
         QGbrmhyOZHlHaseojm1Rg7vUCWkTTukleFqOsgf9gvj1K3DJDVYmIPbPUdsReYCi03x7
         ZK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734029; x=1771338829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kplIjn4dF3J0IHV7D4b8N2dtG1YTdjm/lTb/P7a40E=;
        b=SjHFB+Ze/KjhsVROqyMJdqr6pqJK4ve/oZwC9dhuiqSDvCPYVnxhTbgQ6HCFPd3UUU
         rdRq1gt77uzg651+dopgpTLffP9tvXUAOmcxAiCkh5Ga/xja1ci8QCS9TYG3/XJmZpc1
         aTftWL6hwGfsleD7FFEiXimm0Dppd/+AVnt19V6LoWIPT08/60B+avtP38jwAseL7uO0
         CJR65WmWzvq3xNiMx9FkwKRoEh28OD1nKliMaiqvaGe4dpnzts4iDPgKmtgLe+9EUFAr
         rIkaQYJyk2Rlm6hQq4y25Bq9HLwiWWkfHtgvSgnQz4g+pbxIta1v8J1a9AiDoTbFOR7r
         /dhg==
X-Forwarded-Encrypted: i=1; AJvYcCX4u9azVEHxPGdPzHUfKi8Dx6dKVIOoty1xJ8pdDsCt79VJ9zQbYxWkMXpKnErIJZeh/pM0ff9z4vbreiGPAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C2cTj3i3RNB2GSC/WJkMu2l+Fnq+QZraPoAxG28BlchviB/+
	qh1Buf0uKQSL3zOEJzimyqD9uApPIRB5UKjPv9xEqF2b+fPKD6tuRo2f1qkfft2wuB8=
X-Gm-Gg: AZuq6aL4rXQPAOLUBw/Z87NTFy7zNHppdFZbSkn0y6rkENtto1OTY4NoV/5GdHv+QJf
	CO2yTi29OTUWtQEEkrvX4TLB+Pao8RvyLqi+GA/qD/cVrRuPR3KdVlCLdrGovg4qosPSpBkYYdS
	2q4RPdfjXQpJiv8VsK8TpJ+nfkILyTC5GXnr/ngDuhNCTkGqvMYOne5l8AkovLzuHZY8v7zlHpJ
	eqDW370xJSC1SshaijVaVRvPWuHDhQfSFW2Km1omBW2Gr12BM3jETnXWKJPF0dbxpg/9vjMR2TB
	Xdx32O6fMkpUU12btOgYRwNMq6aSKMJZRK4KINmN6xkHf6VYi8i023+22KdtaFWsTBg0GZGBphG
	QXq92qTdZ14Pes4qGEnkF3e5ACn87wtlvWdKOVuPMknjFnhfAUQASQwhBgU21r3XO277y7vyry7
	S+5O8f4bys7OOMxKjKi+C50k6u
X-Received: by 2002:a05:6000:2dca:b0:437:673f:e069 with SMTP id ffacd0b85a97d-437673fe2ecmr14263570f8f.59.1770734029528;
        Tue, 10 Feb 2026 06:33:49 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm18265323f8f.14.2026.02.10.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:33:49 -0800 (PST)
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
Subject: [PATCH v3 0/3] Replace uses of system_wq and system_unbound_wq
Date: Tue, 10 Feb 2026 15:33:29 +0100
Message-ID: <20260210143332.206146-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-31699-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9162911BEF7
X-Rspamd-Action: no action

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2-3]  Replace uses of system_unbound_wq and system_wq

    Switch to using system_dfl_wq and system_percpu_wq  because
    system_unbound_wq and system_wq are going away
    as part of a workqueue restructuring.

    No intended behavior changes:
       system_wq -> system_percpu_wq

Thanks!

---
Changes in v3:
- fix nvm -> mvm in patch 3 subject
- rebased on v6.19

Changes in v2:
- improved commit logs

- P3: wrong commit log was about system_unbound_wq; subject changed with
  system_wq.


Marco Crivellari (3):
  wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: mvm: replace use of system_wq with system_percpu_wq

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.52.0


