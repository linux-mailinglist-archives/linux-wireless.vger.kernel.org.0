Return-Path: <linux-wireless+bounces-38924-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7It3Ap5GVGpykAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38924-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:59:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C2746852
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:59:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WkPV+UQt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38924-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38924-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53BEC30088BA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 01:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8228C854;
	Mon, 13 Jul 2026 01:59:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A22641CA
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:59:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907995; cv=none; b=QVAAfBDIVKxAiDU4ODsRadWXn9PCBahI0c7hQfZFCGQstppOR5p8l0a4wdbjEaFw9/CrjzEOoeFnBebOqSeRHNiaaC6qb+1Zmy/1SRALsWygbNGYByeq9cXTD9CFOv/y9yw2PEGGlet/0HnBh8tpf6PDeHQfPgRSi+sBbFIwNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907995; c=relaxed/simple;
	bh=+11yWNOdd8cBhzP4+Mwsu4bHfxAH2qECK88s/cKMByY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGCh3hHoKkdKQKSMLoHzy3uclWOBDcViKYwdq0torXt7OhHvjuM3Vg651+Dzsm6dY2Ztuf8MxkIL78P8rNcpiCcaL7VEwG3QXzd1hNFRn6ouhtra8LXDoM/3UEQTjYkYxKtViaztRZDws6tn4U5w3+AIC/5Sn/m0lf2rGVe7Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkPV+UQt; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso2922368a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 18:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783907994; x=1784512794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6ZY0A81ZwFH7zPrXD3IEMLtteDysZZzXtDeInBjqMg=;
        b=WkPV+UQtRkYbHAtVc3mieuguqORhZmP33obXxziiE3hUOUk014tGZ4LUW/Py9RhiSC
         s1QLNG1DLB2b956AHPNYlcTJpVbKo9EODsTL9CxYDNFivKzZWG/2utpGJ2vQd/EvEJZT
         h0YIlKFoHRTGGaEQbdGoWwtB5usGIN1PHNHMvZYU8XW63/KLD95pWA5q44DFStDE2X9C
         GjxglQzmK0O7f4NgxfEwKzEjT3ua0jixg7KxKXuQ+8xgv8g0+piqBCsPyuTLlPN6KhTt
         xq/S0PLy7UOYBbSuaq7hzLZc1qHA4iQvbuHIxor/LVTo5O6Vpg1CSfQBEwkUJo61X9p/
         KMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783907994; x=1784512794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6ZY0A81ZwFH7zPrXD3IEMLtteDysZZzXtDeInBjqMg=;
        b=LJmobruTjvt/NfB8upARpXsRqq1S/Ybm8mOTwfMUs1687Bgd5J4GmYvSv4kpgLu9EZ
         bIy9kSOZME5vWrVoqXky4N2v76ZyxyDoj99OhBmdl5yrJOgmQOX44gmg+o5qxlYmiOnJ
         QuWQaydXRSrfHSX2F4lDvF8sUD05VWEof7FZRGTdPYydeDMEnRiDMvVsQ4DkthQtNlr1
         Q6d8BW9s14Rv4ySbuucNO9XB3PK6yeg8uJGXm/qs3inncmcVSsHGHOzyDJKyRMyjIBFk
         PpzNprzWCRBv2BrdkRBbgtyl43hRAkxz4GTpMlFw8+F2XMvFAriTjiG/oomDX2V8SSd6
         4QsA==
X-Gm-Message-State: AOJu0Ywois/LKJUjRtwL/TbcptPAc1YwCpV4GH1KVhinlK10jAYo2dBQ
	7uao+DCCkpY16RmoaUy5nyjbYOy9OnnZmjTh4SUWzcsPi/0jzHRLEP9e9oTAfg==
X-Gm-Gg: AfdE7cneYucE3+aG3u1UerpTQgAoPnrVHMXpJhVuNaIKxy/PU7ug0cJZrXXLbjvM0PK
	Dxsw/VHhUWpSyIQiu0GIRQYMO4jm4ECeRRIOP/7+ydvFShZ5lnCKSavmZJ3YolfOYc/Gt5jtQqS
	TH0t50klAbHc8UwyUGl+19oWtDvgVjwTYuOK9vKAsqbVSAk21tTJo8yXsvm+m8bc0FepWhOsVqf
	1nyV/G7ha2+jcMSCFwi+rosY5jIxJwTie5DwcT5OGbGQ1bjcA/RChCsOjX51bOZvpd0GAJ3MCZf
	Boqt4nj64FxI/arAJ5Nb2dNZiCgLgTCgPfyq5dfXYKyVWfD8nUbwAu/gsL3YHg8tI2VjA96MgC8
	Sid5bXgwEZetr+b5yE3JSGsCgfHtOUqP+KZuGMiNWT7vWXDaF9dLY7GV1O+rracvfQBf8UnSuUQ
	9FDJ9MGoMoq8YvvyQeggi11g+wraUOCoI2KdyUo4iSvPRMj4LYmMuT1ZYVFvCQhuKSY7mQNyhY5
	BMh1co=
X-Received: by 2002:a17:90b:5883:b0:37f:9cdf:f0af with SMTP id 98e67ed59e1d1-38dc780f6c9mr6851162a91.30.1783907993608;
        Sun, 12 Jul 2026 18:59:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:6251:ecfe:10d4:faf8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm68369573eec.27.2026.07.12.18.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:59:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+b6ce23950fd636e6efb6@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: don't encrypt pre-auth (ETH_P_PREAUTH) frames
Date: Mon, 13 Jul 2026 07:29:46 +0530
Message-ID: <20260713015946.44636-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38924-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kartikey406@gmail.com,m:syzbot+b6ce23950fd636e6efb6@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,b6ce23950fd636e6efb6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B6C2746852

Pre-authentication frames (ETH_P_PREAUTH, 0x88C7) are sent before
the authentication handshake completes with the target AP, so no
encryption key exists for them yet. Unlike normal EAPOL frames
(ETH_P_8021X, 0x888E) which are registered as the control port
protocol, pre-auth frames are not recognized as control port frames,
causing the kernel to incorrectly assign the current AP's key and
attempt encryption, resulting in a WARN_ON in ieee80211_encrypt_tx_skb
when the cipher is not handled.

Fix this by setting IEEE80211_TX_INTFL_DONT_ENCRYPT for pre-auth
frames in ieee80211_tx_h_check_control_port_protocol(), so that
key selection skips them and they are sent unencrypted as intended.

Reported-by: syzbot+b6ce23950fd636e6efb6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b6ce23950fd636e6efb6
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c13b209fad47..b3acfd69380f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -557,6 +557,9 @@ ieee80211_tx_h_check_control_port_protocol(struct ieee80211_tx_data *tx)
 		info->flags |= IEEE80211_TX_CTL_USE_MINRATE;
 	}
 
+	if (tx->skb->protocol == htons(ETH_P_PREAUTH))
+		info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+
 	return TX_CONTINUE;
 }
 
-- 
2.43.0


