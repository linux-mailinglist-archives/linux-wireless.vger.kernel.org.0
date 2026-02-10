Return-Path: <linux-wireless+bounces-31700-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N9hEfdBi2mfRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31700-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:34:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42311BF06
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD823024979
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06526F288;
	Tue, 10 Feb 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WgpwO9fu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F122B8AB
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734040; cv=none; b=liWZN8DmLZoms7AkXdm0klhODf3+jnzFKg6+XlGNuVjg4/qAABvhZfXgfmv6DdiUQllf9LMIEKmAqvpoo9dMwg2t3Q6yR0WZNeENtsNIAapw/sF+8/VwKapOKd7TRk+9DvvtzjiIIOSpYAvA0GeHuhy2os9YknRHwS3kZAqRA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734040; c=relaxed/simple;
	bh=nIIEsPTauyFVWtnOFk2aqKgis+M/T1iS/tVHAiy2bTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIoQ8fOOYFHH4LM2pHhxUPlbFxCq8Pn2w9DJr7B7p+8pp/rL9Q5nQrw2VapE1oRZpgIqNVoqDIueHApSPkIw3KUayjGKitDic9q9Q7mh9nK/2ySG6JhVoxwxys6trDWVoeM7ZU1xNekifrvxOu//PZy7UgPu3rxFWm9rH6nJCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WgpwO9fu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4362197d174so626347f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770734038; x=1771338838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pis0fcDLAyPGpTQVut9vY+Trt4oqVjrVCWf5NczeZ4E=;
        b=WgpwO9fuX2NWuOb8WbnQuHQrTjQzLIhf/LnntZu0g8id/4/kYMkE9nZF6TAAOajp9L
         cFQ1nYKXRwsm1JSKvr86/uS6Cq0hqpbsBQwLFXnRy4GNboj2JNLOAwqH0pAGMLdk39wr
         ApIrowDMrmtnQCikeIM1NDJSxbllHEmrHKERfKBgxYsJbLmady0hdpiPlv+XH5kpCUs1
         /MJmq8MzkZkI2MQghKTpFN3++zTWY5jzlNAcBonYFuiANdzi50G6yhgqWE+6jWPrRBCM
         rSOr3q9oucdI5G6mpTza+0v5+1hUn8RBLjCtjPzrz7xt0A524hS7CUOirF1F+mZ66vDs
         WDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734038; x=1771338838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pis0fcDLAyPGpTQVut9vY+Trt4oqVjrVCWf5NczeZ4E=;
        b=DBVb9eowCTBmMsVkV0NT5iImHJcXmMR5yri4yodBxqVY/e0tMgn0RAPuzeGc27h0cO
         tcdQU9kKsd4YI3/zz5yowri181Ns3N6e4WQWVwesh9r2JChcavB4eEQYJ8vexbFjP4W8
         04/4j+pCc/jeK4/Cks55Gkh2OxsZeMCZEj2l4A0zSTshdcOxbXsGAuYd8i9EqYaZYE+9
         tmdWSDenbd7kS4jJCq417zVmAsrWgPBJMycodyHUBD8k4/xALbLQZai588eA6MnIAT5Q
         F+Tz1hQiPE8o7PdwnkiuB4s9Lbehnxpv5iTXUi7j1pacoryFU5DgsEw7yl9QzHPsVj4S
         SxmA==
X-Forwarded-Encrypted: i=1; AJvYcCUpTmdjWyMeE6WnQrUGgmfdI6XOpYBCGMUYl7ikuKVcpn+GggNk2krYnQ0Bk2Y2SUPjl0VxwzuYd4RIKXgXRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJL5cO77piRYdcacTfxjcOtYP6nQZ0EYywYyalz3zaMBbEoOL
	CadfegCCKobSQRAkStdTfwOA4H6lRPCbKOro7u9WclI0gP/+A9zcEDxwkdL4aT+0bPw=
X-Gm-Gg: AZuq6aKllUk9SRQLlZnckJaQLkxPlYPCyOox/X6ib2S35AZh8sCyvUn+fnVwQ24XsZ0
	TsNMrhaCO9nj0UEHQrO4kUpyYHceKgaQiNOa/UKOkx5XEJpowqfWYJAvtSa0aJsdAUWZpEwlhgz
	ki0XoHjpiHZ3oaHzIz68/o7XKQlRjyEXwGSrbGa8asKks4wQx/BAc8FCKeRdiI6usm8TOMGAmvz
	JPgITUP5kkPrT233gFtexD0cYN2q8jXh+SNg7vroQZGcho2BBhKRPDaHNO1OV144aqsNqME3Yg0
	DlyShyHm++4lPGswZNj3GwUGEIy5XeESibXxLftJ+Bjr1NQdWl+ceeEK6pB8tJ3ou02EXzGKVdh
	hQH8RoRwwtcQVO2CfHSCHTvFC2fN5g6WUWLfmpedKg5ETtCKAKzsR/SjOIujTDMKcMdBBvrm20h
	usnPi4iH8IJG7Tv6c4CeC6BGF1
X-Received: by 2002:a5d:64e9:0:b0:436:1d80:b663 with SMTP id ffacd0b85a97d-4362938578bmr22844040f8f.58.1770734037519;
        Tue, 10 Feb 2026 06:33:57 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm18265323f8f.14.2026.02.10.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:33:50 -0800 (PST)
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
Subject: [PATCH v3 1/3] wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
Date: Tue, 10 Feb 2026 15:33:30 +0100
Message-ID: <20260210143332.206146-2-marco.crivellari@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31700-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB42311BF06
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
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a552669db6e2..2f24b639c133 100644
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
2.52.0


