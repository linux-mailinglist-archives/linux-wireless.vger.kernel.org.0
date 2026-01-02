Return-Path: <linux-wireless+bounces-30298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC5CEF42D
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCAA302B11D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DED3161B4;
	Fri,  2 Jan 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4SO99XH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4203043A4
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384202; cv=none; b=hOmri2ZyxlOiL3x0OaTP0zAw9p/JSqhi3KV6L+3PblHHJdItkMbC/WjDtY3Tgq+ffWDGmu99QmeCbRega+Luum4nZN9dHX3alJ6MfjQKER3LVehA/1COEriUn2U2BXj+JCWd2xDWyWofY9VwWgKhUsOQcc7nWHXuiXycsfyP4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384202; c=relaxed/simple;
	bh=M6Ock8BWADnZL2JWTWO6Lzh1vmLr6RD+DRXGyhEPElQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHBB4BMq94wHjjH1mLxJIcSyzih7lcc/wW1WBvK5HkBygv8Fvvhg74Xfv1/XtyxG8Kxk8S6OJ6tJ688BYy4Q6ROw42rD1Zy4SanHq3eapeGQ/Nt35wkJl2rWmGP2DMKILmE/S2HGKZoMhCA/R9Ieqo+yrMXDy8CdDi9uvDqeeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4SO99XH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so7546568b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384200; x=1767989000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRB/GMkUOZQKL62/6S3QoUiStZiACBm9ZEli7ks4aAc=;
        b=E4SO99XHpOZe64sJPx1bABOiaQ60usw8LvGxs96bJw0m3XoJnF5+d0dQUj9edqgX3m
         e8HJY7uNAAMz80gCwz+XlICy2MIdiStGE90uV0RD4D7fsFv0awflEOERljagNTaDNfda
         FZgnONyO6+XUy+b9lG7N2rt3zlpiYjvmyy8Hc7ZdZ3GtjsNwGeqsLeRrlqcpmkyJGvDT
         fMtpUkWWdsl8k4FP9WB4LDexmjb8omYhHuo5/Z1N7jRxABvEhW51h8OcPi8mwu5RExU3
         U4gOCxBvfIQ9Ujst7hu0LAzYKVa9RyzTNcgKlCl/c6/VoOv5644kcYgs5VZFn7fdyjg9
         uhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384200; x=1767989000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRB/GMkUOZQKL62/6S3QoUiStZiACBm9ZEli7ks4aAc=;
        b=IXI7bgl/jT4X0DTtSeSjNEiAdUvMgxVemZcVxglq/1tDzLJpRt5valy4NtX9DyxUxe
         OSkjR9nPwRzI7wRuplltlpKiWIbIqsKEGTCCrAlXgki9IQh8DbEeclOqGD+V1jJG1Ld0
         xAoR/ytDP9gMs/xKHWYHdM/ZotY8/XnQF025YNtRSNDH7pBbdsBWL87RtGP147SYNaDT
         3vrBeKkCzXPqWcoepedl105Gfg1no1TJWS/s+4OF2/SaLG+jAOoHbUvc5eaqaPg5pJ2h
         u/2HbBlNf1OoDKkZwfkB+C+cJWR5+dlk+36wUBeBYiFiaHCdnInlFB2Z87B48fuq1XEW
         op/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbRID8XHt817H4APCTF+rS3SJpCybTDKoNDHCmmdJAJUEU96JdQ1NcKBB02G7Dv4CN1c+kBxQx9tQ02886NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhL/pYrtN6u4tPpLklwlW8HONW2oYXEqTIyFhI7mByEG39IhvG
	/zL9E7WtAlTdX/sT+bOv0Idpbm/FvCLAwPYUXtXJKREbO5Oq8DtLiRL1
X-Gm-Gg: AY/fxX4/5e45+bURjZU2TYyEKrbUPGSQBa8flVPc+4TQgYcVj/tcO7OYkxQg/ADhNZa
	zpA+PzrGq6At1t/s8efdM3FG55jdeiHHpw2mIqVnhtHlMofKfBKeMnD0Wr65nkEAmDLqrhdXYg8
	+6rKyZqzu00grASgSXswOONHCWhvxMb8wRjNfSO9960DkDpIVv4dZ43ChLDIiRzM178Vynflqx5
	g7ZG/UL8QztDw9JBpQVPE9GFZ9u8rIoEJCD/66CrvaJmMFa1SyiKmBpuYeFW5cJ8ZZbozVWge7/
	osc+yOEtRoMeGWY2gTTRk25e9P48cjCx7LKl+15fVGGhfcypCPN80SUlS3J7MzKJFrUk4ooJ1ae
	mck2hKcccBX2zgV5KqUV2VqO4+lX79byD3JGGIvgeqPnHGOwyF2QI9/mR73GQcZRjDU/PWa3Imd
	U/7/am8kcwYpzIFtzO4uje9PU5TzpXw9n+EHpaVnc5f9kduBiwC9FGRfqpxO+XAxs=
X-Google-Smtp-Source: AGHT+IFBSUfFL7mHg821Z4iXp+NFgdGr+i44ARHcNYNV/RBJ9bl+fL+NqsT3peNN1SqyHKAuIrBvVA==
X-Received: by 2002:a05:7022:42a7:b0:121:a060:6d80 with SMTP id a92af1059eb24-121a06075f9mr28800779c88.25.1767384199803;
        Fri, 02 Jan 2026 12:03:19 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:19 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: fix kernel warning in MLO ROC setup when channel not configured
Date: Fri,  2 Jan 2026 12:03:11 -0800
Message-ID: <20260102200315.290015-3-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102200315.290015-1-zbowling@gmail.com>
References: <20260101062543.186499-1-zbowling@gmail.com>
 <20260102200315.290015-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7925_mcu_set_mlo_roc() uses WARN_ON_ONCE() to check if link_conf or
channel is NULL. However, during MLO AP setup, it's normal for the
channel to not be configured yet when this function is called. The
WARN_ON_ONCE triggers a kernel warning/oops that makes the system
appear to have crashed, even though it's just a timing issue.

Replace WARN_ON_ONCE with regular NULL checks and return -ENOLINK to
indicate the link isn't fully configured yet. This allows the upper
layers to retry when the link is ready, without spamming the kernel
log with warnings.

Also add a check for mconf in the first loop to match the pattern
used in the second loop, preventing potential NULL dereference.

This fixes kernel oops reported during MLO AP setup on OpenWrt with
MT7925E hardware.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 mt7925/mcu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mt7925/mcu.c b/mt7925/mcu.c
index bd38807e..b0bbeb5a 100644
--- a/mt7925/mcu.c
+++ b/mt7925/mcu.c
@@ -1337,15 +1337,23 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
 				 mconf->link_id;
+
 		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
-		if (WARN_ON_ONCE(!link_conf))
-			return -EPERM;
+		if (!link_conf)
+			return -ENOLINK;
 
 		links[i].chan = link_conf->chanreq.oper.chan;
-		if (WARN_ON_ONCE(!links[i].chan))
-			return -EPERM;
+		if (!links[i].chan)
+			/* Channel not configured yet - this can happen during
+			 * MLO AP setup when links are being added sequentially.
+			 * Return -ENOLINK to indicate link not ready.
+			 */
+			return -ENOLINK;
 
 		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		if (!links[i].mconf)
+			return -ENOLINK;
+
 		links[i].tag = links[i].id == mconf->link_id ?
 			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
 
@@ -1359,8 +1367,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		type = MT7925_ROC_REQ_JOIN;
 
 	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
-		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
-			continue;
+		if (!links[i].mconf || !links[i].chan)
+			return -ENOLINK;
 
 		chan = links[i].chan;
 		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-- 
2.51.0


