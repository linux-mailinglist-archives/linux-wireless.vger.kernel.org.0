Return-Path: <linux-wireless+bounces-39012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9k+iKqriVWoIuwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:18:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968A751C6B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=SHhVFq1d;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39012-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39012-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7353056507
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE83DEFF3;
	Tue, 14 Jul 2026 07:15:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358A1A6816;
	Tue, 14 Jul 2026 07:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013328; cv=none; b=Z/pu8tJuZoscfB5a56J5UWM+9lfSpSeVtDP2SeWbaX7dgVtnwQRv84lI1sF4AZlxs1+xCqSLVIIcPxtJU/twb2jk47qtP+2GwD+CTixL5+b99V+6mXvwQxi8XdN8+CbWZ4WcWJK1iNQ+pyYm9y/4xAesUaF1God0Hi2asFLjtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013328; c=relaxed/simple;
	bh=8IFavZNqMx+KPefxR+v2kQGGi+5On0u6SVSae6DGdO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqx7m5qGRISqkB7NvJyX+zX575mgMO5SMK/6Uq7G3ww0VsA+w0eZLvK1fMlrhmP9sucLJbfVzlkhNOnA9Zdj67K4FmrUWW2hdUDk6cUc+FmHeacdCxITBcnB4yBIfTq5/t2agdYdkvASrx124soS0sAN3CzTPzPO+/7CEV+cR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SHhVFq1d; arc=none smtp.client-ip=80.12.242.78
Received: from device-97.home ([10.65.86.66])
	by smtp.orange.fr with ESMTP
	id jXLIw4eumHyPqjXLIwbIOb; Tue, 14 Jul 2026 09:14:12 +0200
Received: from device-97.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jXLAwudi5Dc2NjXLAwN20p; Tue, 14 Jul 2026 09:14:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784013245;
	bh=f7yHgKxBlZE3sw5vpiwyp79xhFrzLpHFWzdnwoYHduM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SHhVFq1dD33m9xnj8gMep3IBP2MqrlNKpyI7HGpArTUHhSUaVhFgoLWhf/l4V25le
	 VMVKItQU8Yseiri57z6bBlaq+50YrS3iutHlFfF9OykbGHU5HXopSNiKklOMnqBGRi
	 Zd3dsQHlDT5zUs5mS37m1uqg+XN68mKWpZWAfpxQgDrt6tOSsBLZfiov3uwhw84pvK
	 Tbgb3D3nbR8sSwsFMhodf9478FNp2BQgZr31ev7RPyQa+q8YXLevBvwjoXIIq8Y3n6
	 UBi8Af27WAbq1nwQkyYLNZM+mJQ/7woxpvtz5pafWT5td+h0zyFpcWMlJd+yYaGp3O
	 ynHq8YJ3Wh5yg==
X-ME-Helo: device-97.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 09:14:05 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: Constify struct cfg80211_ops
Date: Tue, 14 Jul 2026 09:14:00 +0200
Message-ID: <5aace954b6ef5c42017b83a1bffb859618e9498a.1784013180.git.christophe.jaillet@wanadoo.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39012-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0968A751C6B

'struct cfg80211_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 143726	  34579	    192	 178497	  2b941	drivers/net/wireless/ath/ath6kl/cfg80211.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 144814	  33491	    192	 178497	  2b941	drivers/net/wireless/ath/ath6kl/cfg80211.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index cc0f2c45fc3a..ecde91159b54 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3437,7 +3437,7 @@ ath6kl_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	},
 };
 
-static struct cfg80211_ops ath6kl_cfg80211_ops = {
+static const struct cfg80211_ops ath6kl_cfg80211_ops = {
 	.add_virtual_intf = ath6kl_cfg80211_add_iface,
 	.del_virtual_intf = ath6kl_cfg80211_del_iface,
 	.change_virtual_intf = ath6kl_cfg80211_change_iface,
-- 
2.55.0


