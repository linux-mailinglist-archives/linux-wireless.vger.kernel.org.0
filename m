Return-Path: <linux-wireless+bounces-33257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOyUNGUSt2kWMQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 21:11:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 746252924C1
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDEF630055B7
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF637A48A;
	Sun, 15 Mar 2026 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu1+AS1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4034252D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605474; cv=none; b=ichC3c+OLhiocPAIx/QXHbYkeoSDb3YwTWHcuLxHFZZtSWhzX8M4DvtCsbzyifrchyZ08jlPCu+yOBLLTmpJhVXfMMRyPIQc/LCl4oKmPlZr3YDBhY9Gjr/kJ3/NkaiMNJ+rU3cHIx4ophktUw/kMx90yeNasq11vtitFXx9I9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605474; c=relaxed/simple;
	bh=dYe+Ufw2a60K3/BlwZq3fLqTJLh2UzfMi4ICKNZCaUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggOwJQ0K8lmVWQ8obtYZGgEcoV1dIf+5GcZCBLqEejk2HqV6qbGVtGozZO+FTZK4NkxnUNRG8W6x9PExSxlVdZyBGMw9Tz4lSzKHfKzbq/fdaG+ISqLTfBQm94M3Kh5fId516jSRT1vVMgnfsfOGjrQNs/DgDnVV1jiyxn0BRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu1+AS1n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540355459so35132135e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773605470; x=1774210270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mk9Q6mftj+pYck/R7PSYgQcBCN+tPgC/fyzhU6r+TTc=;
        b=Nu1+AS1nvp60qvvYMogJcfdkKiZ5uVnPUdjofK9d2p9Yq5iGCDy5VooBpX1Nct6RiF
         2CjZy2GWbtJCRz/grd/5LILEe4ixBd5kd+d04g3lOOlvhh1Q7qIh9pJbaxNJeYv9E3ip
         Rrcr1PoEnXi1uppXhDjl6hdefCdIt9tVhil+TrpnWD9blIOWnXw0lM1GOkYHwrCF8pD6
         OFIo+ys0RfAiYS08CffUwA0Nq2veq0kH9t8fyQQqXZy6tRIUzcKYNoQ0mHZ9xIRlPoTe
         VR1VmqxohmCwyXb2SjZTZxSR+ma70K+jYPCvpmBBH9HzdMipCLpSHCtOCr1MmxiT6z7Z
         Wu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773605470; x=1774210270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk9Q6mftj+pYck/R7PSYgQcBCN+tPgC/fyzhU6r+TTc=;
        b=rxShlraCtPTOw3lFXQpBoFKaf55eurWTzI9O5FEGP+UL3WvE3oWMF7wk7xY+lVJSjk
         qXzRYxmaOhUBoq0DF6Sp+V2PekLUBUb+wSme3P2ya9q2T1pdANaDWRR/Uql76gSJeaP2
         94MxmeBRFJeHqhGaLmIrjNNGRK42f3OXtruVhNMmXxKIWGYG0NDQZ7G4W+a/J7zceIeA
         Ayw+HvsNLoQcErxAc33QkK6DV23B87L+ZZRdyykJZ5eKTcutUeYM1iy0cI0FXG4T3lsa
         q2tV2VgtR6/vdfpfX6yutDXdTrT6mjU8HjpWZvU4+K/9hXjbXnLdm3R6CP84mip4YaZ2
         2nqQ==
X-Gm-Message-State: AOJu0YyYvw9GpSCO0LcmvqsfFeSdYFncahxcXmzAZ06lK2j0b5WoZKOs
	QXfUhO0Tay+YlulFpxQwQOp3/bR9YEaiehr0kACCseYROjPYpRRsqFeQ71IeKXG3nSDokw==
X-Gm-Gg: ATEYQzwOcgV3B1tOGFEv86tuJgoHgho+FTFEIhtrpoo56VxS7HmVbXkKmw6TMba634B
	fZkHKiHefN5qKkdcDti7KIq78w1+80K6m94Ykgdi8ND/dLNRko81nysKUSMIQb4EREA8zqOtxAm
	wbRIH/8tJFTrbnd3tJcmJT7LMO5Efvk4lcOXQvQcKrTX9NveBCqHI3KVs3byhbT7t928sty1bMA
	FVLYuFTLSs5uwrCDL4MqNXpd3tdOwitL9HqstduGiKEXX+t+vUz5zQ3rKQpoPABoIQ4UxHyNzN4
	t+D993+cvY8NJHvZNTFkeBODCZeeuAcFhsJ4DzixpJ1yQdMjoVHp7pZzNmgDfIq7LXYru+JrCxt
	syO6eNqGSPZS1SxAzL+Y6aaCkvF0CM8JRbBQjy6mZdsZ4D2CFSNcn17IZHopJzhLX8w5jGvdoR8
	T8YXv9ALa0D9IqMghJ9gZoRJx77GjDxY8x/PHawQa1KL4p
X-Received: by 2002:a05:600c:34c4:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-4855670e6d0mr154443655e9.23.1773605470264;
        Sun, 15 Mar 2026 13:11:10 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fe27sm389772875e9.9.2026.03.15.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:11:09 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v3 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 21:10:40 +0100
Message-ID: <20260315201105.15041-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33257-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 746252924C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d7..87149f29e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1683,7 +1683,17 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 		 * Get the cpu prior to the place to search
 		 * (i.e. return will be > i - 1).
 		 */
+		/*
+		 * Balanced distribution: skip CPU0 for high-rate RSS queues
+		 * to avoid contention with system housekeeping.
+		 */
 		cpu = cpumask_next(i - offset, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(cpu_online_mask);
+
+		if (cpu == 0 && num_online_cpus() > 1)
+			cpu = cpumask_next(0, cpu_online_mask);
+
 		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
 		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
 					    &trans_pcie->affinity_mask[i]);
-- 
2.47.3


