Return-Path: <linux-wireless+bounces-33258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOm8NbwTt2krMQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 21:17:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45853292500
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 21:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC6D7300A508
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6232915FA81;
	Sun, 15 Mar 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gheDVVSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A76481B1
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605815; cv=none; b=Af/1twA4yNvC4ZKN+YdwlawaEBuwToc8sgOIetK0wS7xjTLBGf0Pi3d1ohCPIO2jkEylxI8t9g52fnKjOvqxnVKpfoxs6Yxm6YvV3TYb+RjOuSR99YblebBKPBVHg9pGMAyn6DpMXs7L+DvspAqJWKa5sYCBldTm83Dv6D8Jba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605815; c=relaxed/simple;
	bh=dYe+Ufw2a60K3/BlwZq3fLqTJLh2UzfMi4ICKNZCaUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmavXgzfiEshP02Dq3D8T0iGHcnO4xfAf2WZ9KrdX812FvXQC+y1B9Tu6Kq2oPgZQKSH06tDPYZEDCANTb7Wfle+jvVrcCvfwJNkbDtmT2REDhnopyLKSMmyhdkX8CmUnc5AfFnw6Ru7arQe3dZHdp7feWa7oPX5YCez39V+sPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gheDVVSF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48534237460so43214635e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773605812; x=1774210612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mk9Q6mftj+pYck/R7PSYgQcBCN+tPgC/fyzhU6r+TTc=;
        b=gheDVVSFJmPsMvVrhHo4bS6Nibqu2JQkNC+XB0/aJm3Ni3I29POQAeCHbzgzbFka1E
         yeiOkiI4UMhpYC4Ww4JQPrR20CQMeny+avZh2mgZ/CgSv7OQpvvJUdvpvP+6Rk7vo5LY
         ccp1EM4jUADRDsfCcwt3rQAdCA8cAywF+ZGDdw/rk7JwiGR2LDnH9NOPYwzupPQoOYN1
         Z+2fHeDxf367nE9Sohs0PxNeB1bzrQPkFoCGcO9FlRkbPKsxc1hd4ZrpzaIJqpHT920n
         dtu6WegvI14DMp099Wdu5XTSPo5ioc9EF/Y3z+oT/FInp2RAg1ClUAr5O0dsklo0AF2v
         omuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773605812; x=1774210612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk9Q6mftj+pYck/R7PSYgQcBCN+tPgC/fyzhU6r+TTc=;
        b=Mxvr/LxvN0z1qku8QnwpX/0zfesQizXS+c/Uz3aB2GiaVZLBEjwWkOKX6FfL+dEYss
         +F6WaKrC2lEiROA50grfHTxR4AI1Y5tCJ+pgDvRwEg6c+zIE0sKF3z5wdQGD2ehAv9pG
         jv0MiIrs1rvA4LGBXNjzqEuY3pxqmo6ri1X0BfeVlS2F3XhJxs0NTAWkdyc57Nqp25OM
         W0ephQEB6uEjUhQibsEXuKOWrryLwusmiuIJQq/4uuK6Fe/h/5fXe/Y3UQBlr1N8O/YO
         UNdip+k5NfZaEs7UzdhIw3r45eyIOWhFJBXd98VSHggAU7OEe66y9NSfn3NO7cT7U5ha
         hrXg==
X-Gm-Message-State: AOJu0Yx1emhP+GqMKhygHci/FTUO3yW7O/jWhCCSp5O3S3nYFo6HssY5
	oReqjNUSHdwl9P0TwDotr95R0NtaInj9OdrhDIDnInRyMom7y6JA7nch
X-Gm-Gg: ATEYQzzEmJ7GQE+LB4gIpytJd6rce1yikt2Q6nm2+jesBU57vh2btUt6PXi3Gem4aXe
	Bhb8r1sIgX8c3NaeOiJhgyxhJkgSJt5yX4efvfbrXG9fubmgV6ZgzPSMEnCbxwlVDlVm+1OwmjR
	99Snf+3XoV8mNDeM+9pTWNP+JB4DbDtVS05g51LJeVGnWc/N8FsuXvEzFm6TFSJivoj2viF5eDI
	oDx2/oXIl0X7sZ1nKmiQLxrJNYe/boRwIYK9O4li4mt6U1gADKdnAg5p0cf8ZHzPfIRxwVJGMJQ
	55TI2pfVXg28qOlhprUi9gX7b56PAuID9mbXW0+EiWdi3+5+uOmTwxXYpjGQF76VfViRHpquvDk
	/oAgiHVyQiZIUQDS8HALSnaH4c9Stp8RzNLhSSe99HN7bRYaBbHSuF+gW43vUxkVwSzBZDs4ryx
	shLx4S7jQ/aGbgusjXZGCexBv0q1lP13M9YTM0l0tVSLcx
X-Received: by 2002:a05:600c:c1c8:10b0:485:3a8a:5df5 with SMTP id 5b1f17b1804b1-485566cfcdbmr131029595e9.13.1773605811881;
        Sun, 15 Mar 2026 13:16:51 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6b7sm518840215e9.9.2026.03.15.13.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:16:51 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v3 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 21:16:08 +0100
Message-ID: <20260315201647.15328-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33258-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45853292500
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


