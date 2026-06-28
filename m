Return-Path: <linux-wireless+bounces-38213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWStFHBnQGqAfQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 02:14:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0B6D2DB6
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 02:14:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X4vgZsiH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38213-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38213-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 522603006934
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72931800;
	Sun, 28 Jun 2026 00:14:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9C1E4AF
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 00:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782605673; cv=none; b=DdQgJPYvS+R0nI+yHLtfPvaO46J5dp7tviT2KlBRs+aLnGPeVBguA2kXGd8/kPnB9npM2nq7Pd9u9nCDfMvBuiE0UBtljzLg53TyubNZVqoszsqeOWNGIxrbnnugvE7jbO/O/blKNGrgiWkRa62VNxh6YBmJRitROd2mPzjyRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782605673; c=relaxed/simple;
	bh=bn5D81Emdp3F9NQjebzQbfGPoc9F0nldGSqdoQJdmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUBpso0nFdjkZNGLq45+g89o7GKVUuev4LOFNniFZ8vFTB7+7GuMnIap3pbtjZoqi29H2y16ic8s+T7TR/Vo78aV5vYKgh9hpVLsBZU4ST7aDF6Jimw3eZywloiUG7NOhxOFYfO7yrMjS55X3CtqBoef9xtC+MnvmrEpiyFTK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4vgZsiH; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46ee68c3b7aso1732434f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782605670; x=1783210470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebH+lK9HrTDn4Rg3W7vRRjbwOoSeOQcKiaNHs9OnUKM=;
        b=X4vgZsiHSmrJ+Zl3m9iPFdkxObopOdzVRz4wiU2C9qyJNK7oyhZw2YP5jUWlIX4daa
         reECGgG2pG0DAb8NtJFQG8+mLLxu7BgUg3MKj0hhj5T0rQfmYlswIij+9QA6nqcZ4sSs
         q2r4vfydOAxNAiqQMT0h8QAN/0RUck5LZzbpexLsw0/hd/08xp2G2+YLTF0kmbm26Vp9
         saV4GRu84aMsFoah03+/3gfr8ZN40h+z27o31qh+53UdE2H+5DvTdccYNteEd9D9cVu6
         nmiJEAT6WPOf31reQOGekA0at/mwY9KZBCXTfuwQvClzWgwMZJeisfKeckzPeVUlo7ts
         3N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605670; x=1783210470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebH+lK9HrTDn4Rg3W7vRRjbwOoSeOQcKiaNHs9OnUKM=;
        b=LgiKAFVgtDvdOw2cRxrWUreq8xQ923m5+aLxrDKI9qQwqOfFWS/KBcovxKhVMTIZIP
         w9UTC3tK3AU8MuPGA6FRvqnrlGDMtyrxcuT/JhCvNj5NqhQ5CwThfPONFM+RE9b+WUEx
         iZkYMPAGoC9+n3/9GbkUOsRHiRsNKuKgi2eMZWgA+khiiAVpLfKV3C/ycix8k1Kb+GOu
         kEBQjtY7N4oGQceXpvKQcuQK/1o7kQVGW6y0T5wpAQmAPu7Yk1a8lNzNbJGflQmLFgYi
         pPEvoeQYXW+VdVZ+NNEb6zk+sXcivD0B0W701QUqTyppNd6o2Buy872MLAaOT1snTpI3
         dVIQ==
X-Gm-Message-State: AOJu0YxDgw7M7KYeuNM1fVE6Te+fd8la+lumXHJ3ImdSbOsNUOLd/53N
	iyGd/sgmsqrO2lSa9EpMlN+hVrkh0go/KFov0vAN0Xm8908LFhd0UiXd
X-Gm-Gg: AfdE7cmLZ7Kc5GNlZpFqxXCrBiKf3lw9luvyaE0xLtqYb5Xz+JY5G7godJ0HJeHuTN7
	ArXZkxQLaD53a6IpUMurCV7q3Aiue8S4Sb+SuzQwzSJN+HRI2gjKcNX0H21LVSDAicBrTHhgdp3
	xOYijw11XBXwot2Yq1JEDKfxsfKkIIaehPRneWyvdJO1gEn/m94Z30yZS1s4PlZ0z34e6FZtCks
	RHdPLSs5PBhw15xMSfaeGFDNnLzMU77HgTF5jRVjyzl+0LDTJVLzEpq0I17FDSl9wqYqGQFWlqO
	00LTUQnN/Q3vQiiow3xtQtZFt4WNO5/FIK4z+fZLZYf+3hMM5rq2hDV/artP1AQXpGQQYabGQbc
	uFAseA3IriFwiOcJshFrcaUwGNUhATR4VFXLJxoyq0tI6r+tGNkPoAk1uQkjwxYnvM8ZnweDIAu
	kpkaZqILOZOyB4pbaijXDMLTwWkw==
X-Received: by 2002:a05:600c:3b13:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492668ad60fmr185218005e9.31.1782605670319;
        Sat, 27 Jun 2026 17:14:30 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4939a8279f3sm53101525e9.10.2026.06.27.17.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:14:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: ath9k: avoid device access after async firmware request
Date: Sun, 28 Jun 2026 02:13:50 +0200
Message-ID: <20260628001350.20997-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38213-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,cb7ed9d85261445a0201];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49D0B6D2DB6

request_firmware_nowait() may invoke the callback before the requesting
context resumes. When a firmware lookup fails, the callback starts the
next fallback request. That nested request can exhaust the fallback list,
complete fw_done, and let disconnect free hif_dev before the parent request
returns.

The parent then dereferences hif_dev only to print a successful-request
message. Remove that post-request access so completion cannot leave an
older callback using the freed device state.

Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versions")
Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb7ed9d85261445a0201
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 515267f48d80..aaf924cb8860 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1222,9 +1222,6 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 		return ret;
 	}
 
-	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
-		 hif_dev->fw_name);
-
 	return ret;
 }
 
-- 
2.54.0


