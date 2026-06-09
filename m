Return-Path: <linux-wireless+bounces-37575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lx8cAaDkJ2rf4AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:02:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78965EAAD
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:02:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l0Illhda;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37575-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37575-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E304E30990F4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F53A9002;
	Tue,  9 Jun 2026 09:54:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C63603C0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 09:54:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998862; cv=none; b=FgkhcQ1AIXUjLwFLDBe0Hx7CPeLUxH5YmBwq/J+aFQb4MDUcyXBr80iKShQBf7ueZmCkgByf21egTgbBzA0JjEYKdd0O8g82QL1C+n1t1z6Q4uQaE1lf/OfAcQ9/Xn5GQ+kdwCGDUk1d2bZlAi4hB5NszlQxzAcE0mgdJHSAwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998862; c=relaxed/simple;
	bh=MG+MBcNvqcq8Et1tRDgRhMfvYMeM7cEx2V7ysgwWkNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDwAqgJShr7spurbueJDct9vIPATR0wM3SjuwpoZxiBH0eWecjU/AXjzGmQjeGZlF79ZeWHfDqH9/2DzDd8YZedwZ50a7DMGjolIVlSSgTvREfQSi9mHapbBt0N+QEbMtyaaWc+FnPmw3c7H4UtQJWmXbfp4xGxuTYXoJSm0KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0Illhda; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec4639953dso960985166b.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998857; x=1781603657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PetLQSauU/7mfz2291nX83ledTGEEi5d/jN3iXgKPwU=;
        b=l0IllhdadIxZc4rKlIfIyNAQ2FE0AIwLsXjvs0hMorZQ4JxgL4H0oRvDMsb4CVYG0M
         3JPiintZcws4OlUw/bqmZSOupJYiZsg5ZLNCJ1ORGoVUF0Ki1ymb44Q2OigjiMZpghWv
         /FO92ntX2+tPmFw6iOwbsHULj2GOJflWOMhbtUYgfayzfe/6B5G7a08wbEb/vU6GZbIg
         ZLvTTwf6he7I3qqPVXabMYK1En2chgi/1YftnrkUPjTOCx+4D5Fdnb10rAQzbYhfXlE7
         rAWSmtYqDvu8l0fkBLTZT++47bIp6aw89F6Oj0fiL6RXcACQjSUpaakdsr66s10x4xOU
         k4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998857; x=1781603657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PetLQSauU/7mfz2291nX83ledTGEEi5d/jN3iXgKPwU=;
        b=fsJ+b5s/wJXLHRZJvSMXt8i7dp0gJtiCsgWfGaDNwHzFOLO74hniKQZw0kSdXXwFHj
         jpJv4NPOAOjyd4xv748mfkZjJ6t9i4vO7K5gV7SwTwJMe6YyMIKJ30zI0Rc85oAorGR1
         16+AAMUTiqomRX1a4rJ6647kHzyApm4IXchzMAn+PuWAWMCYA6jN8qrUyrG5j/TJ1vYw
         7mOJzZRGkgBpyCIWHj18I4bk+sqYh76BO/njaySAc6Q5H+LMOoGRtdWsxLppkGH8meJZ
         C424s7YrDXI4FhxWvLlB2YiXQHXDFFVEMseV1NIXJX6dMGtYHYYLzocPcW3MbLTBgC0b
         7k/Q==
X-Gm-Message-State: AOJu0YyNFxi3YlpwXbOjuRQRv5JMd7hOZC4D0oQeIK3LV2/XKm+saA2M
	LIxn6ds/3vYsxfm/O72wMa+f07mWEFDD/dhimOAB+O9ujWu0o95J+Mho
X-Gm-Gg: Acq92OEXDsaxqmp/GHysVQz4Z/b5F+LuGGAamIE+/3ugv8dMEW0kw4HZA2oYMZkw/7h
	/I2hpjfrSmcRZF4jZ2UCpwYOpteD8d6ivrNJ8w/H0zHOlT3+/Y7HZfMVXSIawpRB9lZ7l4PnPR5
	BPsxHTcYIed+suqURR1yllSpIUdSbMyPSLcYoOk2zmZkP64ub5w3T2pKqRFOAwES8mb9L8jthCz
	FP/1yKVsLAwcTcG0CmG2WRzDka3fLZEa+vvFTHmQ0PmJOH/3ayJmIgepBUWudeoHk6XCfljcBCq
	KIVCsMarWf4lgQ5tt9FrG3rI2Q1eaD/ftNqPUKdNzAA0+tlKpSVMf43fnqD+WM/6six6/B5JIeS
	gxqyNu8puvvMrn7UuZke+AbQn0tTPw3IIU4vOnbi61npR71v84gW8SZD72q9hpxFS2zlOTRSSuX
	0vfWo+ltXagc+wHWPDVgZvNBFGXJofCbrr5n0n8WARuCgg
X-Received: by 2002:a17:907:3f9e:b0:bdd:f2c9:80cc with SMTP id a640c23a62f3a-bf9373e2be2mr100836266b.21.1780998856952;
        Tue, 09 Jun 2026 02:54:16 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307aacsm1013781366b.47.2026.06.09.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:54:16 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
Date: Tue,  9 Jun 2026 11:53:59 +0200
Message-ID: <20260609095359.2964193-1-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608135345.2526325-3-williamhb+k@fastmail.com>
References: <20260608135345.2526325-3-williamhb+k@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37575-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF78965EAAD

rtl8723be hw_init() calls local_save_flags(flags) followed by
local_irq_enable(). Later, local_irq_restore(flags) is called.

This causes warnings from Lockdep on boot and modprobe,
as local_irq_restore(flags) should only be called while irqs are disabled.
The warning was introduced to detect this class of bug in [1].

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

raw_local_irq_restore() called with IRQs enabled

...

Call Trace:
<TASK>
rtl8723be_hw_init+0x5992/0x7220 [rtl8723be]
? static_obj+0x61/0xa0
rtl_pci_start+0x222/0x5c0 [rtl_pci]
rtl_op_start+0x128/0x1a0 [rtlwifi]
? __kasan_check_read+0x11/0x20
drv_start+0x16c/0x550 [mac80211]

...

irq event stamp: 887679
hardirqs last  enabled at (887689): [<ffffffff96511170>] __up_console_sem+0x90/0xa0
hardirqs last disabled at (887698): [<ffffffff96511155>] __up_console_sem+0x75/0xa0
softirqs last  enabled at (887670): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
softirqs last disabled at (887649): [<ffffffff962f4675>] __irq_exit_rcu+0x175/0x2f0
---[ end trace 0000000000000000 ]---

[1] https://lore.kernel.org/all/20210111153707.10071-1-mark.rutland@arm.com/

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
Changes since v1:
- Remove timestamps from dmesg output
- Use [1] footnote style for link
- Fix subject prefix to rtw-next

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


