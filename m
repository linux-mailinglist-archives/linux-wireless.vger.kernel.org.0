Return-Path: <linux-wireless+bounces-33491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIJgBd40vGl3uwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:39:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1B2D021D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E04E730157CB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14504390C99;
	Thu, 19 Mar 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqC2SY0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE53921E9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941916; cv=none; b=UA9AgsHE+lxFtVk9vsq3aGY8CoRoLreeyvp2AXpX3HUI7zmt6fAAc1WcjN8iWgyXLSfzQobyY2V+L5mxIokxjdEBqRGmHNaux/Vs4fi/yEBHCYHF3bpK/cn5H0jAMc4GVYAjydmVJUevNy2m4As8ljyOJxYVQY4A+NI0T9dcAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941916; c=relaxed/simple;
	bh=2f0B5s4msXlutCGEOQQSJUjLfo8gH8sXF1l5QUPFRQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYEBW45siBoZdB/UxmsgklY7VnCIw+bRusV917/OOPrla99UKQjmV9Xc3eNpW+4+yUYLteS41kOBRFEaT/3FuHYuYv1/IZ0Mr3zTasDRvMKs65P8esCRFeU24dQX4Wvd0SlXkzyO9rs/yId6ad1WsPTFpUH5KdL3YOQnlKrN+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqC2SY0f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso5312845e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773941907; x=1774546707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgI+DPXRdVpg4D5i41rr1oHdTnMWXpCcs29SAk0XxJ8=;
        b=EqC2SY0f7DFTR9RzmSyLjfgR7YjYBWYFt716fZsTRCTC/Rr+6e1mCmvRwBAvJrMNjm
         WJxIP0jWCBWeFkbAjJtc5KLGuEQM5QD4Yzg1P5zWOrLV+0flM91CsLf7lAuE6ayN4Q21
         F1Y0VsX+MpcqJIn0hjsn5YOK/xu32CdWA9cY24ySlUMYyDpiyBGcDgQq7P5uxueKgXIn
         hojpduGsP6DkZ3ZX07BXmg+Oy10HtX+np1Zergb7qDVVa9IoO46eHIIJgH3ytQ3X1znd
         R0mnESIyR4NUocPD5dPDznXiy7O/7sa3L47N+bfL7s8ZBkIzC2BtMfebkqwd6QZMJU/q
         Vo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941907; x=1774546707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgI+DPXRdVpg4D5i41rr1oHdTnMWXpCcs29SAk0XxJ8=;
        b=GL4DZt+w4HRs1NpTprjC31CzfLGgjPFz5DFbjIasM39cFl+SGyjwM6hK94jQGvTMTM
         BEOX+Yu83uwT2lkZzNq50U1ACGIRAYpWTsZoc0IcjNGpNvrLLnP9C7y8f0RPDZeeKG9D
         ENLLsL0crzK7iA09VXTRXXSV+iOsW80uNkmp+gBlO50DcoDkNk59R8+UeJmLznQhZ8s5
         p7m8Ou8oWHnagmrl0em9v+nqPyYny7XQJEFyCZ9XwmKIaEEMlUYZmr/IXLsyzsoLuOiZ
         Wg5U3bViXWVMGAp/4K4+kg8b7924UX01D7mEdwUHIQlpiQPfC9u7KeZOh3PxAI+0g441
         FQHw==
X-Gm-Message-State: AOJu0YxCWmSL+cT3hoATVItYA+TR3WmNhQ3X3ghLqcvSC+5T1AYeJR6w
	ifijcTrVK42HxEsXMIUsbXI1IU9BEcJ2EChd8MsnCGhgaY6pMsf35zk6
X-Gm-Gg: ATEYQzxc/PzhDaULTNYN/u0OBiY+BHzzsFCQwnPo85Kp6HG4OX/hQd1eR3VO03KlG/k
	kqTRm4olLVpDUzEtEvAze+jMALcaIW85h5nerXJ7cL6sdn7ZpJmCz6KMMPp41xhymKPrxTnZDC4
	8omBqjNn/dKWWQnPaN3ANnXf1U0TxM0bjdYLkOZFCrRuYOP0En6geGot/a3+29sREjL+5RBsJil
	0SioKNd5pJjIaJZ7GZt5gRHFi6hawFE00eXCrdKbvlUTsKMdC7ylW3tJInSCDYDjxjLIvXbkr2b
	SFIN9byvTAMFg0IQRUWVW/D+y9hm/j8cXN3TVe5q/y5sRlOflQOna5OSp0R6chH8RWViM+wNEvY
	mo4BYOh1NNXWYHO4qrWrgBmxN0W4Xk7cPpO8Z9lh6Wc2Edm4ONUcyV+fY4M4aEdCi9bw67SUufO
	MfE7wt32uHO8yABinholz97aEKStpbV/++rg==
X-Received: by 2002:a05:600c:3b14:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-486f445e260mr132200275e9.24.1773941906846;
        Thu, 19 Mar 2026 10:38:26 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm10784775e9.0.2026.03.19.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:38:26 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v6] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Thu, 19 Mar 2026 18:38:21 +0100
Message-ID: <20260319173821.15470-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33491-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6B1B2D021D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Balanced distribution: skip CPU0 for high-rate RSS queues to avoid contention with system housekeeping. Use a stateful last_cpu approach to ensure unique core assignment when skipping CPU0. This avoids mapping multiple queues to the same core.

Addressing kbuild robot warning: remove unused 'offset' variable.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d76fe0..1d0dcf0bc7686 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1672,18 +1672,28 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 				      struct iwl_trans_info *info)
 {
 #if defined(CONFIG_SMP)
-	int iter_rx_q, i, ret, cpu, offset;
+	int iter_rx_q, i, ret, cpu, last_cpu;
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

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.47.3


