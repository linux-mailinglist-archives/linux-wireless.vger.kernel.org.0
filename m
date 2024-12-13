Return-Path: <linux-wireless+bounces-16346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421969F0451
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73ED1699ED
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE91898ED;
	Fri, 13 Dec 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO4fUTo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377B184520;
	Fri, 13 Dec 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068814; cv=none; b=U51G7cCu3CoEc/hCrHogiZHSmghcEhfL+ruTAmEOOrNYZxfiyi0Fgbr9lI7emZfVSNWQ3pHb+YA3epCk1MbqdmN2RNGOAHvDxCONH9Y7Vuv62bJEBosjpcbCY8cTUqFxrPYaylFXL9K972RRoWuEZzeVRRXo1rsdnN7wGLIAAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068814; c=relaxed/simple;
	bh=Dbl6IM9eDg62zjXvaePP45Yh+mymlhXe9Q+BwlJcMGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J45isa2279jpkkneUXslWrzuXUnu8I8FNphSAxI6eJYdhEht5I417dMHaDedKRtasgur9F8yKyfYe+8sSHkSo6JwUDBMUbbYdpjMCMWpkyhO9CPdM4GV/+IoSDkUxWZXV6cfD1K/qfs6qaca9Ie2JcwfKjr14MRIEp/MoNRsKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO4fUTo+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216426b0865so12491895ad.0;
        Thu, 12 Dec 2024 21:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068812; x=1734673612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq/q3oQ+1coBzSyYiu7PIQ9YY0FE8S8wlVnD6GFmf1s=;
        b=nO4fUTo+ujRaJlE0S93o2VLnOHCaVD7688hvdLJlVwIgGhj1CxG5Rh5z5b6W4CWPgt
         VXGb5dUZ104qbbJ7zavbnJdH5Em90pNp6EDw6aAeAVSNrLa5IPyz2ZgxnQpBTXLxgs7e
         tteF7dtURQ5bW6atCZvHaB99Ro9ejpHKPLCsY3CEryt4QtdBGvn1V5I/6divebQguR8x
         vynCIhkC6zNsxyjgJMx/YGpacI63wRPdu4KcQ1rBzn5WRh94XTfQsHw2Pl+euP6o8NXJ
         Z0/kJPNThvi+kJbuSyC571Molw7MRd2w3nFqVZ+kzMaVZZseYtc/3NDfXJmAXDyZC7ad
         2IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068812; x=1734673612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq/q3oQ+1coBzSyYiu7PIQ9YY0FE8S8wlVnD6GFmf1s=;
        b=NkGbrCOAZUaCsCyLd1YviDLDevn1S4Zk4jCo4n8J3cTZ97sXqJAHpsmV6e0xpcYYLe
         mHa1PxpVs72MMJoi8yZFP4N7IUqEpozvsTlaa6x6JSQ2Fq3ZgkJhVS0wCTPWaQn8/7gM
         jGENbp1vpixNamIHuj7n3XPbfAFev6xrsHOAmchB22d1G5GecrzqF1PjcZgBvvb0a+US
         6k3QbYr5LePdn1Nur1mmTTykxrHihsFY64JVPR+pHQDQFKerzKZfPymrdrBiNDKiw+Rs
         S/GNq9DXXHJPjF3SB1CmiYXETci4uk6vb3YmdtZyfnIm29MtZCCsuj68Ozcbx9btiJEC
         h5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZSZRSb5Sgwrkze7KLzTqs/hWuV4qxE557fyn4MU8gh88syxkQ8MiKBcOCKwG8m8+8au2+RKjXqzalJcTW3mk=@vger.kernel.org, AJvYcCXW4hLlio1w5fcQiUMGJlUlsS/kZUC5FeTiQPT83RaN7DypYZinKdK6CFrun1C/FPMq3RlUKyXb1tGRYhzrBe9+bCOeIFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXqt7kUvnSH+GxLtJVlINp929hAbhZRoCS4A22TX6Tv+wjiJZ
	gbnj6K37HhIhstKLHMp8dSv66gfc06QEorT9iM01mdKAyw15o3tY
X-Gm-Gg: ASbGncuCdoyJok9fOTRISSWI11tDfulPO6aBiwW6ukWQigbFAO/dhpYD/wFsvh0N/M1
	Coe00GkZ7IEE7qn+sbpIus+s+cpj48yB9dVOvCujNvy+Om0QVzPS2S1CCwPErr3BTSb1KQ85TKd
	gZs5FgLu4R7kRMaW3Uq7IEgE5ZaR8kLBR+n1962chBJxzKyl39gA2Y1zTayIrCOyMg96Qj/OLCk
	sjUEBJIskRXaMVbXcnHT2ym5PellZxvKFcTM9BdX8f56Z1aFTq+DATOJMRgK2KZVkeh8ENnHh7z
	WkOkqi8=
X-Google-Smtp-Source: AGHT+IFWBnsyszL3fKLErMwBwi/nv5YJk8bNHSLutoorKV6bDApMEi8hBMM4652Yq5VqnH7LBX6qQg==
X-Received: by 2002:a17:903:2a8d:b0:215:a3e4:d251 with SMTP id d9443c01a7336-2189298bb21mr20543965ad.6.1734068811964;
        Thu, 12 Dec 2024 21:46:51 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.46.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:46:51 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/7] vsprintf: Add %pTN to print task name
Date: Fri, 13 Dec 2024 13:46:04 +0800
Message-Id: <20241213054610.55843-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241213054610.55843-1-laoar.shao@gmail.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the task->comm is guaranteed to be NUL-ternimated, we can print it
directly. Add a new vsnprintf format specifier "%pTN" to print task comm,
where 'p' represents the task Pointer, 'T' stands for Task, and 'N' denots
Name. With this abstraction, the user no longer needs to care about
retrieving task name.

checkpatch.pl is updated accordingly.

Link: https://lore.kernel.org/bpf/CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/vsprintf.c        | 18 ++++++++++++++++++
 scripts/checkpatch.pl |  6 ++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6ac02bbb7df1..bb1018d79655 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2273,6 +2273,17 @@ char *resource_or_range(const char *fmt, char *buf, char *end, void *ptr,
 	return resource_string(buf, end, ptr, spec, fmt);
 }
 
+static noinline_for_stack
+char *task_name_string(char *buf, char *end, struct task_struct *p,
+		       struct printf_spec spec)
+{
+	if (check_pointer(&buf, end, p, spec))
+		return buf;
+
+	buf = string(buf, end, p->comm, spec);
+	return buf;
+}
+
 int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
@@ -2525,6 +2536,13 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		default:
 			return error_string(buf, end, "(einval)", spec);
 		}
+	case 'T':
+		switch (fmt[1]) {
+		case 'N':
+			return task_name_string(buf, end, ptr, spec);
+		default:
+			return error_string(buf, end, "(einval)", spec);
+		}
 	default:
 		return default_pointer(buf, end, ptr, spec);
 	}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..fe0d80f55ce8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6908,11 +6908,13 @@ sub process {
 					$specifier = $1;
 					$extension = $2;
 					$qualifier = $3;
-					if ($extension !~ /[4SsBKRraEehMmIiUDdgVCbGNOxtf]/ ||
+					if ($extension !~ /[4SsBKRraEehMmIiUDdgVCbGNOxtfT]/ ||
 					    ($extension eq "f" &&
 					     defined $qualifier && $qualifier !~ /^w/) ||
 					    ($extension eq "4" &&
-					     defined $qualifier && $qualifier !~ /^cc/)) {
+					     defined $qualifier && $qualifier !~ /^cc/) ||
+					    ($extension eq "T" &&
+					     defined $qualifier && $qualifier ne "N")) {
 						$bad_specifier = $specifier;
 						last;
 					}
-- 
2.43.5


