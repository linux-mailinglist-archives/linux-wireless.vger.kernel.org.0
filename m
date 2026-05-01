Return-Path: <linux-wireless+bounces-35758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HKJsGPvh9GlVFgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 19:25:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D74AE825
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56C9300CE76
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3630B51A;
	Fri,  1 May 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="ShwxBOZj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-outbound2.duck.com (smtp-outbound2.duck.com [20.67.223.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678291B3925
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.223.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656312; cv=none; b=cX4QNAED4sbR26PEQ9QZyz5fqUF+6WI6A8jdd4ueMzG7AOEX5C66E27MULcfQUHyuoMqJs0fuyUeTF0HBJlkgZ+moXeaxJZQKtUlEyEWDeA3N2l1SadRndYgTz8gg+YRkzAyMt+yYAoCBf3bs8CkNzjiWC9veqO1RySsDEAuKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656312; c=relaxed/simple;
	bh=uF8Aty2W+vu4RuQUsBR1pzk62W6yx/cP3bYKHLCV8Xw=;
	h=Subject:References:MIME-Version:To:Cc:Message-ID:Date:From; b=oZ2nDe+yyur749PZrHyesa/n6RRdH5U70087rq2N0UgnK2yXcpc13SiOauhgC8EjpdoOVTF5dEUIG8BNrSM9Mxx0kHJmisjAt7xT+z2YIA9NlM/qKKsafBXq/e1D3p3m7GwnGIjBDXpd+tv16qC8kE62/0qlP0Qyzijp2dyULWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=ShwxBOZj; arc=none smtp.client-ip=20.67.223.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Brunei Darussalam (BN) for 2022
References: <20260501153303.8521-1-hfzz7@duck.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
 Hafiz Zafran <hfzz7@duck.com>
Received: by smtp-inbound1.duck.com; Fri, 01 May 2026 13:25:08 -0400
Message-ID: <17568FCB-64AC-4CF8-9766-51FEE44EF7B8.1@smtp-inbound1.duck.com>
Date: Fri, 01 May 2026 13:25:08 -0400
From: hfzz7@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1777656309; bh=l1UwtWd1c8UqJaVQ/iUfxipLJLrCjKsXmb7tZDPmexA=;
 b=ShwxBOZjjD9zJQ/B2MQ++YEzEulIaXJuSZtsfVVz0xbG2JUE9d4q9bjlxnkv3lM0mkHr6u2gS
 ym35a0MIpJe/cny7covne64NSMa3BhkkDP+897eC9rC0rpGTS6A1Mi0zjB4qLSsHmCoklUoZBEf
 +dI0WkMfIpbYQN698AplLAs=
X-Rspamd-Queue-Id: 949D74AE825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[duck.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[duck.com:s=postal-KpyQVw];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35758-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[duck.com:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hfzz7@duck.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In 2022, Authority for Info-communications Technology Industry of Brunei
Darussalam (AITI) updated The Brunei Darussalam Radio Spectrum Plan. [1]

* 2400-2483.5 MHz
	- 200 mW

* 5150-5350 MHz
	- 1000 mW
	(For 5250-5.350 MHz, DFS and TPC are required)

* 5470-5725 MHz
	- 1000 mW
	- DFS
	- TPC

* 5725-5850 MHz
	- 4000 mW

Also, add regulatory info for WiGig/60 GHz
* 57000-66000 MHz
	- 10 W / 10000 mW

Note: According to the Telecommunications (Radio-communication) Regulations,
2013 of the Telecommunications Order, 2001 (S 38/2001), "non-localised use"
refers to the operations of specified radio-communication equipment or network
at a specific frequency or in any specified frequency within the whole of
Brunei Darussalam. [2]

[1] https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
[2] https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2013/EN/s086.pdf

Signed-off-by: Hafiz Zafran <hfzz7@duck.com>

---
Changes since v1:
	- fix grammar issues on the commit message
	- adjust transmit power limit to 500 mW for frequencies that
	  require TPC
	- add INDOOR-ONLY flag to WiGig, as per review
---
 db.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 3252521..2de3281 100644
--- a/db.txt
+++ b/db.txt
@@ -326,11 +326,16 @@ country BM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-country BN: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (20)
+# Source:
+# https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
+# Section 7.5, Page 244-251
+country BN: DFS-FCC
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (1000 mW), AUTO-BW
+	(5250 - 5350 @ 80), (500 mW), DFS, AUTO-BW	
+	(5470 - 5730 @ 160), (500 mW), DFS
+	(5725 - 5850 @ 80), (4000 mW), AUTO-BW
+	(57000 - 66000 @ 2160), (10000 mW), INDOOR-ONLY
 
 country BO: DFS-JP
 	(2402 - 2482 @ 40), (20)
-- 
2.54.0


