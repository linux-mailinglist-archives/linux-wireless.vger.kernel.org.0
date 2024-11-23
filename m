Return-Path: <linux-wireless+bounces-15619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4329D6A7B
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C841C281CEF
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10977CF16;
	Sat, 23 Nov 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YikKy8BM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF2182C5;
	Sat, 23 Nov 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381739; cv=none; b=MB/TpfenA8wWV9ylyTtrlekYCh1wPjM3USswoNGMQ5JKInRcB3wv477di2RJ29QWq45DWCmWuFNZXJo7Id30YAdVI3xUDrm/WnS0LMGDkOBS5UGsUoT5VBdRs7xo8MZNjRKOyK5/BrB/TnZ969i5ToFoI+hxqgLPHedHlMXgqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381739; c=relaxed/simple;
	bh=5cPMr1DNbqYnFPyBfwKQvLi2clCHwTN2t1b2+wRxcrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjIGmNZ01AjrisjysV835tJeSjddfLqeaO7RNFMJenVPEcVam/BpoxCZH1yK3/dVH9tSfP3RDloe86AAmdfzdLctsP8zSJhuwIj0hQHW7qdNydpTgJEI516XQuBc0tj8F5C/DljVyAfAOtIZt86hZOMt3SxmmsCuxM6TWZ8CQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YikKy8BM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea1e605193so2683002a91.0;
        Sat, 23 Nov 2024 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732381737; x=1732986537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEgZ1O0VIRFiEEKyO5T6PVpXFre8ATx/DXxzHlxKxNg=;
        b=YikKy8BMzgs42Y4SLSoHDBCH/t5jPQxLmJHYzdywwZJbwZQiJZ/xahs3S6yx0OZahG
         nhIGg/rSKru9QABw6qo8EvZWt0+XQbei8DP4NxQ83NqLEtNBxsSP6GCEpoE74V5A7SOr
         lVuJQqTido7FYKkqieB/vfFgv2Rizex2tWC6V9BCQixJrhKz5kLKzPUHP8Gbz2V8lmio
         xGfhRvuX8N4y87kdofi2S8mUXXYrZ0rOLL715T+xYb/dHVDTXerNmhBoqme3X2bOjkwO
         BdjkFhaVxWKzoYXi/jkogD84ToWnYFs2wQrEsF5MtLvSwfkiaxM7acVTUcxjHzowE/6k
         DqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732381737; x=1732986537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEgZ1O0VIRFiEEKyO5T6PVpXFre8ATx/DXxzHlxKxNg=;
        b=L12KaXJcKuXh955wML1i++NgVOqWvz8IBPJZvCXOhgQNrd5b9CCtSCyZvs2uLfA6pz
         prrjzFd22QoZCSBiuMGAb2gRoEP+WHwslKzq7hoZ6fbeelNOOAh4ZbDDfKqVP+ig48Xs
         s5kCEShQIbLlIQhsEnke8OCjWwC/agyXJrrh11miskW/d2ZsO0/btYRwSsC9AEBBmf3G
         JlLA1P2G9Y3wAYp4m22jYqPmpRmFX3XE6WHYmawKRVRPYzJ2nmLcN6I5o3aCVzfTXEGT
         vhr3TyNSBJnaLu0BfSw7WteqfXqIQ2rF56q7JStiKMFCi6wGB8ViN1Mr+yP0G0XQG0st
         VuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ5d58FT0YUA4zsQQqHWN+1VulO7wfobPneVUtYvv77ZVWQmwhu94R3bwxWsAydO1eH+nfq6RLa9Tic1ykQc=@vger.kernel.org, AJvYcCUQs6AJ8igX206Zm/hq7Lu/nlHhTDWwzwQMAojTpWywquLdmeobdWgqI9/UC6MSAays2XbDThV/xkUYOpXF@vger.kernel.org, AJvYcCWpF/RPR9cf+gTwa83qiRbvMJLnXXLX9UVsohBYwxblnxkwkZAy2VASyFH8Zw32bLGBPCpo+Og6wYbzWRaQyJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxybs2ubAeS1rScrcngGHIgBx9V3AhYsDK29ffQECXwqRPLCWjo
	/wdQZl58mjZg3WkfaUi0XZrfVPba1UheP7yxaC0Wubvkwa2PF3uT
X-Gm-Gg: ASbGncukCuav8eG6Z4DLpieVI6At56LsDWdMroe8LXgmKV0XtnCWEcUfa0k84ceRNR1
	Mm13HSDQoOVrTl8uqELG5srvtWCwqDznxB8HoE7tqU9VJLSCIF8fQnhLFoi69nOTwr204Pl389f
	B5nOHm5Vj/Cp9FlediNL7Z7fgwlmSLbKBmJ1yu67XfwH3ZDdS9yMZr8R3XpXjsjscc3+x5IkdpK
	no8+Zwjx9fIkhKyEPDeUmg0remyAir5YCzVSLjpyFGohixDaqCHgQ==
X-Google-Smtp-Source: AGHT+IFDejkdBKcCM04yTLOZf6qc2Kp6goUQ83wubq/BVryb3qqSxvFFIkvL2TJ53uOZB3bpHaExAw==
X-Received: by 2002:a17:90b:1d49:b0:2ea:696d:732f with SMTP id 98e67ed59e1d1-2eb0e841915mr9065634a91.29.1732381736978;
        Sat, 23 Nov 2024 09:08:56 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3598268a91.14.2024.11.23.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 09:08:56 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Subject: [PATCH] net: mac80211: cfg: Initialize cnt before accessing elem
Date: Sun, 24 Nov 2024 01:08:48 +0800
Message-Id: <20241123170848.309264-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new __counted_by annocation in cfg80211_rnr_elems, the "cnt"
struct member must be set before accessing the "elem" array. Failing to
do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
and CONFIG_FORTIFY_SOURCE.

Fixes: 7b6d7087031b ("wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by")
Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 61a824ec33da..6936b1303e81 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1105,13 +1105,13 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
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


