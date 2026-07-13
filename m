Return-Path: <linux-wireless+bounces-38999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id osYqKW5gVWqKngAAu9opvQ
	(envelope-from <linux-wireless+bounces-38999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 00:02:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5574F682
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 00:02:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BG+8GeF1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38999-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38999-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD23C303661A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867438237F;
	Mon, 13 Jul 2026 22:00:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C473624BC
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 22:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980043; cv=none; b=WF2/XJdvHQoYUqE4qBU/jB7HhMmT9NTpDB0t/4ha8KKvVryEuSYLKcj6ZcZPQyTK45DxiuMxfZI3KrXhLBTBnGk/Yo7wwYIQEPntLcUuZCUz/kkCWkx+rw0XRprdYrn89xUpBUU3akTCQ8b9T/8A7w+0za5lWyLmk/oei2CwuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980043; c=relaxed/simple;
	bh=IH0jw9NkR5pWlG+/9Od4/E/NM9li019E69ZGFN2PFAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tC49XmBnNV92omXOp86p3TKvirHYTnDUi4HjkR98HJS7uHplgB1gMyjGc3uizz/YZCx24UUOv7Y47CXeLzpYCZlAYuOuV9biEpWSwjlpZwwI3QFXPtIjt1MjRq+wLzNU5582k078MA4GWx6N8hwMiTVZCWX21lqrbHtRnvfBeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG+8GeF1; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e65e18969so29338985a.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980041; x=1784584841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkyIPjZMOattJthn3NIAY55tIPZC1UHX2o3TSoUHUg8=;
        b=BG+8GeF1WElHSG1+8ub/MDo86UZzKOnTqly38MMoNddayYUopbqLiy9WJ1LTBleZ/F
         Cn1zrXroz6kAewFATHRNApNcrVDJkm4sZHwE4U5DC2EWhWI3sVhOu/NpJjugHz24Ebwy
         2zQ/CO0ksCC6afJ0ueMQymPnBYkhiui4nys2psBhC9BUgHjB2GWjQTBMRLTb/goTs6Zr
         JpiJefpS4YmHJJpRN6tmcF9xehNkMsWhT3h5C25K36pxhB0z53xO8l/pgDNvk6PZ1bwO
         DRg97v3Mx4nC1LVRcbo52SIVi9AGw0q632a77VI0hW5OL2zwmtESgiHcKQ1CxrHn5SKq
         U0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980041; x=1784584841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkyIPjZMOattJthn3NIAY55tIPZC1UHX2o3TSoUHUg8=;
        b=PGOn2CJhRJAFvjiqhp0nhrBcCtjpMDbHaN2Q8+sMZw3gpFoTpX6msLw5Y47QNnk75B
         82bBdbSbMiPvKsUy8g+LxeIrdz8IuZryBqoBAQUzWu/Wga/qbVlg2JvpI77oS5i6tqEt
         cKHd9rYohJEgyj1+IA1FQ1HWG2M2D8IAkEzGThf7YSNB+kWXyIJmghxkITH57PIkemPw
         Mn98I/E/tDPCsRGT7171MmB9YgMZDE2cgNdyDVOMqWo9DNj7GcY5hvX8J2IGgwM4CDq+
         2b7b6ybaxurzr4L6HoSl8M3Op+kuwgrn8STyNFSSgH0mBOC0N4whnjsDi7+CYJ45reyZ
         Gvkg==
X-Gm-Message-State: AOJu0Yy/yvDOWzbFPs8NxJQth3lJkd+1jdQQTCmtxfPWRRnExHTsC9LQ
	dz+pQVAuWhQPluYCM1wTzSlMPGWCN2kxmqw/78eaSsNuasgxDemhwJFr
X-Gm-Gg: AfdE7cnu6AhEcAo8L3ThPLeDzUsxwYs/Z0GmwtP7F9AMzmxUvw5xMDcNmv+VwqglDe9
	mMzcjW/Xx5fL0cIfz45v7vVKjQnvmqwNCm9yd1WN4sGwxYtJO8ZPW4xIjDYLdb6mtADD2HHCTwB
	c/3d7D2UIjHdcOJ8ejdzhOVVVzSYaaaeu6w5mA6eAtDm2MekVHHeb2hdOUN5nlQ7j1C3/+F8/AR
	l8VQ6FGcZoly4uj/tB0R5vMBNanDFAEtaDOd92kdspuK0yDKZ7PpcMMzIAqH96LwyGzwYOqs8uV
	xprGbaW3KCeTDWT1oEPwIABUZlesMUJD7lAZWY8Y9+Kj6DM0zJx2O4KV57QafOnKpa+Rba8t8CI
	a1T4nP33zoY089BzyQwq8ptJBRiXFIj9hi7r4nqyDzARSd3aHL1mvtXypXAN5mOuZQmNA8Q130S
	krYJJoq/b1KISpehOnqtbMxh/JxESLdfXbj0TLI7W3//8TcZx3YBQTqGhYod5h4OHkPGJUdaUlL
	Ev9rSs=
X-Received: by 2002:a05:620a:4394:b0:918:7e9e:de74 with SMTP id af79cd13be357-92ee4bb5a82mr1613393385a.17.1783980040749;
        Mon, 13 Jul 2026 15:00:40 -0700 (PDT)
Received: from KernDev (pool-72-83-148-136.washdc.fios.verizon.net. [72.83.148.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm141169046d6.13.2026.07.13.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:00:40 -0700 (PDT)
From: Alexander Bendezu <alexanderbendezu10@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Alexander Bendezu <alexanderbendezu10@gmail.com>,
	syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Subject: [PATCH] carl9170: fix out-of-bounds write on bad command response
Date: Mon, 13 Jul 2026 22:00:37 +0000
Message-ID: <20260713220037.109649-1-alexanderbendezu10@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-38999-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER(0.00)[alexanderbendezu10@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:alexanderbendezu10@gmail.com,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:chunkeey@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderbendezu10@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEB5574F682

carl9170_cmd_callback() checks if the response length matches what
was expected (ar->readlen). If it doesn't match, it warns and calls
carl9170_restart(), but the code below still runs anyway and copies
the response into ar->readbuf using the actual (wrong) length.

ar->readbuf is only sized for the expected length, so a bad response
larger than expected overflows it. This showed up as a KASAN
stack-out-of-bounds write, found by syzbot with a fuzzed USB device
sending a 60-byte response when 0 bytes were expected.

Move the memcpy() and complete() into an else branch so they only
run when the length actually matches, instead of falling through
after the mismatch is already detected.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Signed-off-by: Alexander Bendezu <alexanderbendezu10@gmail.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430130f4..3460b0ca0360 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -145,17 +145,17 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 		 * and we get a stack trace from there.
 		 */
 		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
-	}
-
-	spin_lock(&ar->cmd_lock);
-	if (ar->readbuf) {
-		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+	} else {
+		spin_lock(&ar->cmd_lock);
+		if (ar->readbuf) {
+			if (len >= 4)
+				memcpy(ar->readbuf, buffer + 4, len - 4);
 
-		ar->readbuf = NULL;
+			ar->readbuf = NULL;
+		}
+		complete(&ar->cmd_wait);
+		spin_unlock(&ar->cmd_lock);
 	}
-	complete(&ar->cmd_wait);
-	spin_unlock(&ar->cmd_lock);
 }
 
 void carl9170_handle_command_response(struct ar9170 *ar, void *buf, u32 len)
-- 
2.53.0


