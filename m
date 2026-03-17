Return-Path: <linux-wireless+bounces-33357-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKmnGHCsuWmEMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33357-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 20:33:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013842B1906
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28E5D304C6B7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8119342177;
	Tue, 17 Mar 2026 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htr6A8BA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8A6FC5
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775980; cv=none; b=OaI7GAI6SkDglMPpOBZFL52/pwnSQMuw6fsh8qocBBP6GjPU/PQnAVbW5TuTaIdThOLGhyjPKuZ413DCWXRi0oRBOwvcfawQvfVWUfjFnFepwQ/JzLRs0JrvhlxrbUQr+JULGGZzYW3YVTJfc3hYSDe+sJDMXu/UdpsKTt5Uy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775980; c=relaxed/simple;
	bh=Y03vGyVCBAtPVlna8V71PmC7Nl5f2N5vBGNLBRMDENA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F73ZODv0iZY/HrESdSfr/jAtKri08l5aev5z8TqBfplCzRptgXbwG51yYGV/45rFdDG124bB5nDgcqdVDunhwgbVJMRa4LclNpCqg8qeLYzUmJkaQdKnaTKi2cEFBYLuzYB1G3lmt1RfGAbY1vNVNbnlqR+CA9+h8A2C9t1kuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htr6A8BA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539d21b76so44832485e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773775978; x=1774380778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9zHDceEGqX/hCL8Yub/QA83i/kbyW92V/RZjWRsucc=;
        b=htr6A8BAzhxrQnYRAxCSbYE6al34EXWQKDVKmJkgRdX1OghsoDsy/40ofARfwT0tAK
         P36fPeNtbb1+7HA73AyL1mI1qgAQL4IhOLDyIuJfU052dr8Z73nq8VMWcKvXSzeaziFg
         6YvtTyVmaMzeOixUI3bJtjl9qrEr2x/GQaQ1Fn1nd0my/LeGlhtKFhW+2ji2bZUDvcZc
         6wVRD0Eg5qEg+eIYL4fhMFyf6US3VB5fTGo0xMzz71ju3P9iBgyE5yA0dbPggb2R2iOX
         OxnmkpbZJT9SKRtjOJf+rli2qbN7GWQJoJsy7mYceTw4GoXrgdla7El3JA81jeu/8FjA
         6IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773775978; x=1774380778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9zHDceEGqX/hCL8Yub/QA83i/kbyW92V/RZjWRsucc=;
        b=gT6xHqZzqOV6SKliLxXti4nspC/v2NdXDfol8srLpEqfVtHzkbqQRzhUPJThm4+xV3
         2FbVXUaru2tYHHMU4DOPhavSHZHQRuAcS5slYOBsAYwV/qrT8OzRAO2O1UG6kbzTcXaB
         2lLXq+MxaZbtdxf/NcgKNzyt162Eq4Z00ts/03s86JdOznukLQnCp3YVNWYw6kIABJnx
         aC99Wu2PNA9WuBkby6WGKltl4vSx4rORDhWqL1u0+Mr2kPPVLpIZ45wBTZQTY6X+eCta
         /bI3afeVhwD5/a6HEj59Er/q3vJdGVNSza806WEtxlTjhKJDvAyAqPQbX6YcBa6gSwwO
         mEZQ==
X-Gm-Message-State: AOJu0Yw9NCNmxUcx4hzDWpm9HZ2Bio/oBGCJPEhi6FmUHxE9Dx/yefI+
	NZycQtg+54CYsQrgZron9J2yQ5xnEdnmC8r9vlwyTLAO9L3zFePWN5tw
X-Gm-Gg: ATEYQzyx04ZK+EuZzUKlCpWvXPt7PGCSKwCSeXQocgx6gnscNi/VSHkm52bWfR3X1sw
	AxebXnqnjLFF8Jj3CfzTE96b/vC8wzVw9kGfyhE65LRJehc8bfqPef2u4FTIHPs8RiDAPlltYiB
	3My6jjq34LzJ7yyLcPrklt3HZ5Cf5SZVhEQO32BYGj8Jri0aFCcts7R7eh0ucGkU2X7nwG+Sf3z
	h4flWbPhQ2SKtNtdZ2fzNCf9sajbCsIufHX21MkX52eueS0U7tB1yOcr5g4sri7lUOXvFLO7Hcn
	DFhXsCITAxzfYEodvjkv0f0GAXTeHz0J4tURgiv8LR5d8lzNOh6/rrL8CA8wEJ6Qt+jPkLHpscQ
	s2o3miLyKsqNDnHym9Vw5n32Zfh62aCwBBYNpTWLuAgH2dNLaMBb8yNCzzfMZnMZ5B7wZFqdIBD
	tZwIOu/NatGXqcXle9Cbu6l838NXtFSokImQ==
X-Received: by 2002:a05:600c:c163:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-486f441b801mr15203365e9.4.1773775977745;
        Tue, 17 Mar 2026 12:32:57 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f420d7b5sm21977775e9.2.2026.03.17.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:32:56 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v4] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Tue, 17 Mar 2026 20:32:52 +0100
Message-ID: <20260317193252.13763-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33357-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 013842B1906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Balanced distribution: skip CPU0 for high-rate RSS queues to avoid contention with system housekeeping. Use a stateful last_cpu approach to ensure unique core assignment when skipping CPU0. This avoids mapping multiple queues to the same core.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d7..7077ec015 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1672,18 +1672,28 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 				      struct iwl_trans_info *info)
 {
 #if defined(CONFIG_SMP)
-	int iter_rx_q, i, ret, cpu, offset;
+	int iter_rx_q, i, ret, cpu, offset, last_cpu;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	i = trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 0 : 1;
 	iter_rx_q = info->num_rxqs - 1 + i;
-	offset = 1 + i;
+	last_cpu = -1;
 	for (; i < iter_rx_q ; i++) {
 		/*
-		 * Get the cpu prior to the place to search
-		 * (i.e. return will be > i - 1).
+		 * Balanced distribution: skip CPU0 for high-rate RSS queues
+		 * to avoid contention with system housekeeping.
 		 */
-		cpu = cpumask_next(i - offset, cpu_online_mask);
+		cpu = cpumask_next(last_cpu, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(cpu_online_mask);
+
+		if (cpu == 0 && num_online_cpus() > 1) {
+			cpu = cpumask_next(0, cpu_online_mask);
+			if (cpu >= nr_cpu_ids)
+				cpu = cpumask_first(cpu_online_mask);
+		}
+		last_cpu = cpu;
+
 		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
 		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
 					    &trans_pcie->affinity_mask[i]);
-- 
2.47.3


