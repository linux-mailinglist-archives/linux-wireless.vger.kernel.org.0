Return-Path: <linux-wireless+bounces-18145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F465A21CF7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FE23A582C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A41C3BF7;
	Wed, 29 Jan 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paranoidlabs.org header.i=@paranoidlabs.org header.b="X4uui67t";
	dkim=permerror (0-bit key) header.d=paranoidlabs.org header.i=@paranoidlabs.org header.b="wg0+NsCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.hypatia.paranoidlabs.org (hypatia.paranoidlabs.org [45.11.248.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157411B4257
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.11.248.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152651; cv=none; b=urUzqgR53ZNwAzb4pflQyCuu8wMhS8MPzi/l9WlRw5lRXkqAjc/PY74Kwcp5xAbflzFOc0VvPjoGVNgdhO+pJpjQxpyGmnqYA0NuUX29CKXIZRRQw/v0qlDjilYh8rvYs0tIdo5My7h0pJjPiElazvyuiUa64O7hruKVz9cgSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152651; c=relaxed/simple;
	bh=AXsmmS0pX71sBLE9DJ3+irvoubuqFKdOj3JT3VbLZQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA/Gdp21vnlIZ8oxJ7j7Z2oZ8QfrZf9lY3ZzIFHdZSD3e1OoETJijy1uu4WSfLQJSNvQFxw6nCHeayLwizYzq+5wkTGybnZ+PemCxIgxESarEFCR+Ur06TH6gbq/hs0iFYdJQUNfmAnssLt+MOfxzJ7RjKCol96AoQfe3L4qTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paranoidlabs.org; spf=pass smtp.mailfrom=paranoidlabs.org; dkim=pass (2048-bit key) header.d=paranoidlabs.org header.i=@paranoidlabs.org header.b=X4uui67t; dkim=permerror (0-bit key) header.d=paranoidlabs.org header.i=@paranoidlabs.org header.b=wg0+NsCI; arc=none smtp.client-ip=45.11.248.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paranoidlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoidlabs.org
Received: from caph.lan (unknown [IPv6:2a02:1748:dd4e:ded0::3ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.hypatia.paranoidlabs.org (PlabsMail) with ESMTPSA id 1E9C43AEC1;
	Wed, 29 Jan 2025 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoidlabs.org;
	s=rsa-20210101; t=1738152105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ldVEcmtinS/lY7ECt5uwSWw8v2LtBLA5DVqAw8pk09c=;
	b=X4uui67tRuNT1IvAdfBJAIsloobVMTR3WLJ3YO840r4T1YTBzWuPGkNPFSPL+VmlQOcVd8
	ISbCQRf2/P3MD0GEB/lnNeHvz0MxyVv44f4vEfg/7P/IvEHqlh21M7x8C68eZ1AcbR8fDT
	HKkQ72QUPfcxzSYTlEtr8OKOZsw9DSZSLT/BGB2WAUEmolXU3pLfb3vE4NLJsHMII6IXyn
	9BfuVO0mOe1aEXZr2H98ZFQI9S0HZpLuFbgWBTrujaKMaOiRo73ZREykoxQD4mKX9Nb8fH
	rcvChUf6g/BAgwCSp3+fodEcAZsIrvzGjSsmZJ01dGit+VSGU7tbCBcIHjW8ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=paranoidlabs.org;
	s=ed25519-20210101; t=1738152105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ldVEcmtinS/lY7ECt5uwSWw8v2LtBLA5DVqAw8pk09c=;
	b=wg0+NsCITUZ88Y5NT0t3xJ+QUM+cslRdBsTah5rQvQJYZuQH+RgR53tmpc/N1f/ZaXWyLo
	EnxgIECMZ50WaoBQ==
From: Jakob Riepler <jakob.riepler@paranoidlabs.org>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Jakob Riepler <jakob.riepler@paranoidlabs.org>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Austria (AT)
Date: Wed, 29 Jan 2025 12:25:55 +0100
Message-ID: <20250129112554.27296-2-jakob.riepler@paranoidlabs.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the Austrian "Frequenznutzungsverordnung" Attachement 2
page 404
(https://www.ris.bka.gv.at/Dokumente/Bundesnormen/NOR40251378/II_61_2023_Anlage_2.pdf),
Austria extended the usable range according to the EU SRD Band 75a (Implementing
decision 2019/1345, current consolidated version:
https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A02006D0771%2801%29-20220210&qid=1738145465756)

This probably applies to most other countries that are part of CEPT
and/or EU but I'm not good enough with international law to be sure
about others.
It might be worth checking and updating this for many more countries.

This also updates two outdated links (the RTR one was a 404, the CEPT
one redirects with a warning that this link wil stop working).
Specifically the CEPT one might need updating for all other countries as
well (also the link now seems to refer to a newer version of the document
than the originally referenced one. v2.2.1 is from 2021 and was updated
to include the 66-71GHz range as well).

Signed-off-by: Jakob Riepler <jakob.riepler@paranoidlabs.org>
---
 db.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index e282e3b..8a5c0bd 100644
--- a/db.txt
+++ b/db.txt
@@ -114,8 +114,8 @@ country AS: DFS-FCC
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 #  EU decision 2021/1067/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:32021D1067&from=EN
-# Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
-# AT: https://www.rtr.at/en/tk/Spektrum5GHz/1997_bmvit-info-052010en.pdf
+# Harmonized CEPT countries (February 2021): https://docdb.cept.org/download/25c41779-cd6e/Rec7003e.pdf
+# AT: https://www.rtr.at/TKP/was_wir_tun/telekommunikation/spectrum/bands/1997_bmvit-info-052010en.pdf
 # AT: acceptance https://www.ris.bka.gv.at/Dokumente/BgblAuth/BGBLA_2014_II_63/BGBLA_2014_II_63.pdfsig
 country AT: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
@@ -126,8 +126,8 @@ country AT: DFS-ETSI
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
 	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
-	# 60 GHz band channels 1-4 (ETSI EN 302 567)
-	(57000 - 66000 @ 2160), (40)
+	# 60 GHz band channels 1-6 (ETSI EN 302 567)
+	(57000 - 71000 @ 2160), (40)
 
 # Source:
 # 'Item' in the comments below refers to each numbered rule found at:
-- 
2.47.1


