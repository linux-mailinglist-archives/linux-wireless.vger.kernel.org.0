Return-Path: <linux-wireless+bounces-15620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F0B9D6A92
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 18:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BCBB21BF3
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565737CF16;
	Sat, 23 Nov 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko/bhx+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5766195;
	Sat, 23 Nov 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382711; cv=none; b=KaS2amBSz+SkkKXxXcLzLCTi1shxhShlO0qRg17H72uU+5rzDtxK1iM33dgrX1KkMklbRvsR6XkV9/+oJEgJfHJFfeAOM2urJhXvMiQ2T+YQcTtknko2IRpA4HjbJuE4JT1VYASha1yhATqGa4vfDGGs7hBuZOaL109M8a/O9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382711; c=relaxed/simple;
	bh=do5FpcXe+YPGqzUKIa7gtHLJOU1MBH7h7I39m14jIuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5nl4sgl97MqTCbzJai1JTv9VsbPRPz7bSV7/l167/HyJVQDbvr/nJ3jfTRHJBaipUWlFoq968KPHIvKUtO4AYO82qg5UhGbHylvxGrMyG1cgkJWXGqmKcwU3YWd6bbK1a58l7xNj+pKH65DBTIeNF601FEklphRlwGX6ypJw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko/bhx+0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so2431687a12.3;
        Sat, 23 Nov 2024 09:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732382709; x=1732987509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DW0N1eG0yxuVH6pEtyWsL2STLDTPWc/PAMyAqXq+1as=;
        b=ko/bhx+0vIJRizMX3MkgYLR8YqFre5YVOEqzwiBlWI+cGQlxBXzgzSZ6l37LZgIdkZ
         /lOOJBuXhcfWOzt4Cve3C8wNIJSWp6mjlDY8CvwV/TauviqEoL19crBMrA03FXSsPk1k
         3HE+4NJ5GZG0ADqFJJsiv7TWmD5eS9yPNw5gvJnHa3h/tkmNciSLOeQ8yCietVd7Rzos
         e+V/SdO5uOqFSpwIcwYMdMXa+xoeyhfQFlWP54pP0x2tkRoNx53kjzUFw2qxxv1DuCGO
         sSeXVVTSACKv7q4lVzoZdTVrc4YoQtGmmGbe0HN4gkPz6f4mr9WdO+Crvp0hsgaOIJQK
         wfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382709; x=1732987509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DW0N1eG0yxuVH6pEtyWsL2STLDTPWc/PAMyAqXq+1as=;
        b=nxLfofs2kicB3Ep74e2EsWstrXdTD+RVjoIRLG2jAZFhcU5NpvlvWBSG3evDItQtlR
         NLY+Xh9WGoc6yG/pRzNDffoe2Sh55pv8lbYBKvLmRjbmcfPIGmnHQ9eRrDVEjsoqDtuu
         cpjMgU4hfSwxePsKZC0rYAS3CRsPkrtPU7/JmGP3WfAdW4Xy6TlvfPb3dxiGuNMYV9Fz
         K96Pme913VDTPcmBKo5yApcOuk45YKE4VERshHdFL0y8Hy2OOznIMXZ0KBChTlN1t4gW
         QzQYGJRV5GkHN1vLttII1So4OWExlWFyUBpN8T+hZ/Fq8dXaCrtOjdfmtf+SHIXkpHnG
         QI4A==
X-Forwarded-Encrypted: i=1; AJvYcCUGHxFkJdSCKr5nL4ofgDxwnsU9iBLEsXVeG+YRrSalgAkfkJquE/zEoFFaSbKkrcbvoWRK3FeE6gHCKkR0@vger.kernel.org, AJvYcCWEBvLK5GV3MPfRwGAtLL/zK57+Hwfx4y4nlfKO/m7B5/qX0fRfuV4vczokzOTDEBmKOVrJsiRdW4qEPxrjv20=@vger.kernel.org, AJvYcCXvPCNPYU8YZ8Ic1lkOlxAF/+YA1mSapZLnbBVIJvkFv4yeCWdjPw4/D2RnokbkIYclXfHY5ruBuz61HsDWhCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZS6f9VtdZA05XtjemfSUMyBLU2XqI3O8p0OpyhE1j+6uxvmr
	6Gbr45yB8dcQRM70ZPIM4xeGHHUx7xawChmEl5wqCNaxiQ51FGgoriYivHcVxpBTvK7/
X-Gm-Gg: ASbGncvC7wChNB79cL81LcQNxTsId8Uu0cYodm/AfQFiQR1cCzRrswBAdQAT56el5+A
	1SBpvNaVlCSJKGHJBdUc5w6IffmaI6CcpDWOK+4QXJ/V1ZIe670/KFM+k7tF1VDrCi4iwadVXab
	dCufeantepq1z9DUI8ZaQvDoF5xZ2eIERMOO73TyW8zKDT+/oPrPzqoPpuPD+5dRqifcfMhZ/Z0
	4dGdnrhn8ehkbY8N67Xupkp7cSny+6xhUZi3bU0JgKexdiNu2+s7Q==
X-Google-Smtp-Source: AGHT+IG1PhaCoRwezIi0opqFOZ1+jE+e8RYz3APjscqDtcqIIdEaXJeTQaDRBchS0Yw2waNsl3Ro2A==
X-Received: by 2002:a05:6a21:114f:b0:1e0:bf98:42dc with SMTP id adf61e73a8af0-1e0bf98435amr1574448637.28.1732382708694;
        Sat, 23 Nov 2024 09:25:08 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47955asm3621038b3a.65.2024.11.23.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 09:25:08 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Subject: [PATCH] net: mac80211: cfg: Initialize cnt before accessing elem in ieee80211_copy_mbssid_beacon
Date: Sun, 24 Nov 2024 01:25:00 +0800
Message-Id: <20241123172500.311853-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new __counted_by annocation in cfg80211_mbssid_elems,
the "cnt" struct member must be set before accessing the "elem"
array. Failing to do so will trigger a runtime warning when enabling
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Fixes: c14679d7005a ("wifi: cfg80211: Annotate struct cfg80211_mbssid_elems with __counted_by")
Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 61a824ec33da..1dd61c9bb8f1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1088,13 +1088,13 @@ ieee80211_copy_mbssid_beacon(u8 *pos, struct cfg80211_mbssid_elems *dst,
 {
 	int i, offset = 0;
 
+	dst->cnt = src->cnt;
 	for (i = 0; i < src->cnt; i++) {
 		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
 		dst->elem[i].len = src->elem[i].len;
 		dst->elem[i].data = pos + offset;
 		offset += dst->elem[i].len;
 	}
-	dst->cnt = src->cnt;
 
 	return offset;
 }
-- 
2.34.1


