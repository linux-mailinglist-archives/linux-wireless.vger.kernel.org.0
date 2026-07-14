Return-Path: <linux-wireless+bounces-39008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzMHAAfaVWpouQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:41:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE5751942
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=Mshau6pM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39008-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39008-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556C6304DCE8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDE139EF2C;
	Tue, 14 Jul 2026 06:37:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8682DCBE3;
	Tue, 14 Jul 2026 06:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011049; cv=none; b=X+oDaOp1snfu4CtRbITxHZzhjPznVctzmEVRefhYiaGbZBk2CNviW4XO9zgTUFU1QaM+E/L0iIngjChl+PqY1WIf3vO7k8ohqjdm43sKzdPkqTvh7ZBYw3Z6f74oW3kKmP6GepvRtVmob+It8R9ZLSgBX9O3hNUJwc2L6tlvVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011049; c=relaxed/simple;
	bh=GkGwn376F7BE5RVGZppjjfouvV1bsKEXfbRQpIrL1tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcBGhAi5GhfY/Zt2tIKI0VVYrwoBDTpijvBYvRqdFS/xHqxEuBxI83A1pw0if3ocQm8H1eFlN1tQmLak5An47kfjztgZVFT+y0jFlBAf+B9x6za6Io1Lxur20OdGXCYerR+tbxMU+ZzUBbweUvbha57pJn1mv0OOgGKKNmVmK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Mshau6pM; arc=none smtp.client-ip=80.12.242.19
Received: from device-97.home ([10.64.95.101])
	by smtp.orange.fr with ESMTP
	id jWkYwgEf6fzaIjWkYwrYuv; Tue, 14 Jul 2026 08:36:14 +0200
Received: from device-97.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jWkPwSgdjLgO9jWkQwhwg5; Tue, 14 Jul 2026 08:36:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784010967;
	bh=s7dq0hK5vSS4LjpG7VM2pGMjoaS2RCGYKJDzNBOXpDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Mshau6pMTQgZcvDkQ7CxS77/E5zwAMEQjfMF1vuWNtuVylovOSJaAHBN73A0O3ulU
	 ideZXz63XUnNFMhZqBtLnQe1Z3lxThYWf1CXSLLrYVd7P+WxuYDHCYKmhzIsWU20He
	 DIW03Smj5SM4BQPduJjDQW0R44XV0NcSVrKA0j+FZXde9JrZy9w+tZXG7QbAHS/vGC
	 EtCu4Yc90kgo9GH7Ot92H3Ccrdo0AXcZV83W03MuHjqaOxNwkDW8w4hWUCq1GJq+Rz
	 yXSNI1lEu7wWsct0HBXW3vghmfKnIFHrQkLN4W7bFBhWGXUGNldY/QRacsCEWKEjLM
	 SDa3MeCHTnbEw==
X-ME-Helo: device-97.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 08:36:07 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH] wifi: ath12k: Constify struct ath12k_dp_arch_ops
Date: Tue, 14 Jul 2026 08:35:56 +0200
Message-ID: <469d732e2c6f159e1a05e89c7e417c3a10db5fdf.1784010931.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr,lists.infradead.org];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	TAGGED_FROM(0.00)[bounces-39008-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21BE5751942

'struct ath12k_dp_arch_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6318	   3384	      0	   9702	   25e6	drivers/net/wireless/ath/ath12k/wifi7/dp.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6478	   3224	      0	   9702	   25e6	drivers/net/wireless/ath/ath12k/wifi7/dp.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/wireless/ath/ath12k/dp.h       | 2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 64f79e43341e..a94bbc337df4 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -538,7 +538,7 @@ struct ath12k_dp {
 	/* Lock for protection of peers and rhead_peer_addr */
 	spinlock_t dp_lock;
 
-	struct ath12k_dp_arch_ops *ops;
+	const struct ath12k_dp_arch_ops *ops;
 
 	/* Linked list of struct ath12k_dp_link_peer */
 	struct list_head peers;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index c72f604661ce..01a45f428990 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -139,7 +139,7 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 	return tot_work_done;
 }
 
-static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
+static  struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
 	.service_srng = ath12k_wifi7_dp_service_srng,
 	.tx_get_vdev_bank_config = ath12k_wifi7_dp_tx_get_vdev_bank_config,
 	.reo_cmd_send = ath12k_wifi7_dp_reo_cmd_send,
-- 
2.55.0


