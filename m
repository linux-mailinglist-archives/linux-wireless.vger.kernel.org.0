Return-Path: <linux-wireless+bounces-36592-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAtiMTbHCmqf8AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36592-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:00:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBE5684AD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DF133065234
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758951C861D;
	Mon, 18 May 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUKj2hYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67B37FF56
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090484; cv=none; b=mNIelAkl1iyzHLVf3xZUN5XM1FLmCIY7ql7mV18Gqsb/0+Z6aEVS12WWcSvvjzXfX7IPx1mtHMyUE38sTC55XSWXDs6u1rtXhnXyZqQ3FF8cDWXoRFFqZGEjPOLzgtukqZrgRTcr9In/p1oJiNFfMMpPvz5zCgPn/lLeEmVg5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090484; c=relaxed/simple;
	bh=Cbo1aTBDdmKfTks38NxLxsN/PWTj/Lm91gWZ0Iux59E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNaa5/Y3NE7QTmAGx1t6vbJDUR7wdY3O96aXz9XCscOFouL9EhDHskzm3icEzVT2JXljKSL+gN06PBmw5/WoZNa20S/P5X02H+vnZjNvjilmqX5t7KuMGwvuxZMetWF/VhDUBZgx8rWUgG907A81CaIn4ErTpUbcC/qSPQKXW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUKj2hYy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83d31ac4017so776727b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090482; x=1779695282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntftegR19uG4jEPijjx2rHNpuHDapz9rb9AoEjoP9Aw=;
        b=RUKj2hYy7sdi/tvAqIZZ4gbZewBsxWi1CMzdPnn+z5zyp9+bbNwKwArIGuQv44gjrT
         v3wU1I4Hidz2sKzeKijSOC62QU1Tj4vrzS0ibYNzLOuGsrrKoXL+EzdXiXgUeLb+k6/i
         DtScoW5UFzv06LlfdZuqNnBGybn9xeu9BCWlI7jaLYwwnM4EUpyAnhLyj/ADpEIRnue6
         KRb3wPOXGyOT280/4AHWpOl0blYMj8Wuiholn+ows8cig5W2hHwbNkYrfBnGaZjcJVpn
         qVjcnLacVbGI1bLzjrHnKqI1dE85iPm03DqYuYB+XOrYM5TTmWazIneiavgUT305/cD+
         G7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090482; x=1779695282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntftegR19uG4jEPijjx2rHNpuHDapz9rb9AoEjoP9Aw=;
        b=mHl3g1UHUrJkAjK435HkowP+ISIg7Mf2PL2UEQk9PPloEgIsEFeIAH6/zPxW3cMRQK
         JeW4eacTCd/cmhvzh3THlID5IglyBg7x5EKxgvO4G+lDwoIXO0TYDVVka16f7ABi0Z5l
         bF4jgjfs9okUtoLJkz5U+/yWwKhKadFdV5BQ9Zgl58beHtiQfFjWZmHWZ9rgeOrH0B9F
         uSvWZTFczOr2tNxh4OnnrBJO1LGigNTWue6K4hkrDaZiNKRtpr6gbzO19EBldhMG8bO5
         UC4CDzbsK41YPN0fLc5al6/dJ/BWdz6IddIz0SEXSTOmh/3DWfRpNOgNe3sPbGahcPlW
         RCGw==
X-Gm-Message-State: AOJu0Yzrp0eVcILp9sy56MmfM2sCcIsVK0p5ZQioLSf5FbHB6DkXJGa9
	+kQi9j6Uz+sYYPWM5dTGYEtZKMrkscaomI4+Zal4B0zCzrbiF32LQduuTzJnYPDgvTA=
X-Gm-Gg: Acq92OFCRxIAGWz0UqNaoRIkuYnynLH5vXQmeSJFhg3IjM4HAf9PxLRfRRTy8nOLTzF
	nMDqMlTIJDEa1F9M84mzBVFO4deqi/8fH2acwclJY+zfwmU041zlz8kFfMKBCCfrdSv65vw9Zoa
	Se7FUnd5ptMTMVrDl+q/SBj2aOwwoKbp1bL1Q/hkA8r9NbM10bnQrD0riv4KPxnsMMxe5aDCgwN
	OwBMnZejVkd0TADqeCYkna25a8I3wPjrQmxqm09e7FqS36HM+OcGkDjVRasrjtuDC3u/myWgv7Z
	fDzwX2saBgzxNMYj9zxd8zvHx/jMUFyRpGJMxdW14vaP+2X+jjhKb1QVbuFq9Iw/CwwzJMJ20fJ
	TP4GsE+IcXMGKSmlmftbKPrP7T333dDskfVA0XQfNdhNdsx/49X2IpQMzZNtHzZtwDIj6Mhbd07
	cdEc0wbT22F3u2dtAvHkCz4UpWNaBMYuJ0L2XMz9IBlACSVA==
X-Received: by 2002:a05:6a21:33a8:b0:3b2:86eb:335b with SMTP id adf61e73a8af0-3b286eb353dmr4514969637.11.1779090481787;
        Mon, 18 May 2026 00:48:01 -0700 (PDT)
Received: from adsl-dynamic-ipv6.slt.lk ([2402:d000:813c:5008:e225:394e:61ea:4bfe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19661261sm17056369b3a.3.2026.05.18.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:48:01 -0700 (PDT)
From: Mohamed Aashif <maashif011@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	pkshih@gmail.com,
	Mohamed Aashif <maashif011@gmail.com>
Subject: [PATCH v3] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
Date: Mon, 18 May 2026 13:17:43 +0530
Message-ID: <20260518074743.179402-1-maashif011@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAHrRpu=-ngPpe2MsmWz0gQq1VVxbr9L0+jUos3o62wPUY-wXqQ@mail.gmail.com>
References: <CAHrRpu=-ngPpe2MsmWz0gQq1VVxbr9L0+jUos3o62wPUY-wXqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1ABBE5684AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36592-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[maashif011.gmail.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maashif011@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trc.gov.lk:url]
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
- 5150-5250 MHz: 23 dBm
- 5250-5350 MHz: 20 dBm with DFS (no TPC, 3 dB reduction per EN 301 893)
- 5470-5725 MHz: 27 dBm with DFS (no TPC, per EN 301 893)
- 5725-5875 MHz: 24 dBm with DFS (per ETSI EN 302 502)

Note: The TRC gazette conflicts internally by allowing 30 dBm for
5725-5875 MHz while citing EN 301 893 (which doesn't cover this band).
Lacking TRC clarification, we conservatively default to the ETSI
EN 302 502 limits (24 dBm).

Signed-off-by: Mohamed Aashif <maashif011@gmail.com>
---
Great, thanks. Removed DFS from 5150-5250 MHz.

Changes in v3:
- Corrected the table caption in the source comment to "Table 2 - Applicable Standards- Wireless"
- Removed DFS flag from 5150-5250 MHz

Changes in v2:
- Split 5150-5350 MHz into 5150-5250 MHz (23 dBm) and 5250-5350 MHz
  (20 dBm), adding AUTO-BW to both.
- Applied a 3 dB reduction to 5250-5350 MHz and 5470-5725 MHz (now
  27 dBm) to comply with ETSI limits since TPC is unsupported.
- Capped 5725-5875 MHz at 24 dBm per ETSI EN 302 502.

 db.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..8038f5a 100644
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
+# Sri Lanka RTTE Type Approval Rules 2020, Table 2 - Applicable Standards- Wireless
+country LK: DFS-ETSI
+	(2400 - 2483.5 @ 40), (23)
+	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (27), DFS
+	(5725 - 5875 @ 80), (24), DFS
 
 # Source:
 # http://lca.org.ls/images/documents/lesotho_national_frequency_allocation_plan.pdf
-- 
2.54.0


