Return-Path: <linux-wireless+bounces-37531-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qPWHNabJJmo3kgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37531-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:54:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94468656D36
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:54:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CowFtsuX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37531-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37531-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 967CB3021243
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83A370AFD;
	Mon,  8 Jun 2026 13:54:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E023C1984
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:54:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926865; cv=none; b=JnmBi79XIe2N0p4wrlT7I3rXiaoyJsncudlib/ilxM87gbL8HI03azwpA5rAiyy8yEx49k2boVm1N7tU8m3flM1RNzttUVv9+XMiOFwkMPseZREMRIhylD9DngKbdP+gpa9jwVPdDJu23Qp48Y87MTlnZQYTrBevJHqshIaCUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926865; c=relaxed/simple;
	bh=WRM6rnm0YRU9zIEhu6olPs9K+uYsva+VYcdLLXprDfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzF1Arhxttb1mGaRyskvy69KXIHMxq+vraEBD1B1hPIcnZFdgU4Hk9AHO2hfb7R6q8/MSJe0BQGLM5GfcknfQG9MzXMEFfTB0c30tarNhMUW5bIR+2eAlYGiO88NrHnuH6aYZMY8aeUosQ3X2AEfscURuwBjsAyodnPAhIEFxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CowFtsuX; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so36072665e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926862; x=1781531662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXD1hmtAJBOKntNEa4d1CS66NTtiC54GCzkhUezAbnA=;
        b=CowFtsuXsI2n5yX/XQwBvBEItN5OFYanMsi2nzoBkX/uyhX4LY4kfib9VggDhmI2hz
         VWLPvvuDGzTU2X0+d8heiBo+GJ2zCHrzYF8x5eULcE2JuQlNKcnyb7rhOX78Nv7wfpU6
         zULJMY6lr5pDojO32920HWruEqTCrlmJIE64kZBvTl93lxi/dM7+7k46UfwzkkAT2KNy
         +c06Qc8W5xZNZwDKG2bpdJ/34LPizgojrW3Qpfw8P1HexY8eBeTWkawECMPxicm994Ea
         PRAoGM4oYI2rAIJcqHBgi4Ukh2r1fzu693caZYuWICYBrLx/yNQEuOAMz9flH7EzVKYo
         /0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926862; x=1781531662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXD1hmtAJBOKntNEa4d1CS66NTtiC54GCzkhUezAbnA=;
        b=gpAHvNc33BtzyPpUIgXH0wM78Xpg0L8PC+jS+sEcRJ8YDvD4wCD5PlpEFQkoGWdRpb
         T/VbEzm7GmOU6M+lsjNwnT72pejNXhBaRz1oBnyI+6sHqY7aZEOqnWZuoiDzEbMkTgj6
         6K84KDfHUFvojEXdOY5C71l4HLbGCpPYBIRCfh4oc9qWLwM+y7K4beiIYJA4IqaSYfDx
         M+Pqp374t0v9q7EIPgRDJFoCQu1nS/KJVEXR3OkjlbOX13x82NMuhekeowK1nVq/nGp9
         GsAgiMkZTUfzXfl/1sAWmEMJ2Tbh43bjZjT8n0BRfJ9+xihBjncs6yTQXeo9RMvUgrLo
         a0zQ==
X-Gm-Message-State: AOJu0YyR5AAA2wQqBUhNKV186kM2ztlErkD9fvGb9/ErT75EMUVDVLNn
	AbgmyCTmE7Jdzp3XO1kyN6g/U8/YyOsriiNi67GynuuxG4Al0rT+cYuO
X-Gm-Gg: Acq92OHNwySIjbcDeocQ7BPf4zQoP8+0bVI9dSGAyqlGP+aJPwjvIiy7lUNvNJJYXmj
	8X7vUNTKAWbahhPnl7bSuANi1DpQ0IDtAS/sCvEFwIT6+qFf0s0fCj5TzRURIlP3krvrwklPo4d
	u8+EFLjIeaHhVIxhLLB2STnQlA8LrOaT3lKdRL4UTIpbMeCwObHXU1qvjZeKy0HjPZgKEtZnuJ9
	pOPbe7Owanlt1jNJSIiUOCFvnG3B+74gxsBSE/h78nND2CpzgPpFf5FMWreNzc120cpSkowM3Co
	9G52yrq9dQxEBSY5DyHKOMQC0clP5MTCjnajVpw+Oh235N0tR0Osah1XU5HkS7zDt5lIHzqQFz6
	00T6KHpCeCxLKuVPzmUXCMFpUP5c9SMvK0Auhe/+k0oBwiF3f36P8qza0A9faRoyEZOuNFnGvwP
	jKC3dIa8TzDJ4h2hQ2Nqf0G1g2Z4sK3cMJAXIxsWHrSW1U
X-Received: by 2002:a05:600c:8216:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490c261ad21mr253671525e9.27.1780926862225;
        Mon, 08 Jun 2026 06:54:22 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm41066099f8f.32.2026.06.08.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:54:21 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
X-Google-Original-From: William Hansen-Baird <williamhb+k@fastmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <williamhb+k@fastmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
Date: Mon,  8 Jun 2026 15:53:47 +0200
Message-ID: <20260608135345.2526325-3-williamhb+k@fastmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37531-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fastmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhb+k@fastmail.com,m:williamhb@fastmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,k];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fastmail.com:mid,fastmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94468656D36

rtl8723be hw_init() calls local_save_flags(flags) followed by
local_irq_enable(). Later, local_irq_restore(flags) is called.

This causes warnings from Lockdep on boot and modprobe,
as local_irq_restore(flags) should only be called while irqs are disabled.

With testing I found that all paths which call hw_init() have irqs
already enabled for rtl8723be.

Furthermore, the calls were originally added for the rtl8192ce
in commit f78bccd79ba3 ("rtlwifi: rtl8192ce: Fix too long disable of IRQs")
before later being added to most other rtlwifi drivers.

Commit d3feae41a347 ("rtlwifi: Update power-save routines for 062814 driver")
then replaces the call to spin_lock_irqsave() before hw_init(),
and thus the codepath which caused irqs to be disabled in hw_init and
prompted the original commit has been removed.

The same irq save/restore pattern is also present in the hw_init() of
rtl8192ce, rtl8723ae, rtl8188ee, rtl8192se and rtl8192cu,
however I don't have the hardware to test them,
so I did not include them in my changes.

Tested on a Razer Blade 14 2017.

Example of output from Lockdep prior to fix:

[ 2305.476471] raw_local_irq_restore() called with IRQs enabled

...

[ 2305.478709] Call Trace:
[ 2305.478731]  <TASK>
[ 2305.478753]  rtl8723be_hw_init+0x5992/0x7220 [rtl8723be]
[ 2305.478798]  ? static_obj+0x61/0xa0
[ 2305.478848]  rtl_pci_start+0x222/0x5c0 [rtl_pci]
[ 2305.478891]  rtl_op_start+0x128/0x1a0 [rtlwifi]
[ 2305.478940]  ? __kasan_check_read+0x11/0x20
[ 2305.480082]  drv_start+0x16c/0x550 [mac80211]

...

[ 2305.570855] irq event stamp: 887679
[ 2305.571569] hardirqs last  enabled at (887689): [<ffffffff96511170>] __up_console_sem+0x90/0xa0
[ 2305.572347] hardirqs last disabled at (887698): [<ffffffff96511155>] __up_console_sem+0x75/0xa0
[ 2305.573076] softirqs last  enabled at (887670): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
[ 2305.573817] softirqs last disabled at (887649): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
[ 2305.574636] ---[ end trace 0000000000000000 ]---

Link: https://lore.kernel.org/all/20210111153707.10071-1-mark.rutland@arm.com/
Signed-off-by: William Hansen-Baird <williamhb+k@fastmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index e1f811218894..bf7b5a32adaa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -1333,11 +1333,6 @@ int rtl8723be_hw_init(struct ieee80211_hw *hw)
 	bool rtstatus = true;
 	int err;
 	u8 tmp_u1b;
-	unsigned long flags;
-
-	/* reenable interrupts to not interfere with other devices */
-	local_save_flags(flags);
-	local_irq_enable();
 
 	rtlhal->fw_ready = false;
 	rtlpriv->rtlhal.being_init_adapter = true;
@@ -1443,7 +1438,6 @@ int rtl8723be_hw_init(struct ieee80211_hw *hw)
 
 	rtl8723be_dm_init(hw);
 exit:
-	local_irq_restore(flags);
 	rtlpriv->rtlhal.being_init_adapter = false;
 	return err;
 }
-- 
2.54.0


