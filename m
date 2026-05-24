Return-Path: <linux-wireless+bounces-36832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNXrIhotE2rm8gYAu9opvQ
	(envelope-from <linux-wireless+bounces-36832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 18:53:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D45C336E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 891C23001CF0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6DC393DC7;
	Sun, 24 May 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="WLVZmTJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0C319617;
	Sun, 24 May 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779641620; cv=none; b=TfO3itDDyCTzfZHFbzWt/Hz0vE8wTFXvfqlWFyHBGt71on4srhHaheYr9IAm6AI1pzS8mn136LQRMpNLf8Gqo9A486EMSwGNtmXRsY2WsnbRJMfXF9P6deyYRO7dXibAuBTrOHGfu0YIptZtBYirLEwSKcgNi2V8ts6hGaab0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779641620; c=relaxed/simple;
	bh=oVdJqfzDg+pfCc4Qmkr/qgAA6WrCqYj0GrqFfkK6LQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUVKG3ybFSe09pnO7DHOqAoOCpLkd5OH7SCFSvfysZlX/Z/q3Z5d7SnMqv1wn+q3krXwcDh5x0jWK47msEmPml//Juf5CF+H50RCKL9PGCGtsFu+JGX7SxN4n4zjkrBjBvqrN8B6er8cZwTfN2HxplZLhLKkXlsOYogccPwePBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=WLVZmTJu; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.lan (unknown [95.24.24.142])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8230C45F79AF;
	Sun, 24 May 2026 16:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8230C45F79AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1779641606;
	bh=jj4UBIPSW7Y6JlpURWt0PQfTWw8tmPjqzcErRESUcKk=;
	h=From:To:Cc:Subject:Date:From;
	b=WLVZmTJuJBNKgf4SZQ7c3es0MHBWHFQ2hWv5tnwgcYuCdmQTqGyosGbWuCKb/QWO8
	 JgBDRw8NrGAU4IzTviLojcvhShiPgpBvKPtsM//qUnyfioIptJpgB5jVEPdD0O7uE7
	 3vs7i/PZvtXegkzoMhKtOoFR1TYEB4K+CE/R80LU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Tova Mussai <tova.mussai@intel.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] wifi: cfg80211: fix leak if split 6 GHz scanning fails
Date: Sun, 24 May 2026 19:53:20 +0300
Message-ID: <20260524165320.62089-1-pchelkin@ispras.ru>
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
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36832-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxtesting.org:url]
X-Rspamd-Queue-Id: 8E2D45C336E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rdev->int_scan_req is leaked if cfg80211_scan() fails [1].  It's supposed
to be released at ___cfg80211_scan_done() but this doesn't happen as
rdev->scan_req is NULL at that point, too, leading to the early return
from the freeing function.  Anyway scan_done shouldn't ever be expected to
be called if triggering the scan has already failed.

Note that the similar pattern at cfg80211_scan_6ghz() looks okay since
int_scan_req is freed there on error in case first_part is being
processed.  On the other side, when first_part is false - called directly
from ___cfg80211_scan_done() - the old int_scan_req is kept then and will
be freed afterwards.

[1]:
unreferenced object 0xffff8881161d0800 (size 512):
  comm "wpa_supplicant", pid 379, jiffies 4294749765
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 f0 81 13 16 81 88 ff ff  ................
  backtrace (crc c867fdb6):
    kmemleak_alloc+0x89/0x90
    __kmalloc_noprof+0x2fd/0x410
    cfg80211_scan+0x133/0x730
    nl80211_trigger_scan+0xc69/0x1cc0
    genl_family_rcv_msg_doit+0x204/0x2f0
    genl_rcv_msg+0x431/0x6b0
    netlink_rcv_skb+0x143/0x3f0
    genl_rcv+0x27/0x40
    netlink_unicast+0x4f6/0x820
    netlink_sendmsg+0x797/0xce0
    __sock_sendmsg+0xc4/0x160
    ____sys_sendmsg+0x5e4/0x890
    ___sys_sendmsg+0xf8/0x180
    __sys_sendmsg+0x136/0x1e0
    __x64_sys_sendmsg+0x76/0xc0
    x64_sys_call+0x13f0/0x17d0

Found by Linux Verification Center (linuxtesting.org).

Fixes: c8cb5b854b40 ("nl80211/cfg80211: support 6 GHz scanning")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/wireless/scan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 358cbc9e43d8..fe7b47d046c7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1071,6 +1071,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	struct cfg80211_scan_request_int *request;
 	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
+	int err;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ)) {
 		rdev_req->req.first_part = true;
@@ -1101,7 +1102,12 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	rdev_req->req.scan_6ghz = false;
 	rdev_req->req.first_part = true;
 	rdev->int_scan_req = request;
-	return rdev_scan(rdev, request);
+	err = rdev_scan(rdev, request);
+	if (err) {
+		kfree(rdev->int_scan_req);
+		rdev->int_scan_req = NULL;
+	}
+	return err;
 }
 
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
-- 
2.53.0


