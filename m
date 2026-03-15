Return-Path: <linux-wireless+bounces-33248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMijIonrtmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:25:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A24291B99
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3051A303011A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E5376BD6;
	Sun, 15 Mar 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFJKUc7m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EE377576
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595518; cv=none; b=n5/X/XBrH9IXait/zvLpFlO2UqH4zx/DEO/PROFi2FFpO1HzsbkomeQgENh47W+T2r17/g/CuTMdePlX280nxRbPMHIIJWmuI3JjV1aIn7qpENogL21YfTf1VZLSF5gTYntdukmjD/a5tL/BP43z71XQK2V8M1M1j2kKUm9pFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595518; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VV26TY3xIMoDnlBNKJvaNku8LvJkAXJd5lNveyrPr/qoWxXfay2RgzOGozBzc5IpjNe9p01Bq07fV7QXZt/6umYLmBBjFRdKuOSqQK13ejoIrmpYqIjOs5PmcqHAsUUhus6G4G0fcK3sm0kFqfpfe7NYW+DhU/IWbe0Qk82iX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFJKUc7m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b3cfc38edso1041309f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595514; x=1774200314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=PFJKUc7mj/jOLsLlx0u0TGb7O5VMQ83GWjJicV52NVFxFjGZ7jqvKmGPXxbz5yMEWz
         R7FQQsrdHqcx5nuCYm9wspa0/1nuz1zFXJGo3PUcJDs8hAS9xRvvJ5vG/1D9b1vNBrzS
         N+E5QMy9GUBapnga4VofMPLgcpuisvI3S5zOSJ93EY8WXDkdAe6oammnMRMdN1TyGn1y
         oAaTgz3xRPu5Z6VBGdpsoaZyuADhws6RT4MAfEagM9V1a6IM6sc9dfr/G7coI9U+oPTJ
         mfoKyDWCpu45R2undLLqM7aMNRYYxlKRO7WKN2JlhXR+bTWmlp5ge+AhIQ2q7x7iuSw9
         hbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595514; x=1774200314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=krrXpLnngcvXc4gmJzmiHwxmQvdQ+TAeBwL0coTcpxaMsBNpysj8uGHsyfXZNque6h
         1ivCnZ1k/rQHzckxrGbpXXGahf4d0qyA3HK+99e/Kvex0ROPmjBZjoXvXqey+MJQlw37
         8WF2+rY/prpFpoD7AwMN+DeNVG3Cpx2erJCGO8gJfdxYJ9md4ahszO7cvrjii/g5gpVF
         3a/R2av45bBi7pdexK8jkVKFPVUW2BxuU0nstsducL+ooHqHqf4zNTVhCBLExl08sqLU
         Ub5ejIvwnOCjs05T2JHg49c0/0XfD4RXkLzOZKK3GJmE4wKv64VUJ7XbubU9d/asJZ/A
         pF2A==
X-Forwarded-Encrypted: i=1; AJvYcCVaDujXGHuVglN2oeAWiCh4jTu9+LLYVIJY6XEdHkNUbj6AXsJN51wy/HoVxu5t/3UtT3nDWc5f4YaQ72ZNPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWPwcuJJjZmAfbvScx6dh4mJ5mC84SE4+G2RNk2PHWNKte2dR
	QMUuXzdEYQjZ1mwXGhEL2MuFecvRKuQI/tgHd2sgb1K32rdl5Yl+9F4a
X-Gm-Gg: ATEYQzw/pGTAVHh8mKw3OIeO36BvR8TdpB10ZHoQ+MJWvXBA9K+y1Z4HrzdfJqlpim2
	czYl0/NYD7JaFKHVK5URrpZScL5HHc8/ljA9lm/kmHX4BE09dkGT3O4isPCx4882mSwYzGv7E2L
	GYsFTXG14iL7KduNTmKND32odbe+MeKi+jJxYlhdkw3g2IM7mC1KGlm8xR6h1hx85GN4mEE7m1S
	f2Ybz/qZ+Teu7Nu+42eTTSTrHWeUZzkmyLs7bZqRI46PTuuuSnpWUGg/AZnBxWLAvJWEn/uq6d9
	mIuxEqBesMw8nJsGhnXz/ZuHsC12T5A9GXrWSMTQ/MGJt/TA+ThxRBKXLrFgumY/wKxkQbPYmO5
	kCE3odlbNLxE2Wuv5cpyEcOOiYG7JN9og1xxqxp9un3vxolVWAMyoM0Rt9kg2zi07SjU8/p51R+
	VZ6TxKKtLoZO36RtSdJpQ3MV1PcTIf1iwy3qo=
X-Received: by 2002:a05:600c:45d5:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4855649c956mr173044125e9.0.1773595513423;
        Sun, 15 Mar 2026 10:25:13 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:11 -0700 (PDT)
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
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:25:04 +0100
Message-ID: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-33248-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34A24291B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series provides functional optimizations and alignments for 
multiple kernel components, specifically targeting MMC quirks, 
Rust block driver abstractions, and iwlwifi interrupt affinity.

These changes were previously submitted as a single monolithic patch 
but have now been split into logical, atomic commits as requested. 
The code style has been verified against checkpatch.pl.

Summary of changes:
1. MMC: Consolidate imx25/35 quirk data and add Kingston CID support.
2. Rust: Update rnull driver to use Pin<KBox<QueueData>> for alignment
   with kernel 7.0 zero-copy initialization.
3. iwlwifi: Optimize MSI-X interrupt affinity mapping by skipping 
   the boot core (CPU0) for high-rate RSS queues.

v1 -> v2:
- Split monolithic patch into logical commits.
- Updated author and email to Adrián García Casado <adriangarciacasado42@gmail.com>.
- Removed accidental addition of nested kernel repository.
- Fixed Rust code style (line wrapping).
- Fixed iwlwifi white space issue.
- Wrapped commit descriptions to 75 characters.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Adrián García Casado (3):
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.47.3

