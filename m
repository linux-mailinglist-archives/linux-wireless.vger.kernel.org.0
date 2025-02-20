Return-Path: <linux-wireless+bounces-19153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419EA3CE21
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 01:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34923176163
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 00:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA88433C0;
	Thu, 20 Feb 2025 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYUp+KGl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621313EA83
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011507; cv=none; b=JLPAbiPqUDhSBLxXQW1lptciOA8ZYwFqMnxp4Zm17n8PL8mVXJI1yuzJPi/E47jLPHCZcmguElBGiQPo1Ba4BBWsZhkUx9JKQj9xPKIOj63xnX+cYMzmPG1Xm7CWWhJVQSn5J+D+YF3wWTXm9pgXhvwmpwDZRUUvkzgqdxDhOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011507; c=relaxed/simple;
	bh=XcTaidESR8T8rnv/vbSGAZ9MQTY2q6bDjKukkR/mcGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBE0rDvcW1qedBsMQoaksYgV4P834aymt70UzH3aU0LtIl3EB7tkj7HUnMytePTh0TDQfDHe/2k5oL96+lo6YHiXKzTHtmpJsmM0W/Xan/zX+zk/iQI5Yk/96BBZNhvPe5TQnv8f5XYNX31OXz2BzCLzpKOusIYqxhfJ6aUe++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYUp+KGl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8cf98bbso6778545ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 16:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740011504; x=1740616304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wVM9iAbMm11U5QAmsHItwzcKVUUL3DYXKcGmr/7SyI=;
        b=FYUp+KGl34/tak8zwduWLPuGgDfWC2RQuUUhw2GnNdni6aPuDwiWCiJuj7tz4ec9Li
         z+JcDtfdJupnbKY3B7UmcaJTioYxzEF2kbJxEr/0NQJIpuV7Hm+mkWkLoQ3EaHMeZNIs
         5k+knotzsOWoM93dcXHv7w4cUx7125yCLDiBlqt4KOdEJCstY3DwRrNtLdW8zr9Wmrbu
         88fxuTVF6GhKvGNwOgO0lkk0IsJiHWvPRLfQxn85B7XINvw3UCYyJdr9FRinWGNxfGAu
         EOebP7egmGh6wREUXcHplyGSJWZOQNw6HsFViABZ1SwYHGyDJ02b6vTXPNqWHHS2FtuF
         0Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011504; x=1740616304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wVM9iAbMm11U5QAmsHItwzcKVUUL3DYXKcGmr/7SyI=;
        b=LoGaRiL+TqSnIQpnsfs4MCQUZYwX9eDkI8S/+8iIQk2I29fqetdE7aK1BUyqJ0ji6N
         5tvl1AzCnyEyY2OFyjTkwUAuaq5JbS+O/itAoKWqY1Q4ICStavtHNL9VisSTDf+37pex
         Ma5cXLyZgBl6X7bm4D2ei7Ex9NX9cd9q/zgfswqM5eXuQKo+9cHnCISGqum3Xz+EX5PB
         leTR4YQ2DijCgllzVqZabGwtQqKAFzjxJXsoWyOxsC0jrn214Thnt9IbZQ5e0ZxlkW7S
         f1uCxLVMfL+gy0qzzR5r3h3tHHc12UFTKGZJrOXEf06KCuJbVwBTX77/+wsCnxRqYupJ
         raxQ==
X-Gm-Message-State: AOJu0YxS3CqG00pEl1sG3WhhGeZfnkbfUV285xmb/KJ1OSKSfKN86ZAM
	4ekAe2a+Zj/AIjNzAzvxxIRZC50puj3oZFUh7GmByvmFaAfkf/GWAwmAtM78
X-Gm-Gg: ASbGncsu04c62xbedb6BoUBV27fvRL0ixPDCLNs4a3c0RC+NGd9iZascneTRo8vUgWP
	PFaIF3B5Y+BE9gyS/u/f+mQQkFIiR8vMAuankLptBN2fwXQHx6Qcx2dzfp46bn5nw6v3jwIKH38
	/aSBOcZSvIHm8sOWQDQwilRduNMNOmcjmOdlAdhaME/GrcJZeXZhP10PTcYRlnvPi+kJHM+vjHt
	+3c+v//7OqWLREHT1qHODSrUIQfLMtqvALxbFY1+4jkgpu0RUlgbUMHE6BVfWbzzLxsHHWTKwwm
	RyifV+wjFcZIga0dz+YRpF4pgGFLEebLPg7FUitK7jWRUzVUJEGm+cS1cA==
X-Google-Smtp-Source: AGHT+IG8s/2SKn5n/jaztt7CLxVpTXSMBCkw8uvHm+S1a+4QXFfJSB9zSUJRG8OSJvxQVW75hCU49Q==
X-Received: by 2002:a17:902:d485:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221040ab8e5mr352109155ad.34.1740011504519;
        Wed, 19 Feb 2025 16:31:44 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d556d6d2sm108857895ad.177.2025.02.19.16.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 16:31:44 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v4 1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
Date: Thu, 20 Feb 2025 08:31:01 +0800
Message-Id: <20250220003103.4484-1-pkshih@gmail.com>
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
v4:
 - check NO-INDOOR after checking validity of all flags
v3:
 - new introduction by v3
---
 dbparse.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dbparse.py b/dbparse.py
index cc5012bc05bd..29f422445563 100755
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
@@ -135,6 +138,9 @@ class Permission(object):
             if not flag in flag_definitions:
                 raise FlagError(flag)
             self.flags |= flag_definitions[flag]
+        # ignore rule with NO-INDOOR so that kernel doesn't need special deal.
+        if 'NO-INDOOR' in flags:
+            raise IgnoreRule()
         self.textflags = flags
 
     def _as_tuple(self):
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


