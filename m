Return-Path: <linux-wireless+bounces-36534-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIEBC7pDCWr3SAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36534-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 06:27:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BA55F315
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 06:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADA3B3005590
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 04:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2D308F26;
	Sun, 17 May 2026 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyndeO20"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FA2F7EEA
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992055; cv=none; b=vEtL39jMBh7FBa/IouaX473csZu21U8yx6zv4CWma26WzdLPPP3ueyN0ukQrFn/vu6cYPq9mz+5lUpljlstWhPcqB1OWVtr41trU0p8Y+7Z1EQ9AduCQQetgV+ylhet2PI6+aWoM1yMnVf2krDhEji3PI7iU3BmSFMveOaGD50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992055; c=relaxed/simple;
	bh=ygmSXCXK8eNSoZ3xS9hSZvc8k8v9GD4nJKF95kpJoyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSmqpfjNtKhhlAuHSaD2IkbtGjInsNDuKN26VTEFLktj4l/GztexovPxG5BR84QKgHqDilPSy+j4+lHxe0q4VJ11RSM0YqA0YdUGPj0+wcnIWmjQEqcCLqMBSoWvAtFRL1ApM4iocpdHYHVpGsI8ZzC0LEB/IKnMx3CYYyATpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyndeO20; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so6973225ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778992054; x=1779596854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pp/9zZs5nlRYKvE9M7Qf49KtZUbVgu/YWLhMJjU+jtI=;
        b=IyndeO20UutAfYTZSlLyminmR5ajkAOXuQUEQaOp16NyE0Vvz+2acfuegFV8L+yVAC
         tso8guqfBhhi0KtxAP2TzFn7FNjha4nZ6y2wOvbw10o3ou6pMLck3CLlcNaDyIo3UsGh
         mER4wv2YLlqhJ++IBF+blW+f4stHwWziIuiqdUVB32dCcBd6sYYKOy6fLq4/m0HN8gSt
         tWtyZYwE9t3ag7SaDdFMtN+dvxTAybWFfBC0fE2RoV9hH2kATyK/pjz/cNLWg8OBCPa0
         AUeBRfgTVBeoQmtOSBvKiiaLfEkhwUe10S6ZW6G4IeCUl6bUyQPOLuOoV+cCMRi6xDhG
         c0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778992054; x=1779596854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp/9zZs5nlRYKvE9M7Qf49KtZUbVgu/YWLhMJjU+jtI=;
        b=YdvH6SN7bcq+CeygHZce7lw3xxIbSpNSlazrOZub6PWTIJQpU3j2o0WQxyJHco56bI
         8+mO79yJzh7MSGsBQoonnI8Wr0sJ0f3lDXGczjPqIiQ3tqAZDF8pw84k2rh/ltkruW1z
         xlL4rzDabx4plRJsPwlrZtSuLN9feF+Yp/cP53vffa0kIQPZKbWqnoGW5K6g8ZICUdX2
         AV7r1qkcQ3USpSPCesDcl6Zlm0arBfzDbwtYe8c0MjNc3VTd7NuS0ZnTzRWiiHuf4gul
         AtzZna3Io3tv6RGcJbGkMXVA/HLjAEKdOy68t24FcoGOjd50MLDN7bEmk2c6GTyritCs
         MCUg==
X-Gm-Message-State: AOJu0Yzu0kPLYXIsmS+ubGa9b2rHfqUu4N3wfhS3DoqZ5DUZbEp2/vgE
	Xc6kXrxCTTetk5iVCZdtuiTEA56k6s1Kj+Y4KfRINNh35UTRLKyMwcjSBYPejw==
X-Gm-Gg: Acq92OFdUeAJkbi2cfObq8aflc69eXzS5jd6gIVNAs9MqqNi5N78nmKUhOl08K+QYa9
	BHWto2Gk7E4i30DhumRzeBH5LB71CyEy08Ap85o7GbPd/ArPUivHvAjXR/mNh5mncSU4+4iQVz7
	PWqvOWr2owkyljJdweJOnPAe54SEq2dhYEsiRjc6snR5hQMxZtbSFfrl8JeYQ8B7duUOOAa/ZWp
	yr5LCm5+MtpywTADfjtvQ6atMLRcWhouzoC3nAtWThb6FQigC5knXekwCm9O8R3HrSoPoeGlyLh
	5rheGruAnFUD2kZHVKJTODk9wob7yPMcFaa7+9sh3vvGBMk+xqOnFq+QLynPqRRmGHFBtwPTF/N
	eHfR7tBNjMWqfIZpa7gADO0MXQ6Z2QGHzTPl1KQSDZRalRBK/k8T4ntU7af1ai+/7Af0afUG6wZ
	dWRYgwTuja6WFivNXb3UTueu7XMODY7K/Qld47eWRZflLCckyKl0oB9J1i7hzIGys+7TgFZkS5e
	mv+gzxbqN2+gqD8J+SG71e6ibj5fGJzXBQ=
X-Received: by 2002:a17:903:4507:b0:2b4:5309:2c14 with SMTP id d9443c01a7336-2bd7e992465mr73561625ad.31.1778992053583;
        Sat, 16 May 2026 21:27:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d23a41fsm107598555ad.83.2026.05.16.21.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 21:27:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: Clear DMA descriptors without memset
Date: Sat, 16 May 2026 21:27:16 -0700
Message-ID: <20260517042716.2218386-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C93BA55F315
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36534-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Clear ath9k DMA descriptors with explicit status word stores instead of
memset(). The descriptor rings are coherent DMA memory, which may be
mapped uncached on 32-bit powerpc. The optimized memset() path can use
dcbz there and trigger an alignment warning.

Use WRITE_ONCE() for the descriptor status words so the compiler keeps
the clears as ordinary stores instead of folding them back into bulk
memset(). This covers AR9003 TX status descriptors as well as the RX
status area cleared when setting up RX descriptors.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_mac.c | 15 +++++++++++++-
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 23 +++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_mac.c b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
index b70cd4af1ae0..e355f94a9390 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
@@ -403,6 +403,19 @@ static int ar9002_hw_get_duration(struct ath_hw *ah, const void *ds, int index)
 	}
 }
 
+static void ath9k_hw_clear_rxdesc_status(struct ar5416_desc *ads)
+{
+	WRITE_ONCE(ads->u.rx.status0, 0);
+	WRITE_ONCE(ads->u.rx.status1, 0);
+	WRITE_ONCE(ads->u.rx.status2, 0);
+	WRITE_ONCE(ads->u.rx.status3, 0);
+	WRITE_ONCE(ads->u.rx.status4, 0);
+	WRITE_ONCE(ads->u.rx.status5, 0);
+	WRITE_ONCE(ads->u.rx.status6, 0);
+	WRITE_ONCE(ads->u.rx.status7, 0);
+	WRITE_ONCE(ads->u.rx.status8, 0);
+}
+
 void ath9k_hw_setuprxdesc(struct ath_hw *ah, struct ath_desc *ds,
 			  u32 size, u32 flags)
 {
@@ -412,7 +425,7 @@ void ath9k_hw_setuprxdesc(struct ath_hw *ah, struct ath_desc *ds,
 	if (flags & ATH9K_RXDESC_INTREQ)
 		ads->ds_ctl1 |= AR_RxIntrReq;
 
-	memset(&ads->u.rx, 0, sizeof(ads->u.rx));
+	ath9k_hw_clear_rxdesc_status(ads);
 }
 EXPORT_SYMBOL(ath9k_hw_setuprxdesc);
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index a8bc003077dc..97027d286317 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -352,6 +352,19 @@ static bool ar9003_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 	return true;
 }
 
+static void ath9k_hw_clear_txstatus(struct ar9003_txs *ads)
+{
+	WRITE_ONCE(ads->ds_info, 0);
+	WRITE_ONCE(ads->status1, 0);
+	WRITE_ONCE(ads->status2, 0);
+	WRITE_ONCE(ads->status3, 0);
+	WRITE_ONCE(ads->status4, 0);
+	WRITE_ONCE(ads->status5, 0);
+	WRITE_ONCE(ads->status6, 0);
+	WRITE_ONCE(ads->status7, 0);
+	WRITE_ONCE(ads->status8, 0);
+}
+
 static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 				 struct ath_tx_status *ts)
 {
@@ -370,7 +383,7 @@ static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 	    (MS(ads->ds_info, AR_TxRxDesc) != 1)) {
 		ath_dbg(ath9k_hw_common(ah), XMIT,
 			"Tx Descriptor error %x\n", ads->ds_info);
-		memset(ads, 0, sizeof(*ads));
+		ath9k_hw_clear_txstatus(ads);
 		return -EIO;
 	}
 
@@ -427,7 +440,7 @@ static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 	ts->ts_rssi_ext1 = MS(status, AR_TxRSSIAnt11);
 	ts->ts_rssi_ext2 = MS(status, AR_TxRSSIAnt12);
 
-	memset(ads, 0, sizeof(*ads));
+	ath9k_hw_clear_txstatus(ads);
 
 	return 0;
 }
@@ -591,10 +604,12 @@ EXPORT_SYMBOL(ath9k_hw_process_rxdesc_edma);
 
 void ath9k_hw_reset_txstatus_ring(struct ath_hw *ah)
 {
+	int i;
+
 	ah->ts_tail = 0;
 
-	memset((void *) ah->ts_ring, 0,
-		ah->ts_size * sizeof(struct ar9003_txs));
+	for (i = 0; i < ah->ts_size; i++)
+		ath9k_hw_clear_txstatus(&ah->ts_ring[i]);
 
 	ath_dbg(ath9k_hw_common(ah), XMIT,
 		"TS Start 0x%x End 0x%x Virt %p, Size %d\n",
-- 
2.54.0


