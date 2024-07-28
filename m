Return-Path: <linux-wireless+bounces-10567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1193E26A
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31CBB221ED
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26343AAB;
	Sun, 28 Jul 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcfBQVqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6958B665;
	Sun, 28 Jul 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128015; cv=none; b=cNLCa06ikLe0wK5a2++Q0vIScQCZ2yAlCjaZ+RhC7aUds0PYt1qW/YX+9OUtDu2k5CPcuk1aajK4gdJPF/ga8Icp2uV2tA3It4SPHx4bce4HaCTEAH6nIxE9/PA2VdpQgvXvJvE5aDbt9KmAWqNjp527uE7KaEA1Z45VY6nlcYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128015; c=relaxed/simple;
	bh=N8fZ0Qatlz+54nOb3qZAMay+Eh4I1PbadnR0ZEvnSW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJA+6w3m+EKIa2q8DBXIRAXxiSNkUcrUmcIgWQRz2bElgne79HKcL2JTlr7eJM8F6zHwKKOl/oK8yKcvci1RtPUrGQlXmZOhvuKePK3KdUQ2sEJKcxjho4yLE5oD3hf9QIFtcskfH9ZOi3V+ggDa+XLFimI0nf0x59KutDCSzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcfBQVqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3341CC4AF0B;
	Sun, 28 Jul 2024 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128014;
	bh=N8fZ0Qatlz+54nOb3qZAMay+Eh4I1PbadnR0ZEvnSW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcfBQVqmqawEZPvH025A9tjyb+iLiRZYvyma438EWhsmvO8JGhWhQJop7v/2duQ5Q
	 iIP+8dhZaJ/6KxUvDB2G5OoMdhQjvIqMFuR1hqSbKBepJPCViwnRx76joJpCpR1MtS
	 UvJW4VmTOJ/XY7HfBIHjk6175EkvVlBQULZWcVIjyGCCJj+nsK3NSq7vrBtLh0OUIt
	 mbxx9kgI/ONwzLB3ckLfaHrdgxj88ZiFKGn7zjsY8OVny50AsB60b3LSpPKEyCurCy
	 HnElfk4FYLA5Pihn4sAU/k2E2f9s4JdDakRz/N4M/OQBpjcMxZJcnH1jCywpcE3jDe
	 v31RYL0DIoQdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 02/27] wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
Date: Sat, 27 Jul 2024 20:52:45 -0400
Message-ID: <20240728005329.1723272-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 0a993772e0f0934d730c0d451622c80e03a40ab1 ]

Commit 5082b3e3027e ("wifi: ath11k: fix race due to setting
ATH11K_FLAG_EXT_IRQ_ENABLED too early") fixes a race in ath11k
driver. Since ath12k shares the same logic as ath11k, currently
the race also exists in ath12k: in ath12k_pci_ext_irq_enable(),
ATH12K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
In cases where only one MSI vector is allocated, this results
in a race condition: after ATH12K_FLAG_EXT_IRQ_ENABLED is set
but before NAPI enabled, CE interrupt breaks in. Since IRQ is
shared by CE and data path, ath12k_pci_ext_interrupt_handler()
is also called where we call disable_irq_nosync() to disable
IRQ. Then napi_schedule() is called but it does nothing because
NAPI is not enabled at that time, meaning that
ath12k_pci_ext_grp_napi_poll() will never run, so we have
no chance to call enable_irq() to enable IRQ back. Since IRQ
is shared, all interrupts are disabled and we would finally
get no response from target.

So port ath11k fix here, this is done by setting
ATH12K_FLAG_EXT_IRQ_ENABLED after all NAPI and IRQ work are
done. With the fix, we are sure that by the time
ATH12K_FLAG_EXT_IRQ_ENABLED is set, NAPI is enabled.

Note that the fix above also introduce some side effects:
if ath12k_pci_ext_interrupt_handler() breaks in after NAPI
enabled but before ATH12K_FLAG_EXT_IRQ_ENABLED set, nothing
will be done by the handler this time, the work will be
postponed till the next time the IRQ fires.

This is found during code review.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240524023642.37030-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 16af046c33d9e..b08e64a5c8932 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1090,14 +1090,14 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 {
 	int i;
 
-	set_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
-
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		napi_enable(&irq_grp->napi);
 		ath12k_pci_ext_grp_enable(irq_grp);
 	}
+
+	set_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
 }
 
 void ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
-- 
2.43.0


