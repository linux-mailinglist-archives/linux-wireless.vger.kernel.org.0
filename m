Return-Path: <linux-wireless+bounces-38725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nh9FM9qdTGqCnAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 08:34:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A2371801D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 08:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ltZWnhA3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38725-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38725-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B130C3066C77
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A42F12A5;
	Tue,  7 Jul 2026 06:32:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265113A6EED
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 06:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405921; cv=none; b=jwxxzztcnrFZqe0owOWmYva13rU5Nw8BesSAbOlgp5B/x5b1Khx4TglGPbxEpRWEdmLshshWYfC0yEWZHkiHhijuzOOYzbjoFU7MLWRBcx9SWgRqk4nRu7bRnz0j+Tpspmzk06tO3Od72HHOxOxs5Yizfl1p/3qwBVGCCj9csRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405921; c=relaxed/simple;
	bh=gw6xFYJYCAR7r3OMW1mlW9CNynfkcU5mRcTEYY+hBLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KeY02me57Hyc2NnFqVOCsr29xEKyBz/kaA7ACczZmcZj4/t8RpdGApn9aX5GtG0GaIDkOnErWdpoOQ3Ibpac3PeyCxFi3LKdud4qkr5FVywgbrxXAKV90h8fmK/NO1tu+6ETl3mzeST0hJZkiQkyG3IReC/JWFI2md33AEjlwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltZWnhA3; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so28399385ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783405919; x=1784010719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfgU9SSdH7/Owo5T8p2cLZ2UNiUdFJqsqDkLIOmhzsg=;
        b=ltZWnhA3r0lrUCUrYhkk1b9wVa+b6pCBBbgoFxHst829bcCYJB5DwCze3bHEoDOdFx
         qMQP47wJHEgggMy21mAv8VsaweqxfmeEW8hteTn/9oW4tnRQ4o621JJJ/8Bs3HY9O7vf
         hMRvvIA31fwBHYjyu5GCFHPy4RP+vAAtQ3e2eq0ca8wYsv3Rhwu4qy7m17gqoOfW/f4s
         bQsqvcHi90I0z69rgpwdmMOw/fTRUbW5f7RDi8HHyykX9xV8flNBEWPdvt/o/cBYkgXP
         aZA4sVjoCM3Hv6S/Pjf8DKtTrpjU3DCS2tQuFTAW5EnQI4oFhFfDKH9D/ynzoECJNw2y
         UIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783405919; x=1784010719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfgU9SSdH7/Owo5T8p2cLZ2UNiUdFJqsqDkLIOmhzsg=;
        b=cdFHsQ7+p5tdGTJCbYjT2qxn3Mg3Xwaz99+K9jfsofqMFpb/s2vX/6xifXU47kxOJx
         0jwaxm9iX+spYoDLFalAQzbEUI2pc3MkyZzsHeHi3mL+KxcQLkT4+PR53xqFoTQq/0oc
         gDjXdjV7IKg7/RL4bsJStJIrTI99o0OqnDysB9Qk5Uuvey335sklPabkya6qQ/C69fzP
         2Mp91Zw9BzMqRCoFXyE4S3sKh63XvLT63FHM6V8bopa+OgOLOGVJT6a16/pW8oTW5U9s
         6ke3Sjbwmm5+Xsn+bCc5LlKTpZkbrUukNtDZTuy5n9b+l7Hl78LkU5Ur+jPvC/AY3MtV
         hiMg==
X-Gm-Message-State: AOJu0YwZpgXmq/jvV8lM4BsQ9XmOj5NvgHWK5bOlPyYIc1kSaC9GJkMa
	3i503Ai/v4HgnWrtDJxXc7cawW2TOGejEGjU7K4WEj5+tgFLu8TmwVKS
X-Gm-Gg: AfdE7clhjpjmijnMnmwxrBDyxLmuyiOW+irmEPFBQIJ9f45ZqAJe5kel0g3NdwO13xc
	XSUq1N5cDjnaR6FtwLi8dEnwDWCKtX5OKfDnWAtgolW5mkpCew/wC75YtZah2ZuoAGrrAneiBdl
	1fVP0HEb/UP8vAv5oNjJqLfo2J7OHkiKaUuE385yUV1LsXjVuu1LQYc4T7b+GzNwkJ7n3lY0cdO
	v1oby8g+HvouMEDs8VfGtDHB4YmJur1RsSvuAXNmcxk+Xq27c+0cK/99JdmLQBOT58OjIOl5pDI
	3rytceOyjWr20jDGaX6CtXGrvMOBpxmR9xhBdqEQmI1m8cQXYeOLUDIODfuQGJ9iFSaeaSoaHoR
	gILqr+uIqpYZqhzbR6fBAK+NehFoZJmOSsyEGtUmTugcIj6zJq/ZMO3J65a3fRl5hj+DkaGv2s1
	4JyAqBQRvffrO0dooy+s1PqPyDk2D7JzaL/YeizVO3InhlMXIH
X-Received: by 2002:a17:902:ea12:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2ccbe7244b4mr39876205ad.19.1783405919194;
        Mon, 06 Jul 2026 23:31:59 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d60da9sm5820435ad.84.2026.07.06.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:31:58 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
Date: Tue,  7 Jul 2026 14:31:55 +0800
Message-Id: <20260707063155.3099999-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38725-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99A2371801D

brcmf_notify_auth_frame_rx() takes the frame length from the firmware
event and copies the frame body with the management header offset
subtracted:

	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
	...
	memcpy(&mgmt_frame->u, frame,
	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));

The only length check is e->datalen >= sizeof(*rxframe), so mgmt_frame_len
can be anything from 0 up. offsetof(struct ieee80211_mgmt, u) is 24. When
mgmt_frame_len is below that, the subtraction wraps as an unsigned value to
a huge length. The memcpy then runs far past the kzalloc'd buffer. A
malicious or malfunctioning AP can make the frame short during the
external SAE auth exchange, so this is a remotely triggered heap overflow.

Reject frames shorter than the management header offset before the copy.

Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
v2: drop the Link: tag (Arend), add Arend's Acked-by.

v1: https://lore.kernel.org/r/20260627131313.3878893-1-maoyixie.tju@gmail.com
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa7..873754be51 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -293,6 +293,12 @@ brcmf_notify_auth_frame_rx(struct brcmf_if *ifp,
 		return -EINVAL;
 	}
 
+	if (mgmt_frame_len < offsetof(struct ieee80211_mgmt, u)) {
+		bphy_err(drvr, "Event %s (%d) frame too small. Ignore\n",
+			 brcmf_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
 	wdev = &ifp->vif->wdev;
 	WARN_ON(!wdev);
 
-- 
2.34.1


