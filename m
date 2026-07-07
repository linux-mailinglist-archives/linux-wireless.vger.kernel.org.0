Return-Path: <linux-wireless+bounces-38746-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +oFwMUbVTGoiqgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38746-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 12:30:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8E71A63A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 12:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="VPTrz/up";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38746-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38746-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB4C930BB6E0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAA3E0C47;
	Tue,  7 Jul 2026 10:23:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF333E44F6
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 10:23:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419791; cv=none; b=PT9WX3zJCA0UV/GVsEZX15FHe5WeZWAXM5IknqXaH19Ij7w3Mz8lDnBEtEy08vBUS4NAy0Tjmydn5f57bA3RDIC/PJOiL+1uMZV4o89914D+LnaYMtwkOCWpP9OnRzdbsvb9hLBSiEQGklL6Y6Y3+jRqAJJnFlfvUT51ud661eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419791; c=relaxed/simple;
	bh=xHQwsR28DCaUl6xwb13l8RdKLkVzlcxiX7hu/6kuc+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsvq3cO+7/8ihxE0CSzjKuRJAfEgxjyWwjnCPyh4fSJns+uJ5lg+zQOwWOP2ga6U2ele19DUbrKH8NHIxQPewCLZecSJra7eOmhvjJMUEN5dIzMn3WLYCxG4OtuSkvy4cY9kQBXBH9h4ShGVJSViYyxqVtPFAQ/02BS3vCtAJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VPTrz/up; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b1710405so25351795e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783419788; x=1784024588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/lA36J/bQLDfutFSE5oIizTeSmltDoXhBB9tDrM1e4=;
        b=VPTrz/upXvZORs/XZkAtXEHTYtM34LvANez+5MQJEtDEBTEFBpHhRzV3ht6LsstBSO
         c64Y1PSA73N4GRoJ9aVzW6gQ1YsFTIvRfpnzwbZ7b8Z/56kaPRH66K1CnnWjH0HRHuFL
         t8JQwnBI2ehwlnu6xVsh5KYPa3qXzFubd/MMAJtqcaB1TWE9meLETLxvS7UdXvDdDnP5
         w7PiNCzc/v6D0rULv07lbn+0I13HaFY2/NPVu0ThPuEA7BBGHKcHoZ66dePEZb904IG2
         jhAa9vjg5CL0Ms5D0bGtKFSDw7gHts+RdfVIf+iqUupofy6YRca43bRy97h+cOLJY9XO
         7YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419788; x=1784024588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/lA36J/bQLDfutFSE5oIizTeSmltDoXhBB9tDrM1e4=;
        b=LtfaR26RJz61f6Y1Owio61F2O10I28XVcbe6k8U+s0V9U7f5g+NTL9FQSb4V5+zrpP
         E2yLaqbexIRXz82vAfq6DKwZUg3W0ZlhisjKruCLKTmIGcbdldATnM/vmUgazEG+XeiY
         /HeApi7ihBiAlwXnRDXL2lU+J5rPAEE2ksWgjJOMc5+7U+14xF86PfcUNnHpaIPmEUpg
         LA3xHFNPjWLMbEaua428wL7/rzfUwqPwT9R1sYJlQB3wFu6PMcu/pUBM/kSQmQ2JlXA0
         LfIwuJRAZKxw2llWYtwWyIM91Y37sjnzo/SmW50Qsomo0/lqj/G/g9yztCVolRYNd4Ns
         NXAg==
X-Forwarded-Encrypted: i=1; AHgh+RoOdQW7pfMZYRYcwsW4MO26/xIjUPYXjp3SIeNQcM8pJkyLrIqYmp2aC7kEpQXMlzMW9hjpaP6LCL2Ws+5q9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRaiF/08K1gxz3tKQ4v+QK6jGeZr0ap8rsxKofskSlDb9TjXtj
	FQF1a3ooQkrZOeQ1NRdnIcN7A8vitCqYEdRgeRGh2Iu/3n+H+E863KEHWRLPRPI2FKA=
X-Gm-Gg: AfdE7ckNjgeKJsfPnibYe26UuXxdmilrmZAFvgb08JUPkKrc7Sdd8evujvhLjTwmjkl
	uDu6Q4pHxdVI//Q0DCPb5um2XdTT4gvjSiNcYpBIi09u2izhiXdUBTtWh5CUDMqsbcCmUDjLzAl
	lDEEGuORN3NEJ+ngmb3Jr9HNLQmJifby2ks4dvFEmeGm48Q2q56rurmu9JE6q0apPIEM2LyxchY
	LF3MFuZrdQTfKHHKlUDZrIWl+6AUr/4bejwL+EdpPD/Rj+5WPdoLCPp9Yw7wjN1qPOYgg5tw7Jg
	xfltHB9o59LfzfdE8wydsbVodziLCUHR3s+7rzV3S0T3pO6JfRamJKH4Dtr3OrbOPTJufSzx7pt
	Ra5j2bv23rLXc349jWbdNbtHv8p3JKqt1cXaF//RzN0qhkV9QEe00A8RjtZ+AAwQSqmCoNGbCbo
	HFdZWTtlMOIlccYOnISfPcDbjBwAIKqdZquYlD
X-Received: by 2002:a05:600c:e549:10b0:493:cbdc:7cd6 with SMTP id 5b1f17b1804b1-493df0b6aa6mr34447565e9.7.1783419788379;
        Tue, 07 Jul 2026 03:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f439fesm47344285e9.8.2026.07.07.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:23:08 -0700 (PDT)
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
Subject: [PATCH iwlwifi-next] wifi: iwlwifi: transport: Change system_unbound_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 12:23:01 +0200
Message-ID: <20260707102301.148845-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38746-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,intel.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:marco.crivellari@suse.com,m:mhocko@suse.com,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F8E71A63A

system_wq (per-CPU) and system_unbound_wq (unbound) are the older
workqueue name, replaced by system_{percpu|dfl}_wq.
The new workqueues have been introduced by:

  128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

Usage of older workqueues will now trigger a pr_warn_once() because they are
marked as deprecated as per commit:

  64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}_wq is used")

So change the used workqueue with the newer, keeping the same behavior.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 73aae1125042..9343b6230e1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -236,7 +236,7 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 	mode = iwl_trans_determine_restart_mode(trans);
 	if (mode == IWL_RESET_MODE_BACKOFF) {
 		IWL_ERR(trans, "Too many device errors - delay next reset\n");
-		queue_delayed_work(system_unbound_wq, &trans->restart.wk,
+		queue_delayed_work(system_dfl_wq, &trans->restart.wk,
 				   IWL_TRANS_RESET_DELAY);
 		return;
 	}
-- 
2.54.0


