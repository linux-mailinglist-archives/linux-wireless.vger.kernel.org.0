Return-Path: <linux-wireless+bounces-28241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A930EC08E1F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779574E11F4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84222129B;
	Sat, 25 Oct 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="RaGNwZb9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-outbound8.duck.com (smtp-outbound8.duck.com [20.67.223.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AF1F4CAE
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.223.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382546; cv=none; b=bGEN6lKCJCciksoxK21THq3Vay3ZWX967oKxTEAoXDhj18PrCD1DaOY1BIEugqczFe4vw28UQYHJQzwZEX3xjsI2V5Nj8q1OoG1AG/W9r/bengur17SBT1uzV0Mh7J83umUgD9SkE6bVRzAfkEWv3IddQAqdZEYA5ByVt2usBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382546; c=relaxed/simple;
	bh=PQjm/epzb1I7LJO3G2SLFh9JS4zKVn22NumIJ65TAmU=;
	h=Subject:MIME-Version:To:Cc:Message-ID:Date:From; b=PFI8cqeAbiw6j8ofM1vsIJ0zGvMQGgMyzI5YDHBx7q78Mn0a147DvW9S9VNcU08FV0WVznYj+GEYngofCI5SY4LbtXImMaeDQj1wCjvVoY79Vg6r6NyZQn3C8bsw9Wjs22FSd8Zs2DJpzzvcVO7YGpTeswwhCJMmTyX9oKUlemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=RaGNwZb9; arc=none smtp.client-ip=20.67.223.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
Subject: [PATCH] wireless-regdb: Update regulatory info for Brunei Darussalam (BN) for 2022
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
X-Rspamd-Action: no action
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
 Hafiz Zafran <hfzz7@duck.com>
Received: by smtp-inbound1.duck.com; Sat, 25 Oct 2025 04:55:39 -0400
Message-ID: <6CE7089F-5113-4210-B09C-2DDEC06A2225.1@smtp-inbound1.duck.com>
Date: Sat, 25 Oct 2025 04:55:39 -0400
From: hfzz7@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: Subject; q=dns/txt; s=postal-KpyQVw; t=1761382543;
 bh=7aeFWucAJ5b1P9eHusXCkS37rYsvW2nu12CFLMSqyV8=;
 b=RaGNwZb9pl/ni5gZKSfiZNlH8FAZQrvnJFLiu0paM1H/D+dSXUvCpRw5+PcHLWUzy5Ym2+qr0
 p4DETQWJ1Gp2NNEhxgJ/13FUTKPW9SfGu0OyZuaAxyz63vn32faR77phw1+fcY7NHUlioHVjZWb
 Uhe5Eb6Qfix9L7Gg8/cb/lI=

In 2022, Authority for Info-communications Technology Industry of Brunei Darussalam (AITI) updates The Brunei Darussalam Radio Spectrum Plan. [1]

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

Note: According to the Telecommunications (Radio-communication) Regulations, 2013 of the Telecommunications Order, 2001 (S 38/2001), "non-localised use" refers to the operations of specified radio-communication equipment or network at a specific frequency or in any specified frequency within the whole of Brunei Darussalam. [2]

[1] https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
[2] https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2013/EN/s086.pdf

Signed-off-by: Hafiz Zafran <hfzz7@duck.com>
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 1d17271..8e5cbb5 100644
--- a/db.txt
+++ b/db.txt
@@ -326,11 +326,15 @@ country BM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-country BN: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (20)
+# https://aiti.gov.bn/media/planjc1p/bd-radio-spectrum-plan-2019.pdf
+# Section 7.5, Page 244-251
+country BN: DFS-FCC
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (1000 mW), AUTO-BW
+	(5250 - 5350 @ 80), (1000 mW), DFS, AUTO-BW	
+	(5470 - 5730 @ 160), (1000 mW), DFS
+	(5725 - 5850 @ 80), (4000 mW), AUTO-BW
+	(57000 - 66000 @ 2160), (10000 mW)
 
 country BO: DFS-JP
 	(2402 - 2482 @ 40), (20)
-- 
2.51.1


