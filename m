Return-Path: <linux-wireless+bounces-38703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fQUsOsvWS2rKbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:24:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A171335F
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:24:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="A3oP/Nyp";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38703-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38703-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215243077B6A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73C430CC6;
	Mon,  6 Jul 2026 16:18:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2420421F00
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 16:18:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354710; cv=none; b=XXZ01BzQokf/fPf5f5cOK8BLqRWFniY/qnMAY9JvmEMggGkejprZ8gI+pHcMmHoJ6P0XbXH+6G8vCesfw7BWzNhPHChWie+JnkXOK0gxUqEp93lhPxrcuiHsfPfFKPCl5lu1f22a0sCWHwFmZ4T5b3L3FavpSwhTp7RaOkzln2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354710; c=relaxed/simple;
	bh=uga9yq6Wsu+61EZ2xlBnLUHRbvzLzH7QGLu0bVCIo2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ua+7Zj02JNw61LJEYWeYGpHC7i6t/boxR2m5KxQ7px4MRmEX1X2tIExQgdN2ufVLI7jVOxgx1u4o0tCAS4fuy16YY6ZWNvfgR3cISVTDA+KCN37jdvF5ixcr4suso4dEDpjBue8pEIzEw8gwK5/4MAI4figheEAKwPT4Z9caqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3oP/Nyp; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847aebc56b6so2515879b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783354709; x=1783959509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t7T+Sc/sT/VjtNfD1hynQA07ltSFXZs0EJkEbquL54=;
        b=A3oP/Nyplesbd7EcXW27lclTFjKs7BfBNvt+BC0kKYr0E6exIfIRucH6gi4n0yUkdo
         pPQBmVbPg9iq9TW5R19WAl2cI8GhHPEnxtWhF94m/x6GGUz+xhVUBNq+uypX3R6yFLHR
         P/aZh/9X36cGw2Yndp6Aq0T6hx9urye6MHloG150pgYqKbhJ5xk4NG6WB9Ok+t1JJYAb
         jJvqWLWMV6qqN1A4YEkvhn+6e9/fEQiECYXQD09gl0ebd7JW8RW9am1QiluGs4ztpfUd
         2b7Tmpvq51OnfEVjybkh034TuNAX/VkSTyWMErZHjfFA52rykt6oXa3CkiZOk6of6NBV
         Ctqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354709; x=1783959509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t7T+Sc/sT/VjtNfD1hynQA07ltSFXZs0EJkEbquL54=;
        b=EMDaG4f0CRXHJWejVAdNZipLesOXLVlqsXmn7rS+Rn/rn8cf2UHEiMZT0eNVzs05RD
         9IR2bdzLpOd10FiDsafXkyDavDDDKpu0zFo8VCRrPQXU1JvwSU9VqSxse7EwTDEekFmN
         +xE3/pSvm2E5BdokgsrpZdjTBxpu0PwFRXn/AQ7WDi+CY/IdpL5aVMLguXN8aml/yJGT
         wmz5MppCTHoi/GqGNBjqfvFwrZqso+aUz3sDndNBvJGo/8Uq1PZrGpcOHD1pHGtTYGhu
         aM5M2e3JAMQf1tD24Opcx8MQq4vSj6P647P2r2WtrrdMRWVP9bvLpQYDtvzcoNCCtG+S
         IUDQ==
X-Gm-Message-State: AOJu0YzBizhYtDw89Dv7xt2ugZWL4ovmOGSPIz1jhdlVBISW/TjZ3+Wv
	oWG6ZFT/AMIyjp80AKdnXjWo+u+EXTolbB2MwUUh1GrSq74RAMqrDNnI
X-Gm-Gg: AfdE7clNb17DKhdMAyPB/dcfJUyfMgy3/YQFNyqemQOfq3ecY6FKUv0VaH7PWopLY00
	Q/2rskIq/tXNi8fK7ZcwSL1VWvMwdwvkWINGJ1iN/93zXiemPUGRbm3tv6pdCys8t2mbWZaLUni
	sb3b7anwdMI+bc0TbFfJtUM51WMaV/AH+x1URbt2L8Nc8+sawJE6CT4C2Jx4hWmo/A29b1xjtDC
	Z83h1EmyDAp7hbDjXzrbLF4aY/Ftc7aiSTTuf5jB0DA2GZMLvmZukXH2riGhRH91m3GwD7InzBV
	bXbJaGFX/P9xDgODBYYpZTyENhQKsELBnDI+y2GdmZC3C7EGIEPetDm9qH9DTAafS5NwSTsSqUy
	H0jj90Nwq3VdkdM+UzlcMlbfXF2Dge0zehXVptyRe+uGUhVudZU7egqmMO8ITVTsdAtwoeb8QZY
	mlcubv1O8=
X-Received: by 2002:a05:6a21:62cc:b0:3bf:63af:859 with SMTP id adf61e73a8af0-3c08ef1766cmr1637800637.45.1783354708931;
        Mon, 06 Jul 2026 09:18:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e92b83bd9sm6325071a12.31.2026.07.06.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:18:28 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: mac80211_hwsim: avoid NULL skb in stop queue drain
Date: Tue,  7 Jul 2026 00:18:22 +0800
Message-Id: <20260706161822.921039-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38703-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 974A171335F

mac80211_hwsim_stop() drops any frames left in data->pending. The loop
currently checks skb_queue_empty() and then dequeues separately.

That split is racy with TX status handling, which can remove a pending
frame under the queue lock. If the last entry is removed after the empty
check, skb_dequeue() returns NULL and the stop path passes that NULL skb
to ieee80211_free_txskb().

Use skb_dequeue() as the loop condition instead. The dequeue result is the
object that stop owns and frees, and a concurrent status completion that
empties the queue simply makes the loop terminate.

Fixes: bd18de517923 ("mac80211_hwsim: drop pending frames on stop")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..f92d90bc7107 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2303,6 +2303,7 @@ static int mac80211_hwsim_start(struct ieee80211_hw *hw)
 static void mac80211_hwsim_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
+	struct sk_buff *skb;
 	int i;
 
 	data->started = false;
@@ -2310,8 +2311,8 @@ static void mac80211_hwsim_stop(struct ieee80211_hw *hw, bool suspend)
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++)
 		hrtimer_cancel(&data->link_data[i].beacon_timer);
 
-	while (!skb_queue_empty(&data->pending))
-		ieee80211_free_txskb(hw, skb_dequeue(&data->pending));
+	while ((skb = skb_dequeue(&data->pending)))
+		ieee80211_free_txskb(hw, skb);
 
 	wiphy_dbg(hw->wiphy, "%s\n", __func__);
 }
-- 
2.43.0


