Return-Path: <linux-wireless+bounces-29014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E09C620EA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0635DE0E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160EA1F3BA4;
	Mon, 17 Nov 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xvLgk4+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C41DA0E1;
	Mon, 17 Nov 2025 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344991; cv=none; b=W2o/z9wpXFVGfMPLBnw2jc1XCX1vWnAv19jCLM0aETeLS3yknofGyL3R8dLvwO5FJCblYE/FKyvWjdB6eqsjLeqEkKyN03p6K7ld7ufB1EH/tYQypgJeaCQebSDdXph2VhLgdhSHAid0waH/hL7NC/WU/hTdHnGnkytQDHxMgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344991; c=relaxed/simple;
	bh=Knr80ZTro4c33wgNAZrm4WT3MZF7qPqrDSXCVeHJseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=er1NvEGJfyX56LT9QAGn9Bb7jXov5LtoMrLWKM3Cbn0Xxcczmeb7O0a6yqc8Fn8w15DDCAl4M3ng93Q4PGRSIFUcUrNsFJeJhwuFqRrkSsTiEl0vCdI9W9FdnvO0CNWCoGZoPi+99liY31/giFKY5lcHBFS0cbEYqt4XoqfvLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xvLgk4+m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Eh4GNByBCedca9B6eSInq4ZCrdVh1hL/k2mG6UD9rns=; b=xvLgk4+mxrIuhBa2QNEKej8eqn
	TYrz+dQQZB7zoZMKzVpK17d8h+v52rEOlzLsJ5bXpedWJmJKPyzi5S9o+hdkWdABGyCk7gi7fKVRJ
	VNXhAMYz6j/PNjniUoGQae1jDCnTusMQ39ysjsd7tzPGCsul9Q6yCrtwQfq4qsNbph9WSJGA4xOTc
	ayrb4V2kAStVn77l8raVoJ+LTK37KkLRBpik/HAAuIexkRj8zli1FlobPnqPBk7ufOvdZSexlSdTH
	N6Ll3Wugc62ub+OXzvysKB6dcrnOrOZdXhvGKXyv6M9+TFJD+wpOegoUufu9Dt91l7Oekzitaib6J
	qC9ATokQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKoa8-0000000FHua-47LB;
	Mon, 17 Nov 2025 02:03:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
Date: Sun, 16 Nov 2025 18:03:03 -0800
Message-ID: <20251117020304.448687-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Repair "bad line" warnings by starting each line with " *".
Add or correct kernel-doc entries for missing struct members in
struct ath_tx_stats.

Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
  may have had errors.
Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
  may have had errors.
Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
  Valid only for:
Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
  - non-aggregate condition.
Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
  - first packet of aggregate.
Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
 'xretries' not described in 'ath_tx_stats'
Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
 'data_underrun' not described in 'ath_tx_stats'
Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
 'delim_underrun' not described in 'ath_tx_stats'

Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debugfs.")
Fixes: fec247c0d5bf ("ath9k: Add debug counters for TX")
Fixes: 5a6f78afdabe ("ath9k: show excessive-retry MPDUs in debugfs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Toke Høiland-Jørgensen <toke@toke.dk>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath9k/debug.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- linux-next-20251107.orig/drivers/net/wireless/ath/ath9k/debug.h
+++ linux-next-20251107/drivers/net/wireless/ath/ath9k/debug.h
@@ -142,11 +142,12 @@ struct ath_interrupt_stats {
 /**
  * struct ath_tx_stats - Statistics about TX
  * @tx_pkts_all:  No. of total frames transmitted, including ones that
-	may have had errors.
+ *	may have had errors.
  * @tx_bytes_all:  No. of total bytes transmitted, including ones that
-	may have had errors.
+ *	may have had errors.
  * @queued: Total MPDUs (non-aggr) queued
  * @completed: Total MPDUs (non-aggr) completed
+ * @xretries: Total MPDUs with xretries
  * @a_aggr: Total no. of aggregates queued
  * @a_queued_hw: Total AMPDUs queued to hardware
  * @a_completed: Total AMPDUs completed
@@ -154,14 +155,14 @@ struct ath_interrupt_stats {
  * @a_xretries: No. of AMPDUs dropped due to xretries
  * @txerr_filtered: No. of frames with TXERR_FILT flag set.
  * @fifo_underrun: FIFO underrun occurrences
-	Valid only for:
-		- non-aggregate condition.
-		- first packet of aggregate.
+ *	Valid only for:
+ *		- non-aggregate condition.
+ *		- first packet of aggregate.
  * @xtxop: No. of frames filtered because of TXOP limit
  * @timer_exp: Transmit timer expiry
  * @desc_cfg_err: Descriptor configuration errors
- * @data_urn: TX data underrun errors
- * @delim_urn: TX delimiter underrun errors
+ * @data_underrun: TX data underrun errors
+ * @delim_underrun: TX delimiter underrun errors
  * @puttxbuf: Number of times hardware was given txbuf to write.
  * @txstart:  Number of times hardware was told to start tx.
  * @txprocdesc:  Number of times tx descriptor was processed

