Return-Path: <linux-wireless+bounces-31627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLfIJJREhmn5LQQAu9opvQ
	(envelope-from <linux-wireless+bounces-31627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 20:44:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71E102E18
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 20:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 296CC3004D34
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6330E0D9;
	Fri,  6 Feb 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="iZTWL1gD";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="5whLnhAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24D307AE4;
	Fri,  6 Feb 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407055; cv=none; b=LqHS6mjt8642+m6f6D6xMaQSCoRdd3Gj/JDIR6NtYQVPkfpjJUqgeunw+SEj7EonpI/Wkjo8TdA7IH9qMvAknv03+oWY+wPoS1rDN4gz5JMyC2l2TmwnbFXcgxnoOnE80xpJfH+tz5Co6/NlsbgL2twYDaoPTjWlCmrpcmm3ewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407055; c=relaxed/simple;
	bh=LhwWG2r7Ww6fOg2VoYJfocmn1GCzXhPwMp6I9Tbywvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eC+73NykHuOdgb4HogoQjpLzNkyyleZb6n7BMuugZIbFoXa3UNYhozJ1kvf+n+1qdcWYP4ei+1ePE8CnQ5KHkuVRpSq7FyE83ksntOSK7k4wCkn5wF2A1nOyXLzNJ+FORhYvzr4N6EyvXYZpC06mCMiaStuFt14xgMmU3RWIq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=iZTWL1gD; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=5whLnhAU; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770407041; bh=32LE/KoR10luMKllipYKpEK
	C+tmhCHdKbkkvguW08kk=; b=iZTWL1gDUEHtjy7edQuj+6PAzOA8qa+0H1kWp7HblwWKotHBTn
	XaypDq/DN1zNNlABuXvQODj7gxm6dG2nU2DwdI+8Cd4AFJRgWFlxS2DePozRHiI6I9I1UJbE1+t
	YO2D6uLMlOrO6zGK9CGB/T95kfqaTdQ9xkPmoZ+RkfsdjZMtyxy6LMVN69HfiLUTu7/VaRhMdsK
	tW2G3vT4/oDMLubAKz2D8YtvYUtWwQRs2QZ8ae/KT7oypeTOH2OB1p+HdQqIoeKhlf8bqYdv/6R
	LTPQlUHRC4NRbYj6SXGE1JoMtLjYyRjpv35GJb+IHNAw9RYh8HfNmCA8RhVnteoGuDA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770407041; bh=32LE/KoR10luMKllipYKpEK
	C+tmhCHdKbkkvguW08kk=; b=5whLnhAUVpt792npxDS1sUSZko6ZNlJakzlASIBoSx2znWJ3LR
	ydIQMlU5P626KPxvCSZWvp7LLgtETH843fBw==;
From: Daniel Hodges <git@danielhodges.dev>
To: Brian Norris <briannorris@chromium.org>,
	linux-wireless@vger.kernel.org
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH] wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
Date: Fri,  6 Feb 2026 14:44:01 -0500
Message-ID: <20260206194401.2346-1-git@danielhodges.dev>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31627-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0B71E102E18
X-Rspamd-Action: no action

The mwifiex_adapter_cleanup() function uses timer_delete()
(non-synchronous) for the wakeup_timer before the adapter structure is
freed. This is incorrect because timer_delete() does not wait for any
running timer callback to complete.

If the wakeup_timer callback (wakeup_timer_fn) is executing when
mwifiex_adapter_cleanup() is called, the callback will continue to
access adapter fields (adapter->hw_status, adapter->if_ops.card_reset,
etc.) which may be freed by mwifiex_free_adapter() called later in the
mwifiex_remove_card() path.

Use timer_delete_sync() instead to ensure any running timer callback has
completed before returning.

Fixes: 4636187da60b ("mwifiex: add wakeup timer based recovery mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 4820010a86f6..5902e2c821f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -391,7 +391,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
 static void
 mwifiex_adapter_cleanup(struct mwifiex_adapter *adapter)
 {
-	timer_delete(&adapter->wakeup_timer);
+	timer_delete_sync(&adapter->wakeup_timer);
 	cancel_delayed_work_sync(&adapter->devdump_work);
 	mwifiex_cancel_all_pending_cmd(adapter);
 	wake_up_interruptible(&adapter->cmd_wait_q.wait);
-- 
2.52.0


