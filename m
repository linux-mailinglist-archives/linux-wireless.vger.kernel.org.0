Return-Path: <linux-wireless+bounces-38219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id azo6AGTpQGq4jAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:29:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC366D3791
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="IigX29/Y";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38219-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38219-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF12D30125DE
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3073101A2;
	Sun, 28 Jun 2026 09:29:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2706285CB4
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 09:29:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782638942; cv=none; b=OF+U5mkRW4+AVoUVTDIILymkYmELOokCkRbf8Ipkf2EqyEChAnmiRbB4vGsOJQh8U3vPGG5AuV/Es+UK4E7uayE3UuerIsxBhxLpUvNtMaFLibUnGKi1Gh8J1OM3HbvH8qC0ZRh3800iL75kXDog51Tx7CduJZc7mRgND85th5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782638942; c=relaxed/simple;
	bh=g3TEEhSCxa22KRzyGSBbXztaApgxMd71thbKhrfdhH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbSEjFaMLLS216giOhtBA3P9pJT3rJd+z7GpUEp7C7KZLwEG5wiaYyzy2TtJyQ4AUYfv75TEmZ3MIFmCQ4eq1ToRm7gMr+Y0roW39n3C76GQGeDFox4nBEAzJJG6w1GlZUOkaBicjreCn8cbLOCxPHCKldMXsVXutCUVzsVUuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IigX29/Y; arc=none smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664ae993e4bso1980042d50.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782638940; x=1783243740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBRPtbJqkKNZ5K9wV4Mq8UH+00E10dqVKsU9yLUE8eI=;
        b=IigX29/YhnMkZOB9DNFpOEP0mWnZySasxJ1I3piH05xD0NsO5NC/+45L32c8AFjunH
         jnHWLM196wfYxIsgIFb8UhHd3i8+VQtCPWaC1YKyNzY/hWFv7LovwbeFYaysUeymVgw+
         k48geaKAcF36YyRQANprM9Y7VNzehIi44b9eg0S41agWfp//yHUGZoiJGPo50H/OCvdT
         V9FBLRBE1isbJ4/XaNoL4qdhATBNB2K7bJvdaY9P3ATKj6b7UwVfdECDeB8eGiYVKvNn
         Vtg3zZzM7FHjEMntBzBVjJ3wrmQJDfwlZ9gLU9ISbpAEIQsjxwqobXvLcjcxYBsWEist
         ZCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782638940; x=1783243740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBRPtbJqkKNZ5K9wV4Mq8UH+00E10dqVKsU9yLUE8eI=;
        b=pIUs2ee8TQ3/hBXeYO2QIaYStRZZC9rOVOzeLoD1NHtpGhkezoM5KcVzA4JXRkyxmk
         ynp2WUlVJtGo+QlvKFqNqvtLgxVIojEGEOq4WjqgAX+bqabrc6N47qQGbVTF53KvebNg
         GdXhGOn75OuFmDeJ06905uH4FhFeROJJ9/S/JcrmUSk7QRpAhJQQrNanjujJwEvjE6if
         doTiBDSLaTqOYEOUElT39OEpT0Il2o6aYTA3PTS+VsqxF6FXaFBPzOMOXUFpZGJXmh9K
         ZIyQSQ0K2aWQd7qf7vj534YycYLyLWsUJD0k/bdQvJP+R30CRhZkB4kYoT41zAC24yvZ
         cm8g==
X-Gm-Message-State: AOJu0Yy0W0u1pEmmhT4AMrxsupK7WSk3jFYkZRnHo/leK77Uoh0si2DQ
	hkv5zeFMqttRve/SH3FC6AzR6wlttTKC8S/ZZzhO00Jv4SNWX+ajQOx+43G2k1/SuUVgMA==
X-Gm-Gg: AfdE7ckgOeDdvGBMouJG9D7/SVBWPw0XhRyEf5F0ACDkPnsAku06WOJvMTo2THjCwMD
	bWCOllvXwhPRXgyQof+V5ZyTObiDiyf4AS+52L5Nw2/rlmQLHFVBirOsmekwqWS8NsFBh3/ygb+
	ADUZ16CSH0vUdYy0EGvet5OtzuLHYb10ka5OvntO8qujWXDSVMGeCQHDqXJhDLwTY8utvW8hAcN
	808tPC5MO+xMQmUKH+e/71LhT+FZ/zaP/X87BQZhjcAe5KKqvujct7QcAWLbu3e8o94R9c2MSx5
	FL2WAUn3j1hhJ5BbzWdHyzQI0mVf+mbdEHqRUlHrpN98ggtLEc7WSgTRvavBGpVRrDGyIXyuLFK
	Qh/1slpcaopRssCP7GGh2xrH3S9JxQEiN6MSSBw2cRO7+m89YUTUc0Q3grSRS+koPaVSVuEKVS8
	qaUuffUg5YLJspBiUBno2E9oZ8hw==
X-Received: by 2002:a05:690e:e89:b0:664:9ffb:e4c with SMTP id 956f58d0204a3-6649ffb1e1amr7317427d50.15.1782638940444;
        Sun, 28 Jun 2026 02:29:00 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-664b8d0842asm1882897d50.19.2026.06.28.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:28:59 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: carl9170: reject mismatched command response lengths
Date: Sun, 28 Jun 2026 11:28:14 +0200
Message-ID: <20260628092814.40583-1-alhouseenyousef@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-38219-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:chunkeey@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BC366D3791

The firmware response length is controlled by the USB device. Although
carl9170_cmd_callback() detects when it differs from the output buffer
length, the function falls through and copies the entire response into
that buffer. Callers commonly provide stack objects, so a malformed
response can overwrite the kernel stack.

Return after scheduling device recovery. This also preserves the stated
behavior of leaving the command incomplete so that its waiter times out
and clears the pending output buffer.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430130f4..ea3f435fb64c 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 		 * and we get a stack trace from there.
 		 */
 		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
+		return;
 	}
 
 	spin_lock(&ar->cmd_lock);
-- 
2.54.0


