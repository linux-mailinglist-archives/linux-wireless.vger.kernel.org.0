Return-Path: <linux-wireless+bounces-19109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C109A3AFA3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB46188C743
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF17A2E0;
	Wed, 19 Feb 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL2VXa0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397117CA12
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932498; cv=none; b=hO1SirwX0Fy1hSxFei7YxZq38Ed/KO+SEOWxiBu1umzPC+SGNhtaYdSiafdjgdIFpiqeXCjNCtIc91kLOHReSTHn2uoVPme4foxtknOHCVx97Ml/zPo4s5BnkIF26xTRPhwGTUDh4TzlWizmZaxadOMSHCKcZwCVSgzrXXaf+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932498; c=relaxed/simple;
	bh=r60a2r+fqtPfOnmlo8cVNJbtoA0eL8318/a+gNw74As=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gEgcBCOSB2bbpTRxwMQxQlHyAPacFNn3Ok7zvFWcz88vCD9mYGFg6tfQ6aSQVCjyBwvGB5tZEbw1Aup1CCr946+ihKEGStERiALtXVkyzIEWCQnlT5phncYE/MXZXtgtCxhYkHQcc0Gpa7oN4tDQhMotcpbjVtcOQcwy00H5n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL2VXa0l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c92c857aso6739125ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932496; x=1740537296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R04HbjsN0O8oNVWfF9dMnHHroywF9MmsNCZD/04NKBY=;
        b=YL2VXa0lyjPjK0MNpFlxf/NPiiTK7tsRJxasI0n5nMlfqQ/dwUbz6Pq77O5nsM9OKU
         mSkezMBgPBD12kM4D6CW+mHtEV9H0cPoubCFPEcqzL1G0BW+Z5OPCXrFUvs/HJ/LxaV6
         TtTPclEOF0Ih0g9Qb+DY2V62LsVyJ69RJ7nlgUM4oUM04ODVRXs2ff1Ax7Y5QJmZOC4d
         CGOpC+KM1kEoie0pn0eoBKN4n+v6KYtoRh8NeR9gCTwAv13xzJVaL6Tk4wnWvIgVEhLC
         JR7W8cvCohMPH65Iw1Zsz5HCJzryJ6xbFBGC2N2FUK1gAr3D5Fpzzds5glYyAEhGe36d
         jb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932496; x=1740537296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R04HbjsN0O8oNVWfF9dMnHHroywF9MmsNCZD/04NKBY=;
        b=iFoPJ5YekY8fuSd/7ul5QQzlzoxVXbN6Ms66uh64T7rO+nu9Dt8MWnltnxQF8Cd1et
         oF3NX1tjn9vyfGN7ZdjCX08j9YJHlGIth+WsdW/qIKWpsKhViwm/3v/2X22c2HL+Ahjk
         3gpHMeBN6xMz2yNa5qcaNbhLieGUDVVlhpT1N4+T6cu+OsnSNlDQvoMM3rMZ5+VV9OyX
         KsiXkuS4UMG1bJdwLzITCXtdtjmYmEOP5YRW2J4nDvgxN1B3fmyWuofmbyZIrgixSgFo
         Pa21nkFD84KkSW5qvJCmZI+L+Ywpv2KLO7cE9rsyqkXzOTPqCXZskdhzBpkPcZ2VSSqs
         O/LQ==
X-Gm-Message-State: AOJu0YztasmlztbTpXCkc4q5+upQFBRBmVUZuvX+0uCteiVqPxhMUheM
	OFXtbWlsqcTUBbehbQ10YqW8knH9kZNQmMdOGzJXT/EtC1druLku
X-Gm-Gg: ASbGncvYxZUgUC0KTFxFkCn5IIVPIOcOHZgMP8qEWKJJspfpaCFmMXq7wWdxJATu9RA
	oZJW05us1312818CuYHbxTBE7Sn2EvB7jS3hvvMqDsqQVPLg90NdG3T/8UcvJ3FKxHKJiOFJL0d
	2x0eTyIhtOezEcOI0LTHlzxfEV7NnlPosSYEgdIRdRg5nouIKjnfYKTG2g6jBfeC7mRRnkv64U+
	/aAuBWXNaCkSLN0j4M/sBizwb8MKDhJd6FQjC4NdYT4vxIR9snN3uMKlk4s+hTb5HbTUoMvyGtv
	hdp7mQ8335st1DaVQ21hZkiSx2BrteJyuiguYi9sxdw8wO6T6Mpum/whDQ==
X-Google-Smtp-Source: AGHT+IHBWu2zNx2ZlrggZ0xLhsQ8WBxnnw96NQe2O8w6INoGz6Pif8fopNl0K3piu9ZyZbDJXE8fMw==
X-Received: by 2002:a17:902:f541:b0:21f:5063:d3ca with SMTP id d9443c01a7336-2216ef0c858mr35681335ad.16.1739932496085;
        Tue, 18 Feb 2025 18:34:56 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d536671asm96837625ad.88.2025.02.18.18.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:34:55 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v3 1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
Date: Wed, 19 Feb 2025 10:34:13 +0800
Message-Id: <20250219023415.14229-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

For certain regulations, frequency range is outdoor only, which flag should
be NO-INDOOR, but db2fw.py doesn't allow this flag.

As suggestion, only fill NO-INDOOR flag in db.txt, but ignore this rule
in parsing to binary.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Link: https://lore.kernel.org/linux-wireless/5e433cd8d070682cb6ed31de3a2dd337e6f48b50.camel@sipsolutions.net/T/#t
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
 - new introduction by v3
---
 dbparse.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dbparse.py b/dbparse.py
index cc5012bc05bd..450406ff1b34 100755
--- a/dbparse.py
+++ b/dbparse.py
@@ -121,6 +121,9 @@ class FlagError(Exception):
     def __init__(self, flag):
         self.flag = flag
 
+class IgnoreRule(Exception):
+    pass
+
 @total_ordering
 class Permission(object):
     def __init__(self, freqband, power, flags, wmmrule):
@@ -134,6 +137,9 @@ class Permission(object):
         for flag in flags:
             if not flag in flag_definitions:
                 raise FlagError(flag)
+            # skip rule with NO-INDOOR so that kernel doesn't need special deal.
+            if flag == 'NO-INDOOR':
+                raise IgnoreRule()
             self.flags |= flag_definitions[flag]
         self.textflags = flags
 
@@ -429,6 +435,8 @@ class DBParser(object):
             perm = Permission(b, p, flags, w)
         except FlagError as e:
             self._syntax_error("Invalid flag '%s'" % e.flag)
+        except IgnoreRule:
+            return
         for cname, c in self._current_countries.items():
             if perm in c:
                 self._warn('Rule "%s, %s" added to "%s" twice' % (
-- 
2.25.1


