Return-Path: <linux-wireless+bounces-35258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iSWUO4Dh6mnJFAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 05:20:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C94596B7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 05:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA63301E59E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A331C567;
	Fri, 24 Apr 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMBmX7gA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D834314B6A
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000641; cv=none; b=NyQlVYvI1rzFDJpq6ykgsI7jr2cswzoALik/dsyvO2kwpxNiPQivIv0omWDrjTL06rRwfgNnwPb42IYO+BGA6K8kTi7mMS+YmaK9x1NOeu7Dd620FNRzsYZNjjrvhjL4XfOG/G3jI91zC8OX2smFTDu6P2Ul+6TrXOIXUrw3R7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000641; c=relaxed/simple;
	bh=rao5ehkoXjAssQgtOWx78WED4+hOJlnquumrKplprhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfJsIUkVdl+v8ovEsWCVqffBVSfwdI8xYLjiIIr96FyKwsD0vIXUsiSrWNTHXz5VHNvVWmQ0EXMectoA+lXqAZ3Nl3mXMGDFyaAiCmGShyCL92eDUs1VeYSIflNrXIdCICsrkd3Qihd05VTcjzXS0sy39MokDQux+gEtfqpE7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMBmX7gA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827270d50d4so6803214b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777000640; x=1777605440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClDsTq96IVcz0ozOKs1wh1TCvD1RtoLEc3MUwTedZrc=;
        b=tMBmX7gAP6jMvMT0/f1aU7fMmFni0dIBkzsorWXDK4ByYPP+DR6pD+G8gfoF3/cMwl
         vbpPaE9IzrTfTPBhqteG9OtM3C1jRQH8kqXNtwhv0Em94szLNzgXOOnGGfD3lMF3Pl3t
         xEZfUkS/ycgNNpm1CCJWUttRkqiYyl7BwPhArwcnTd2m8TNf9jyihV/amHqcdWGVSC+V
         5tEzQF9Fj+2PaPH0Pk1EwKsTVWva4Iwn9daDSeoSLQrbYrbNgwgA08LpMXlyF8cKFma1
         VlEJOSP+SNPTZq236lGd43yq8RazkCUXEVPkjQMNHOKaGjjp/TFBzLpE15n6IxTeyaJF
         lyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000640; x=1777605440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClDsTq96IVcz0ozOKs1wh1TCvD1RtoLEc3MUwTedZrc=;
        b=cnnh8Y1uN8QjB02H2OCfcUkYMRmajy3/jQqzLoiU+fPvVOoM8aU2f/JjeScTcJmjdZ
         t6S10hq3AJWfLddAVXmtQEq5ctGcnbJfawyStpBN4VxMCSqg/JN9vCAXZzeJuWSU5B1J
         Gf7DyIkkg5p7vNWelTDMFsjvWjjAQlp0wm+Lzn4o5mTsME04wEjek4jBMt1kvPdScBra
         sjkM4Ay8IJYc4AaKaR+p/iQY2ePxTCsQj+LRF1Xw5r2KPi3PetuIZ5+OJxkHYrn9FllE
         Tr2v4mO1KIQvR+ckeHW+Qe7VDRfMepFmOJ1vMRYCx4Dr1ukz0roG//c54ZTiEu6qDKZO
         /15Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4vzffdC9o5VTMb4Q2r96rfwr8v2HqTnk8lTYv+xqbwg/JHaTQN0jUYJvKaQMe61hUKBQuQXtHVxO4r/Z7JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8S9lBLqFhfuo3Zh+4vZm8ZryccwcvcNrHOU4a0z0mFyJ15na8
	WjVv+H6IOthclbMT0KY0m48m4NGFcgeMEmvZ6FQA44dyi8wSMt6y2zE4PKs5zg==
X-Gm-Gg: AeBDietfU/UvDOfpwuIvsoLh8w3Niy5cz5omhjzc41uqpjYwF5s63xyhVn2g9dYKVPH
	xEM5hX1AQmRkQmmhwFI5wMDBvI520yMf+VvD4A2YY4e4hClJuzv1jE1u13u5smFxc+AghCC+2r5
	HyozXG++scgVfYmF0PAr9ovv6b04gAVjQc1WKkZT9pyAl25MjTJ027kd0MPrx4lITAeo1b2ofuI
	lYWbZSRsqXcQlxwMHyYLILdCaVK9y1bM6lUHw8xTEAF9R1PGs17kEuR8WuhAJUSkdlcpQ0iayfo
	pvr751blU6nm8sb5Cjm2fr606dFg/7woOconnWIfDX6SPl7bjwqXx1ox+Uo5++2dB0SeIYodILT
	1BeE4eey1VAnNF7BSCYaxR8cYQApdt+MoW/laFA1O88/8E12Ngs8iWtkMy79tlbKXwKzwUx7W5I
	h6Uus5Icgg8M0Tl3qYw4iwN90XJPcL9CLfpCEdnLsM0pOaEfFmHHrwpWR4llQk7B8ve3dAzOvuV
	iM6uh6kNJkuaVZUIw==
X-Received: by 2002:a05:6a00:2ea8:b0:82f:807:ed7f with SMTP id d2e1a72fcca58-82f8c8c239cmr31637492b3a.24.1777000639926;
        Thu, 23 Apr 2026 20:17:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:180a:81e2:33e4:98ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec05391sm22666060b3a.56.2026.04.23.20.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:17:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: chunkeey@googlemail.com
Cc: linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Subject: [PATCH] wifi: carl9170: fix stack-out-of-bounds in carl9170_cmd_callback
Date: Fri, 24 Apr 2026 08:47:11 +0530
Message-ID: <20260424031711.53104-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 496C94596B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35258-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[tuxdriver.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

carl9170_cmd_callback() does not return after calling
carl9170_restart() when an invalid command response is detected.
This causes a fall-through into the memcpy block below, where
ar->readbuf is written with a device-controlled length (len - 4)
instead of the expected ar->readlen bytes.

A malicious or fuzzing USB device can send an oversized response
(e.g. 60 bytes) causing a stack-out-of-bounds write into ar->readbuf,
as detected by KASAN.

Fix this by adding a return after carl9170_restart() to match the
original intent stated in the comment ("Do not complete"). Also cap
the memcpy with min_t() as defense-in-depth to prevent overflow even
if the control flow changes in future.

The bug has been present since the initial driver submission in 2010.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430130f4..6a5923495a01 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -145,12 +145,14 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 		 * and we get a stack trace from there.
 		 */
 		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
+		return;
 	}
 
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(u32, len - 4, ar->readlen));
 
 		ar->readbuf = NULL;
 	}
-- 
2.43.0


