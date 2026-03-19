Return-Path: <linux-wireless+bounces-33493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAHHLpdAvGm6vwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:29:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6730B2D0F7B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390513045A91
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521F3E867F;
	Thu, 19 Mar 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy5QDAUa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F91230BE9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944974; cv=none; b=onT6gpzKniNAZhJGVQWf5Jv7Q1r3Nkv0b+gVC079Ugv/s722cotz+ePDzBCcznuhGeSX3UHkdK8aCtjHI2jujUus50OnXZZaZNboiaamPA8oKmOADS7VsIwzc341SYDzYn4DtU2yczoX2tT0GliynSaevlCq64tB7Rz1lEuV0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944974; c=relaxed/simple;
	bh=DIUx4qeolYOGNr6eUFGI6x0WPiaU3TWuFUf2GFIgGFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aPIIZSQoUhvsAMVJXkbXbh4qbqXTOp1lSUbIrgu6UTR7BEtdo2tTsf1giYAkpnudb4R8WKXWjZqE8ml6ISZ0cp8SOcPQr3tiu38ZgULeWqA2nR/+1pg8CAtd+LS12YPRPB9IzYR65nRwrsnuPEQfeCAUhMSQWmIY5ttfgmawBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy5QDAUa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bcec8613so931024f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944971; x=1774549771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxcQ3k355K3UZvFFS/hK8cgdmWpwtKdrYj0iIrXwPoc=;
        b=Yy5QDAUaC6iSIxLYPZrzajUy4XA2tBm8hJ8w6+NjYAvEraIwkFnNpc6Lvc5eUwUk8T
         /kJTBfyjAlKdaI4fMKOFj5h3LIFQhZKK4HlVPdSC9F27zUXMMRfYeIk5lzHJsVp3Q0n2
         45BOMbVJjzloZr9rN8csRKAfsYQt1g9Y0A3G6ObFZHgqDMCXMXPOGtACli7OsBlISfWN
         7/QcjF7ZDQldZWt1qbWHV0nN2GEg+v72S5mNOofsp7yGGZk708Q+kbrWyLjDyj2qfSX1
         pEsyK1bKSjS4k3zTYFcXwty4RklmuS1Kq07VorYOh4+1CJbV8sDPiJhs1dijO7nf2dIk
         k5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944971; x=1774549771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxcQ3k355K3UZvFFS/hK8cgdmWpwtKdrYj0iIrXwPoc=;
        b=BfxRXm4ypaPXb9twXSYC1S4oSbbocbvtbXrIBbnlycbUHHahHOWe7XNdFkRrF+BVYG
         q61iXP8yqSt80nYBhmI2pMq66wxBoLWICdq8u6xJKgTna/oMsy8v+D/v++6jiRpND5S4
         3M2n1YBYtOtpKCanbr1lQoYTRMPFAkIbuil4n9nqEDNCCgXqdaROl0TUX2hvnJWqc3nR
         viRz/yRdOBBlVxZE77sTEF/KpQ4KmpsSOlbAd1aq+KCCrjfnaJlZss5WaIvZ1N2waRg/
         d4BGFBi16PL4iPjknU1y6HsGt6BTquVAHYo/1yzlacjOcK0awaciEL/AS5zRX4aD4TkK
         mnCQ==
X-Gm-Message-State: AOJu0YwNBDFuH7JbccLKPW29iVltiJdJHqHkK3vnhPafPFJtQ4ql3svo
	nK6iEdepVwpxh66k0r0V5F9QzFuvanVX6gpuPVu7YXiGI2b00ehZMuVo
X-Gm-Gg: ATEYQzw2nn0O6N4PB6L2g5pBMtFbbIkKnOS0TWNl0hi+xNirVIaY0FUlgr1RyBZdap5
	LIvAOZomcstX0J7HbQbwAw7dQ3FDffnuxvrtCvTGJJWTqf0pfjhkUWUMztpkDr4mYy4WbPWj0ry
	CyAlPZkTfuZbK6pAlB21FQBYjks4kF98dOTzK52mPy55P8CwGgxn7EB1fNnfm5yiq8EcZxBB/Tx
	B5djn4MtbjjXVBhGaVpeHYGKon1w16uKH94l2bkghroi11vqEfQh3XensewugRb4S/kCrlC59zV
	TrAPJN5yKMnFjJCLAPm+cttSazPVgD7rV9xgu9MeLLO18+e//v+UtYwCYrnvFpB7j7vQQhmDLVL
	4w7zMSj50hrjRp4+q2MSTpzTolsnqB0bIl7iDyUFij3dXR/sviCkdLmjiyz7KcMq5gb6QSxXPTv
	FP0ZN0SiYzaoQ50bgGpcDpZgrh/Wb6hi/I2g==
X-Received: by 2002:a05:6000:24c5:b0:439:cb10:dfcd with SMTP id ffacd0b85a97d-43b64286f98mr615175f8f.39.1773944970548;
        Thu, 19 Mar 2026 11:29:30 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm498077f8f.17.2026.03.19.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:29:29 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v7 1/3] wifi: iwlwifi: pcie: migrate to modern pci_alloc_irq_vectors API
Date: Thu, 19 Mar 2026 19:29:25 +0100
Message-ID: <20260319182925.19436-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33493-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6730B2D0F7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Johannes Berg suggested using pci_alloc_irq_vectors() and delegating
affinity management to the kernel. This patch replaces
pci_enable_msix_range() with the modern API and leverages
PCI_IRQ_AFFINITY. The manual affinity loop is removed as it's now
redundant.

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


