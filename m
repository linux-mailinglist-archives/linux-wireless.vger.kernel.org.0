Return-Path: <linux-wireless+bounces-37930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nDOaB0jHNWoy4QYAu9opvQ
	(envelope-from <linux-wireless+bounces-37930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 00:48:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BB6A7EEF
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 00:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=TFXxjYGu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37930-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37930-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC934305093C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE336C5AC;
	Fri, 19 Jun 2026 22:48:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01761EF36E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 22:48:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909304; cv=none; b=Q4K62Uls2ZUoPN7Y2nfJ48GDycHHjliNqutQGFRhENaYly712sMkrtsbDAAHnykP5CJr8zRZEo4vQRQJypTNK2pOYwsWx/EkrES3GqD9aXAypWCUfwURuOYEd8G6/Y3OpUHRBjPRQcl9cSq88bZhrksZz3B3y2BHForkOE/O0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909304; c=relaxed/simple;
	bh=qYpawD4I0G9Kmk3fSFb5oesMzXolKyIvQ4eHDKMJQSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3OwH5CcmU00BKL/o+6CVFzrBY58xpnfWnEscJcGxglr4+NTmlOn2TZmZO9hBjC+TQb4fVSNbS9+7ofzMVMbNJPwpR7rNz7ktq/S+GHR7g0q0IYHZzsdPm9h6+nFkYN8uG8VWMc1+Be8vz1lrYOjg2l7dHC09PvcM3/RtdhhcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TFXxjYGu; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so19064965e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781909300; x=1782514100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TD0jGrdu/kEvTl5sP1bpS7d7xXxB9kQjpHSw8hNZbo=;
        b=TFXxjYGubIEHBIm++zhCBMRo7s8mNJo3UCeZiPv5NW8u77haU+nUUM/WKVAPVQHMO7
         AfPs6NT2NX5On2t3zh0Ilsck3bMg4HO66MhtaodVdmdY6nF26dVZvwR6OhokOA8HWB91
         3BG46W6MGfFDCEwCALnU59+W1NjGHBkyQomwcQlpt4SfVSysFYyyP4ZnowtehBC2jCun
         9URVFbJ3dh6cM6RSsUq2LK0X+n3qunY1Ath2jEMYAEriU23lqhSlPWNnObziy+LXx9AZ
         wIMjUABsjUEbVzIO6qSD/yIUnNpSqNj/T49gRdjXKywlWIIp1TePZg4yV/LR+RuNKvOT
         a2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781909300; x=1782514100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TD0jGrdu/kEvTl5sP1bpS7d7xXxB9kQjpHSw8hNZbo=;
        b=IhR1qblzN8UdvmjGPM2oLIJVwU4+ai0WeFsPvCu1mN54U/z/C1plVMjp6xJBcnsFcz
         l8ElC0MAXkP3SkiAgVhUko25hSrMLR3E36FoSz0jDPK2eAhJUVxOZiiC00+RAHhbAmPc
         mk1U+sTDSQSdawqH8IpFps1II8GDsF1G7ex9NFv4Ub0L5DMTGLIj7xDPPZeK4mosfWsP
         npnwOLhhGYIiM7+vCdJ2zPD+0SrJA2ccgwPxQqADmYAs8X8JV9uuoKRWSulOu0qZcuQP
         My1tiEHv4OeNf6y/JxNmVFB3bjFSyG3AYaZqEALVaaEjCWoENFvcPJc1XeqpCdls+kEY
         6TDg==
X-Gm-Message-State: AOJu0Yzp3vCvUdWavMQN7l+CAJtO3x+DILb/bYN0jeEqYhUCeXzw/Grm
	zxdDvG4eBK7dR8KHMXrx08gYJDF92Rt4+I+GRbqxzuZ82lYq5glzalLnHlvx1Bu5LtD1
X-Gm-Gg: AfdE7ckTf1pVl6pvKebWXNB+imTVHNP8nm/Qzo7ZgEYPjzP7to/5lyVPvFnGSzhVt8/
	rTuG/ksUy+XmiB6NyIYbG/JMkJuHPhhvUzj/DcgEr+AXPJ1EHGg1hDJscuSzONOl+rHPZDbrXFC
	G+iKVK5ryF5YvBPNUsOB8aUh7QoFvV8vRBavo8w+uSILQZvHLLI2ejfKHDsrXyKYmTXYpE/6S1U
	diRi4SGiGqKKE6cD/HE1ebS621wLmJvBdSq8ZYJCunOaH/dkigxYbYaqrxNNZZY+hCrzLOff+Tu
	7UaHoDNw03y7xcSTrughaAwZOHtJD/oQREVF+da3wR4v3ItgQVa/wnLuvVDgA9HTSxMLYgX2N2Q
	qdtytG1l85zfkGJHsGVEHAfL7+9uLbK9dPR4qJj4QDwoUSCzii3y2AmcZSuiW+TUaYiUZmUXaJU
	yBzGogyyGJOkE7urgMI2QJiLxnnev5/8n5BVLv0QuAiYgnGyH2sh0TYcbIct2HzQPzT1sqCcae6
	q7SS00wbfclurdHcCuAUGLlL7kNtOvOEMr11wFg/7z25Q==
X-Received: by 2002:a05:600c:628f:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-4923f56c067mr93697755e9.23.1781909300210;
        Fri, 19 Jun 2026 15:48:20 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd33dafsm113045555e9.8.2026.06.19.15.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 15:48:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Christian Lamparter <chunkeey@googlemail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: carl9170: clamp command response copy to the read buffer size
Date: Sat, 20 Jun 2026 00:48:18 +0200
Message-ID: <20260619224818.90751-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37930-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:chunkeey@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com,sipsolutions.net,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 995BB6A7EEF

carl9170_cmd_callback() copies len - 4 bytes from the device command
response into ar->readbuf, which was allocated by the caller with
ar->readlen bytes. When the firmware/device returns a response whose
payload is larger than the requested ar->readlen, the mismatch is only
logged (and the device is restarted via carl9170_restart()); the code
then still performs the full-length memcpy(), writing past the end of
ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
(malicious/compromised) carl9170 USB device.

Clamp the copy to ar->readlen so an over-sized response can never write
past the caller's buffer. A response that fails the length check is
already discarded by the restart, so copying only the buffer-sized
prefix changes nothing for the valid path.

Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
Verified with syzbot via "#syz test" against the public C reproducer
(Tested-by above); I do not have carl9170 hardware locally.

 drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 908c4c8..897e682 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(unsigned int, len - 4, ar->readlen));
 
 		ar->readbuf = NULL;
 	}
-- 
2.43.0


