Return-Path: <linux-wireless+bounces-33250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML6oHdPrtmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:26:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5B291BD6
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC9C3024505
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07319376BDE;
	Sun, 15 Mar 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCxyw7jc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1037757C
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595520; cv=none; b=Do46WGqgeQVX8KWBpnuQGIieIa2PLDoVdHSv8n4W3vwQ+qG9QZpYg6J3jbVV6YiL8jGDoIpFn8dqfTUCgUusOwLNj4wAcluSuv+GKT5OdZL2cg7FZWQWMzQv2eq4SnJO2uXW4bWvT1GswuZxIuPQUmw/77r09i9/R1SKigbymlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595520; c=relaxed/simple;
	bh=iKpFG0Av0hoqoOlPYCyOzyzjoAeTHTDVQHbGXDPimao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upk9evHodmZZTQEBfYJhMI9UnBC0Xg9Q4wshKQKx1NVyD9ggUUeON7ctwtW0V3w+XW1+pXBGeCGBQ2OuHHDElyJ0pLDfEfbAXbnG16VILvLWj5httCPnpc8iT31Up6ZVE6bsJ96vDEUMjm8MT7zqrd82LGmm8vrOngsq4csJ8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCxyw7jc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48529c325f0so27041655e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595518; x=1774200318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=MCxyw7jcQUketWPDXn6YA/c9jegxAxqw2iy6SMgpnMTSbNb+GM0xZxBWRWGdaLE+ve
         CmOc+fA+m2rJ6KjEb3TNyQLN4XmSZu+y+D7J9KJcGooMY3vZaeTIIRP7Lmd7e7owSF06
         PCTmLqQieGNFisw1FuPaiHPMBJtXrLAVtSd3nj8gouSxzM/nY4Ai9tLIBlIfbFayA4Sx
         BZMkyqH/F/L6bjkv3jetwXgQvNmNGmdW2EM3HbeRXej1UEIc25nKJTNjsk3u5fSC6uzx
         Y5Dk2P8R29oxRo2EUKboYLWAtgSMR3FthtptmBAeBkB7HdP86s7UN4OyieWs8s0wxIYl
         jMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595518; x=1774200318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=qVMJkdO0VqObdotPKQ/bHr85bsp5iJ6Ba9kOCXMMJ+qozP5o4T8QCejVSh8IgLrnAk
         WD8eixXqmi0QtjkjxSg13HL2EjK6yoJCQnMcyefJ9PBIl9YH8LHQ3Na6/+wQOsBRX2cD
         YxUDEXBfz/cGPm7CKvR5D/fEMzX3GtA0qUhEUyQkMmtMMgZLGzRP4YqAN1dUnKQSGQFH
         KjbrUYHulzbmx9v15OWf25AW3+lSqkAsa/FO04JPpK9yursh7ubySHJ8fYUmuiPT784T
         1u0132FsYmTImWnvqfB+KUmP/NDY0pXVMzUj9VRS0VCLvNuVrh0yGwhcXrXBva8rvQ2k
         W3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXLKht/kT7gLAKEFcx7VEOKZcZjwZlyRZjNWwQVmh/Fkk/wqwq5mbQE5poHm97qUtlaDPUYTQzV8bJUuk+YrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwewOJMiDDEMz92T19FbePELgHVbpGUspL2TTmtxj1pfB/Ayt91
	i3v5m9YtMZt6Y6hDffqqdjh7FIu9SbhKvEVnOgutuxYpJ481yIy9bLPJ
X-Gm-Gg: ATEYQzw5IaZty6vVq249AH9anIxFxbXgTUz19h6N6w+b8BtJ91m16UVSN2nm0VKGKxm
	pfwrogP1Acqd9btpgyVCUIaJrEax5PyI4wC8TOCeY2+1d1GW5GXpoF8HtqTP25kM4iOQYsqhQ9x
	EaCfIScDlPjFR2EdEdDCighuwDUh3kdviYeFkfnrJSSOPeDb0B/YfEyPfMwRyN2iG6msa25s7Y8
	zWM0RH+XHw8ccIEOJaZOCcXAFv1K6kfFqU6GOKjh5AOBno7pBXgDx61Pa2rvjwRLnqRqfiYsecL
	PLcI1U9hPJMVnXVYfqigEJE+qfAkJ9K00/d7ua8yDEU6C5UL1sgT0VXYLn8aXWU0RyZ82yi0wyi
	jQopQWuK/N3+A184lCFnT5a9PAS0IZCG//U5Xvu6PO7yvOodBoTiORSF1TpHO0uG0jX//aFNXK1
	74GYJ21WMyJoCOrLNnVmF+rp5kFyAruVAhtRs=
X-Received: by 2002:a05:600c:8489:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-485566f7a2amr181338655e9.17.1773595517762;
        Sun, 15 Mar 2026 10:25:17 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:17 -0700 (PDT)
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
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 18:25:06 +0100
Message-ID: <20260315172507.270480-3-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
References: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33250-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9B5B291BD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
allocation. This aligns the driver with the latest PinInit zero-copy
initialization abstractions in kernel 7.0 and fixes a type mismatch
with GenDiskBuilder::build().

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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


