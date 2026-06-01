Return-Path: <linux-wireless+bounces-37239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cImYIiJUHWqnYwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:42:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41261CAB8
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C5EC3008D50
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295638F239;
	Mon,  1 Jun 2026 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="bgGB8M7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB33911A9;
	Mon,  1 Jun 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306959; cv=none; b=pnZMFaPq+Ay85a/hWXQn45HfgcT9Pm8337DWUDYeqYVz5KbDkiQz1l63YUE7ihAExHsTJjmKq0aRR/MmgGpIp6tkteaNCih83ptCwGlIuyFeeLuaJkftrSI9RQMWB1w6p1VYEkGu5ZtG1ZjxRLRqMqXuoV7vNGh2OU9b3ceREk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306959; c=relaxed/simple;
	bh=v/wlTCzzy1x3y8a8qqBDroW52+/ldlcxYkaF4hrnZZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OO63vRt7THrsFhbG7kBoQkZcACQ9TP6UVE2UIYCKSUn2wJZKK0635sWkL+8e7g23P/fjKOkl3lCxw/qm2WX45ZDo/dhxOwpHeBz5JeFEfEJWal9kUqIlQcVX44kvOOJilnbkLb0IsQGvPXtybAu+jgZrtt/cA4JaP+w+7kDoIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=bgGB8M7A; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id ACAE945F79A0;
	Mon,  1 Jun 2026 09:42:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru ACAE945F79A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780306955;
	bh=xK2hbDAVnfKEPFyoa/9soeG8bghEWrrXehnImFMj7Dk=;
	h=From:To:Cc:Subject:Date:From;
	b=bgGB8M7ADwysXs1pKvlgL4rBX77O9lxl5RUy9B9tlAGD9TH9h0Da9brSS9kR+Hw3S
	 DUiKmgszeSWArm33XYPGUJrlF2DWclyT481cMBY8Idh66uyw0xRTbrfHRuciYnNYmr
	 lu4sKyICqE7RpbEYYy4/7Kg0d6knX2VxayzT9MmA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-wireless@vger.kernel.org,
	Tova Mussai <tova.mussai@intel.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] wifi: fix leak if split 6 GHz scanning fails
Date: Mon,  1 Jun 2026 12:41:56 +0300
Message-ID: <20260601094157.92703-1-pchelkin@ispras.ru>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37239-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ispras.ru:email,ispras.ru:mid,ispras.ru:dkim]
X-Rspamd-Queue-Id: 1F41261CAB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rdev->int_scan_req is leaked if cfg80211_scan() fails.  Note that it's
supposed to be released at ___cfg80211_scan_done() but this doesn't happen
as rdev->scan_req is NULL at that point, too, leading to the early return
from the freeing function.

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

v2: move ->int_scan_req assignment after rdev_scan()  (Johannes)

 net/wireless/scan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 358cbc9e43d8..27a56ee2e8f0 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1071,6 +1071,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	struct cfg80211_scan_request_int *request;
 	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
+	int err;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ)) {
 		rdev_req->req.first_part = true;
@@ -1100,8 +1101,14 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 
 	rdev_req->req.scan_6ghz = false;
 	rdev_req->req.first_part = true;
+	err = rdev_scan(rdev, request);
+	if (err) {
+		kfree(request);
+		return err;
+	}
+
 	rdev->int_scan_req = request;
-	return rdev_scan(rdev, request);
+	return 0;
 }
 
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
-- 
2.53.0


