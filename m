Return-Path: <linux-wireless+bounces-36508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GTPNLJACGpEggMAu9opvQ
	(envelope-from <linux-wireless+bounces-36508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 12:02:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806C55B033
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 760DB300FB7B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12224355055;
	Sat, 16 May 2026 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOCdqW3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E32D662F
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925742; cv=none; b=L8/jNF8XvaW6+FHac2yVU9/jeEfid/w+8mrdIX7HJC4109Mjq5m6sL+ILUE5/vs/O9EXuPyq8edTfAMydavH/XJrxxL30Zgv6OEuKd7ibbYFMe10+LLnmKXEb8O49bO+1da/QGH8BZiYK6fhgczwNQVivWEkJk18Cp4ij9migac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925742; c=relaxed/simple;
	bh=OmhJi+nTOlnVfftR6ChzOJv5KbtlkxKshUmdIKoJllY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJo7v6fU4DiViIIFgsS1uV6nTAEiiCD6QYH9MyJpOEcGbdJ55AiETIbWffrp9V0990WhmD0e8r4GW1T2oH/4TYqDUvd2vuX4phx4wVHNA6nLJG/kc6Gs2iO5HUWKU6zwzjQFmrl9Q60E5zlpyJE6oLH6J9TOe6FwaN0LIeKVm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOCdqW3X; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso238584a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778925740; x=1779530540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CDTu0uMmnhCUoH+aSiyceKxfV77uqNspzafxvvFlRg=;
        b=cOCdqW3XOZOkk5pT9lpjYK+mLh8MLPRkAwD0DvZHlYuPrBgc+ZFs0C0nhXs6L1EXP4
         hVTFIk2HomQXz8Kz11t2B3UQhMRdOAiHEg2tW3/ClVo993u28HZSS9CUaxPFxNiPDzUs
         fGqxv/Qd9xjmHkATQ2GV9siPGRqUGUQAaRSaMtzzK/wWHOv7vYAiAEWp7QDU1bkekuuZ
         914C0YFJ8kbA7txPvp1Q6RPptnF09PslDNEjbuL9YNIKoZ7vY5Y+N3LMF/jWv/qagync
         BvhTP1O1tLb3j7ZRRCpGtZKwTbDhaZzLXNaNvy0r3CeUlP5jR+qgWnVrR0f+kmKS7n3f
         +tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778925740; x=1779530540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CDTu0uMmnhCUoH+aSiyceKxfV77uqNspzafxvvFlRg=;
        b=tAbo9nMWMJrkeHaHwPOwMHsqkkrUdPlm7CTBpE0YbsdCy0mq/V8otBs09AJ04vK41Q
         mIg5JCvsKYpwreUB6+OPIpOXPbze9S6/54GKUmJc3vhSJECO3DO5le/YTjYuLjdDMqu6
         O+NhXIINfcyaiE/0mWWbt2OPhOHWFDQY/apSPlOTf53wi5avTs1y5Sn/KSn41Ww5p2YT
         e+vmfhHPQ0cJ58D7N3Wva2UP6YjSyVAnqg8vr+UrvzdR0afOnohpcGIaSoTMzmIaBwBu
         asQBTcl33JpUZ9ZzmjVtE/cKaLlOkOVRWseISFA2d63gCO6TiX1Z/oKJ9m1vy4EsKVYs
         bflw==
X-Gm-Message-State: AOJu0Ywi/Z65ENDwqTMBOOSURpWoftC3zhKibHDHOwNDA+77mji6DPIS
	0zXV94qR7zLfDh1OAt5pwr5MlMWJxEJP4KHvlE/BXDtGMfjKke42wAcAroFc4BHlvxEOGA==
X-Gm-Gg: Acq92OHvzph17iMX66kZnJ86/56IVork9bpDOG3sm3J0RSFrqi4ghYzHd9ehO939kQ3
	gJ6xp5j/CPH+CIGca9XTLvJc/GI7tsmpqkUsdclBWpupiD58V/5a1yfimWN87sLn1uHhFlcK+Ge
	E5G0xtrFCNtwQLNncRhW1bFj6vo+ZLqXc5gtb8YApzmLBdvZPn1rSYaOYXXIqIq95wwBtJyoJk/
	sjqq+c+yaocMUwn89V7hEHJl/AxUuwNTzl7FOMT9JQz7uTgxtMTfT3Ky3SrWqJER74ARJCvOG7O
	+570zZrGzs6Rlo6f7jiuzoFOdLakTaHdsSHtDsUEICLa3aCPx+teqI6RLkv25FiZJBQHm79mkZI
	73ZPPd8B7DLHK16pmGjL2UdGo4x3tO1vB11IBTwOxY91xpag9ykwp7byBe2AvS8xiJsVSn+kJ3m
	pFuWdmlJRPjSLcLrBVdKicLnkf4AD6ZuBs9d82cDG84acJWw==
X-Received: by 2002:a17:903:fa5:b0:2b4:5cb8:99eb with SMTP id d9443c01a7336-2bd7e8bd34fmr89152795ad.27.1778925739604;
        Sat, 16 May 2026 03:02:19 -0700 (PDT)
Received: from adsl-dynamic-ipv6.slt.lk ([2402:d000:813c:1db1:d202:27df:3833:73d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235c18sm81015995ad.81.2026.05.16.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 03:02:19 -0700 (PDT)
From: Mohamed Aashif <maashif011@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	pkshih@gmail.com,
	Mohamed Aashif <maashif011@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
Date: Sat, 16 May 2026 15:30:24 +0530
Message-ID: <20260516100024.103241-1-maashif011@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAHrRpu=Ku=cK2Hd8xzJr82iPkj4Jzp57ch9wEE1KsoCiExbhbA@mail.gmail.com>
References: <CAHrRpu=Ku=cK2Hd8xzJr82iPkj4Jzp57ch9wEE1KsoCiExbhbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3806C55B033
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36508-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maashif011@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trc.gov.lk:url,lca.org.ls:url]
X-Rspamd-Action: no action

Update Sri Lanka regulatory domain based on the RTTE Type Approval
Rules 2020 from the Telecommunications Regulatory Commission of
Sri Lanka (TRC).

Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf

Key changes:
- Change DFS region from FCC to ETSI (document references ETSI
  standards EN 300 328 and EN 301 893 as the applicable radio
  interface standards)
- 2.4 GHz: expand to 2400-2483.5 MHz at 23 dBm
- 5150-5250 MHz: 23 dBm with DFS
- 5250-5350 MHz: 20 dBm with DFS (no TPC, 3 dB reduction per EN 301 893)
- 5470-5725 MHz: 27 dBm with DFS (no TPC, per EN 301 893)
- 5725-5875 MHz: 24 dBm with DFS (per ETSI EN 302 502)

Note: The TRC gazette conflicts internally by allowing 30 dBm for
5725-5875 MHz while citing EN 301 893 (which doesn't cover this band).
Lacking TRC clarification, we conservatively default to the ETSI
EN 302 502 limits (24 dBm).

Signed-off-by: Mohamed Aashif <maashif011@gmail.com>
---
Thanks for the review and catching the TPC and ETSI standard details!

Changes in v2:
- Split 5150-5350 MHz into 5150-5250 MHz (23 dBm) and 5250-5350 MHz
  (20 dBm), adding AUTO-BW to both.
- Applied a 3 dB reduction to 5250-5350 MHz and 5470-5725 MHz (now
  27 dBm) to comply with ETSI limits since TPC is unsupported.
- Capped 5725-5875 MHz at 24 dBm per ETSI EN 302 502.

 db.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..12cdafd 100644
--- a/db.txt
+++ b/db.txt
@@ -1058,12 +1058,15 @@ country LI: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-country LK: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (17)
-	(5250 - 5330 @ 20), (24), DFS
-	(5490 - 5730 @ 20), (24), DFS
-	(5735 - 5835 @ 20), (30)
+# Source:
+# https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf
+# Sri Lanka RTTE Type Approval Rules 2020, Table 2 - Wideband Data Transmission
+country LK: DFS-ETSI
+	(2400 - 2483.5 @ 40), (23)
+	(5150 - 5250 @ 80), (23), DFS, AUTO-BW
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (27), DFS
+	(5725 - 5875 @ 80), (24), DFS
 
 # Source:
 # http://lca.org.ls/images/documents/lesotho_national_frequency_allocation_plan.pdf
-- 
2.54.0


