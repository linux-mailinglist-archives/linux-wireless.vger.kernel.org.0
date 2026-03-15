Return-Path: <linux-wireless+bounces-33252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLEDCV3stmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:29:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D5C291C09
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D134C3035D77
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63788376493;
	Sun, 15 Mar 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+m9ZiIW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0471EDA32
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595676; cv=none; b=l9iAg63dKlfOK3dlY1tKYdG8cbhh+/DsJWS8AmND7e5VAUWacuc/QbJrDT3gzpCQ2YHj0ZTfrWLZBXpW+YqJ6Jc+LkIAd7T2v90KMROVT8p21ETrkaoWqjGltgpkqsJtkubRXi4mv5tJj0Sjc33BYnR+DoJl/RxwtKGtj1FqGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595676; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uojZ5ggG7hZ7zued4xIP5gQk80OziBtNxcM7At5uYqYC+1Ccwiej2dy6C/OwLpjBidPphn9BB6T1FS/b8hpVFx/hVoBFfrlLneOvs1w92M6ncN7W2cIRUmEoTiD7Uhkwg4sY3DxPiUOqkSn1YNu5SRgRh02IZMfq5tZvoWCJqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+m9ZiIW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485345e1013so34518955e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595673; x=1774200473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=d+m9ZiIWprHELt1wMn6ikjKhjod+dOB77GCh7OzPVM0ARTDFsFvqVsb09lbEbU3Goi
         nwV+5DW/URuKiLqMIh+RKdRr3PA7Xw3Y2n2hXuKtLVwhQGfXfUhZOkmxJiEdHqorzGOs
         q2B2tQPvxY5QvYf1PvtHvuHNz66vsCVyw71wDv87vOWsuLHuopLCNGPtmc+4AihKpGKD
         iNC6or1IOq0zjABdxr76npW5Q+08I37BYj9qyVBpmAmKguKulBGaXDIStqrwNqedaxs7
         mVc5qov417XNiyaDj3e+kM2Gt3hVADduNgkjiy3xBvxdNiJgHlRiTOD2vtzF1I/KEUYV
         kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595673; x=1774200473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=CzBkuNrLE0F/Y9d3AGeGHCTNhz5M+2SAizu1Yfjb9SXEc6YWHDr9U2v1+CQGwvNRhl
         ieAY2Hy66XqZAzGo2b2peWlUlSEgIOz8M4A8Wq9+idLXbeDLdRzhk6sR08lNtvGHr1gA
         Qg5rUcfhsOFQfpML/g0lxlE1x8ZJJn/ut6/5DV0XjrGcbG11b/GjZUTYiJ+6fyL6WJES
         H90DcRwlvcnHRoH92tpBLTL8V5N7Nmtt26DYZazN/T8ONf2rHEwefae/Rr2rj9T5DaRr
         48Iz5kf2UjXTojRs+rZ0k2BVUQFRU/d+vEXNvfy3ouViBW8L60x6APh8DafmrB85PV2B
         Nbiw==
X-Forwarded-Encrypted: i=1; AJvYcCV/S8PzOzMLOA0LLxe+avSo4BKK2cftgYzDJKbHd4Ess5dzZpg1IlbVvxLOE04R2EeYH5T0DdXsoGPuKESOmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVJWdNCpQObQCoC2AEWHtSQEh1S+93IaE1etGh6CtFDp06C3f
	kreJWSgn7cDFhn1bL33ZGkzFukl1XfFaB1n/sAIffNYLZ10xDBZD80y2
X-Gm-Gg: ATEYQzwwQ3mBIAztJ+20pLRnGfRJ6OcG5Fa1GAzO5vrV+sOHA5+wb8DZBNKJxJp8xzf
	ySLMVbQ2dyWC9BtoA7iPDbg6u/lwyTlZvTjdx56xH69q+C9KsScug35l6gD8Acj/8HlJXeUNwfy
	O2eLTBtbxO6gIfhBoMdKlGaS8afi1NbHbS7zYZBRYmSI5h+zSkh7jHx3N9uzrLuDsJbIZYY9ziL
	YlZnz1ajT0gUkAckv+57K8WMIFyUdTIekRJ0IEU6ZAhTW+Vi7BxVpojA5Z70uXyrVNd0DU6FBUZ
	jOn0vIhVtGufSMdqWYPl94HZEjPpR3a/YXG0VkLRmde/i4H1MOnNQVV4nW3LOCMys0bFaskPR1M
	hhfaxKScnGHxmJU27Lvs/hNQHpP/J2cLxRds942pRGhImFy2y83KlFHdvOfrVfYW36Az/X0rmvs
	NKOTvzHXXdIQc+++mf+wOYtI+irYHPy93d7tZf3yiB0tZAsQ==
X-Received: by 2002:a05:600c:4594:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-48555acaddcmr154699455e9.8.1773595672220;
        Sun, 15 Mar 2026 10:27:52 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:51 -0700 (PDT)
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
Date: Sun, 15 Mar 2026 18:26:37 +0100
Message-ID: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-33252-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79D5C291C09
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

