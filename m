Return-Path: <linux-wireless+bounces-33513-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLr8AbNhvGmLxwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33513-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:50:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3412D2631
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685A830125E8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5F3F9F49;
	Thu, 19 Mar 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aylqXywE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CE3F8DFC
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953256; cv=none; b=NnflaasoRn1pVw+BPYjA+1TotLYjuljRTai1WyoVsoJRPWKRW2BjYb/w80b0njDPnOUkbci0lyZ5w6PhBxCAYkGkTOlZHsnkHyg4onDBiqc0JETtsteGGW1LEKAFdHmFu+mkI4Qsu1wpkvSNfj8M+89B2IStUsI6aIllznF8hGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953256; c=relaxed/simple;
	bh=bisf0XchOZYoXALYu8CjuqBhG93r4tfWvdbSWvyUWLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hqs3MIdZyWuE5fE3W9nnXSLcuTUUmN42WL5x0PKf366TC63ulwPnoF3r6KIJLyGMNqIJUkeNVKJzbOQYGVqHP5s1WvPZCoIzcJenD4hitaHcqv3Hnl0RXF7T7AzYQ2y2WcEUEv4ZzbDwu/rNTgkZBLOy8QOimF9N6blnVdqPMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aylqXywE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so11473555e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773953254; x=1774558054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPIk/0st22ZS1OzuVSWsQ+rWgA1iBUqCVtU5Rvk+tKU=;
        b=aylqXywEp3Ad13CgT9t+nCzyllJnIILSdYwvfFsCTLyn+znG0oRiWH7gZP0BjfNJM0
         Q4hZPc+UkTDKwSzPF7g/mOQF8cfttW4FvRO9BAUjYP81zMpk8Uu3SvsT+WYjUgyVSsVw
         jsFVhb5uKY7mUvaRO1T4kIMuB4HTbkTb4ASRnLFX3UmrRLxy9PDJpGO64yHdYrbJGz4D
         fKH74mrCI04vn0pyWITo9RqszxiSdkfU0JtPnXn3kPnXoh4pr2HzRQrax2TAg3QS+toX
         LWKN7Xk927LG7Tr3tHctJNJ7DCiJx5vYjjPYyoCqpeDJ3e3FzSLkvNfMT+vLKXyFya0e
         yKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953254; x=1774558054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPIk/0st22ZS1OzuVSWsQ+rWgA1iBUqCVtU5Rvk+tKU=;
        b=Ltqnwl0EXixOw7kCVKMZokNE7SfQ/MQqxmMHo+ogp69KJ3xe+xyvu+6v1Ts9MOaOa8
         WkECEsfo7ZDMJMlzwRqd6bc3zHfBP1K4zguIEPY6/UCpn5j/+qTXxEIRf1YwEdJbzdwC
         36XayV1PJdkPGp4iHkOmsZHhFK9U+28PTNLLmvOW6rEz3ixvRvFQxpTIIE61covgfgXt
         ul7lI7O4YWF4LC/MqN8T0xMjo3wRaqsTAnKRxOYb3ssA24vCRtaMA50Qiy4vhNAnJAco
         nji3geXEynETaUwbzWuIu8xIoW3aW4Nwss8BLAN6y8+VjvmyojMh4yoZicWUaqenPfNG
         v3Jw==
X-Gm-Message-State: AOJu0YyPjhs3G1oq7dkyzbcObpWWWqm2HKInphmJC+kOmGKA4IZdae5N
	nzuwd+QBgnQMnYNTitn1kCvY49xIqJCrtAAebMjlKP2Oxw2SkKiZPcSg
X-Gm-Gg: ATEYQzwblM9pF9KCgzDbJlExociC0kjXQce36LPo9AEYekGMMVf+eHZjww2kzv9T3fA
	QN03kcsS0BxtAsB3FOVtIhj67/6s67fcEnLwqgxsJd/7+zkN5qWHSSDHntP0vUk2ZknFGn06oov
	e/kT89YzU2hnI9AVhiFsWIlXAUIB0m7IaeYoF2MeWmthUPigj3KLvBbYWaaNOdadaTuC0Mlbnew
	EY/86hyM71uYsbvY+VwyQVhV3zIwrnKGrqrTt65cJDpj3htfz6S/wftiG2PdraM3cCzIrrc0aFE
	w5XrHHx2kBQf4Nva3LHS3U4Hx3sXxJ39Rq/Jth4h2kQyxVzu5/ROq3EcZJ1C7pabg7kqAu5Kd17
	osd0uoKajZFPHb4Hg5Jdqgl/eLhJmjHWf88Ok7dY3MGQuNako5CZCiGiFT04Q+RbZ+l0KzX/bu+
	Gf0M8N3ZPe8kdsqMC0yBaM6jNnZ3706+e3qA==
X-Received: by 2002:a05:600c:468b:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-486feb5a4f8mr9663195e9.0.1773953253533;
        Thu, 19 Mar 2026 13:47:33 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b94a83sm87202905e9.10.2026.03.19.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:47:33 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v9 1/2] wifi: iwlwifi: pcie: migrate to modern pci_alloc_irq_vectors API
Date: Thu, 19 Mar 2026 21:47:28 +0100
Message-ID: <20260319204728.24836-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33513-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D3412D2631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The iwlwifi driver currently uses the deprecated pci_enable_msix_range()
API and implements a manual loop for interrupt affinity distribution.
This manual approach is less robust than the kernel's core affinity
management and increases maintenance complexity.

Migrate the driver to the modern pci_alloc_irq_vectors() API. Use the
PCI_IRQ_AFFINITY flag to delegate MSI-X affinity distribution to the
kernel core. Remove the manual iwl_pcie_irq_set_affinity() loop as it
is now redundant.

Additionally, remove the unused 'offset' variable to resolve a
previously reported kbuild warning.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 46 ++++++-------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d76fe0..e4808cfe1caef 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1274,7 +1274,7 @@ void iwl_pcie_synchronize_irqs(struct iwl_trans *trans)
 		int i;
 
 		for (i = 0; i < trans_pcie->alloc_vecs; i++)
-			synchronize_irq(trans_pcie->msix_entries[i].vector);
+			synchronize_irq(pci_irq_vector(trans_pcie->pci_dev, i));
 	} else {
 		synchronize_irq(trans_pcie->pci_dev->irq);
 	}
@@ -1608,18 +1608,20 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 		max_rx_queues = IWL_9000_MAX_RX_HW_QUEUES;
 
 	max_irqs = min_t(u32, num_online_cpus() + 2, max_rx_queues);
-	for (i = 0; i < max_irqs; i++)
-		trans_pcie->msix_entries[i].entry = i;
-
-	num_irqs = pci_enable_msix_range(pdev, trans_pcie->msix_entries,
-					 MSIX_MIN_INTERRUPT_VECTORS,
-					 max_irqs);
+	num_irqs = pci_alloc_irq_vectors(pdev, MSIX_MIN_INTERRUPT_VECTORS,
+					 max_irqs, PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
 	if (num_irqs < 0) {
 		IWL_DEBUG_INFO(trans,
 			       "Failed to enable msi-x mode (ret %d). Moving to msi mode.\n",
 			       num_irqs);
 		goto enable_msi;
 	}
+
+	trans_pcie->msix_enabled = true;
+	trans_pcie->alloc_vecs = num_irqs;
+	for (i = 0; i < num_irqs; i++)
+		trans_pcie->msix_entries[i].entry = i;
+
 	trans_pcie->def_irq = (num_irqs == max_irqs) ? num_irqs - 1 : 0;
 
 	IWL_DEBUG_INFO(trans,
@@ -1671,28 +1673,7 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 				      struct iwl_trans_info *info)
 {
-#if defined(CONFIG_SMP)
-	int iter_rx_q, i, ret, cpu, offset;
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
-	i = trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 0 : 1;
-	iter_rx_q = info->num_rxqs - 1 + i;
-	offset = 1 + i;
-	for (; i < iter_rx_q ; i++) {
-		/*
-		 * Get the cpu prior to the place to search
-		 * (i.e. return will be > i - 1).
-		 */
-		cpu = cpumask_next(i - offset, cpu_online_mask);
-		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
-		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
-					    &trans_pcie->affinity_mask[i]);
-		if (ret)
-			IWL_ERR(trans_pcie->trans,
-				"Failed to set affinity mask for IRQ %d\n",
-				trans_pcie->msix_entries[i].vector);
-	}
-#endif
+	/* Handled by PCI_IRQ_AFFINITY in pci_alloc_irq_vectors() */
 }
 
 static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
@@ -1703,15 +1684,14 @@ static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
 
 	for (i = 0; i < trans_pcie->alloc_vecs; i++) {
 		int ret;
-		struct msix_entry *msix_entry;
+		struct msix_entry *msix_entry = &trans_pcie->msix_entries[i];
 		const char *qname = queue_name(&pdev->dev, trans_pcie, i);
 
 		if (!qname)
 			return -ENOMEM;
 
-		msix_entry = &trans_pcie->msix_entries[i];
 		ret = devm_request_threaded_irq(&pdev->dev,
-						msix_entry->vector,
+						pci_irq_vector(pdev, i),
 						iwl_pcie_msix_isr,
 						(i == trans_pcie->def_irq) ?
 						iwl_pcie_irq_msix_handler :
@@ -1988,7 +1968,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 	if (trans_pcie->msix_enabled) {
 		for (i = 0; i < trans_pcie->alloc_vecs; i++) {
 			irq_set_affinity_hint(
-				trans_pcie->msix_entries[i].vector,
+				pci_irq_vector(trans_pcie->pci_dev, i),
 				NULL);
 		}
 

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.47.3


