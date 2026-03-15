Return-Path: <linux-wireless+bounces-33254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPpEcnstmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:30:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D489291C3F
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1299C3060BE2
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593F376BC8;
	Sun, 15 Mar 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7IjVq2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A18377552
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595681; cv=none; b=uUJY5wjDxfNJxpCS5g3vslpsfgkzCeOelz//Jz1yVFK/8dYN74IS71foYSsrOQ2RUe0BbOTQCZJ9bsJxOlYP/E+rpIqnJvVcHAPzhe0cMqZCX57DITI/SzCul8yqKV9KTbJsqfnmUlUGqBgFJve2XwUFpozeurJAPdIiTm0vePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595681; c=relaxed/simple;
	bh=y8Mtr9pcqnP0vzscG2RNUti3BiDjvt7BhqDCfc6+Xhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYXHs1OqmYE39v3Cv0xNUonoCDFNynhqcBsxN7GdncFXhc4iND35HLvxsv5TC47jfQXpdM4uW2luvP1Q3Jo9zBrrBbM9x58MaYBZGiYDmcIdqY8r0J2YYQtGiZcOSeGkLyDI3boqr7qSHCBsRawI1NrmGsYQX4DdzxPb8AW7X94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7IjVq2h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so19651165e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595678; x=1774200478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dhH5M5FJNqVSup5S7MKNqMM3K7FwdoGd3zPkVDPQec=;
        b=B7IjVq2he/R/gxoyzIozDS4TOhCTh7tA/GbsLWYGRrUopXDRznIt7PMswdCUQaWC8T
         7Zav6qEKDiIrmBGDD6LV1VCs+MZo2OWSsvEz4uZsmUkPVZWyLJRI9dube/GW7qWVrBII
         OQRvgGYKtlzb/JfbDB70hRrP6WkNmAGhwXSV2G/DfK+RPXDD1gqcOxgUMDQf7ClGk65T
         v6SnNpJviw7xWXAdzNX2a1J8R7qTLVQGDdDrs4f9uKP7wL7m+0sgxEf/PnRCgqtVRWHb
         MZA82adK5DHXIq1KCmVWTxw5FYZ1Ar+Y8QziwfQPIaoX6dpa3UL2Ai2gMbhes6/MisG5
         3yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595678; x=1774200478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dhH5M5FJNqVSup5S7MKNqMM3K7FwdoGd3zPkVDPQec=;
        b=Y0+vTmTtqkg5f2Ozrce8zg4F5NrRdfz0HRTv8SXYNQkmZQWWXjZ3lSW7ovtJt2KAbj
         9MAu/RDjsQ1Sd0+D0G34cGy/LGuTdfVxVoFG+6Kie44ykXZfG305rJL3/CDLkMl5u8sM
         rgJQYatnwpeCbvL0AMFiZTpoK7zyevaGgisQLUtI99l2OupVcoEf+NCcMIayzeeygMMf
         SVoP2MTbA1VJ7qL/qbQk9b+DzNQVSE7zwTx6Rzu47LSF0MeZpIbqWyJ146ON8fm1cAs4
         wE4BcY3r23oZ+V3MxSlZFQJytWVnf1bIKMyVdZWGGZ7lpXKfJsBB2zd9fHSboJzqrjjW
         L6eA==
X-Forwarded-Encrypted: i=1; AJvYcCUkIebFvEWAiaT4+9csxWLi/dBUwsycL2tgUSJIHlxLEfnnJsD6vxKwLP4MRGhoBu6kKO1GLvt9zfHc53+D4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK86Ib4VoRmfD/LmcesoqnVO/+RmTZxNQdimFIs9kyw2eHSjt
	NU3o8cR/8L2mPYR/vKq3X1tDbM6UZckQY6mytsuDMalXUlZUAVseFZ/Y
X-Gm-Gg: ATEYQzyx6+akKK+vNefaRDDX0R5W8V+zKgQO/e425cISnPGY4eXSz65dHdbUKtEqhM1
	s6lNLSn5VDQoNzHpPd8eP94qGAv91zBBtNack1eqRav0lKMvBcFc3Lravw+AvLFp2mc5rxNmNrz
	u8/RayPvXCiap3WwmW+jb7F3co5kCCHqJHUwMZy08ZFSmY2MNlDpSNCxcqZQw6q3YrvEP/DxPtu
	aehB+EzhDaBflI/eaWGhD9qGVVqaprx1XHq7pTh8qweKjE22iLdzervstKHFBGTnlkDs5xN5Wkl
	ZD5I6LuHwJPS3FTEFanqR1yITGbhtsn5jEXTirmm1amnkSFsrTLw11nh9CubsevhVO7gfPlDI04
	GR9OrQafauhirXBbypCXhdixqQJ5xHvvoQb05yRujx81+4BowPvxnuj3fSNC36aiogOYLSjIPPG
	Ap11ZOb8b6CBhnhUYEtTH9ck2lzTgqbTI8pJI=
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr159704575e9.1.1773595677669;
        Sun, 15 Mar 2026 10:27:57 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:56 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 18:26:39 +0100
Message-ID: <20260315172746.270734-3-adriangarciacasado42@gmail.com>
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
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-33254-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D489291C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
allocation. This aligns the driver with the latest PinInit zero-copy
initialization abstractions in kernel 7.0 and fixes a type mismatch
with GenDiskBuilder::build().

Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
---
 drivers/block/rnull/rnull.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715fe..23df23936 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -54,7 +54,7 @@ fn new(
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
-        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
+        let queue_data = Box::pin_init(QueueData { irq_mode }, GFP_KERNEL)?;
 
         gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
@@ -65,16 +65,21 @@ fn new(
     }
 }
 
+#[pin_data]
 struct QueueData {
     irq_mode: IRQMode,
 }
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = KBox<QueueData>;
+    type QueueData = Pin<KBox<QueueData>>;
 
     #[inline(always)]
-    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(
+        queue_data: Pin<&QueueData>,
+        rq: ARef<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
         match queue_data.irq_mode {
             IRQMode::None => mq::Request::end_ok(rq)
                 .map_err(|_e| kernel::error::code::EIO)
@@ -87,7 +92,7 @@ fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool)
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: &QueueData) {}
+    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         mq::Request::end_ok(rq)
-- 
2.47.3


