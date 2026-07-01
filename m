Return-Path: <linux-wireless+bounces-38459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MoSuGNofRWq07QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:10:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F12746EE8A2
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:10:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QFnBNt1E;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38459-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38459-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60C9630298A0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BBF258CE5;
	Wed,  1 Jul 2026 14:02:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA125B0B3
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 14:02:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914560; cv=none; b=bmYO86Az9SNm7fPsZTNohwkmel6YNI4C/HF0loTe9yDX3c0XOAu+JXNDU7oCkKaOAcZUDWd/6jmt9WZxiswB+tycpgTvssPB0S+vYQ1BnP43DOTBHF1rzkDK2Dgerym++a1LAcKLmftw+h2iB2imJtoSnnc6azbeum2RS9YzXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914560; c=relaxed/simple;
	bh=b87QwzvJSe0F2yHr23QZcSdKxJvHN4AUenNq2ATH7gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQZaCK7s9dKFOOo+7e1daWcXrXjFJmyOyGMvw7gMdN1e1jfaW4vcbGH/TDy0oGLmqLNcaTGT67sL5zCbUmHWDOXZvr/nOJRILwv43G5p+0eHs+GVu7pdBAkHQQu+0z1OWcDoUAOHTHNZF6YTeGYwezJ3dkVKLxjgKb6GiiEhOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFnBNt1E; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49253e951cdso278195e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782914557; x=1783519357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=smlUF8PDysGUPRBW5n55dDuKs8Qygu7ujB0Z7MC5VhQ=;
        b=QFnBNt1E7VtbH5E0Frx7D/7CpoIoKNMNWAa6dT5XIaEPiNF9WWctMWEgNAFkK1VIAw
         Mc7SupMbhkq5ga0g3TujuG/37g7Vd2ilFPhuaCe4CacbkmcPpa5Hn6iYfMDspaWNF9cJ
         ybBeuaGSmMx/ky13JbjEB3HJbrBMLPs/ZutYqLV5vIDPPPIvC+/MCcFaZ+PpDS8uuLau
         2NiRM9U9JPE76fQ34r2pjwCNg6QDgQb7sKvVsrT9Yw6BNNPWDolEJVKEUHhADGoJf1gs
         huzJSHqvXeCBUQogIrYRQWaOmQUhnQVrKQjlVHR4byNtyoE2SuPM9g7gypqETBnG4wN/
         KBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914557; x=1783519357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smlUF8PDysGUPRBW5n55dDuKs8Qygu7ujB0Z7MC5VhQ=;
        b=Z6sERe8OBEXxb0aSLUIrWTkUzHifT3d7FR8WT5UEhS0xF3AMn0BQE+un8stFsOXzGT
         Gn4NfCYW0XEHXr4vCHDSgaHfN8vRNsa9aJ4VIXR36ZvW3mP6XopMRfg8J8P8/zHqWncJ
         sG/lUBAC+I3T3All4UgNi82vTDGrxF8YH+Wkt+A7adRcNsCZTqFN1OZqD2RD9+3C9819
         5IK+1HYdznyHdR/skE6m4X6hW635/DfCWEz6YOGmIhuk7DpgRFUd6dS5SP0MQBJmUq0c
         61/k2b0BtkTLvdV8J+WI73qRwhfyJKM4yZk5p9YRXDoPRzrHO10WcNWNlCchoAyLtF3e
         tuaw==
X-Forwarded-Encrypted: i=1; AFNElJ8HRC3zSWKbSJJUpflOj6x4fkaXfdrQqKAgvT65tBZ9nMQmtbbC/lqtNJ12lyv3xauwQcxKqZ0dZp62JrOgeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0AkkAEYmYAeHc8jRItUjChrFLIu1GV5ztGvF76wxV7Z69Iwo
	03Jx3Kc0AZfiVCRVWLGM8m/68O6L7nBlDS7TLypyI6fcDsJnOGFmtmEB
X-Gm-Gg: AfdE7clxeTOtIzwVjxvwmY+vi5AhvV/1qJKpqFtu8SeKlStUHJ8qCAu5TUZoLZiLFk9
	OA5L4edq+baLbjrPQZnYQuPO6KBIgne3Lu8NJPUR8mcQeIXLHDHgADewed8twqHeGDQs1zPKcCy
	yoaNfHsAVG3MXXF8xVzcczDEwlqi3DPuH14fos4ufvmn/z/TRG2dxDtfFOdC0AFNOw/nsNo+D9d
	2/8DcSX020O/Kw45zP6IzUbgnohK6em1wCJMyx/T6JVjJOCQiAud/al7JDokd7omSBd3QxWceEF
	G2s928IooPH5vTyZCXmT9VJkI7CMDHyRL1SSylJr+qQZ7PzpSdl0hemxJa079BT4/87QPqgJFs/
	SkyEOPFEUQmcOLw9/AB7fC9hAzrRzA3E3xP6MDFz977k5NJk85n1hh8VEutZOSfMCiQa/nB4rCk
	6b5iCRW7UKC9W5+8cIAsXaCmNWOCRAWNERWCX5MMhZ3CfowOAUZphKX+YZc7/Ci9jF4OMNjeogl
	yIFzkLyPw==
X-Received: by 2002:a05:600c:5493:b0:493:c26e:d5e6 with SMTP id 5b1f17b1804b1-493c2b906damr16598955e9.5.1782914557070;
        Wed, 01 Jul 2026 07:02:37 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-477dde1a4fdsm85f8f.26.2026.07.01.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:02:36 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mt76: Fix missing barrier after initialization check in ath9k_wmi_event_tasklet()
Date: Wed,  1 Jul 2026 15:57:44 +0200
Message-ID: <20260701135745.43208-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38459-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fourier.thomas@gmail.com,m:toke@toke.dk,m:kvalo@kernel.org,m:penguin-kernel@i-love.sakura.ne.jp,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fourierthomas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[fourierthomas@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,toke.dk,kernel.org,i-love.sakura.ne.jp,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F12746EE8A2

The write memory barrier in ath9k_htc_probe_device() before writing to
priv->initialized, so it seems like one is also needed after reading it,
but seems like there is none after reading priv->initialized.

Add a read barrier after reading the priv->initialized flag to prevent
reordering of reads.

Fixes: 8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 284e8c13b043..1e28599a6146 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -160,6 +160,11 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 			kfree_skb(skb);
 			continue;
 		}
+		/*
+		 * Make sure ath9k_htc_probe_device() initialization is
+		 * committed to memory before processing skb.
+		 */
+		smp_rmb();
 
 		hdr = (struct wmi_cmd_hdr *) skb->data;
 		cmd_id = be16_to_cpu(hdr->command_id);
-- 
2.43.0


