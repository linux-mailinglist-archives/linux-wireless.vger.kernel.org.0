Return-Path: <linux-wireless+bounces-36035-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNJ6JCxj+2kuaQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36035-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 17:50:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31344DD96A
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D70F300B454
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E14949E6;
	Wed,  6 May 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGlDhIGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC13F0AAD
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082590; cv=none; b=TjxIVErodh2mXjTpBqNbmqpKQgh2J+TrYknxzYklGx2soDGnhrR9yBxSLhNAWbqTrNCWZ4GdFaJho0xZVsobneEqBPF3y6mBTla0SQqTkEiQYo4KHFPBrdOgIq/thzh3ORBdWQeoLYHbSfasNcPii8BWnyE8saRQ73IfwXUHDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082590; c=relaxed/simple;
	bh=40kO/2HMZ5uYyPmGYQDyhSCiSa4+MVFSHpWVwxzTq00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I990loUHmaTB3XddSnHkk1x7QCS5wKwJ4ro68fhWqsWF5lAaRtbpCpqlgdwyahf45/fFYVrZSQm/WjJGF5bz8rtFRPc50fV0M5afpSF2H3BvqZvu/xwyrJwnQBDUTrCSt3Aa03v9vgekvLBGu8igyI2RV+GKKJ6R1QBs3xYzlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGlDhIGQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso1535729a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082586; x=1778687386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xucSoN9Y6c5d7rMzqyVuKa4SJThVaaNejVC6mnM3X5o=;
        b=mGlDhIGQpTIYW/FCq8YbzAV07Jsb2gcI9FkIU670Xv47gakZ019+tXRSUw/RSiUxbU
         sywZY8dVkOBKKPo+Ym4L3W/rZtPpHeT3c+QGCEyb0GsP+NUB8eMKqluJdKQnAYkoDGqJ
         wrhaqaK+oF3qbZq634PQnV0UQKcwfbEaFxUFDr0nWN498tJEGQLVN4LS3HPkyS8Y7a2Q
         pq3rsxEzZW+GzuuZWU+0L+KI3C1H3+nCxKn6kaRXCjPRfELYRHV7XIDZdkuj4NDNIMyd
         9bCsycEWMPO9JyPnLjvUpkSlzRRHcRe3VXyrueKsTU+ojn+9W6zFp+X/q++kgf8ANxJp
         jPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082586; x=1778687386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xucSoN9Y6c5d7rMzqyVuKa4SJThVaaNejVC6mnM3X5o=;
        b=PAspUMV73Vp6WHh6Av7l4wGzL/xIZ2kMGUCr3AJi6M+H6JK3465FrqaB0k3Bor64kL
         qW+D3FIaRlWaniBPbU2OIPo0o43ScOP5mm3hjoZ7Q2GlsH2WlUWgKQufa6VBdQM/jXI8
         SEVL3ISQznoUEctgxwm7Mh5QNoZOsxt6aI81g6qZHTYS2LM2hXdrlI9EmVj3bRi59CI6
         ZHgEEspEdk1w8WpNswn7pSH+jtzUVC3kTNMFSdvrSZDomViAS0ZWYRyadXWlvlfUu5/R
         o348eyySB1sYD5nyjxNw3QgPI+SGcaI91BIdWYQu4cQpRxFr/JBHXaIyDFQxsYkDTEB7
         mivQ==
X-Gm-Message-State: AOJu0YxC5XYjguzvOHykox2ibu1ngsVHV551+3MVzhW1fSIvPG+29pyh
	S7Qb+2dx/EWci9/Dd0wLd6pKFJPhkysrQ1ZkoMQIf4wpLkqVdb1yBNS/Z6ivNI3lzDE=
X-Gm-Gg: AeBDieuh7FBSx8G8d10YDprii+DXoD7ttry3plvlo+tic/UhSKg4MmfilSJtLiCwKFa
	c+P7G1URxRpCS12TZalynv0BDwxRXsFc1b81aHX5GIqJacbOu9Jkiij5/9LzFQvrB5s9/vdI6gO
	96vN6nL0IOl/8zqoLpj08QKT1ju/ZHhiDCMKjrVe77pDGq5Pg8l3BE57u2k0r+hu7RsGT+zP11T
	pAM8svjvhOI9y6P+iN3pfSihHPgdJaAVK8TjcrCXshx5OTHEwqxmbsrSoFw7AVtZut1HT9sftYq
	MYrNqehfZU9gN5zX2ckjXKILd/w42L2oW9wKnJzwmqqJF06O5fdl08Sya/iaJZmM5fKTTPST++n
	4+cntOavJ0f2OiKf5BfvrAURbh44BnPI/dzWfsv0IBZZTnhkMZ5yQFY48GYOmdB4SI9W0cz0uAH
	AS5V4IPsfJgtLx1EDcIHFqpSRG41uhr2klZRde1ahH11MFl8zKNeQO2C22
X-Received: by 2002:a05:6a21:999b:b0:3a2:dc51:458 with SMTP id adf61e73a8af0-3aa5a99f62emr4230782637.41.1778082586387;
        Wed, 06 May 2026 08:49:46 -0700 (PDT)
Received: from adsl-dynamic-ipv6.slt.lk ([2402:d000:813c:31dd:f749:6da3:8e01:1e17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242acb677sm2552557a12.11.2026.05.06.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:49:45 -0700 (PDT)
From: Mohamed Aashif <maashif011@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Mohamed Aashif <maashif011@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
Date: Wed,  6 May 2026 21:11:29 +0530
Message-ID: <20260506154129.64112-1-maashif011@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E31344DD96A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36035-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maashif011@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lca.org.ls:url]

Update Sri Lanka regulatory domain based on the RTTE Type Approval
Rules 2020 from the Telecommunications Regulatory Commission of
Sri Lanka (TRC).

Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf

Key changes:
- Change DFS region from FCC to ETSI (document references ETSI
  standards EN 300 328 and EN 301 893 as the applicable radio
  interface standards)
- 2.4 GHz: expand to 2400-2483.5 MHz at 200 mW (was 2402-2482 at 20 dBm)
- 5150-5350 MHz: 200 mW with DFS
- 5470-5725 MHz: 1000 mW with DFS
- 5725-5875 MHz: 1000 mW with DFS

Signed-off-by: Mohamed Aashif <maashif011@gmail.com>
---
 db.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..d265176 100644
--- a/db.txt
+++ b/db.txt
@@ -1058,12 +1058,14 @@ country LI: DFS-ETSI
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
+# Sri Lanka RTTE Type Approval Rules 2020, Table 6 - Wideband Data Transmission
+country LK: DFS-ETSI
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5350 @ 160), (200 mW), DFS
+	(5470 - 5725 @ 160), (1000 mW), DFS
+	(5725 - 5875 @ 80), (1000 mW), DFS
 
 # Source:
 # http://lca.org.ls/images/documents/lesotho_national_frequency_allocation_plan.pdf
-- 
2.54.0


