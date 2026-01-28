Return-Path: <linux-wireless+bounces-31260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HFwG4e/eWl/ywEAu9opvQ
	(envelope-from <linux-wireless+bounces-31260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 08:49:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB09DDAF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A89BB3003BCA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 07:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF12FFDFA;
	Wed, 28 Jan 2026 07:49:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B32BCFC
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586562; cv=none; b=CvzyyJtfNlDHsO9yZSXkgeZiF2/lVxwX9Bxrln+kcZ4SwfEd/Mg0tUZhlEDbN5k3JJ0D+j9+GhgXqI7b1jq5FEyCxRDLRHoT/prvbpycZkEHzKLOnngIpo/d6oMs6Od+8IebiM6jwESjbe0yZgpsJDm4diOoY/U1wlQK/dK/tMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586562; c=relaxed/simple;
	bh=5Jd1u2LYBXz8lrxKiWu2R9AaCF0lIiv0uKhjJuh4G8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMn9XSxXS4y7IXjzhNtj/LQpl6pBJcztNd4SuaL4bSUI5idZ/fS1ore05Gi2vJUbO38GSXW7LhujdkpQAl/RJzjag9+XSHCzWTo92X7neSfqNQnyDHpwQPEbmKGSQhYIq3jJgvhhWaVAVIZ7rk1ItsQJ1rhT7Gg0TCiYpzq8hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id B02405FD53; Wed, 28 Jan 2026 15:42:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	druth@google.com,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] wireless-regdb: Update regulatory info for Canada (CA) for 2025
Date: Wed, 28 Jan 2026 15:42:34 +0800
Message-ID: <20260128074236.965019-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_FROM(0.00)[bounces-31260-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canada.ca:url,ic.gc.ca:url];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org]
X-Rspamd-Queue-Id: 3EDB09DDAF
X-Rspamd-Action: no action

Canada issued a new revision of its regulatory standards for 2.4 GHz
and 5 GHz license-exempt local area network devices - RSS-247.

Update the rules to match the new version. Fix up band boundaries and
power limit values and units to match the text.

Note: the database is supposed to have values for e.i.r.p.. Most
regulatory documents specify e.i.r.p. as well, except for FCC ones and
any regions that have rules based on FCC ones.

Details about the changes and justification for them are as follows.

- 2.4 GHz band boundary aligned to actual text instead of WiFi channels

- 2.4 GHz band changed from 30 dBm (1W) to 4 W
  section 6.3.2 explicitly states e.i.r.p. limit at 4 W.

- 5.15 ~ 5.25 GHz band power limit unit changed to mW
  section 7.3.1.2 explicitly states e.i.r.p. limit at 200 mW.

- 5.25 ~ 5.35 GHz band power limit changed to 500 mW
  section 7.3.2.2 states e.i.r.p. limit at 1 W, but requires TPC for
  e.i.r.p. above 500 mW. As the database nor Linux implements TPC,
  the 500 mW limit is chosen.

- 5.4 ~ 5.725 GHz band combined and power limit unit changed to mW
  the new revision removed the restriction 5.6 ~ 5.65 GHz usage.
  the two existing rules are combined to cover the whole band,
  and the upper boundary has been increased to 5.73 GHz to cover
  the whole WiFi channel and make it easier to write the rule,
  like how the US rules are written.

  section 7.3.3.2 states e.i.r.p. limit at 1 W, but requires TPC for
  e.i.r.p. above 500 mW. As the database nor Linux implements TPC,
  the 500 mW limit is chosen.

- 5.725 ~ 5.85 GHz boundaries aligned and limit changed from 30 dBm (1W)
  to 4 W; AUTO-BW added for combined usage with next band.

  section 7.3.4.3 states maximum conducted power limit at 1 W, but no
  explicit e.i.r.p. limit is given.

  apply "e.i.r.p. = max conducted power + 6 dBi" conversion, arriving
  at roughly 4 W. This aligns with the ratio for the 2.4 GHz band.

- 5.85 ~ 5.895 GHz band newly opened in this revision
  section 7.3.5.3 states maximum e.i.r.p. for indoor clients at 1 W or
  30 dBm, with maximum e.i.r.p. spectral density at 14 dBm / MHz.

  Apply spectral density limit at 20 MHz channel width, arriving at
  roughly 27 dBm e.i.r.p. limit.

  While the limit comes from the "indoor clients" rule, it is the lowest
  limit of all the types, hence it should be applicable without any
  restrictions.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 db.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/db.txt b/db.txt
index dc72989..64bc853 100644
--- a/db.txt
+++ b/db.txt
@@ -388,15 +388,20 @@ country BZ: DFS-JP
 	(5735 - 5835 @ 80), (30)
 
 # Sources:
-# https://www.ic.gc.ca/eic/site/smt-gst.nsf/vwapj/rss-247-i2-e.pdf/$file/rss-247-i2-e.pdf
+# RSS-247 Issue 4
+# https://ised-isde.canada.ca/site/spectrum-management-telecommunications/en/devices-and-equipment/radio-equipment-standards/radio-standards-specifications-rss/rss-247-digital-transmission-systems-dtss-frequency-hopping-systems-fhss-and-licence-exempt-local
 # https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf11750.html (6 GHz operation)
 country CA: DFS-FCC
-	(2402 - 2472 @ 40), (30)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
-	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
-	(5470 - 5600 @ 80), (24), DFS
-	(5650 - 5730 @ 80), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (4000 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (500 mW), DFS, AUTO-BW
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+	(5470 - 5730 @ 160), (500 mW), DFS
+	(5730 - 5850 @ 80), (4000 mW), AUTO-BW
+	(5850 - 5895 @ 40), (27), AUTO-BW
 	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 # Source:
-- 
2.47.3


