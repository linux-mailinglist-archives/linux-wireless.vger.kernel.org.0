Return-Path: <linux-wireless+bounces-31626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQhKNg4hmmcLAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:54:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A0A1024BB
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365F0305594A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1D3358B9;
	Fri,  6 Feb 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="JSeHRfg8";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="BMD4PauA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99B3101DC;
	Fri,  6 Feb 2026 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403933; cv=none; b=CjRlhn5HqVhApQGZnLtcT+Wie60ssa2tv2o/Zjh928e3fmi1ZiTTm4Jg6sCeDk5AVyMx0CPyfaup6y227TuDde1czWnGMU6Wen7wfGfsQk4NCewKJvhCZugWHFug4eREOeoMfk7Dk1IT3Aiql1YFtx75F1gr2lYy4/X/cf+njJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403933; c=relaxed/simple;
	bh=6yfCy7W4tFeioUdd+RifpTlM5OStWrizeOn8nuIcu+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIULWN4yzcJm2QTAWkTNmyh0xxTYivQo2nGeFliO2VuGMwIb0OX/lqxx8PGafsxLREQymXYF3YEKSeZ6G4sNxYBusz/gQhBkYUXd7jFXsG1/BM9D9PWvF82O3Ua/pwD7H7JOeOF3dcncVGpGVaifvpZtgNgyrivl83mISA429kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=JSeHRfg8; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=BMD4PauA; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770403928; bh=XNr0FzGsrf4Uo7sUvlAcFvN
	exWs+LzbVsCAH5WagLxs=; b=JSeHRfg8Nhz99yzYo611Y1PB7/9fk3lEQn2pifk+VuvqBgYg/z
	oYGjEBmuk85LtGl7VVlorJxH8jwvWklQUU5zB4BgvreU9FzmUlxVdZFxWBtwoxde2QLe0r8L7CF
	XUYUL5DudBRUX29afaHOnqyOIaOwzT36Iwd7uEiU1HSpgr58Qw1LlcSowhG8ITFyQ10HDyR8c3o
	bbc6hPZSALH7IXheWmmeUOIkD2aPC9Fi1a3rxFK8yJ3h4Yxl1FcUx9/dZylOP6RtVjj0aW7u+3c
	a8nXgEalI6hKHhIcE4w1qgLmFKPYYVSyprwpyyJj3V3RgIgZFcj9IFBkblTuiv315oQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770403928; bh=XNr0FzGsrf4Uo7sUvlAcFvN
	exWs+LzbVsCAH5WagLxs=; b=BMD4PauAl2XIwV0JZYOSRiPpxrM0pezkNE3aXLyoVHvFm0Q0JT
	CTZmJgKRz+R2NITKXfEsnyNCA8SHHQyUO6Cg==;
From: Daniel Hodges <git@danielhodges.dev>
To: linux-wireless@vger.kernel.org
Cc: tglx@kernel.org,
	mingo@kernel.org,
	joe@perches.com,
	vthiagar@qca.qualcomm.com,
	rmani@qca.qualcomm.com,
	jouni@qca.qualcomm.com,
	kvalo@qca.qualcomm.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Fri,  6 Feb 2026 13:52:07 -0500
Message-ID: <20260206185207.30098-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31626-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9A0A1024BB
X-Rspamd-Action: no action

The aggr_reset_state() function uses timer_delete() (non-synchronous)
for the aggregation timer before proceeding to delete TID state and
before the structure is freed by callers like aggr_module_destroy().

If the timer callback (aggr_timeout) is executing when aggr_reset_state()
is called, the callback will continue to access aggr_conn fields like
rx_tid[] and stat[] which may be freed immediately after by
kfree(aggr_info->aggr_conn) in aggr_module_destroy().

Additionally, the timer callback can re-arm itself via mod_timer() while
aggr_reset_state() is running, creating a more complex race condition.

Use timer_delete_sync() instead to ensure any running timer callback
has completed before returning.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index c3b06b515c4f..25ff5dec221c 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		timer_delete(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
-- 
2.52.0


