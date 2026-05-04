Return-Path: <linux-wireless+bounces-35880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE27AJLz+Gke3gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:29:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1F4C33F2
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 251B8311AA3A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912C3EFD09;
	Mon,  4 May 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYa+07ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEA3E1D1D
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922098; cv=none; b=GD9wDmjBKmSsRIDUt8bQao0zeW7ryK+xj67hlP7wtLNcYc4mrZjCnNfAcaEDZaLq3ihFLxoWuSQxTSFSNIyqCxZsXMntOntE3EihSqf0tKSdMONjtp0CZJCeBv33BSJS5NlAmJxbr2jGfWwc3vjr1vaRSQveBuBW9Kz1LLzGQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922098; c=relaxed/simple;
	bh=8hz3nNbpDkgK7Ir5P2gvyuc2i6jQwzqDnKD15YME4FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFUPuPCjam0ySHCvtWPQ0E5cuctpHKujR94AadvE32vowil1VEplVFkLlWII3jCh2jzYGJn7mOC4n2ZvRomUcPGvUfXLTj5taEUwHmcn8Mj7gZabnmrNn4/hrBeHXQmPoN4ZhxDXIWc84+HDEu5rqcmGIZJ5lcLuoqrHkAT9XC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYa+07ex; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso46713765e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777922095; x=1778526895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4XWmoLuuce+y2fX+lK8lyMcj1Ej13XR6oe3HMUEPQw=;
        b=TYa+07exHjDIekJX6Y2Axl7tvmSst0hwqXHshUa2ovdqdpXfLPptfLQFcvN9mpZpaT
         gagoQ/bgXtuDHh8PDZRS3e+mTfvYF9xHlo+yqGLjMv2IBiQSwHdCDopxfRVfZxYwEujY
         6Bmga8n+O3E2R2sYJ7i1fMjGEUnrSE8lggZ89xtTh7bBb90A5cOb7LeNST+J4WpKJ/I6
         AQluAANoy47tiuqrMrZdz1ndyXkqmpt7co7X1NJzwExbbpzYO+V1FoCVixlJATQl1Tnp
         VoMbLEBlHSIFR08faAAOJ3JijGXq1oEi1noGGAR5X3pPbjAc51yeJmCg9Xb+L1N5vTay
         AXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922095; x=1778526895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4XWmoLuuce+y2fX+lK8lyMcj1Ej13XR6oe3HMUEPQw=;
        b=M5dmQzNrY3igHBBmbhvzPxp85D13Xhn7GBldA4Y5n4M4jigaA3i2TMvH5NRMyCSkMr
         zuzgwucIejEKAmo2BPXBcrtjB1ctmEMJre65GOo9IQ+L1zGk+1e7acZar9UdOhFD4Mr5
         KTiXau/ssTdWGsTV43LQGu7uFFANqf4L30RNJsEcRpZw2d/2BHtzM7RnbQksOQqdRuhP
         e6XNdp0ltQfxeuicRwr55fdWI9sqON6z/aE1hW8l/rostXP/kPzpDuuDhfI+e1gyeLw4
         jh51ga3R0opAzBN9Apc2IpKTsEofoJlWc41YylCJocW335pV5f8oKhtPOQ80758h4n4t
         0qPw==
X-Gm-Message-State: AOJu0YwbyH3Egp+r+xoNha73wd8EVikKYT0/8ZgzL3wpo911rY4SIHsJ
	B5NclRmDNtB8bDK2/Cm2BfIvci9Xgcoj3hy0RLAtkrtfs69FE5ejAMyh+pkq
X-Gm-Gg: AeBDietxV694zbxHE0ylfgKU01y5HndCaEycl5EjgEhnXfqZaqY7EYWA/jt2faaaqnW
	09DUbzGONNrOpcJHsyL0f5oNxheh5SOzjxP0VbtMuMYDY5GtOU1LAiIjw1dwUAJ6YhYDFJz9OI8
	CfOpdv+mjL+6ejaZa2467dQfLICJmO4fe44mTIOzmqVMho6u1bJCPSTJ7iTTNo+f7RtJPZZb7vP
	PEa4qHS0Z46yJ43b4SOBJXyZrV1IIdULkzZFBPhR5SVHX7G5GV0xqJZNTHXi/nHbcurARCLuLgd
	Us/mHf9TCMgqQJ5fmnHSrjvC1271fw8Y1ryEc67yG/O3BqiO05LWjC3S9gyJkc3xj6YOVjqEDHU
	9GAsgt+ExgiOeEe+jAvclxxPHNkOO6gRLDT+LAOo5qDiZuHzgzt3iPL34uh/0ycMIuzhNewTnH8
	/hmMvnNOXlVYfJHFNi
X-Received: by 2002:a05:600d:8496:20b0:48a:7605:751e with SMTP id 5b1f17b1804b1-48a9853c928mr119382975e9.4.1777922095300;
        Mon, 04 May 2026 12:14:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500d73510csm105445f8f.14.2026.05.04.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:14:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: error27@gmail.com,
	kuba@kernel.org,
	johannes.berg@intel.com,
	dcbw@redhat.com,
	linville@tuxdriver.com,
	lkp@intel.com
Subject: [PATCH v4 2/2] wifi: libertas: fix OOB read from firmware bssdescriptsize in scan response
Date: Mon,  4 May 2026 19:14:52 +0000
Message-ID: <20260504191452.3408257-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504191452.3408257-1-tristan@talencesecurity.com>
References: <20260504191452.3408257-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FB1F4C33F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35880-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,redhat.com,tuxdriver.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The firmware-controlled bssdescriptsize field in lbs_ret_scan() is used
to compute the TSF descriptor position without validation against the
response buffer size. An inflated value causes out-of-bounds reads from
the 2312-byte response buffer into adjacent struct lbs_private members.

Add a check using size_add() that bssdescriptsize plus the response
header size does not exceed the total response size, avoiding integer
wrapping on 32-bit platforms.

Fixes: ff9fc791940f ("libertas: first stab at cfg80211 support")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 41dee6e0ca9fa..8015adf37c4b0 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
 #include <linux/unaligned.h>
@@ -554,8 +555,8 @@ static int lbs_ret_scan(struct lbs_private *priv, unsigned long dummy,
 
 	bsssize = get_unaligned_le16(&scanresp->bssdescriptsize);
 
-	if (bsssize > le16_to_cpu(resp->size) -
-	    sizeof(struct cmd_ds_802_11_scan_rsp)) {
+	if (size_add(bsssize, sizeof(struct cmd_ds_802_11_scan_rsp)) >
+	    le16_to_cpu(resp->size)) {
 		lbs_deb_scan(
 			"scan response: bssdescriptsize %d exceeds response\n",
 			bsssize);
-- 
2.47.3


