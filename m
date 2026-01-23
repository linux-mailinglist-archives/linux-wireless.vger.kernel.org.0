Return-Path: <linux-wireless+bounces-31124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I79G0Wcc2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:05:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF478236
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8637303CD21
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A02853F7;
	Fri, 23 Jan 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="LwFdyqjp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBB182D2
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184171; cv=none; b=QjhnzhoGA5cTAo4u8wt3MV5GqMXJlC2uE1EO6gl9qKpkDetL8sX5CWo8aEGROvaRVsU0pm9NO2E6SexK0Lnm9QxkMfJppDjwSYHnxxk7bnDvseroHOz5anLV3kjr/rqTvHbKskAz+atZm1RHFsf0bKm/cOG5xEt0lhdVdPkQ3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184171; c=relaxed/simple;
	bh=xc24npT9rAHBSGHPDys4wEQkoai7oXSDgskM7kxJjxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUBU5/zgiLJIX+sFdydazgFm50lnYB++sFJnwsYNphOMD3H66zyYcBHkJ01i3aNrfZuOjZBG6nJBitpZZMQyPVAViGiTSrs246KYyMp4sZ9DcD8CtxklQ383jaOawfusD/FHnYnunMZjjI2o5/5YN3p5Am0QrnoehmwbVTlbr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=LwFdyqjp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c87d82bd2so1692847b6e.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769184168; x=1769788968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tVMdOq+RRmPd7zkB4BscKVMh/SgbBpBunr6VSji3Qs=;
        b=LwFdyqjpqKiZ6HA1qrycgQMHxz/vIR0FFtcw+f/b7stCAhFjBfAId6jhZ+IW/DlMIe
         naCxd50+pSHi+EggAWWm0Hl+EZW6dpu1+T0DTyM4lN4nCak8yDfTXBu2PQkRmTlEru2y
         tqiYO3iYscmx4KCpYAhfdUEg/yi8Ro6Jei9sc+B2PI2z7FMKwwkU9jRso8kwIUn8q70L
         njFC85ZgLqBDfBXvTshBZNqgitz5zrvz1IlOBlhvAQyoG9lWdJykB9Ur9wQ4Cg/FvDgw
         tXqBb3xYru0yVESYLfcnEJmbfbLy1cEf8idcwfN9nQWAShO5Pzdci9dfn6RbyeRi0aXm
         xUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184168; x=1769788968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tVMdOq+RRmPd7zkB4BscKVMh/SgbBpBunr6VSji3Qs=;
        b=r16tyHOapTi7YGRxEGkGzqK7HJWKu2YNWog2tc3EjizRDeZPeit53tTXployd17DcP
         2jKzjW7v7mY6wNpkLC3BwbEabrkp8niCPNS1rmzDavzTd6hp0FTcCrvQbh6VVFfPccPy
         F6/odOXqPXWd5dlf+tK0UYQVdl1x+x98fMqUfSdi/qmCEwiH73TfUoiX3Cgv9rKThOlT
         j2X9KtEvVqt1Ve8XPX45eab5AlEk6NJc6X9DPwwRtzT+Ndm0EF2eGdSQpolk1SzzO8uw
         U0q4I8Hr1tNs5GGcp+wxZxlpEeF6ciaGEkyhqx++4d5dbd2/hs9m5IBbdNBAJL1Ju1cs
         f93A==
X-Gm-Message-State: AOJu0YyZi8s7edvpjj4GQp4l7qGrtGye/EUevZFYET+4W7inAt8YgnGQ
	Z1EkB91FD1t29JENgrY4LVFQWTuSzgMdKLJMqH9IfeT9I4jMcTjOioYkIhwWIQAg9VY=
X-Gm-Gg: AZuq6aLNAus/s1pFciH1hyQDR3/S52ToUPTcf6+7I6fX588Z35/3iclBg8xyFdv5kjl
	+0FO+qrBjpp4YZuGefw/qhybYkpraBJuG3DvyWCksWNq2FdMeEeJfUdtaRBkw5TkNS91uA1+y4Q
	JQzcIJKIU8uGaj0TKJhd3O0iuCIWOwcdOWIXrrtOjg8WeuMS5aiky40n7E3ry2W/hDFT4CBeAWo
	dR+H+cRQ2JWn8P/JH9wrqiPTqMX8mP1NW5GgBI7mB6BmI2NiPbQ2hXm5WqNCQGpmMvkfmfDJdfd
	fswfvUoNolutKNuGZl6n8NtTpNaxHaeVRuuzKgWJLkW7eK9Ih4bKTR3HyivfBT1D9iiPhM1Hiqx
	57YSnPKKKsa0o1QGZ4/VKoR4w9OGKEM8YF7TmOIpIsVih0LJbpcEy0GyEIIAHd5aUK9TiLzfdRw
	MqVhMOyQZWTBH6+CoAN9se6azpK6SwZgusm7mDdXSnLqrmTJUxwdCW1DlgXA/VlHCbRxVI8yOmh
	KxfwCJeyAGYcf6vDo3RsiEDG/UFFL0=
X-Received: by 2002:a05:6808:2226:b0:455:8b5b:c763 with SMTP id 5614622812f47-45eb1ec9619mr1597955b6e.67.1769184168229;
        Fri, 23 Jan 2026 08:02:48 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45eb42530e9sm1485317b6e.16.2026.01.23.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:02:47 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
Date: Fri, 23 Jan 2026 16:02:44 +0000
Message-Id: <20260123160244.262225-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31124-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C5CF478236
X-Rspamd-Action: no action

ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
assert that ar->data_lock should be held by the caller, but neither
ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
before calling this function.

The field arsta->peer_ps_state is documented as protected by
ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.

Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
following the pattern used by other WMI event handlers in the driver.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b4aad6604d6d..40259504927c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5305,7 +5305,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	arsta = (struct ath10k_sta *)sta->drv_priv;
+	spin_lock_bh(&ar->data_lock);
 	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
+	spin_unlock_bh(&ar->data_lock);
 
 exit:
 	rcu_read_unlock();
-- 
2.34.1


