Return-Path: <linux-wireless+bounces-37939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OnTeF7buNmrbGgcAu9opvQ
	(envelope-from <linux-wireless+bounces-37939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 21:49:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E76A996A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 21:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=ZE7ofwaH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37939-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37939-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3289330058F2
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079435DA42;
	Sat, 20 Jun 2026 19:49:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D22571DA;
	Sat, 20 Jun 2026 19:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781984945; cv=none; b=bL5y84Z3nMtxRUfcsrspBBxO6P4hBBRT7gXeAUijW45NM908Kfn2oHa5soNVw9DtHK7Iegj37UqeDf0nKekB/Dz7Eds38gOTg6JQIakD8/yrJvfGq6j4hQaCfhVrutIEJ5RKERpxfwj0TrE8Nhfxai3z8LWL65W3E06GZ9RPWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781984945; c=relaxed/simple;
	bh=gHZxsX8bY6Zhd3K5Hf0IjdC4MpUB6U7+gcFfrfmOpJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooZM8whCMYr1aMErVn+Gp0sdJeE+Xzncm66m4rN8PHy8TfHHiUSVdxqC/Yx+iXXVbDKwdTMIuyfDu4BeOsGDk7RnWCX6N44LbtLM/DEtmuycaFvz4CsCeeGn51fh0qE7Qv99KcXGovYSfoTFFQbpepeJu9TiHMK4Wops6HgV4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZE7ofwaH; arc=none smtp.client-ip=80.12.242.22
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id b1gawLfr9VbDYb1gbwqvkU; Sat, 20 Jun 2026 21:49:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1781984941;
	bh=vRNWjvfotB+kRrLOF2yEOhQj5VtGit3V7+2y36dr6PA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZE7ofwaHic4aJ18mr0Ol4YQKwDeahXb/FrMZoQ7OGVPQ7ZQHurgS4pm8DncFF/LyI
	 ymFeqFc3kmBHnL6LtkOmxrAeMr/+Z8ju1xTxsUqbMrPcq3yN34VeRXN23n5qFtZu0A
	 XdAWVwpG6ErZ8W2y4s1en00jixYK3BH4uniV34QYBoxwnJYxlMRCTIQHW3vEO8dzyd
	 6ni8OHpStM3D5a2Q0mL8f672Jp/tGN8Zme1zN4+OQgyY1IrwJY/PvX1ZLWxUZwtVvz
	 eBxcOKjPnxC7adh5DXCi7HLImEzJ1+wuem8cJZ9AhCXtRSEu3KTG6VfOIwYMahCDr8
	 ItSpWHl+D4OMg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jun 2026 21:49:01 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: Fix an error handling path in cfg80211_wext_siwscan()
Date: Sat, 20 Jun 2026 21:48:56 +0200
Message-ID: <a1be7eea4da0da18f90589af252bb76a18a61978.1781984889.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37939-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linville@tuxdriver.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD3E76A996A

If the test against IEEE80211_MAX_SSID_LEN fails, then 'creq' leaks.
Use the existing error handling path to fix it.

Fixes: 2a5193119269 ("cfg80211/nl80211: scanning (and mac80211 update to use it)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 net/wireless/scan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 05b7dc6b766c..38001684014d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3612,8 +3612,10 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	/* translate "Scan for SSID" request */
 	if (wreq) {
 		if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
-			if (wreq->essid_len > IEEE80211_MAX_SSID_LEN)
-				return -EINVAL;
+			if (wreq->essid_len > IEEE80211_MAX_SSID_LEN) {
+				err = -EINVAL;
+				goto out;
+			}
 			memcpy(creq->req.ssids[0].ssid, wreq->essid,
 			       wreq->essid_len);
 			creq->req.ssids[0].ssid_len = wreq->essid_len;
-- 
2.54.0


