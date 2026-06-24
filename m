Return-Path: <linux-wireless+bounces-38043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3gGCxpsO2rHXggAu9opvQ
	(envelope-from <linux-wireless+bounces-38043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 07:33:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B166BB8C0
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 07:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UlTGWQWy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38043-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38043-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 862763012771
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FCB31D381;
	Wed, 24 Jun 2026 05:33:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D02EB5CD
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 05:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279183; cv=none; b=FuoBJC7/K0YnpAKsIPm9TuLJBZa3xtWJx4y3QiNiSxJarRJpoXPNm8717b48HYlUipPpPuFCwTRg3h4Velhh9ZWHzTDQHzw/out697dlz0loQHHVYsU5ijLEXDBBfAtH865L1En9WOwG8SV6Q+MObputjJC30e4SiPB9CNVRxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279183; c=relaxed/simple;
	bh=nrtaw2ep0DCwDiNk68McCNWo/BLbRmzKgeIJm3iLoCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyKIQJpK3aCz+ukB5+qF7qmR/wlCcZ5CIoPOCmc38kJ7R3Q1q66JEIU4AW5uqDkYLuG5Bfphq9ferL46hb3b5eMGMVUrd6XL2DqIcqlSiLnAu6vEFxuP5nIjGcHTT0qlJ/rIluKlB/ALegqBu3WbTPQcoMZgt6AtQxZnfvBGFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlTGWQWy; arc=none smtp.client-ip=74.125.82.182
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c6836fea9so402885eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782279180; x=1782883980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOavHhXXwzowPYsq4xGyB1KuD7Tfjz+llQKByGEFJQo=;
        b=UlTGWQWyJ+Acfv62bVw9aW+LlqLaie01vPFPQsvO1ruK45g/w+V3eVj8RmtX14mVMo
         k8FqaviXfHY2KuooVq6c9HlF3uz8eYpIVxKZAdo4QfGy4kPFZf4EVQ/6aOELa1gHzluf
         WYfGTW5qpfkW4Q/uArdUNmhQUn4+hPPgpCM+eemP6UFKnKWJdDHnALmffiIc1HujF28b
         EtSKKK24GHHEa6lnYi5amLy6KHmJ5ltM8pPJaBbrw/0/f6PXWJXSNdNA8VrsL09YthRA
         gzXsP2tL1pp5nmZCTnwS5nngZ2zvQf074hWNK/3PNEMnzK4FaneNfDyumnpwNkB1icaW
         WqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782279180; x=1782883980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOavHhXXwzowPYsq4xGyB1KuD7Tfjz+llQKByGEFJQo=;
        b=UpPSN5VF4WkUxaIKJNO4pRAerGhMskZ5AuX08k2PiefGOApehuboV0vTBdG+JqyXFv
         /qX+rjtV78n+VXEcfJmBPcpT42bvmTUrIc0iccqe2m9aQg5Xs9CX8m2uwP+nf0dAQkCw
         UQuTIcWeKesdo1qOIpJ3wnfyxNUk26NZd4bBQFlRCdp0/7vH5YVlpn4RnNlbFP6FRwet
         OigWNzsS3gt1Vrw/Z9/6GSe/ZfDhzT3/KrXJ+SHBMfILN4doeHfPiVs4jAKmcKgTHHI+
         RMj9CloTRGcUnvMIpYGJaDbnKjKnmop9ohBGPY9bR0if9VNubLXAjJXpZNZJ4TrnUL7b
         moKA==
X-Gm-Message-State: AOJu0YxW4EcPa2zYjQbsBFXolsliMVV/WfJ+z9ap22FkhQIY0gtSGIdn
	P7xqiijCtVkNWaO4CW63tGDNtJDKfoAKYo48hhzehrUWdWpz0pLnUQqV
X-Gm-Gg: AfdE7cmBb3vEr4UrcXbsXUz/tnsUj+F+KrWE/OcOUfeF00XDOZYsv8b1tWHNc+vjWXu
	eRGa3bxvlf5uXU8vTrDNoVWRAdNFLhwlEIgYdtQBqqjab9Onr1dKFs3Rq+k62aKCiv/p5Oa8WJA
	JK9yaUBFKrWw6mOSEI90Q6siN6UT4eIrRWMROQdGozGANC7iwq2QmK63cRhLv09t+qu0X4geX7z
	62F/4G0S+XV+x5ZXjphKuPPY4ydLo5/OIhMjo63ej3Pvnmm5EcI8UFL9yzi7m7WljVgI1ga6GSq
	NSTspJenN9YQ4tC3nZ1Iq0ptzKPBScEz9aNcclkIx+7zcWAxiQs5sesNJ2T+MxYKkvBq2ewGlJB
	FeiUg88xYJHllnlXJFRzA/XLHMCEoPSa/AK9ERJWziyoXobsKHfOVLkF0X3kC/FGVxEoJQWWX8z
	HvM3oNEBKq2BcNi7GJr+Zei3iNjifWKhSzkt/ffp69
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id 5a478bee46e88-30c5553657amr6680575eec.6.1782279180167;
        Tue, 23 Jun 2026 22:33:00 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c32csm22955775eec.6.2026.06.23.22.32.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 22:32:59 -0700 (PDT)
From: hewei-gikaku <skyexpoc@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Subject: [PATCH] wifi: carl9170: bail out on invalid command response to fix stack-out-of-bounds write
Date: Wed, 24 Jun 2026 14:32:45 +0900
Message-ID: <20260624053246.74617-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skyexpoc@gmail.com,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:chunkeey@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38043-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23B166BB8C0

From: HE WEI (ギカク) <skyexpoc@gmail.com>

carl9170_cmd_callback() copies a command response coming from the USB
device into ar->readbuf using the device-reported length:

	memcpy(ar->readbuf, buffer + 4, len - 4);

ar->readbuf points at the buffer supplied by the caller of
carl9170_exec_cmd(), which is frequently an on-stack buffer sized to the
expected response length (ar->readlen).

The preceding sanity check only emits a warning and schedules a restart
when ar->readlen != len - 4; it does not stop processing, so the
memcpy() still runs with the attacker-controlled length.  A malicious or
malfunctioning AR9170 USB device can therefore answer a pending command
with an over-sized response and overflow ar->readbuf, as reported by
syzbot:

  BUG: KASAN: stack-out-of-bounds Write in carl9170_handle_command_response

The comment in that branch already documents the intended behaviour
("Do not complete.  The command times out, and we get a stack trace from
there."), but the return statement was missing.  Return after
carl9170_restart() so an over-/under-sized response is neither copied
into ar->readbuf nor completed; carl9170_exec_cmd() then times out and
clears readbuf in its error path.

Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
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
2.43.0

