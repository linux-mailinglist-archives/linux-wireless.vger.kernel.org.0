Return-Path: <linux-wireless+bounces-33511-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAggAyVYvGkUxQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33511-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:10:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC72D1EF4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B18D43003820
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B8364953;
	Thu, 19 Mar 2026 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbaNFdY9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98F3644C5
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950984; cv=none; b=hKJZ+JJb4SE/EjFEIjzavWSk7SWbCIzrTmRAX1PgRX9SG+T9cjGjiyo5rxdVE0RBqHiQbb3ChCGS0fgo9H20aPdvjy+vejl9L/SMfbb8VaD/pvneCndZJvw0JpfqgTZVGuqsjTToYKphyjvlJAs/pnUwjVDh7DlRnERMphBMmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950984; c=relaxed/simple;
	bh=bisf0XchOZYoXALYu8CjuqBhG93r4tfWvdbSWvyUWLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkdlSRM5EkxOjc1Vf18ehT6cFNKrIytD3NwYuFsS5Dzhv8xrzHvlGHTb7N6kwPi5cwNyqczPshWNI8xQtJr2e8QqPkLEYAHCT2TjyPZJPH6nkEcVm3YLwCuzA4KEYntHmiFBAIIRo5Y6ff5eap+kTY3x8CFudb4NaEpu+H4bFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbaNFdY9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c6fc2910so887707f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773950981; x=1774555781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPIk/0st22ZS1OzuVSWsQ+rWgA1iBUqCVtU5Rvk+tKU=;
        b=CbaNFdY9dDHp5mfQQ0VVwZXGP8jc5G/LJwSJhhWBnoGp3H+1V3rqNHn1zA46I2oQUA
         tQHVLUSUfT4VrcDjh/9dtB6isD89rNJ2J1II/Vo/U1XlB7+hq1EIodUDon/pcZq2+EAR
         LHh13Wi5ResL/s6BfDe2dLZiQYaSeqAAT032pXRUIGDoG/ls7gqrU8JjWjFlTA3tuCn6
         6iOKFs7sJEi+AEOM4meeJBIYzYqaPprTEGEEOZhzx4GNEFYYHeH9dwfRqewpQHGQnzhj
         yJNnjSghyYL1xQ8mnptye3XixD+/OG+HogdZRtNVEOQiZ+vx1vgIbG6zeFThWhgn3NOC
         Fgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773950981; x=1774555781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPIk/0st22ZS1OzuVSWsQ+rWgA1iBUqCVtU5Rvk+tKU=;
        b=Y3I9xj1XwwxpiEHZs3h/9cle60BEPVihw0DlXO1TynaQiwnywwuk6I5mEVpQouuefj
         jRlUSa0UrQg3AtfU/KMs2/tU6MDqI81AqxEwlrawVIwH5sabEIwgzVjjGu+lQ3cnDaEi
         7cfIhlg0icFKtDh/xTJ3hB11LZ8wcaOlLMoN9XA+DYE6lF1FSYB664nvLKrVDpPUhAA3
         BXMR2Q26k/4kGPiCun46yMNsaLH3Fco9OO9dw9LtZweelABMrWMo4rm/eFObG9rX2Dgz
         en4fc8GAelv389tfPkKUuXdKo47FEbO/uNLp01Chme0FHbN7PdW6SVYRR1f7lQLbGJfV
         zurA==
X-Gm-Message-State: AOJu0Yz7hphK4PPV3+2XQlDtrJ6NdU2lCXGu08R2xY9CKhOOiAV7FVm2
	ACGdnTuGkRuC3cjTYApRMuu4dSmYyo6OaKc5FjUpPig4JqXPUmJ7nHnq
X-Gm-Gg: ATEYQzzBkJL/PLzuBo1goOisBRIJpeRhb2b2L1HqvVc6Zu8trTYwWrYlKXC+X7EzPRv
	Icg8RrnsPLVoBbNWGNyEsv4/Ufr3uPc0Yv0n1Wb1JxaqF1+fafj7NNCs+wYe+u3Qu+o4Jiiel5t
	tD9AK0HvIAJRd9jmXmhBJojgge65TnqM32Cu/7cQHOLREo6ACGhYCEcqmpT3mszl2tNzwt1UAu2
	BocpBb7+qSxi46pzCFCGQ07hp4yYqAaLrj6Tt4SQa1i2G5ZSbQPqZTiWtvGB21YHk8ri5bEIUES
	PPlIuYFiEyhr9Lzp/V9vsIkqMZuGbuXWXkpu0wNw8qjntrml8mhcE0SFNdvtLbckq2r40riYGE3
	8pIWn3d97FhtdXWkC+704HBeF5QEHY1itQO5khHGnIGc0s8wMhU2GVM1ZbEZP1O887AoJHtkgXc
	MPzzJEiScchDIS+vIlVTl0MtCi62CHwaq+AwbOfIE6JI8/
X-Received: by 2002:a05:6000:290b:b0:439:c67d:9fe8 with SMTP id ffacd0b85a97d-43b6424ef8bmr1184861f8f.22.1773950980293;
        Thu, 19 Mar 2026 13:09:40 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6471a27csm1012550f8f.36.2026.03.19.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:09:39 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v8 1/3] wifi: iwlwifi: pcie: migrate to modern pci_alloc_irq_vectors API
Date: Thu, 19 Mar 2026 21:09:35 +0100
Message-ID: <20260319200935.23253-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33511-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BC72D1EF4
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


