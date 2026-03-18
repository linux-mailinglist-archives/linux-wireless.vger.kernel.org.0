Return-Path: <linux-wireless+bounces-33374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGAZBNpKummWTwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:48:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7572B68C3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9A03012C52
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0E4A02;
	Wed, 18 Mar 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU0/ncZr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31066337B81
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816535; cv=none; b=CmGl4Ofusaj1XzOYfwVKG/J7uSoeK593XO7O/5CHWKXefC7nuySvzRDApwwW1E122JEXZq7viQ5/zp+wxwxxITEy/Kx6qsCLXv1xLjzRFoY1gWLOYgbdHfs8wQpj5KQ7s8M5E916OoUKh4LpP11v5RR5xsVZ/2iiJVM5VjmF4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816535; c=relaxed/simple;
	bh=vWUOxXCIopxE7m4cEHgcLnIzPzKbsRFmBfEjsZ6TSMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cTGFXd9wYmAKnmru0gtPtds3JSDKdtRwCAEN1jQIC2zbnLMXUd99eqKkP8RxiZXXm3CEZ/fTRxeDOtnI4xSfmygzLILgolU4d2NEg+IE+6s3geYIICDaBkdmmb/N9mFVEVGHFnOMcxAgefOJE2uLP/4uHH9WnjL85b2vtKnyHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU0/ncZr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so2538029b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773816533; x=1774421333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlC4k9fcBpkR2TeWfp5WdwMkkhT+G6+tLfuISegqKHk=;
        b=ZU0/ncZrhwhdaW2PRc+x+9+e+UENBcu5xQynYu5TnNz2ElAoLZRv27SEh6rCCOL5Ap
         /HCZVISxBph9qXYaVbrg7yBrvw6NSgYISOp8V54ugGsUB+asKMK6cxqBatW+0b/V8TYM
         FgdzptxIb6/tCIFThV5YhlPIrElKrLsIiNn9+tabPvXt6/1qI69GJ6jfErptTteIHe6Q
         FstfT6bOvRMaMz5IvMbLVIIcU7MkOh+BntgPAp37OMUlHXZwCWLWZzScJeljupRvNah+
         U9QhdEnmTFf/zlyYe6vP/dKhb6KOIcY0TASKebnnFUp5BOzptNAwzdNjlaVh0DGZw6H8
         C1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816533; x=1774421333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlC4k9fcBpkR2TeWfp5WdwMkkhT+G6+tLfuISegqKHk=;
        b=sCJ3YFHh5uAi4OH8XjVqaThi2A96QFc1TegbX39ccGdPdaOKxUq39ZVI/dqomBknx0
         Ur7kth/LRWdE7exUvcTrKhmXFYuZNhkOMG41GpIFDbSK2T7u25jTdlKYDwFq4ixo8Y0G
         /eYZdM7XfvmvKddHU0RRKSxVDmjNcIqK++h74tNYNS4ouR41qnsAJUIKuYXANbKUNFK5
         PgqKSna/syI9EjX/gyoOJFChEQ8v+L87qBhoN6A+wHhiP7KuDePj0u2Tbg16iyfhoWRL
         3yy33zNn0KbPdu6hqQy8+z4DvJ6hq90sqYVWAUNIjpcenNuxKK4std+z+g6t2unZSMB7
         cz4Q==
X-Gm-Message-State: AOJu0YwoWXzcwOBz47dNhhmWmZe/Y+wwX777bweFUE0Js5WqIbLnLSG0
	helgeNjtwkpalRq3PTnpqc2sYpLtkAjOafNmFQk5aAEAYI87KOnWkTfQxk7fjGo4
X-Gm-Gg: ATEYQzzeif2NT+6LQ9/V2BeALpuuMiRtcnG9KIy7FJ0+8tl/stBKcWh1cmksQTw96c7
	pIw5c7w8zL9Sg2Y0Q5s6Unzp9VQe3PyeGw9MYR4gl2EvwjbjBy6DkEL614pYaTLvZixu8UyPy4t
	SsdNw+S3A4af6QRnyPEEuqiNvIqDZoG2s1WJutyxuG/PSlKRyo4n2ROoOw1pasNDGo4fI9ZobOz
	HUmFwqe7TWYYQgXkLgClK1V7ufjCdVleCatLQ5rQ+5Vq8Cd0Z5jN3UynUrvPLl1XkHK3kj17HpB
	+PvD85t/Q/xbtUAsF/Nu3rxy8vB+2FsiiPWGCsS1GgSJLgeVeFQTF+jODiUVZz7zjwtaQLi9c97
	eNWFl5ex146JDFOrFcKSeQl98MaS/ctKUNhr4l30DUEs8tdOPSydK8v7aAhDSKlgB8xLYGXy/Y4
	x7FReYBG4a7UgIKIArCUypYk1ZliSMdg0yK3gRyDOb69UXNSI4feyXj373aSKVRLBHX2jJQF4jw
	Wd3Uel3jQ==
X-Received: by 2002:a05:6a00:1590:b0:829:8af4:5eb0 with SMTP id d2e1a72fcca58-82a6ae088edmr1787175b3a.26.1773816533523;
        Tue, 17 Mar 2026 23:48:53 -0700 (PDT)
Received: from localhost.localdomain (125-227-180-151.hinet-ip.hinet.net. [125.227.180.151])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6b541cdfsm1508764b3a.1.2026.03.17.23.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:48:52 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Add regulatory info for CEPT countries FO, GI, IM, SM and VA listed by WiFi Alliance
Date: Wed, 18 Mar 2026 14:48:34 +0800
Message-Id: <20260318064834.103731-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33374-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,europa.eu:url,wi-fi.org:url]
X-Rspamd-Queue-Id: 5F7572B68C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ping-Ke Shih <pkshih@realtek.com>

In commit 5a8ced5ad313 ("wireless-regdb: Update regulatory info for CEPT
countries for 6GHz listed by WiFi Alliance"), the following are skipped as
they do not have corresponding entries in the database yet.

     - Faroe Islands (FO)
     - Gibraltar (GI)
     - Isle of Man (IM)
     - San Marino (SM)
     - Holy See (Vatican City State) (VA)

Look up the CEPT decisions [2], and add entries along with decisions [3],
[4] and [5] for 2/5/6 GHz regulations.

The 2 GHz band by ECC Decision (11)05 [3], which the adoption of ERC
Recommendation 70-03 [6], the regulations and the frequency bands to be
used for Short Range Devices (SRDs) are included in specific annexes to
this Recommendation. By ERC Recommendation 70-03 annex 3 (WIDEBAND DATA
TRANSMISSION SYSTEMS):

 * 2400-2483.5 MHz
   - 100 mW

The 5 GHz band by ECC Decision (04)08 [4]:

 * 5150-5250 MHz
   - 200 mW
   - Indoor use
 * 5250-5350 MHz
   - 200 mW (due to TPC required, -3dBm, 100 mW is adopted)
   - DFS, TPC
   - Indoor use
 * 5470-5725 MHz
   - 1 W (due to TPC required, -3dBm, 500 mW is adopted)
   - DFS, TPC
   - Indoor and outdoor use

The 6 GHz band by ECC Decision (20)01 [5]:

 * LPI devices (adopted)
   - 5945-6425 MHz
   - Restricted to indoor use only
   - Maximum mean e.i.r.p.: 23 dBm
   - Maximum mean e.i.r.p. density: 10 dBm/MHz
 * VLP devices
   - 5945-6425 MHz
   - Indoors and outdoors
   - Maximum mean e.i.r.p.: 14 dBm
   - Maximum mean e.i.r.p. density: 1 dBm/MHz

[1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
[2] https://docdb.cept.org/document/category/ECC_Decisions?status=ACTIVE
[3] https://docdb.cept.org/download/1535
[4] https://docdb.cept.org/download/4501
[5] https://docdb.cept.org/download/4685
[6] https://docdb.cept.org/download/3700

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/db.txt b/db.txt
index d54ef78e0da8..e2afb145ede5 100644
--- a/db.txt
+++ b/db.txt
@@ -731,6 +731,13 @@ country FM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+country FO: DFS-ETSI
+	(2402 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+
 # FR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
@@ -801,6 +808,13 @@ country GH: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+country GI: DFS-ETSI
+	(2402 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+
 country GL: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
@@ -976,6 +990,13 @@ country IL: DFS-ETSI
 	(5725 - 5875 @ 80), (25 mW), AUTO-BW
 	(5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
+country IM: DFS-ETSI
+	(2402 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+
 # Source:
 # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
 # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
@@ -1855,6 +1876,13 @@ country SK: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+country SM: DFS-ETSI
+	(2402 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+
 # Source:
 # Regulation N° 2004-005 ART/DG/DRC/D.Rég
 country SN: DFS-FCC
@@ -2072,6 +2100,13 @@ country UZ: DFS-ETSI
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 
+country VA: DFS-ETSI
+	(2402 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+
 # Source:
 # http://www.ntrc.vc/regulations/Jun_2006_Spectrum_Managment_Regulations.pdf
 country VC: DFS-ETSI
-- 
2.25.1


