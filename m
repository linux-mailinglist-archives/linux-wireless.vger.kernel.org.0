Return-Path: <linux-wireless+bounces-33247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEOiN6DptmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:17:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85032291AA1
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FC3A3021944
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A523750D9;
	Sun, 15 Mar 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGDd2s0M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED05376464
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595025; cv=none; b=rEXfstNpU973v0bBcfK/XUBgRdE+T0Acihbcbeke8Adwv7PAHistvrJ8qEPJkp721ZxOvNZyiEZhYG3eUXLQ9kgUJa9JPLbeiJtf6+A9i00X6/0Q9YhR5w2JQsQ6/JkuwuiAZ/U+h2QfNyYigAd9U7ykKBA9uFco3q8QAO6ML04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595025; c=relaxed/simple;
	bh=xR1aQtJyjOGsb3F8bKi8GxD9ZWQvMlCBKAMwTQealv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIIppemsr0YoF+akEeZzsNrHWPsenBG2FTQ58/saxUVr777knU0YZF0FLBbsPjxmJRoyOJqPjQTScpcjGDoQVBz/Q4T36m0bTVjzVWr+Pq2iSmsggFJ0QbJrcphzcaOQB7X6gWqOVCjO2qZlftKnDUUXk9VLTLqhvAYHAtDAUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGDd2s0M; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bcec8613so2838196f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595022; x=1774199822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=LGDd2s0MRWWVzXiLUlhscGY31hZPYrH4KObYvbpf2p9Ur+gOzA6ep5+r+WLKV8QH9/
         +/4S8qNW/piz9OVtsNFhHEK+QQNbGl7USWoD43ej62kuooI1hxOWuwzxxVphv4bNfxHQ
         lXO4IOJsrITQRmID1rAQyjekPiuqPqSvwc5T4DDj6fRl9Xtzu1hn1XkIPKQ+mg0l1olG
         beUUL3G+Tx4LMx1AcTr9YqTznBOAY1nZOpvJ4bwqjGLTvaS4eftDMgtwuDsQsNNh5R5s
         iMDqrGuK+zeWy65nDQLF/OuD9rYse0Giq148n9HjONRPABWI8T8LuwY+JGv5+WGrL3Zr
         RUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595022; x=1774199822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=Ku8ozR1xCFZYw/ipjtHcHFmiYaAJsW4+y3M+D181pw3dnGDpp/jRv7vnDND7Bk3CCp
         OdtzsWwFUChPXk546oVvKlgL1e0/ho1KUMfDRaaAr5Gmev16L5AA65uTmCmeUmULqxC/
         WWLncbNz/dqLNfYqCmmf0F5nDLoOuM1cgPjsqAcXh3hnrGbL/rhs0DFaBkr1b9j9dDI5
         VzYQ7/jKMgfDlCAOVypOgotKK0zedeTSUOctQsVOgI2+h5Y0ePcwJWZFqL5dxbsPiK71
         0JgFMN9HUePT/ClZdSsAWfxrzB7rVh/HADWunZh0FCerPAYW4L6UndapweHDoc5BvuLf
         06ig==
X-Forwarded-Encrypted: i=1; AJvYcCXShyWw8sJ2AYhyIwQpvo+svRXW+bTUf98BR4B11a3XFGdWJTvTGYOOaGN2+R4IDWqVCINJhhXiytQsazLB/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMTzXsFI6cMVHPO7GT99RW7L+ckZJm9B6xGljWnFke6pj42ct
	2PgFF8pHvxkcSrtUDuPBgMEU2oOLDO8hiyop9sbm4NIZfg3QDJsyWencQMssVVDH24otvA==
X-Gm-Gg: ATEYQzzdCn0q9jNwFwoSLa7HVcEcpDXq4cQP1lFGCnVe3Qj1/0HW1Amd5tR7YwpjnDn
	VCxqACcK3ar55XS7mMuWSVlEou6cYNQVxJfKUHYytfZG76xUf7rQpVLFFYCksdw83aK0v6UULhz
	5vqdpUASU4WpjQ0JliL0+FMkz6nvwOocZ/EAtgrp3ArCuLeeLYTSAJnGXH2PP1YdtNTbPijWEsE
	pF2dK20fkvZmld1IHcgeBEvPxlHQYi9t2ULFz/fNfwZstHDiZbDafcWsSCjz86FijEbFtzzyt8e
	k/2bRJiNHoLUNgpMr5FAR7jVbrbkQH6/3xdHomALUhCD8/A8gEsw8mLNdPhGt4xqrjBG+nWzw+3
	BwacR6DAmaW6jWT+38BWybRYGzC6dBU8EhjUmOKV5MW/5S6HuGgPgvQjFXBbRx4oT+E47jqEvNE
	kkwbkxTPdNHC1p0WQGDKCfHSDRLd+GXAAskQ==
X-Received: by 2002:a5d:5849:0:b0:439:af0e:57a8 with SMTP id ffacd0b85a97d-43a04db7edfmr19896954f8f.33.1773595022342;
        Sun, 15 Mar 2026 10:17:02 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:17:01 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 3/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:16:52 +0100
Message-ID: <20260315171652.269020-4-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33247-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85032291AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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


