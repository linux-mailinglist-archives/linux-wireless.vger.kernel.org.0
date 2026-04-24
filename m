Return-Path: <linux-wireless+bounces-35272-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB8tEsts62kcMwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35272-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:14:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BB45EE07
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3891C300334C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039373D5239;
	Fri, 24 Apr 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoZ1RMko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5B33A9E1
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036486; cv=none; b=NPtA534oN+8r7InA+tHx1fIf2YI6gKQ0zgk3wHW8XYrZqNBW0rv9trE2Z9CQC+8PRfOxDdEZBH7U+kh8UGrzSjzRiS/ohByIntOsTeg8xKDzaM4G42E9lSeLxuLLXdTcPlvrk6g8PDYE4Wrd1MtddRbErxpdpdJTtkJNkuIkY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036486; c=relaxed/simple;
	bh=dyavU3qXI2tJ3+ju0VcHYmrHuUmrqrQ9qdsQmT3swxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN4v1OHxAzj3kndxlsK3u5TtgzpIUJfj5eHOXJOWn07sn4fvT5L/931vekYeM0rgcekT4SbajMvfOCjxdPRIsb0y6wzD2yv8FpJkudxsaOZbzoRTOOa9HxgfIn4PCOpIY2dFIdFF4pZKWp/vXiH+V45Xa4B3ZENKxD58ZjXyua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoZ1RMko; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7980c060cfso2682506a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036485; x=1777641285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdJIR9/b2UzOLN3bbr2cSRO1rNz516MTroGF1ZNF3I=;
        b=eoZ1RMko1lJucL7RZYAaGNBP8i9OsfJ2HULrGLjuN3A/M2ybRjw6av3+pbKJKaJM1M
         rx5n98PRhR3X9vcarXO00YmB0gfqAFdrob7YECoQLem2zsnn/m9d4Yu4zNprjvAWpUl1
         2G8uc8LLDJoTbx9+t9/SPoysav1Y0U4KEWG2OvP2e+qqTJxifpufe4UWvOB9IaISA7tk
         L3+bXqcxSjnP0TFYT+iKnTdr6aWRJmAdRGSzffbSkVNC2LX+P2wtUBryVJE9fIWV06DW
         O2kNoN6bnw1neDJFo4tXw2CUj32Ngua8ntaSY4YOvTrRaWaXeGdcL1kj2ai93Rc+mWup
         y8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036485; x=1777641285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFdJIR9/b2UzOLN3bbr2cSRO1rNz516MTroGF1ZNF3I=;
        b=ltwe6ZySx8+PJs98qgLpj8uBqxi6daM+0Xilhsvwg6LBp2pY3cv1XkY8XsSm5UnFZx
         0fTjBuKFJdR3dh3PjnoRove+xuscLeQhOt+f52TTUUp9jP2vbj18Zq08qQn+BcRWeJiM
         8Se+AlFsfHtK0X7Cv/He1TlZEvlXNm5obTVX4+jOpNoIzk2xFrYXwxPJw1fRq4si2Bk9
         WBXB2DwCXncPUC2rvFaHo4BON+da2nbVhOHE4o315JQl87ZAIPKc6oq2g9aWtPi3UvvQ
         yZH2W1AON0IvaGuD9tV9K2cWK9ZVh6sBD1mw07W8Umg/ligD2dhXV3Q3l2bViab21iRD
         B4Fg==
X-Gm-Message-State: AOJu0YxM9ONEqsMSIYx2Z9fnmcXiBp9FiJv1arL/rEkAvwOAUbFXogfe
	Uk5VdqnEchexqzCg/NseDcB8H6LFR36aWh68PrifsanfNpfgA3Sdv7w+KlAsmi6cGUax09NU
X-Gm-Gg: AeBDiesb+xBhXohpFIt/iLXUfJzanig1jgXDxmc8VUl2aXA6KJaqJIYKO9tssQNX+a2
	liRu/2QqMJt/SHVFhTMXLxB5mv44nERMHhleQ4Smxto0Bxh2eaSpeNoakd7eN3CNJC0S4/Xd2tr
	FE7bqdQs8kX/2TBOVIqa35YhoKPLMBZkKebtZqxiAI+2ylCjUZavOVNmFrKpSCTnjiiv7yRLnG3
	Ys8cZA1p2mHDn0rAmiR+K4W0aWRJJN7X4R5aj6pKrMAKdAKnEGiYRQ5FMwighaAQ71uMohqrXQX
	j/7JTjg7IjSXZrT7WknInR4zM4ZRWISl3fo0JQBgGgjtz2OZ8u+ZCUn0+umPFVvHhx0lqgp2aRF
	a9t49GiwjET7P0EuwE5XkVL8JmVA7w/NqAahY3Vdq4RyiyrVMu3TPNTLK/J1GULiJAj+qrh31/a
	gdb/8ao4eYrdINFouf48XFlFCLqH7t//U4RvMPcxRhWdFUAhFn595xRaC1J+lGaWmhtCq44E8fu
	DEtECiR7Q==
X-Received: by 2002:a05:6a20:2583:b0:39b:98e3:6a11 with SMTP id adf61e73a8af0-3a08d8faa9amr37311860637.50.1777036485068;
        Fri, 24 Apr 2026 06:14:45 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm20324116a12.8.2026.04.24.06.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:14:44 -0700 (PDT)
From: Catherine <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Catherine <enderaoelyther@gmail.com>
Subject: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX rx_result
Date: Fri, 24 Apr 2026 21:14:36 +0800
Message-ID: <20260424131435.83212-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D34BB45EE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35272-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

ieee80211_invoke_fast_rx() is documented as safe for parallel RX, but
its per-invocation rx_result is declared static. Concurrent callers then
share one instance and can overwrite each other's result between
ieee80211_rx_mesh_data() and the switch on res.

That can make a packet that was queued or consumed by
ieee80211_rx_mesh_data() fall through into ieee80211_rx_8023(), or make
a packet that should continue return as queued.

Make res an automatic variable so each invocation keeps its own result.

Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Catherine <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3e5d1c47a..8719db8f3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4971,7 +4971,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	static ieee80211_rx_result res;
+	ieee80211_rx_result res;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;
-- 
2.50.1 (Apple Git-155)


