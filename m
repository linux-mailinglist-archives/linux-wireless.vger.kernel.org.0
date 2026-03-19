Return-Path: <linux-wireless+bounces-33447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD3gCiRhu2lujQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:36:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E62C508A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288F530293C5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25E2F659F;
	Thu, 19 Mar 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R61WT8Vy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBC330328
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887757; cv=none; b=Yj7zd1bVu5cwuYMtNf8Vw6bNXq+n+h5qaPe0mjwz9PoU2sIXh3Z/kksgueKcboTiQnepxSLYoWVOZX1pwXUuW/KgWtDYnFoJKciO9xn1ZUkqwdMGtWw7R/NIlavLOw5L9MuL9QW1z4tXh0SjLO09G+vaUXB99aSVHM96Tpd6X1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887757; c=relaxed/simple;
	bh=YeMwLrGaPzF7S9fQJh+UJ8jJFVmsvglKFPob4TvbNbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B7yIilIea1oL8IF5ZWaWA3vRP0/fwC7gMwq0MNg51vmsamX969NLnp1lUFHyVgIJkeQVW4DTmcuXzw0V7zBmbcqaOuzMSUTrJV6w23XkToZhMTl61CzIr/aKjm0ZTwoe3qVMZfSSVqAUc/qfLWQLuZQTT8w5X+/3rnkWbIXOqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R61WT8Vy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0586d5bb8so1301095ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 19:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773887756; x=1774492556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7UzL6QGLhGmKpQzbDFFkiRj8Hy4paFdOUTt9ZLsBz4=;
        b=R61WT8VyYuL1T4VfWapdlFDkDhSvhrR5SgtWbuuVkLjaqaxKO/HaYGsKBa7a5ff0c+
         FaLVuI2zOAg5+Inm6f2B7s+IggY0R7WEeLpIA7kdTRWN/P0VrHsy5dI8vRhS6TUlQoci
         QDtsTCnMjFzNgPtMs9WTME/FRmaHygu+eOo6nxLpa0yvEfyRxCMCx8bMJ+k7L70kpBoU
         pM9frlsmhbmMkkbvQAqao0DsaLV2/qGGcPD84lAw2ZlF2gx7/p2Pnp+ZzORNFfyHR/vQ
         OjGQS8MEHiutOnOhsOfj8GZHDakl2juPQgYkYOXPYAte9ndv3n586+SJbWs6GiatiXNn
         u0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773887756; x=1774492556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7UzL6QGLhGmKpQzbDFFkiRj8Hy4paFdOUTt9ZLsBz4=;
        b=f4S9E7ff8UdHeQn3r4/WselguFShdmgZkppB0XG18A91RptPtv6IIg7h1IPsEGPfKT
         H5EJ5Jy6MZ7jLXe8ITTrO6sXQe3+3wNho7YYo8R65r6D72GBUwQ4Qw8FdOxuOBTlIg7P
         5vv51LkHhJLy16qPIYdOY/Eqfe9V+A1ywGJd2KnwQWNPDrgAoaGcyJDzUlZZ1/b1kmC5
         vaU3SYpn6ym3VFQ/zBiBQpZYz0FfoQR2B9wRjrkAfDJlIcz9R7/WFKw1INcNHxQFGmIk
         ErRtv137G22rEhgJwCcKYa6tx0S7QVUaZ/NGSeE+Jzxki1wHjuafrJTCCdTEFjrRqtyB
         vw2A==
X-Gm-Message-State: AOJu0Yze1GLFPxa1SAgQZY700ygI8p3oKbPY3tNUb1elreWgaLCjHUhe
	fL5KcmLTSBDO2tnG67B52v0+YpJKDAl9wU0TfCm8L1v5B020AsHWPzMhYQvtiGl3
X-Gm-Gg: ATEYQzzfd2RTNW9a3IZ47UoFVIvb3rU57RT2Ltxn86DOEetMIPL+WX3gswVgLufUZyM
	uohqzqRM6mLahxVB+7iS1Rw1Jk2xnmBxf77YsF0Uh1DNNdfKV0QdsyVuSd/C9b64C5cOo84qOrs
	YgpKra71LSKuynkzEHgsbNfVQADCtqphJr4kE2uSTb981C+NDxmpnIm8aTqFkGmopp579yqBX/H
	OQdiMOc1oKf46rN9UHC0z3DzHNnV/sa1QK3DdxigVzAhsdaVMjmxGYNRGStG2aoMwnomP7wBlx+
	OQlD8Q+t/aEzMnX2ZZqLI89De5SyZFxJYtwWqcL4ow0Umdq/MiiQCMM/lcnK41/go3xhIOVbtyJ
	xBbGy0UMPPEgmuI5S1HEYK3UjIezb+VqQ+IiFbc1xX3HFfdG5qXuLhDAAeyrFTV2deQecPXl0wi
	Wi6Wd+7ZJ7CxgOwc3IE4oT0ZzIamk7FBKKUi6n5SJEskO34B/iIaWuhHboCIYdVuY=
X-Received: by 2002:a17:903:37c6:b0:2ab:2633:d981 with SMTP id d9443c01a7336-2b06e3e0441mr54309415ad.32.1773887755691;
        Wed, 18 Mar 2026 19:35:55 -0700 (PDT)
Received: from localhost.localdomain (61-216-20-61.hinet-ip.hinet.net. [61.216.20.61])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b06e5f0e8dsm38596595ad.51.2026.03.18.19.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:35:55 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Add regulatory info for CEPT countries FO, GI, IM, SM and VA listed by WiFi Alliance
Date: Thu, 19 Mar 2026 10:35:38 +0800
Message-Id: <20260319023538.7707-1-pkshih@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-33447-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 802E62C508A
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

The 2 GHz band is now governed by ERC Recommendation 70-03 [6] with the
withdrawal of ERC Decision ERC/DEC/(01)07 by ECC Decision (11)05 [3].
By ERC Recommendation 70-03 annex 3 (WIDEBAND DATA TRANSMISSION SYSTEMS):

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
[6] https://docdb.cept.org/download/4916

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: 
 - rephrase commit message of 2GHz part
 - update ERC Recommendation 70-03 [6] link to the latest
   https://docdb.cept.org/download/4916
 - fix 2GHz freqnecy range starting from 2400MHz
---
 db.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/db.txt b/db.txt
index d54ef78e0da8..343b256063a9 100644
--- a/db.txt
+++ b/db.txt
@@ -731,6 +731,13 @@ country FM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+country FO: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
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
+	(2400 - 2483.5 @ 40), (100 mW)
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
+	(2400 - 2483.5 @ 40), (100 mW)
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
+	(2400 - 2483.5 @ 40), (100 mW)
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
+	(2400 - 2483.5 @ 40), (100 mW)
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


