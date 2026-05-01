Return-Path: <linux-wireless+bounces-35756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBfgBHXP9GkYFQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 18:06:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA34ADEAD
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3AA030075EE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83613EBF18;
	Fri,  1 May 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="lB73n/mL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpa-outbound1.duck.com (smtpa-outbound1.duck.com [20.13.235.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8A3EF670
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.13.235.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651568; cv=none; b=itVQMgVPYNOTvmuBsx2VlxsUZZaO61LM//lL4p9CfsAm3lHotWcpwp4P282+RqJOUAG9j284u1kz9EUPi+2OsNC71na3M+UFVTIFFsTgGsy3etW3KlhTgcqtjeoJGdxEDzOqh1/8htUyxJl1+tvTxyF+dClsZLfFlcDv7KCVrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651568; c=relaxed/simple;
	bh=PQjm/epzb1I7LJO3G2SLFh9JS4zKVn22NumIJ65TAmU=;
	h=Subject:MIME-Version:To:Cc:Message-ID:Date:From; b=Cvlwdb29nJN0x/z7AxsAZW8PNm8ENabf2RpDC79np9LbnGRCivj6XYm8hjEXtpZHbSEn0j+UAYh5TSuRGM7AmJjAwDDSqWQwv8r1MK+ymSMv2IVAESqhlgNFPuYns2/k6SpKtmjfX6YIGsykIy50SyrnsYV6BGzZvKmLtk80gMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=lB73n/mL; arc=none smtp.client-ip=20.13.235.194
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
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
 Hafiz Zafran <hfzz7@duck.com>
Received: by smtp-inbound1.duck.com; Fri, 01 May 2026 12:06:00 -0400
Message-ID: <FF11F736-4326-4C04-B651-6D76AC1B67A9.1@smtp-inbound1.duck.com>
Date: Fri, 01 May 2026 12:06:00 -0400
From: hfzz7@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: Subject; q=dns/txt; s=postal-KpyQVw; t=1777651561;
 bh=7aeFWucAJ5b1P9eHusXCkS37rYsvW2nu12CFLMSqyV8=;
 b=lB73n/mL2XfsqHhSlCX3jJHc7Skng5xWVPPcjaLN6KqTGhyM1v0OT5jl0GepF/+eedwFP9YaN
 xowhkzbkRZzBdhAwZUHMX8nE4Ce4PuqLQGE/Ypcg7pcSn+RMvCbViW9F42tW0L5WQ8Y9RdpVCRm
 VwB+c9peNZ2OpvViUGu+PxY=
X-Rspamd-Queue-Id: 07FA34ADEAD
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
	TAGGED_FROM(0.00)[bounces-35756-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[duck.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hfzz7@duck.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aiti.gov.bn:url,smtp-inbound1.duck.com:mid]

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


