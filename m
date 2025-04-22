Return-Path: <linux-wireless+bounces-21853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B289A97578
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3331B60BDA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908C1F5437;
	Tue, 22 Apr 2025 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="obn1HTZc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A82367B5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350379; cv=none; b=WEu2sfk62BUnynJ9RV7+WSQgY8+nwzaqDUurhfAJW+vjUIiN/TDiL64KPLxZnI1BY4uXsbNxSnHGXcrC3u/DqA1ZlQvOHGZ6ef/Mv7oBOEvyttZkvtyc6Rfp5J95WYpQvwkmbPrYOugKxCWOlm43d8QeMLkSk/zoNUrUEkekVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350379; c=relaxed/simple;
	bh=dIUy4ak7bK9FmBjUAO+fQ20CPx9jOoEV7DHLw1ktlKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gC/dY18rYCGGHYQT5AKILfmYeY+U/TwByS97SgzSN1h4gpRrLl541ytCx1nSG18PIR8mvaM5klr237j56szmR024XbwpG3N6dRbfWg8I5B/e6hcJOGJ6QmxsAKuxrss6asgPLEhROx8vwlnHdIjRfz/aunwjNzrfu2m7fobXZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=obn1HTZc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1xm8MbhmR2nTapsEcJjTMsoaopmfVAI/WW+c9qjHrsg=; t=1745350378; x=1746559978; 
	b=obn1HTZczDeMjVcWUEoXbq1AiEuKJHzbs9/7QwKOywHU9JnGg38/N21fV4dWptpvLi9W14k+LcU
	4mfTnZi2G5rxe8xMOosZ5Bs0OsaWKkt41O3e1eMKpllJoTXQB6xhfxy1SdsvTaRmYRG3owOi67WEN
	vxQanLiKWkQOG4CwmJCVMo99XraZ/bYftcjymzGSrBn2hPYlUSBQLR0s3l0vjWemyob1QMnrL2qkC
	U67udLe0hCPiY1jkFjHh0lwk6x/zL6hkCB7dGNrdaKlHMjbgo67kvNyrwDJUbd0Abry9vXDD+X9aX
	usPekSqdp6llYHjoSAuoei73bYFB4aLpv8qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7JMT-0000000Cehw-20dx;
	Tue, 22 Apr 2025 21:32:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: restore monitor for outgoing frames
Date: Tue, 22 Apr 2025 21:32:51 +0200
Message-ID: <20250422213251.b3d65fd0f323.Id2a6901583f7af86bbe94deb355968b238f350c6@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This code was accidentally dropped during the cooked
monitor removal, but really should've been simplified
instead. Add the simple version back.

Fixes: 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/status.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index b17b3cc7fb90..a362254b310c 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1085,7 +1085,13 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 
 	ieee80211_report_used_skb(local, skb, false, status->ack_hwtstamp);
 
-	if (status->free_list)
+	/*
+	 * This is a bit racy but we can avoid a lot of work
+	 * with this test...
+	 */
+	if (local->tx_mntrs)
+		ieee80211_tx_monitor(local, skb, retry_count, status);
+	else if (status->free_list)
 		list_add_tail(&skb->list, status->free_list);
 	else
 		dev_kfree_skb(skb);
-- 
2.49.0


