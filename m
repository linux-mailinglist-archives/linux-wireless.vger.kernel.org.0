Return-Path: <linux-wireless+bounces-34923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJZaHW0U4mnZ1QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:07:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061641AB08
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AFD9303B5F8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B43A9625;
	Fri, 17 Apr 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jsRv/IN7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517338AC8A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423915; cv=none; b=DWsVHNd7UqfPxmcOBCNs+cKYQgQJPvb9RxIeDTAsyYYsBh3SsSB+C5SXO7U9Ylsg245yCLyOvDGjfkDzac2i/7pqb3UyFE6Kt0ZCMO7Pyrh22ERBncePliBbDErWwII0I7ulaBA9yS9kn1nhajus35KdOpeFz6QVdBEUaHTS2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423915; c=relaxed/simple;
	bh=OU8YuQI77Usmcr0os84JKarPkDUxP3d7PbSbLD5VMyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4gTtDchXb4FwBiRKuyfHguRKFK6V0+jVmGsdxUII8q72pkIhlXtkgla1QAge5tHdWThc/zw/TmJZwsFqhZsP8clbj3b4lKcPwRTxPBvz/xuGKomGlFLB+509IVKACIfUsG/jZyIKcCwRJl/ZvpiksinKTyAVud7Iuno1u7oR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jsRv/IN7; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id EDE25883FF
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:57:13 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:41d:0:640:8e35:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 9E38880549;
	Fri, 17 Apr 2026 13:57:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4vLe3aZRt8c0-xHlgWA25;
	Fri, 17 Apr 2026 13:57:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1776423425; bh=pTf4Ewgl0uakCCidAUdEOQCb0zW65isOJG3+rnpKT6I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=jsRv/IN7yqrv1mSdV+vxbuLO1GjbI+Ykr1pdX56jlMQ5KESGR5WMqpW3ipcJsk4T4
	 cmyFM+XbfTkdfK+f1vPzzJUyr1tlN0CCYuXQOp25bNg+BXHM6y71w26uodZDKCr7Af
	 xcOVI+uOE1+o4+R6YrTbTJhCikPSdjdvTKUpoeU4=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211: use kstrtobool_from_user() in debugfs callbacks
Date: Fri, 17 Apr 2026 13:55:56 +0300
Message-ID: <20260417105556.2886928-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34923-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1061641AB08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prefer 'kstrtobool_from_user()' over an ad-hoc quirks in
'aql_enable_write()' and 'force_tx_status_write()' callbacks.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/debugfs.c | 47 ++++++++++++------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 5a1831b08677..a4d5461f6480 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -320,26 +320,17 @@ static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
 static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
-	char buf[3];
-	size_t len;
-
-	if (count > sizeof(buf))
-		return -EINVAL;
-
-	if (copy_from_user(buf, user_buf, count))
-		return -EFAULT;
+	bool val;
+	int ret;
 
-	buf[sizeof(buf) - 1] = '\0';
-	len = strlen(buf);
-	if (len > 0 && buf[len - 1] == '\n')
-		buf[len - 1] = 0;
+	ret = kstrtobool_from_user(user_buf, count, &val);
+	if (unlikely(ret))
+		return ret;
 
-	if (buf[0] == '0' && buf[1] == '\0')
-		static_branch_enable(&aql_disable);
-	else if (buf[0] == '1' && buf[1] == '\0')
+	if (val)
 		static_branch_disable(&aql_disable);
 	else
-		return -EINVAL;
+		static_branch_enable(&aql_disable);
 
 	return count;
 }
@@ -371,26 +362,14 @@ static ssize_t force_tx_status_write(struct file *file,
 				     loff_t *ppos)
 {
 	struct ieee80211_local *local = file->private_data;
-	char buf[3];
-
-	if (count >= sizeof(buf))
-		return -EINVAL;
-
-	if (copy_from_user(buf, user_buf, count))
-		return -EFAULT;
-
-	if (count && buf[count - 1] == '\n')
-		buf[count - 1] = '\0';
-	else
-		buf[count] = '\0';
+	bool val;
+	int ret;
 
-	if (buf[0] == '0' && buf[1] == '\0')
-		local->force_tx_status = 0;
-	else if (buf[0] == '1' && buf[1] == '\0')
-		local->force_tx_status = 1;
-	else
-		return -EINVAL;
+	ret = kstrtobool_from_user(user_buf, count, &val);
+	if (unlikely(ret))
+		return ret;
 
+	local->force_tx_status = val;
 	return count;
 }
 
-- 
2.53.0


