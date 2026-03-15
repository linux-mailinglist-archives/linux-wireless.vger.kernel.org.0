Return-Path: <linux-wireless+bounces-33253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIMRBorstmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:29:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E96291C28
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17273304AD9E
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E506377EAF;
	Sun, 15 Mar 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARu4y2Gm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1437756E
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595678; cv=none; b=Te25Uz6S3+HIWIvdo4Fge3L4lvL88jh02ysrJXx0Qrgg2IEFbl6VLDOxj1UMtyLMmFsbIDXascMW4ZH/5RpDQOX3V3/1zwtar1alUNAx6AwLWrnttwJQQCn8KA6jlgonb8vXy1VyA5EqQkdsrHPPF74WijzQgrgb9VbREbZuJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595678; c=relaxed/simple;
	bh=3xFqNDbANLuxYwJZCL+0J4Zy2U0siwNrORG2I8A78Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lr6QGrLagv8TEeRu+HjVwFjuznnne0pItrXRA+ZOaVv4WOP5u/nHn74B4GwpsY4aQFhJ1ZcmcCAGT32OqVUBsbsE2TvN4bRv04F9nKY+rhO4tR+oL1bELC6W303WkPclUfxeGVgqJB4wp3lGK8MyzJi2d9U4FLg7SYUtr00uTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARu4y2Gm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so34429865e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595675; x=1774200475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBtR9VKnPKJgjfwnbtGvinYVj4EmpVw+ixE7+VzQpDU=;
        b=ARu4y2GmG8QpEa86w6wV6HozJ+IePGtzrgO8f2Cyo5k5GRcYQNuJPtlF+s3R/QjVs9
         qq0h8HIz8Hl+kKZG8q+UVAOAiggVhGAA56fT5Lxcvg8RTWszZcEBVFYEawgyy3bAtCCW
         kLVh0XwZ+N6z7U7yhUF/UQ0qzDiUl5QUnmeWgqdTtjIgppV9nxyVZUpb5T//OR2mUFvG
         xQJvpDXPsIyJCejURnU2cAiDA7Sddfh40zilghcy4OZJ1GovOXbu7NHo6l9Q4P3XIAGD
         ZGfmG/xfhA0hde6hAXbQq8wlI2kWPxDudCEaO5Up1Ahfc9QgsgUHjsLmCjC4sfg/LnhG
         JFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595675; x=1774200475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBtR9VKnPKJgjfwnbtGvinYVj4EmpVw+ixE7+VzQpDU=;
        b=NIQ9gl2XbhR5rp4kWAp+PArXcS9Nmvgg8DNtSMfyzWDXy5XpJEvY3TGSr8ZMWNQeZ8
         C/PB8gbJB71AAl2uhg6HNXY10qS07Fp0+HZ6Oi2bO/MOYBHPf7rZwOlss/RUfqO4MdZZ
         c1nvIDWDK5oBwzLu/xg6Q0XZPGlNPKU7IhoJ7Pa5jwemgyja8zunnu8tFOp23Ow2kXJp
         BI+f7DaMu26Jlh9odMqa//VzgXtulVt/aDOnM4bEbktffUol2OWZIBhgmKf/He6MS1dd
         XWbtml7KCB02HUrlVxk7SPyhwCPd57WpVlbl7azqe/dMpZuJnL2OwtUD+JN4nlW57AUm
         R+vg==
X-Forwarded-Encrypted: i=1; AJvYcCU8TJByOWhEeRPOWOWyHIGN4rv+v36V4ToBLhk0Fz5xBNFbwAPJJSKUYEzY0ZBAxYO9sFrPal9/mAbDf7fnzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6IeZ3yx/nxHXaSvq+V2k2l7A5CIML60QgnfCWTEM+YY882Cf
	eepOfEdMCm09xAcUE0Z7V0Ausg+B+1H3Uj20aAaf8WyV17maHXOpPd3AelZnadUMj2wzyQ==
X-Gm-Gg: ATEYQzyV1C0A+3Am15is4fnsfuavEBoMdxc6XZn0/9Z3a/xPkaLwSHECXPKw8UKcK/V
	CvA24Uzo2Pdq31H14fvp+TbLlfb/MjceG4TmbT42CaAPACSLWETyg+5eK9xwskN245NneOwhIu9
	Fo+dL/KuiahBx4GU3siz/UegOu/3pIpJAU3ivgMazp0Yyx4zsjZSVrvJWD6oRoxk3ucJweMmgVP
	zxv32H/LRDpSvXi2QCaMVh69OphRjOkfpv24dTnspli70eVZgLwepU9HzYBbJZgn/Z1dpLNKelC
	ExTcAq0wZa3rNgT/gSLzciILlbDIc5X+HvMcDrX7CHE/gUovZXG5UvdUQUF5yK4WsIEZqjCHfK+
	XXPIRzsJwr0Tt3y3pCo4sKUGEoP0Nm4fX86sBbgcAGwMgFUqm9N/l5G2p5f21KGK/n7PH6Hi/+l
	cQt05MN/DGxK+fkNrXLYYQ+7CWpKGQwiAzrdk=
X-Received: by 2002:a05:600c:1395:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4855670b72fmr170714095e9.27.1773595675367;
        Sun, 15 Mar 2026 10:27:55 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:54 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:26:38 +0100
Message-ID: <20260315172746.270734-2-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-33253-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8E96291C28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
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


