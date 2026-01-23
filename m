Return-Path: <linux-wireless+bounces-31103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDfyHP//cmmrrgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 05:58:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF20705A3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 05:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60877300831C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33C3933F5;
	Fri, 23 Jan 2026 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="LpNVEgpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4D314D23
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144316; cv=none; b=JsFbAireFaCCYqZTG3VTrTMJjpCRFxfPRQ9CbG7ZO1DwLmeHxrXmXsU4X3wGH+5jmv7cOZRpFfPlriK1tkYnWzso9MtMcRTrjANv/EGD7w293r7V15gpFDqiJ61+i0fiD4Z1peMJ7KMaEIvXW1Ca8FbviuekZgB3pX3Az0SoyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144316; c=relaxed/simple;
	bh=lYsrQ1EJwEWL/1e/oTQamNHkx7ztcxzCi6MRAQrIUXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSR//6UPzIgZPEboX4cdqO091h1c1zhi4aTya6BtRqiL2yqnSloB3iVh8PNyuFU+Yp2+XhaR/linWQHndLDdwoMoFw74wW1ivhHyAHFLDmJ34NcFg+5rtQL8okXVFPMZyIRN661T1LTBBbtWi4lTMOHgJYM7wgLD3pdsvhx7Rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=LpNVEgpU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662b5db048cso504627eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769144307; x=1769749107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TaN6HO4UpfTa5x1GQ53EAUUeL9sRzG0T0kFV13YYQg=;
        b=LpNVEgpU6/wfulMe4txjV/vQCyU0S9ljMlhRVazh8qeSGdoEfA4vixaa9b2KcToNW3
         78WipYGCNGuw0L24sdvxgsxm5E+NIxHyo8CsmzhDLvXu1pQcgKc3xNxvhOyeZnp8ca76
         6FJfbXksHaY7igQGt/Mxqq6OWSZ/hrCVwo/HjGB1s/+3LIjJscwGqVegekvm0m2Tn408
         d4GRrdoDzcxIKPYf10FXBRavdh7d1vNRrxO3T7RZ76Nr8AcHJ7WROY4fgCl6o/d7DrpW
         WaN5DA+TkGipJ8WXeNKvpANBrdQ2baLc8H+V9HxRz6g6shaUe78rNGRIjvq4X0xhljtE
         7REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144307; x=1769749107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TaN6HO4UpfTa5x1GQ53EAUUeL9sRzG0T0kFV13YYQg=;
        b=LVCe2OgQCjhQfF3fOutaFcFqJo25tdqCWk5kwy5B/XU0rNM0BEz2RD2ARShCPqowei
         X1T994U912sCBPRp9R5S/xTQ57Efx9d9bLOyC8ZXIm4gYunS1MAYylSZJLQHIQM/j3Oh
         /kKPIV/pCvXPpXCoCu1ZcZ6cApBpOQHAny8lrhg9tGIlfWE/fKhxNIWGg+Arosjxu6Xw
         YtYr9LGp+H904VpJnmWFkvly8qNjZCXr1BScJpbCNURvHCryhmHXhot7SLj7VBC8oOc1
         Nw4hJyaPqR3qbAGir7/W5xTDH9iYKSny3AeO0r3ILMShoVMeaI8mlq7mnRpCpNqG0JPc
         E/PQ==
X-Gm-Message-State: AOJu0YwscQaseWzIfQVh2fC/dqRuNmq/nBChKF/8uuyBrfpUUgLziDt/
	9X5IZxeoWBbaWqWULg5h2Y0UMJXVBY0xncvxyMnLWgC4aawtoGVrUAFLeQIhsWpQKB0=
X-Gm-Gg: AZuq6aJknfpr/RHb1Y1GwTDzTrhKqV5HYumePYJxyQUU7oSUbhRE+o4gAQIvGKs7G4H
	udHrIV5zWVA6pObCt7nBBwORoUHYQskFUNMaVC6iT1ICeeeMQvH6j7GmYYLDMzn1y23hnXRf5Eu
	gCevEuNkynNofwDauNKo2BhMrG6nvdx9ilN/1tCMmedmImr2+F6h1B9mI0XfrZTTPbbPeoaeSTa
	8YwAE5ALL+sU+SP26a8KrRYKdxm6VZUIqN/qk4oHfsGwrx+twu9rQA3OEQgSXNOdcRVQfU5CmCt
	AAldWAT1hgItU7JgNabJQMWj7xR88mZSS2YFBYRoO1S3rgCXT11BburyVOEXU1LUNoDbOABtxg8
	MbQ5Deud1IiGAFT+12Tm39xydLMrdnCQgn6vaWyV14e+Dvg2/y22OhMMy7QEPw0sjIAXa3L4YlV
	LCx1X/gMuk/efFbUTIgFSVnEvKHm2h6631bwd/0yabLctRVCBW0JX5tGN7avqsQN8zJPJVHtou/
	+qywiwSqBEFKkiCsvAJseWnX2QAoz/mIlm6Fr+D1Q==
X-Received: by 2002:a05:6820:4c17:b0:659:9a49:8f04 with SMTP id 006d021491bc7-662cab0991fmr870166eaf.21.1769144307361;
        Thu, 22 Jan 2026 20:58:27 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb662e90sm600579eaf.14.2026.01.22.20.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:58:27 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()
Date: Fri, 23 Jan 2026 04:58:22 +0000
Message-Id: <20260123045822.2221549-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31103-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EDF20705A3
X-Rspamd-Action: no action

ath10k_sdio_fw_crashed_dump() calls ath10k_coredump_new() which requires
ar->dump_mutex to be held, as indicated by lockdep_assert_held() in that
function. However, the SDIO implementation does not acquire this lock,
unlike the PCI and SNOC implementations which properly hold the mutex.

Additionally, ar->stats.fw_crash_counter is documented as protected by
ar->data_lock in core.h, but the SDIO implementation modifies it without
holding this spinlock.

Add the missing mutex_lock()/mutex_unlock() around the coredump
operations, and add spin_lock_bh()/spin_unlock_bh() around the
fw_crash_counter increment, following the pattern used in
ath10k_pci_fw_dump_work() and ath10k_snoc_fw_crashed_dump().

Fixes: 3c45f21af84e ("ath10k: sdio: add firmware coredump support")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index c06d50db40b8..00d0556dafef 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2487,7 +2487,11 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
 	if (fast_dump)
 		ath10k_bmi_start(ar);
 
+	mutex_lock(&ar->dump_mutex);
+
+	spin_lock_bh(&ar->data_lock);
 	ar->stats.fw_crash_counter++;
+	spin_unlock_bh(&ar->data_lock);
 
 	ath10k_sdio_disable_intrs(ar);
 
@@ -2505,6 +2509,8 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
 
 	ath10k_sdio_enable_intrs(ar);
 
+	mutex_unlock(&ar->dump_mutex);
+
 	ath10k_core_start_recovery(ar);
 }
 
-- 
2.34.1


